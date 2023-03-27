class JtiMatcherService < ApplicationService 
    def initialize(user)
        @user = user
    end

    def call
        match_user_jti
    end

    def match_user_jti 
        puts "user_id #{@user.id}"
        puts "user.jti #{@user.jti}"
        true
    end

    def self.jwt_revoked?(payload, user) 
        user.jti != payload['jti']
    end

    def self.revoke_jwt(_payload, user)
        user.update_column(jti: SecureRandom.uuid)
    end 

    def payload 
        { 'jti' => jti }
    end

end 