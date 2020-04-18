class MessagesController < ApplicationController
	
	before_action :require_same_user, except:[:index]

	before_action :set_recipient
	before_action :set_sender
	
	def new
		@message = Message.new
		@message.sender_id = @sender.id
	end

	def create
		@message = Message.new(message_params)
		@message.sender_id = @sender.id
		@message.recipient_id = @recipient.id
		if @message.save
			flash[:success] = 'Message Sned'
			redirect_to user_messages_path(curent_user)
		else
			render 'new'
		end
	end

	def index
      @messages = curent_user.messages
   end

   def destroy
   		@message = Message.find(params[:id])
   		@message.destroy
   		flash[:danger] = 'Message was Successfully Deleted'
   		redirect_to user_messages_path(curent_user)
   end

private
	def message_params
		params.require(:message).permit(:body, :recipient_id, :sender_id)
	end

	def set_recipient
		@recipient = User.find(params[:user_id])
	end

	def set_sender
		@sender = curent_user
	end

	def require_same_user
	#	if curent_user = @sender_id_message
	#		flash[:danger] = 'You Can Not Send Message To Your Self'
	#		redirect_to users_path
	#	else
	#	end
	end
end