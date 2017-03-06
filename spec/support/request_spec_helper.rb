module RequestSpecHelper
  def self.included(base)
    base.extend(ClassMethods)
  end

  def json
    JSON.parse response.body
  end

  def get_authorization_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.sub }).token
    { 'Authorization': "Bearer #{token}" }
  end

  def invalid_authorization_header
    token = Knock::AuthToken.new(payload: { sub: 'nope' }).token
    { 'Authorization': "Bearer #{token}" }
  end

  module ClassMethods
    def expect_authentication_failures_for(actions)
      actions.each do |action|
        it "#{action[:method]} #{action[:route]} without authorization header should return status 401" do
          send(action[:method], action[:route])
          expect(response).to have_http_status(401)
        end

        it "#{action[:method]} #{action[:route]} with invalid authorization header should return status 401" do
          send(action[:method], action[:route], headers: invalid_authorization_header)
          expect(response).to have_http_status(401)
        end
      end
    end # def expect_authentication_failures_for(actions)
  end # module ClassMethods
end # module RequestSpecHelper
