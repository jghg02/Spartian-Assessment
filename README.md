# Sportian Assessment App

## Overview

The Sportian Assessment App is an iOS application that demonstrates the use of Clean Architecture combined with the MVVM (Model-View-ViewModel) pattern. It integrates asynchronous networking using the NET library (added via Swift Package Manager), allowing the app to fetch character data from the Rick and Morty API and display it in a paginated list format.

Features

- Fetches and displays a list of characters from the Rick and Morty API.
- Supports infinite scrolling with pagination, loading 10 characters at a time.
- Allows users to view detailed information about each character.
- Includes a search bar for filtering characters by name.
- Caches character data locally using Core Data to reduce network requests.
- Implements a loading indicator for seamless user experience while data is being fetched.

## Architecture

### Clean Architecture

This app uses Clean Architecture to separate concerns and ensure that each layer in the application has a single responsibility. The key layers in this app are:
- Presentation Layer - Contains View and ViewModel components.
- Domain Layer - Contains business logic, represented by the Repository interface and models.
- Data Layer - Responsible for data management, including network requests and caching with Core Data.

### MVVM Pattern

The Model-View-ViewModel (MVVM) pattern is employed within the Clean Architecture structure to manage the app’s data flow and UI updates efficiently.
- Model: Represents data structures, such as Character and LocationInfo, which hold information about each character.
- ViewModel: Contains logic for interacting with the data layer (repository) and prepares data for display in the views. Examples include CharacterListViewModel for managing character list data and CharacterDetailViewModel for managing individual character data.
- View: The SwiftUI views, such as CharacterListView and CharacterDetailView, which display the data provided by the ViewModels.

## Libraries and Dependencies

This app uses the NET library for networking, added via Swift Package Manager (SPM).

### [NET Library](https://github.com/jghg02/NET)

The NET library simplifies networking with a flexible and asynchronous API. It provides an easy way to handle HTTP requests, error management, and parsing JSON responses. The following describes its usage in this app:
- Character List Fetching: Using NET’s NETClient, the app fetches paginated character lists from the Rick and Morty API.
- Character Detail Fetching: Fetches detailed information for individual characters on demand.

The repository layer (CharacterRepository) manages all network requests using the NET library.

## Project Structure

The project structure is organized according to Clean Architecture and MVVM principles:

```
SportianAssessmentApp
├── Models
│   ├── Character.swift
│   ├── LocationInfo.swift
│   └── APIResponse.swift
├── Views
│   ├── CharacterListView.swift
│   ├── CharacterRow.swift
│   └── CharacterDetailView.swift
├── ViewModels
│   ├── CharacterListViewModel.swift
│   └── CharacterDetailViewModel.swift
├── Repositories
│   ├── CharacterRepository.swift
├── Networking
│   └── NetworkManager.swift
├── Persistence
│   ├── PersistenceController.swift
│   └── CachedCharacterModel+CoreDataClass.swift
└── Utilities
    └── Views
        └── LoadingView.swift
```

## Key Components

- Models: Define the data structures used in the app, including the character and location models.
- Views: SwiftUI views that display character lists and details, leveraging data from the ViewModels.
- ViewModels: Contain the logic to fetch and prepare data for the views. They communicate with the repository to get data from network or cache.
- Repositories: Implement the CharacterRepositoryProtocol, handling data fetching and caching. The CharacterRepository decides whether to fetch from the network or Core Data.
- Networking: NetworkManager manages API requests using the NET library.
- Persistence: PersistenceController and CachedCharacterModel manage Core Data storage for caching character data.

