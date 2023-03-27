require 'jwt'

class JwtService < ApplicationService
    ALGO = 'HS256'

    private 
    
    def self.encode(payload:, exp: 1.year.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(
        payload, 
        self.secret
        ).to_s
    end

    def self.decode(token:)
        JWT.decode(
        token, 
        self.secret, 
        true,
        iss: 'api.example.com',
        # verify_iss: true,
        aud: 'example.com',
        # verify_aud: true,
        algorithm: ALGO
        ).first
    end 

    def self.secret
        Rails.application.credentials.devise[:jwt_secret_key]
    end 
end
