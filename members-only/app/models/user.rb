class User < ActiveRecord::Base
  before_create :insert_token
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password
  validates :password, presence: true
  has_many :posts

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.encript_token(string)
    Digest::SHA1.hexdigest(string.to_s)
  end

  private

    def insert_token
      self.remember_token = User.encript_token(User.new_token)
    end
 
end
