class User < ApplicationRecord
  has_many :reviews
  has_many :login_counters

  before_create :confirmation_token
  has_secure_password
  VALID_NAME_REGEX = /\A[^0-9`!@#$%\^&*+_=]+\z/.freeze
  validates :user_name, presence: true, length: { minimum: 3, maximum: 100 }, format: { with: VALID_NAME_REGEX }
  validates :contact_number, presence: true, length: { minimum: 10, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  def to_s  
    "#{user_name}"  
  end  

  # email confimation method, changing email_confirmed into true
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  # forget password method which send mail about password reset: 

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver # This sends an e-mail with a link for the user to reset the password
  end

  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  
  private

  # This generates a random confirmation token for the user
    def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
