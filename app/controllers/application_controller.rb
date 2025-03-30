class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def is_admin?
    Current.user.roles.include?(Role.find_by(name: "admin"))
  end

  def is_provider?
    Current.user.roles.include?(Role.find_by(name: "provider"))
  end

  def is_customer?
    Current.user.roles.include?(Role.find_by(name: "customer"))
  end

  def tenant
    request.subdomain != "" ? request.subdomain : "staging"
  end
end
