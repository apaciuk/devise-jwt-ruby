
class JwtService
    ALGO = 'HS256'
    def self.encode(payload:, exp: 6.hours.from_now)
        payload[:exp] = 6.hours.from_now.to_i
        JWT.encode(payload, self.secret)
    end

    def self.decode(token:)
        decoded = JWT.decode(token, self.secret, true, { algorithm: ALGO }).first
        HashWithIndifferentAccess.new decoded
    end

    def self.secret
        Rails.application.credentials.devise[:jwt_secret_key]
    end 
end
