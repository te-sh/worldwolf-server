Rails.application.routes.draw do
  resources :rooms, only: %i[index show]

  resources :users, only: %i[create update] do
    collection do
      get :mine, action: :show_mine
      delete :mine, action: :destroy_mine
    end
  end

  resources :games, only: %i[create update destroy]
  resources :votes, only: %i[index create]

  mount ActionCable.server => '/cable'
end
