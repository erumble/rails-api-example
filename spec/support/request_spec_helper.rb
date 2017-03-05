module RequestSpecHelper
  def json
    JSON.parse response.body
  end

  def authenticate_user(user)
    token = Knock::AuthToken.new(payload: {sub: user.sub }).token
    { 'Authorization': "Bearer #{token}" }
  end
end
