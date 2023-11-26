# Number Trivia App

## A fully functioning mobile application that retrieves the trivia number from the API and saves the last searched trivia in the device's local memory

This example project was used to learn how to work in TDD (Test Driven Development) and follow the principles of Clean Architecture. While developing this app, I undertook the following steps:

* Creating folder structure: data, domain, presentation
* Use Cases
* Models & Entities
* Repository
* Network Information
* Local and Remote Data Source
* Bloc Scaffolding
* Dependency Injection
* User Interface

## Dependencies

| Package                     | Description                                                        |
|-----------------------------|--------------------------------------------------------------------|
| dartz                       | handling functional programming concepts such as Option and Either |
| dio                         | easy communication with a server through the HTTP protocol         |
| equatable                   | simplifies the implementation of object equality                   |
| flutter_bloc                | managing state and business logic through BLoC pattern             |
| get_it                      | dependency injection                                               |
| internet_connection_checker | monitoring the state of the internet connection                    |
| shared_preferences          | simple library for storing data in the device's cache              |
|                             |                                                                    |
| flutter_launcher_icons      | tool for easily adding custom app icon                             |
| flutter_native_splash       | customization of the application's splash screen                   |
| mocktail                    | creating mock objects during unit testing                          |



## ScreenShots

| <img alt="splash screen" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/78173d7a-fb4b-42bf-8c93-18d8645695af" width="400"> | <img alt="welcome screen" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/cc1f5523-8745-41c4-8a43-39cfcecb78b3" width="400">       |
|--------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| <img alt="number input" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/eb855c33-971c-403d-9668-c7f25698965c" width="400">  | <img alt="loading screen" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/fe077b6e-4017-477f-88fd-6088223fdbad" width="400">       |
| <img alt="number trivia" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/c458faef-cecc-4475-8aee-29c3388b45aa" width="400"> | <img alt="cached number trivia" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/e6ac1790-5eb4-409f-9212-2ad4f964dce7" width="400"> |
| <img alt="input error" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/d7395369-8d38-45e4-937a-70970600c031" width="400">   | <img alt="cache error" src="https://github.com/TR0U8L3-gif/number_app/assets/71569327/0d2e7066-6896-4849-967c-07c954ecabd1" width="400">          |

### Resources:

* Numbers Api - Website [link](http://numbersapi.com/#420)
* Reso Coder - Flutter TDD Clean Architecture [youtube](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech)
* Reso Coder - Website [link](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/)
