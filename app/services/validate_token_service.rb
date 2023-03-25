class ValidateTokenService 
    
    def initialize(token)
        @token = token
    end
    
    def call
        validate_token
    end 

    private 

    def validate_token 
        return false if @token.nil?
        decoded_token = JwtService.decode(token: @token)
        return false if decoded_token.empty?
        user_id = decoded_token['sub']
        return false unless user_id
        user = User.find_sole_by(id: user_id)
        return false unless user 
        true
        rescue JWT::ExpiredSignature
        false
        rescue JWT::DecodeError
        false
    end 

end 