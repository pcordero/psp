Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'states#index'
  #get "/states/:code" => "states#show"
  #get "/states", to: 'states#index'

  # http://localhost:3000/states/ut/feed.rss

  get "/states/:id/feed.rss", to: 'states#index'

  resources :leaders

  resources :states do
    resources :leaders
    resource :calendar
    resources :subscriptions
  end

  get "/all_states", to: "states#all", as: "all_states"

  get "/states/:id/:year/:month/:day/calendars/daily/twitter", to: "states#twitter", as: "daily_twitter_feed"
  get "/states/:id/:year/:month/:day/calendars/daily/facebook", to: "states#facebook", as: "daily_facebook_feed"
  get "/states/:id/:year/:month/:day/calendars/daily/email", to: "states#email", as: "daily_email"
  get "/states/:id/email", to: "states#email", as: "state_email"

  get "/states/:id/calendars/daily/twitter", to: "states#twitter", as: "daily_twitter_feed2"
  get "/states/:id/calendars/daily/facebook", to: "states#facebook", as: "daily_facebook_feed2"

  get "/states/:id/calendars/daily/email", to: "states#email", as: "daily_email2"
  #get "/states/:id/calendars/weekly/email", to: "states#weekly_email_feed", as: "weekly_email_feed"
  get "/states/:id/calendars/daily/:year/:month/:day", to: "states#show", as: "daily_calendar"
  get "/states/:id/calendars/weekly/:year/:month/:day", to: "states#show", as: "weekly_calendar"

  get "/states/:id/:year/:month/:day", to: "states#show", as: "state_date"
end
