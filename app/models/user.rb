class User < ActiveRecord::Base
	has_many :articles
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: {case_sensitive: false },
			length: {minimum: 3 , maximum: 30 }
	validates :email, presence:true , length:{minimum: 5 , maximim: 50},
				uniqueness: {case_sensitive: false}
	has_secure_password
end