Rails.application.routes.draw do
devise_for :users, 
defaults: { format: :json }, 
controllers: { registrations: 'users/registrations', sessions: 'users/sessions' },
path: '',
path_names: {
sign_in: 'sign_in', to: 'users/sessions#sign_in',
sign_out: 'sign_out', to: 'users/sessions#sign_out',
registration: 'sign_up', to: 'users/registrations#sign_up'
}    
end
