Rails.application.routes.draw do
  resources :applications, defaults: { format: :json }, param: :token do
    resources :application_chats, defaults: { format: :json }, param: :number  do
      resources :chat_messages, defaults: { format: :json }, param: :number do
        collection do
          get :search
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
