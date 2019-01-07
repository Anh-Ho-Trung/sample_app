class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true,
    length: {maximum: Settings.app.models.user.maximum1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:
    {maximum: Settings.app.models.user.maximum2},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.app.models.user.minimum1}
end
