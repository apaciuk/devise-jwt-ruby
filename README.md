# devise-jwt-ruby (also api starter)

## Encode and decode JW Tokens with Devise, using JWT service objects generated with ruby/jwt gem

Basic Service object JWTService handles the credentials jwt_secret on decode/encode of user token
Is completely independent of any devise extras or integrations, using the default warden sign in methods & the JWT service adding a token to headers, of which the JWT service is again used to check before allowing logout.

Front end would grab the token from Auth headers (Bearer) and send to the backend sign out route (as Authorization: Bearer token) where it is processed as above.

Avoids extra Warden strategies or extra devise config, only cors.rb to expose Authorization headers

- Files needed to put in another app are all in the services folder, with the 3 methods devise reg & session overide controllers/routes, and cors.rb.

The verify_jwt_token method, which calls the validate_token_service, here is in AppliationController as a global callback, but can be sessions etc

Ensure devise initializer has config.navigational_formats = [] and the jwt_secret_key as below are set in credentials

Algorithm is HS256, in jwt_service, with options for iss and aud.

Is also a template repo if want to kick start a Rails 7 API with Devise/JWT from scrath apart from the auth setup.

### Mandatory after bundle and db setup

delete config credentials.yml file
run rake secret to get new secret
EDITOR="whatever --wait" rails credentials:edit
Grab new rake secret and put in credentials file as so

- under other keys
  devise:
  jwt_secret_key: generated new secret key

As the JWT services uses this to encode/decode JWts, and wont work if its not set and named like above.

#### basic console example (sub is the user id, in this case 1)

token = JwtService.encode(payload: { 'sub' => user_id })
=> "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTY3OTYyMzI1N30.uQ50qFBq2_0fBAF77ZnrDeNss2mFxT_pIXKJL-It_d0"
decoded = JwtService.decode(token: token)
=> {"sub"=>1, "exp"=>1679623257}

##### Curl or Postman (Is tested both, as there are only 3 routes used, further testing can be done with RSpec/Factory etc if developed further.

- Sign up

curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/sign_up (no token)

- Sign in

curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/sign_in # (grab token for signout, and member login))

- Sign out

curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTcxMTU0NjMzNX0.DFzDpERdxi1y6-IbJ7Xi1r0WowRL2je-vhjDZAAB_c0" -H "Content-Type: application/json" http://localhost:3000/sign_out # (use Bearer token from sign_in, not this one)

methods

u = User.find_by(email: "test@example.com")

u.active_for_authentication?
=> true
u.valid_for_authentication?
=> true
u.validate!
=> true
