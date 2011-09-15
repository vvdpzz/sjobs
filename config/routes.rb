Sjobs::Application.routes.draw do
  
  mount Sjobs::API => "/"
  
  root :to => 'questions#index'
  
  match '/free' => 'questions#free', :via => 'get', :as => :free_questions
  match '/watch' => 'questions#watch', :via => "get", :as => :wateched_questions
  
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
  
  resources :users, :only => [:show] do
    member do
      get 'follow'
      get 'asked'
      get 'answered'
    end
  end
end
