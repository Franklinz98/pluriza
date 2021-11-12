# Prueba Técnica Pluriza 

**Flutter** application that consumes ***JSONPlaceholder*** and developed using __Clean Architecture, State Management, Local Database__ and __Unit Testing.__
<p align="center">
  <img src="https://user-images.githubusercontent.com/25647254/141509302-d0cf6c93-76bd-4c31-a667-62b7253a421e.gif" alt="iPhone 13" />
</p>

## Installation

To run the project you simply have to:
1. Clone this repository.
2. ***Get*** the Flutter packages using:
```console
$ flutter pub get
```
3. Launch the application on an emulator or real device.

## Architecture

For this project ***Clean Architecture*** was used, which allows to make the code as clean as possible, for this there are many good practices that include how variables are named, how we build functions, abstraction of objects and structures, etc. All this allows the code to be much more understandable, have greater scalability and abstraction between the different modules. The folder structure used was:

<p align="center">
  <img src="https://user-images.githubusercontent.com/25647254/141511823-0a42c74b-18f1-4025-95d1-0f09b647c43f.png" alt="Clean Architecture" />
</p>

Where:
- **data:** Has everything related to external services and repositories.
- **domain:** Has everything related to bussiness logic and state management.
- **ui:** Has everything related to __Flutter__ code, all the __User Interface__.

Within each top-level folder are more subdivided folders that provide compartmentalization, modularity, and project abstraction.

### State Management

In addition to Clean Architecture, the level of abstraction was increased using __State Management__ using the **GetX** package, allowing data to be handled without complications and maintaining consistency between screens.

### Cache

To implement the cache, the **Sqflite** package was used, a __local relational database__ that allows executing queries and operations based on __SQLite__.

In order to demonstrate the difference between the behavior of cached data and no cached data, I proceeded to establish persistence for the **Post** objects ***only***, while the other objects (Comments and Users) **do not** have disk cache.

### Unit Testing

The unit tests implemented evaluate each one of the managers developed, checking that the interaction with each one of the **GetControllers** (State Management) is correct.

<p align="center">
  <img src="https://user-images.githubusercontent.com/25647254/141523750-973ee601-5894-4a3e-9b5f-d26484e5d6da.png" alt="Unit Testing" />
</p>

## Packages

### 1. GetX
- **Pub Repository:** [get: ^4.3.8](https://pub.dev/packages/get)

**GetX** stands out for being a solution for different use cases in Flutter, it is preferred because it offers great **performance** and under a single package there are solutions that are highly **adaptable** to different contexts.

***Main Pros***
- Multiplatform support
- State Management
- Route Management
- Dependency Injection
- Various utilities such as __Theme Management__ or __Platform Detection__ among others.

### 2. Http
- **Pub Repository:** [http: ^0.13.4](https://pub.dev/packages/http)

**Http** stands out as Dart's __official__ Http request package, its composable fundamentals and **future-based methods** allow it to adapt to various contexts, allowing you to set various options depending on what you are looking for.

***Main Pros***
- Composable
- Future Based
- Official Package

### 3. Google Fonts
- **Pub Repository:** [google_fonts: ^2.1.0](https://pub.dev/packages/google_fonts)

**Google Fonts** stands out as Material.io __official__ font pack, this package allows access to all the fonts hosted at https://fonts.google.com/.

***Main Pros***
- Multiple free fonts
- Easy to use
- Official Package

### 4. Sqflite
- **Pub Repository:** [sqflite: ^2.0.0+4](https://pub.dev/packages/sqflite)

**Sqflite** is recommended and used in the __official Flutter documentation__ and because it is based on __SQLite__ it has a small learning curve.

***Main Pros***
- Multiplatform
- SQLite Based
- Background Thread Operation

### 5. Mockito
- **Pub Repository:** [mockito: ^5.0.16](https://pub.dev/packages/mockito)

**Mockito** stands out as Dart's __official__ mocking package for testing, and it is featured in the __official Flutter documentation__. It is easy to use and simplifies the testing task.

***Main Pros***
- Easy to use
- Developed for Dart and Flutter
- Official Package

All previous packages are **__Null Safety__ compliant.**
