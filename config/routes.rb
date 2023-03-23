Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: { users: 'users' , sessions: 'sessions' }    
end
