class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_and_belongs_to_many :roles
  before_create :assign_default_role

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    roles.exists?(name: "admin")
  end

  def assign_default_role
    default_role = Role.find_by(name: "user")
    self.roles << default_role if roles.empty?
  end

  def generate_verification_token
    signed_id(purpose: "email_verification", expires_in: 2.hours)
  end
end
