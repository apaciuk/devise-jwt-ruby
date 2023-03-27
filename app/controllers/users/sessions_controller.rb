class Users::SessionsController < Devise::SessionsController 
    before_action :configure_sign_in_params, only: [:create]
    # Deviate from the default behavior and issue a jwt/jti token on sign up, attach it to the response headers as Bearer token and return the user with jti
    def respond_with(resource, auth,_opts = {jti: auth[:jti]})
        jti = JwtService.encode( payload: { 'sub' => resource.id })
        resource.jti = jti
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        yield resource if block_given?
        resource.save
        header = { 'Authorization' => 'Bearer ' + jti }
            header.each do |key, value|
            response.headers[key] = value
        end
        render json:  {
            status: {
                code: 200,
                message: 'Signed in successfully'
            },
            data: {
                user: resource
            }
        }
    end

    def respond_to_on_destroy
        remove_jti_from_user
        render json: {
            status: {
                code: 200,
                message: 'Logged out successfully'
            }
        }, status: :ok
    end 

    protected 

    def remove_jti_from_user
        token = request.headers['Authorization'].split(' ').last
        payload = JwtService.decode(token: token)
        user_id = payload['sub']
        user = User.find_sole_by(id: user_id)
        user.jti = SecureRandom.uuid
        user.save
    end

    def configure_sign_in_params
        devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :jti])
    end
end 





