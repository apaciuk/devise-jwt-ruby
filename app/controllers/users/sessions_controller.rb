class Users::SessionsController < Devise::SessionsController
    include ActionController::MimeResponds
    include Devise::Controllers::Helpers
    respond_to :json

    def respond_with(resource, _opts = {})
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        yield resource if block_given?

        # Deviate from the default behavior and issue a jwt token on sign in
        token = JwtService.encode( payload: { user_id: resource.id } )
        header = { 'Authorization' => 'Bearer ' + token }
            header.each do |key, value|
            response.headers[key] = value
        end
        render json:  {
            status: {
                code: 200,
                message: 'Signed in successfully'
            },
            data: {
                user: resource,
                token: token
            }
        }
    end

    def respond_to_on_destroy
        verify_jwt_token
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

    def verify_jwt_token 
        head :unauthorized if request.headers['Authorization'].nil?
        token = request.headers['Authorization'].split(' ').last
       
    end

    def get_bearer_token
        pattern = /^Bearer /
        header  = request.headers["Authorization"]
        header.gsub(pattern, '') if header && header.match(pattern)
    end

end 





