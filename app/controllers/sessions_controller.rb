class SessionsController < Devise::RegistrationsController
    include ActionController::MimeResponds
    include Devise::Controllers::Helpers
    respond_to :json 
    attr_accessor :user_id, :token

    def respond_with(resource, _opts = {})
        user = User.find_by(email: resource.email)
        user_id = user.id
        token = JwtService.encode(payload: { user_id: user_id })
        render json: {
            user_id: user_id,
            token: token,
            status: {
            code: 200,
            message: 'Logged in successfully'
            }
        }
    end

    def respond_to_on_destroy
        user = User.find_by(email: resource.email)
        user_id = user.id
        token = JwtService.encode(payload: { 'sub' => user_id }) 
        decoded = JwtService.decode(token: token)
        if token(payload: decoded) == decoded(token: token)
        # token.destroy
        render json: {
            status: {
            code: 200,
            message: 'Logged out successfully'
            }
        }
        else
        render json: {
            status: {
            code: 400,
            message: 'Error logging out'
            }
        }
        end
    end


    private 

    def user_params
        params.permit(:id, :email, :password)
    end
end

