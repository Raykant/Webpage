Rails.application.routes.draw do

  root 'pages#home'

  get 'home' => 'pages#home'

  get 'signup'  => 'todos#new'

  get 'create' => 'todos#create'

  get 'show' => 'todos#show'

  get 'delete' => 'todos#delete'

  get 'weather' => 'pages#weather'

  get 'todolist' => 'pages#todo'

  get 'welcome' => 'pages#welcome'

  get 'todomsg' => 'pages#todomsg'

  resources :todos
end
