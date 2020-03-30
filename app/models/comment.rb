class Comment < ActiveRecord::Base
	belongs_to :article
	validates :body, length: { minimum: 2 }
end