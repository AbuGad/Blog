class MessagesController < ApplicationController
	
	before_action :set_sender
	before_action :set_recipient
	
	def new
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)
		@message.recipient_id = @recipient.id
		@message.sender_id = @sender.id
		if @message.save
			flash[:notice] = 'Message Sned!'
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
   		flash[:notice] = 'Message was Successfully Deleted'
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
end