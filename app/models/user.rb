class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_and_belongs_to_many :roles
  before_create :assign_default_role

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  def admin?
    roles.exists?(name: "admin")
  end

  def assign_default_role
    self.role ||= Role.find_by(name: "user")
  end
end
