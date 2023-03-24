# devise-jwt-ruby

## Encode and decode JW Tokens with Devise, inc via Warden custom strategy module and config lines in config/devise.rb

Service object JWTService handles the credentials jwt_secret on decode/encode of user token

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

curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2Nzk2Njk3MzZ9.AtMEApZg1l9JQdD_yHyFc0gOb6C3NNfx1enPwn7bb-A" -H "Content-Type: application/json" http://localhost:3000/users/sign_out # (use Bearer token from login, not this one)

methods

u = User.find_by(email: "test@example.com")

u.active_for_authentication?
=> true
u.valid_for_authentication?
=> true
u.validate!
=> true
