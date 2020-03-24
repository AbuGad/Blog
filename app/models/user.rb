class User < ActiveRecord::Base

	has_secure_password
	
	has_many :articles , dependent: :destroy
	
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: {case_sensitive: false },
			length: {minimum: 3 , maximum: 30 }
	validates :email, presence:true , length:{minimum: 5 , maximim: 50},
				uniqueness: {case_sensitive: false},
				 :email_format => {:message => "must use valid email"} 	 
	
	def activate_account!   
 		 update_attribute :deactivated, false  
	end

	def deactivated_account!   
  		update_attribute :deactivated, true
	end

end