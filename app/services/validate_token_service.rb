class ValidateTokenService < ApplicationService
    
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
        puts "decoded_token: #{decoded_token}"
        return false if decoded_token.empty?
        user_id = decoded_token['sub']
        puts "user_id: #{user_id}"
        return false unless user_id
        user = User.find_sole_by(id: user_id)
        if user 
            jti_matcher(user)
        else 
            false
        end
    end 

    def jti_matcher(user)
        JtiMatcherService.new(user).call 
    end

end 