class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def respond_with(resource, _opts = {})
        if resource.persisted?
            render json: { status: { code: 200, message: 'Signed up successfully' } }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
    protected

    def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    end

end
