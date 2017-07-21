Telex::Application.routes.draw do
    root :to => "projects#index"
    resources :projects
    get 'post_ads' => 'projects#post_ads', as: 'post_ads'
end
