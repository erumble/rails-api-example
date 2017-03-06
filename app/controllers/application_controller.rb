class ApplicationController < ActionController::API
  include Knock::Authenticable
  include ExceptionHandler

  # --------------------------------------------------------------------------------------------
  # Uncomment the following method to change Knock's default behavior of returning :unauthorized
  # on requiests with invalid, or missing, tokens
  # --------------------------------------------------------------------------------------------
  # def unauthorized_entity(entity_name)
  #   head :not_found
  # end
end
