# Weather Forecast Application

This is a ruby on rails application, that lets you check weather forecast for given address.

# Main Components

Forecast Model:
> Stores weather data in the database
> Caching logic for 30min

Geocoding Service:
> Extract zipcode from the given address and fallbacks

Weather Service:
> Gets weather data using https://openweathermap.org/
> Mock weather data also

Forecasts Controller:
> Handles web requests and responses

# Technical Approach
> Caching
> Service Objects
> Error Handling
> Simple Design

