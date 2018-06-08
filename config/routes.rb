Rails.application.routes.draw do
  resources :rooms, only: %i[index show]

  resources :users, only: %i[create update destroy] do
    collection do
      get :mine, action: :show_mine
      delete :mine, action: :destroy_mine
    end
  end

  resources :games, only: %i[show create update destroy] do
    member do
      get :word
      post :disclose
    end
  end

  resources :votes, only: %i[index create] do
    collection do
      post :disclose
    end
  end

  mount ActionCable.server => '/cable'
end
