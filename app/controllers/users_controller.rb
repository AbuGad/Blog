class UsersController < ApplicationController
	
	before_action :set_user, only: [:edit, :update, :show, :deactivate, :activate ]
	before_action :require_same_user, only: [:edit, :update] 

	def new
		@user = User.new
	end

	def index
		@users = User.all
	end

	def show
		if @user.deactivated?  
			flash[:danger] = 'ask admin to active this user first'
			redirect_to users_path
		else
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "welcome #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
	
	end

	def update
		if @user.update(user_params)
			flash[:success] = 'user successfull updated'
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = 'This User And All His Articles Was Successfully Deleted'
		redirect_to users_path
		
	end

	def deactivate
  		if  @user.deactivated_account!
    		flash[:notice] = 'admin deactivated this acc'
    		redirect_to users_path 
    		
  		else
 	 	end
	end

	def activate
		if @user.activate_account!
			flash[:success] = 'this user is active now'
			redirect_to users_path	
		else
		end
	end


private

	def user_params
		params.require(:user).permit(:username , :email , :password,)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if curent_user != @user and !curent_user.admin?
			flash[:danger] = 'layagooz :P'
			redirect_to root_path
		end
	end
end
