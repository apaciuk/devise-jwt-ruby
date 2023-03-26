
module Matcher
    extend ActiveSupport::Concern, Devise::Models

    included do
    before_create :initialize_token

        def self.jwt_revoked?(payload, user) 
            user.jti != payload['jti']
        end

        def self.revoke_jwt(_payload, user)
            user.update_column(jti: SecureRandom.uuid)
        end 

        def jwt_payload
            { 'jti' => jti }
        end

        private 

        def initialize_token
            self.jti = JwtService.encode(payload: { user_id: id })
        end 
    end
end 
