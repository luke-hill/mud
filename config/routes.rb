Rails.application.routes.draw do
  get '/', to: 'game#index'

  root 'game#index'
end
