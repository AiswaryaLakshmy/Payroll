class UsersController < ApplicationController

	before_action :get_user, only: [ :update, :destroy ]

	def index
		
	end

	def new
		if current_user.admin?
			@user = User.new
		else
			redirect_to dashboard_path
		end	
	end

	def edit
		if current_user.admin?
			@user = User.find(params[:id])
		else
			redirect_to dashboard_path
		end
	end

	def create
		@user = User.new(user_params)
		password = SecureRandom.hex(4)
		@user.password = password
		if @user.save
			UserMailer.welcome_email(@user,password).deliver
			redirect_to dashboard_path
		else
			render 'new'
		end
	end

	def update
		if current_user.admin?
			if @user.update(user_params)
				redirect_to dashboard_path

			else 
				render 'edit'
			end
		else
			redirect_to dashboard_path
		end
	end

	def destroy
  	@user.destroy
  	redirect_to dashboard_path
	end

	def dashboard
		@user = User.all
	end

	def pay_slip
		
	end

	private

		def get_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require( :user ).permit( :first_name, :last_name, :email, :contact_no, :salary )
		end

end

