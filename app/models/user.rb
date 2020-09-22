require 'securerandom'
class User < ApplicationRecord
  before_create :generate_api_key

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password, on: :create, presence: true
  validates :password_digest, presence: true

  def generate_api_key
    self.api_key = SecureRandom.uuid
  end
end

