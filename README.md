# Phrase of the day

Fondeadora Mobile Software Engineer Coding Test 


# About project
- Use clean architecture
    - Presentation
        - Pages
        - Widgets
        - Bloc
        - Utils
    - Domain
        - Entities
        - Exceptions
        - Repositories
        - Usecases
    - Data
        - Local
        - Remote
- State management Bloc
- Dependency injection with Bloc
- Only Android is supported :(


# Features

### Login:
 - Login with email and password
    - email: `freyien@fondeadora.com`
    - password: `123456`
 - Login with biometrics if device supported
 - Validate text inputs
    - email format
    - password length >= 6
 - Error toast when occurs an error (Server and Auth)

 ### Quote of the day:
 - Request to `https://quotes.rest/`
    - `IMPORTANT`: The account free only support 10 request per hour.
    - After 10 requests the app shows the message "Ha ocurrido un error"
    - The phrase/quote change by day not by request
- Background image
    - From request response if exists
    - else shows an default image
- Quote and author is from request response
- Error toast when occurs an error


# Used packages
- Dependencies
    - [flutter_bloc](https://pub.dev/packages/flutter_bloc)
    - [cached_network_image](https://pub.dev/packages/cached_network_image)
    - [dio](https://pub.dev/packages/dio)
    - [bot_toast](https://pub.dev/packages/bot_toast)
    - [local_auth](https://pub.dev/packages/local_auth)
- Dev Dependencies
    - [flutter_lints](https://pub.dev/packages/flutter_lints)
    - [mocktail](https://pub.dev/packages/mocktail)
    - [bloc_test](https://pub.dev/packages/bloc_test)
    - [http_mock_adapter](https://pub.dev/packages/http_mock_adapter)
    - [mockingjay](https://pub.dev/packages/mockingjay)


# To build and run this project:

1. Get Flutter [here](https://flutter.dev) if you don't already have it
2. Clone this repository.
3. `cd` into the repo folder.
4. run `flutter run`

# To run tests (Unit and Widget)
1. run `flutter test`


# To know coverage
1. install lcov
    - For linux run 
        - `sudo apt-get update -qq -y`
        - `sudo apt-get install lcov -y`
    - For mac run `brew install lcov`
3. `cd` into the repo folder.
4. run `flutter test --coverage`
5. run `genhtml coverage/lcov.info -o coverage/html`

<img src='https://github.com/Freyien/Quote-of-the-day/blob/master/assets/project/coverage.jpg' width="250">


# Extra
Do you wanna know more about the project? Call me :) 