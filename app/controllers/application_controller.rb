class ApplicationController < ActionController::API
before_action :verify_jwt_token, except: [:create], if: :devise_controller?
   include ActionController::MimeResponds
   include Devise::Controllers::Helpers
   respond_to :json

   private 

   def verify_jwt_token 
      head :unauthorized if request.headers['Authorization'].nil?
      head :unauthorized unless request.headers['Authorization'].split(' ').first == 'Bearer'
      token = request.headers['Authorization'].split(' ').last
      return false unless token
      ValidateTokenService.new(token).call
   end
end
