# devise-jwt-ruby

## Encode and decode JW Tokens with Devise, inc via Warden custom strategy module and config lines in config/devise.rb

Service object JWTService handles the credentials jwt_secret on decode of user token

#### basic console example (sub is the user id, in this case 1)

> token = JwtService.encode(payload: {"sub" => 1})
> => "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ayfSB_CrxosN0q0PhkYLZClwzBeOX5syWuOZwRjVpQ8"
> decoded = JwtService.decode(token: token)
> => {"sub"=>1}

# Curl or Postman

## Sign up

curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users

## Sign in

curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users/sign_in # (grab token for signout, and member login))

## Sign out

curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhODQxODcxMy1iMTc5LTQ2ODYtYWY0NC1iNjBjYjBmMWQ2ODMiLCJqdGkiOiJhODQxODcxMy1iMTc5LTQ2ODYtYWY0NC1iNjBjYjBmMWQ2ODMiLCJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjc5NTcwNjI4LCJleHAiOjE2ODA4NjY2Mjh9.-OY5SWbjMcZm_1zat4WE9tWxPO43E0agPWxq4WSy-so" -H "Content-Type: application/json" http://localhost:3000/users/sign_out # (use Bearer token from login, not this one)

methods

u = User.find_by(email:)

u.active_for_authentication?
=> true
u.valid_for_authentication?
=> true
u.validate!
=> true
