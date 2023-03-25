# devise-jwt-ruby

## Encode and decode JW Tokens with Devise, inc via Warden custom strategy module and config lines in config/devise.rb

Service object JWTService handles the credentials jwt_secret on decode/encode of user token

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

# Curl or Postman

## Sign up

curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users

## Sign in

curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users/sign_in # (grab token for signout, and member login))

## Sign out

curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGV4YW1wbGUuY29tIiwiZXhwIjoxNjc5Njg3NDg0fQ.O39_1tD67Kzw2D_9JOoSrQFvFTHj_AQCqRKUUQZNhq8" -H "Content-Type: application/json" http://localhost:3000/users/sign_out # (use Bearer token from login, not this one)

methods

u = User.find_by(email: "test@example.com")

u.active_for_authentication?
=> true
u.valid_for_authentication?
=> true
u.validate!
=> true
