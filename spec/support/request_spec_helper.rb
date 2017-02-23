module RequestSpecHelper
  def json
    JSON.parse response.body
  end

  def authenticate_user(user)
    token = Knock::AuthToken.new(payload: {sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end
end
