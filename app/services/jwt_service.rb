
class JwtService
    def self.encode(payload:, exp: 6.hours.from_now)
        payload[:exp] = 6.hours.from_now.to_i
        JWT.encode(payload, self.secret)
    end

    def self.decode(token:)
        JWT.decode(token, self.secret).first
    end

    def self.secret
        Rails.application.credentials.devise[:jwt_secret_key]
    end
end

