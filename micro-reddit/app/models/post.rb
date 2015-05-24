class Post < ActiveRecord::Base
	validates :title, presence: true,
	                  length: { minimum: 3,
	                  	        maximum: 50,
	                  	        too_short: "must have at least %{count} words",
                                too_long: "can only have at most %{count} words"
	                          }
	validates :body, length: { maximum: 150 }
	belongs_to :user
	has_many :comments
end
