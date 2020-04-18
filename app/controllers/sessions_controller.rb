class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "Successfull Login "
			redirect_to user_path(user)
		else
			flash[:danger] = 'There is Some Thing Wrong'
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success]= 'Successfully Logged-out'
		redirect_to root_path
	end
end
