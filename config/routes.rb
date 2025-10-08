Rails.application.routes.draw do
  get "forecast", to: "forecasts#show"
  root to: redirect("/forecast")
end
