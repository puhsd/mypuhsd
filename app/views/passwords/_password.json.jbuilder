json.extract! password, :id, :user_id, :vendor, :username, :password, :created_at, :updated_at
json.url password_url(password, format: :json)