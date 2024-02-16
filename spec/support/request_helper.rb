module RequestHelper
  def add_request_headers(user)
    request.headers['Content-Type'] = 'application/json'
    request.headers['Authorization'] = user ? "Bearer " + JWT.encode({user_id: user.id}, Rails.application.credentials[:secret_key_base]) : ""
  end

  def seed_data
    Role.find_or_create_by(id: 1, name:'user')

    Role.find_or_create_by(id: 2, name:'admin')
  end
end
