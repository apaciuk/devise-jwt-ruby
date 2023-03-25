class Users::RegistrationsController < Devise::RegistrationsController
    def respond_with(resource, _opts = {})
        if resource.persisted?
            render json: { status: { code: 200, message: 'Signed up successfully' } }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
end
