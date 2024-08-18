# Weather App

A simple Weather App built with Swift that utilizes the OpenWeatherAPI to provide real-time weather information. The app features an autocomplete search field with location suggestions and allows users to choose between Celsius and Fahrenheit for temperature display.

## Features

- **Location Search**: Use MKLocalSearchCompleter for location suggestions as you type.
- **Real-Time Weather Data**: Fetch current weather information using OpenWeatherAPI.
- **Temperature Units**: Toggle between Celsius and Fahrenheit for temperature display.

## Views
Enter Location(SwiftUI)    |  Received weather(UIKit)
:-------------------------:|:-------------------------:
<img width="368" alt="Screenshot 2024-08-18 at 07 41 37" src="https://github.com/user-attachments/assets/d4eadb7a-8e9c-44bd-aca6-6edced85cbaf">
 |  <img width="370" alt="Screenshot 2024-08-18 at 07 41 46" src="https://github.com/user-attachments/assets/6011d5ca-2981-4e2d-990c-3739fcc856cd">

## OpenWeatherAPI
OpenWeather provides weather data for any location on the globe using a proprietary ML-powerd hyperlocal forecasting model with resolution from 500 m to 2 km, globally. Know More: https://openweathermap.org

## Architecture

This project follows the MVVM (Model-View-ViewModel) design pattern, which helps in separating the UI logic from the business logic, making the codebase more modular and testable.

## MVVM Pattern

- Model: Represents the application's data and business logic.
- View: Defines the UI layout and presentation, binding to the ViewModel to display data.
- ViewModel: Acts as an intermediary between the Model and the View. It provides data to the View and responds to user actions.
 
## Combine

This project utilizes Apple's Combine framework for handling asynchronous events and managing data flow between the Model and Service.

## Usage

1. Open the app.
2. Use the search field to find a location. The app provides suggestions.
3. Select a location from the suggestions.
4. Choose your preferred temperature unit (Celsius or Fahrenheit).
5. View the current temperature and weather information for the selected location.

## Final Considerations

Weather App was a great opportunity for me to return to studying Swift the way I like it most: by practicing. It was my first contact with SwiftUi. I really enjoyed dedicating my time to it and I know that as time goes by I will use it to study.

## Contact
- Derick Nazzoni - dericknazzoni00@gmail.com
