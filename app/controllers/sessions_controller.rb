class SessionsController < Devise::RegistrationsController
    include ActionController::MimeResponds
    include Devise::Controllers::Helpers
    respond_to :json

    def respond_with(resource, _opts = {})
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            token = JwtService.encode(payload: { user_id: user.id })
            header = { 'Authorization' => 'Bearer ' + token }
            header.each do |key, value|
            response.headers[key] = value
        end
            render json: { token: token }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def respond_to_on_destroy
        get_bearer_token.present? ? head(:ok) : head(:unauthorized)
        render json: {
            status: {
            code: 200,
            message: 'Logged out successfully'
            }
        }, status: :ok
    end


    private 

    def user_params
        params.permit(:id, :email, :password, :token)
    end

    def get_bearer_token
        pattern = /^Bearer /
        header  = request.headers["Authorization"]
        header.gsub(pattern, '') if header && header.match(pattern)
    end
end 





