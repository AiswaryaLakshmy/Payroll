class UsersController < ApplicationController

	before_action :get_user, only: [ :show, :update, :destroy ]

	def index
		
	end

	def show
		
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
		User.invite!(user_params[:email])
		if @user.save
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
			params.require( :user ).permit( :first_name, :last_name, :email, :contact_no, :encrypted_salary )
		end

end

