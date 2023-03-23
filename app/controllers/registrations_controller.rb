class RegistrationsController < Devise::RegistrationsController
    include ActionController::MimeResponds
    include Devise::Controllers::Helpers
    
    def create
        user = User.create!(user_params)
        token = JwtService.encode(payload: { user_id: user.id }) 
        user.save!
        if user.persisted?
            render json: { user: user, token: token, status: { code: 200, message: 'User created successfully' } }
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private 

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end 
    
end