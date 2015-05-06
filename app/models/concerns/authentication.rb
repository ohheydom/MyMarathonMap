module Authentication
  extend ActiveSupport::Concern

  included do
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    before_create :create_remember_token
    before_save { email.downcase! }
    has_secure_password

    validates :username, :email, uniqueness: { case_sensitive: false }
    validates :username, length: { minimum: 5, maximum: 15 }, presence: true
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, length: { minimum: 6 }
  end

  module ClassMethods
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
