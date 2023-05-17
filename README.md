# Currency Exchange

Currency Exchange is a simple currency converter application that provides users with real-time exchange rates for various currencies. Through an easy-to-use interface, users can quickly convert between currencies and get up-to-date information on exchange rates.

<!-- TOC -->
## Table of Contents
* [Currency Exchange](#currency-exchange)
  * [Getting Started](#getting-started)
  * [Adapted Design Patterns](#adapted-design-patterns)
  * [Adapted Image Loader](#adapted-image-loader)
  * [Database Used](#database-used)
  * [Dependencies](#dependencies)
<!-- TOC -->

## Getting Started

To set up the project, first generate the Hive Type Adapters and injection Di files by running the following command:

```bash
dart run build_runner build --delete-conflicting-outputs;
```

## Adapted Design Patterns

This application uses multiple design patterns to provide a solid foundation for development and maintainability.

| Pattern              | Usage                                                                                                                                                                       |
|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| BLoC                 | Business Logic Component pattern is used to separate presentation from business logic to improve code readability, testability, and re-usability.                           |
| Repository           | Repository pattern is used to abstract the data sources and handle data retrieval and storage, making the application more resilient to changes in the data layer.          |
| Singleton            | Singleton pattern is used to ensure that certain classes have only one instance throughout the app, improving performance and preventing issues with multiple instances.    |
| State                | State pattern is used to manage the state and behavior of certain classes, enabling a clear representation of the different states and transitions between them.            |
| Dependency Injection | Dependency Injection is used to manage dependencies between classes, offering better modularity and separation of concerns, making it easier to test and maintain the code. |
| Service Locator      | Service Locator pattern is implemented as a part of Dependency Injection to efficiently locate services and manage their lifecycles.                                        |

## Adapted Image Loader

This application uses the [Cached Network Image](https://pub.dev/packages/cached_network_image) package to efficiently load and cache images from the internet, improving performance and reducing network usage.

## Database Used

The application stores data using [Hive](https://pub.dev/packages/hive), a lightweight, high-performance NoSQL database that is easy to set up and use, making it a perfect choice for this project.


## Dependencies

This section provides an overview of the key dependencies included in the `currency_exchange` package, along with the reasons for their inclusion:

- **cached_network_image** - This package is used for efficient image loading and caching, reducing the amount of network usage and improving performance.
- **collection** - Provides utility functions for dealing with lists and collections, facilitating the manipulation and transformation of data.
- **equatable** - Enables simplified equality comparisons by removing the need to override the equality operator and hashCode getter.
- **dio** - A powerful, feature-rich HTTP library used for making network requests.
- **get_it, injectable** - These packages work together to provide an efficient and flexible Dependency Injection and Service Locator solution, streamlining dependency management.
- **flutter_bloc** - A popular state management library that adheres to the BLoC pattern, helping to separate presentation from business logic and improving maintainability.
- **provider, flutter_hooks** - Used in conjunction with flutter_bloc to provide Blocs efficiently and support hooks for better state management (animations, form validation, etc.).
- **flutter_dotenv** - Enables the storage and management of global environment variables, promoting better organization and configurability.
- **syncfusion_flutter_charts** - A package for creating beautiful and functional charts for data visualization.
- **hive, hive_flutter** - Lightweight and fast NoSQL database solution for local data storage on the device, improving application performance.
- **path_provider** - A plugin that allows access to the device's file system for platform-specific storage solutions.
- **dartz** - A package that provides functional error handling in Flutter.
- **lint** - A static analysis tool to enforce coding standards and catch potential issues and style violations.
- **hive_generator, injectable_generator** - These generators streamline the management of Hive Type Adapters and Dependency Injection configurations.
- **mocktail, bloc_test, build_runner** - Development and testing utilities that enable efficient workflows and thorough testing capabilities.

By including these packages and configurations in one place, `currency_exchange` makes it easier to develop a robust currency conversion application with a well-maintained and highly performant codebase.
