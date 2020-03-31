class Article < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	has_many :comments
	validates :title, presence: true, length: { minimum:3 , maximum: 50 }
	validates :description, presence:true , length: { minimum: 10 , maximum: 500 }
	validates :user_id , presence: true

	def private_article!
		update_attribute :private , true
	end

	def public_article!
		update_attribute :private , false
		
	end
end