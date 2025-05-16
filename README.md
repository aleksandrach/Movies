# 🎬 MovieDB Showcase App

This project is a showcase app that consumes **The Movie Database (TMDb)** API and demonstrates advanced iOS development practices including custom architecture, modularization, testing, and UI implementation.

> 🔗 Reference: [TMDb Developer API](https://developers.themoviedb.org)

---

## 🚀 Features

### 1. Main Screen - Trending Movies
- List View to display trending movies.
- Infinite scrolling with pagination support.
- Each cell displays:
  - Movie title
  - Poster image
  - Short description

### 2. Details Screen
- Displays extended information for selected movies:
  - Title, overview, ratings, vote count, genres, etc.
- Fully scrollable layout.

### 3. Favorites Screen
- View and manage a list of favorite movies.
- Mark movies as favorites.
- Favorites are stored locally with visual indicators.

### 4. Search Screen
- Search for movies.
- Includes throttled search behavior.

### 5. About Screen
- UIKit

---

## 🌟 Bonus Features
- Add/remove movies to a local favorites list with visual indicators.
- Offline mode support with local storage (CoreData).
- Image caching.
- Core models extracted to a reusable `.xcframework` for iOS, iPadOS, macOS & tvOS.

---

## 🧱 Technical Highlights

### 📐 Architecture
- MVVM (Model-View-ViewModel)
- Protocol-oriented and object-oriented design
- Generics and type-safe APIs

### 💻 UI & Platform Support
- Built using **SwiftUI** and **UIKit** to demonstrate versatility
- Adaptive layouts for:
  - iPad & iPhone
  - Portrait & landscape orientations

### 🧪 Testing
- `XCTest` unit tests
- Async test handling with expectations
- `XCUITest` integration for UI flows
- SwiftLint integration with custom rules

---

## 🔧 Project Configuration

- Native networking (no third-party dependencies)
- Swift Package Manager (SPM) for all other dependencies
- Shared `Dev` and `Prod` schemes with environment-specific configs
- Clean code standards (small functions, no duplication, safe access control)

---

## 🧠 Goals Demonstrated

- ✅ Advanced Swift & Apple platform development
- ✅ Multi-platform framework support (`xcframework`)
- ✅ Clean architecture, modular code
- ✅ Native concurrency and networking handling
- ✅ Custom design, and UX considerations

---

## 📦 Getting Started

To run the project:
1. Clone the repo.
2. Install packages via Swift Package Manager.
3. Select the desired scheme (e.g., `Movies Dev`).
4. Build and run on a simulator or device.

---

## 📂 Structure Overview

```
├── MovieModels.xcframework         # Shared framework (model layer)
├── MoviesApp                      # iOS App Target
│   ├── Views
│   ├── ViewModels
│   └── Utilities
├── MovieModelsTests               # Unit tests for model layer
├── MoviesTests / MoviesUITests    # UI and integration tests
```

---

## 📜 License

This project is for educational and evaluation purposes only. TMDb API usage requires appropriate API key and compliance with their [terms of use](https://www.themoviedb.org/documentation/api/terms-of-use).
