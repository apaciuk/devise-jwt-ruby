    # Model that will be authenticatable with the JWT strategy
    module JwtAuthenticatable
      extend ActiveSupport::Concern, Devise::Models

      class_methods do
        Devise::Models.config(self, :jwt_revocation_strategy)
      end

      included do
        def self.find_for_jwt_authentication(sub)
          find_by(id: sub)
        end  
      end

      def jwt_subject
          id
      end

    end

