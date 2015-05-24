class User < ActiveRecord::Base
	validates :name, presence: { message: "Story name can not be blank" },
	                 length: { maximum: 16 },
	                 uniqueness: { case_sensitive: false }
	has_many :posts
	has_many :comments
end
