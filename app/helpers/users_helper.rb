module UsersHelper
  def is_authenticated?
    Current.user.present?
  end

  def is_admin?
    Current.user.roles.include?(Role.find_by(name: "admin"))
  end

  def is_user?
    Current.user.roles.include?(Role.find_by(name: "user"))
  end
end
