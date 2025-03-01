json.extract! pet, :id, :pettable_id, :pettable_type, :name, :age, :sex, :created_at, :updated_at
json.url pet_url(pet, format: :json)
