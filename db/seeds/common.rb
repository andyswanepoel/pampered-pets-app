[ "customer", "provider", "tenant_admin", "app_admin" ].each do |role_name|
  Role.find_or_create_by(name: role_name)
end

# Will need to create an admin user here
