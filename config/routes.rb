Rails.application.routes.draw do
devise_for :users, 
defaults: { format: :json }, 
controllers: { sessions: 'sessions' },
path: '',
path_names: {
sign_in: 'sign_in', to: 'sessions#sign_in',
sign_out: 'sign_out', to: 'sessions#sign_out',
registration: 'sign_up'
}    
end
