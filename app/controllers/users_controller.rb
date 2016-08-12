class UsersController < ApplicationController

	before_action :get_user, only: [ :update, :destroy, :pay_slip, :pay_slip_details ]

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
		if current_user.admin?
			@user = User.new(user_params)
			password = SecureRandom.hex(4)
			@user.password = password
			if @user.save
				UserMailer.welcome_email(@user,password).deliver
				redirect_to dashboard_path
			else
				render 'new'
			end
		else
			redirect_to dashboard_path
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

	def pay_slip_details
		unless current_user.admin?
			redirect_to dashboard_path
		end
	end

	def pay_slip
		if current_user.admin?
			@salary = @user.salary.to_i
			@m = params[:month]
			@at = params[:attendance].to_i
			@spd = @salary / 30
			@s = @at * @spd
			@bs = @s * 70 / 100
			@hra = @s * 35 / 100
			@c = @s * 15 / 100
			@esi = @s * 6 / 100
			@pf = @s * 14 / 100
			@te = @bs + @hra + @c
			@td = @esi + @pf
			@ns = @te - @td
			
			respond_to do |format|
		    format.html
		    format.pdf do
		      render pdf: "pay_slip", template: 'users/pay_slip.html', layout: 'pdf'
		    end
		  end
		else
			redirect_to dashboard_path
		end
	end

	private

		def get_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require( :user ).permit( :first_name, :last_name, :email, :contact_no, :salary )
		end

end
