Sjobs::Application.routes.draw do
  root :to => 'questions#index'
  
  match '/free' => 'questions#free', :via => 'get', :as => :free_questions
  
  resources :questions do
    resources :answers
    member do
      get 'follow'
      get 'favorite'
    end
    resources :votes, :only => [] do
      collection do
        get 'up'
        get 'down'
      end
    end
  end
  
  resources :answers do
    resources :votes, :only => [] do
      collection do
        get 'up'
        get 'down'
      end
    end
  end

  devise_for :users
end
