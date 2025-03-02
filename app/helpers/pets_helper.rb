module PetsHelper
  def underscore_to_slash(value)
    value.gsub("_", "/")
  end
end
