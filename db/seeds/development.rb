[ "user", "admin" ].each do |role_name|
  Role.find_or_create_by(name: role_name)
end

User.find_or_create_by(email_address: "andyp.swanepoel@gmail.com") do |user|
  user.first_name = "Andy"
  user.last_name = "Swanepoel"
  user.password = "password123"
  user.tenant = "staging"
  user.account_verified = true
  user.roles << Role.find_by(name: 'customer')
end

User.find_or_create_by(email_address: "provider@email.com") do |user|
  user.first_name = "Service"
  user.last_name = "Provider-Admin"
  user.password = "password123"
  user.tenant = "staging"
  user.account_verified = true
  user.roles << Role.find_by(name: 'provider')
  user.roles << Role.find_by(name: 'admin')
end
