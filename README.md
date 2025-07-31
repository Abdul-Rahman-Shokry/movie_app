# 🎬 MovieApp - Flutter Movie Discovery App

A modern, feature-rich Flutter application for discovering and exploring movies. Built with clean architecture, BLoC pattern, and powered by The Movie Database (TMDB) API.

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?style=for-the-badge&logo=dart)
![BLoC](https://img.shields.io/badge/BLoC-Pattern-orange?style=for-the-badge)
![TMDB](https://img.shields.io/badge/TMDB-API-yellow?style=for-the-badge)

## ✨ Features

### 🎯 Core Features
- **Movie Discovery**: Browse popular, trending, and upcoming movies
- **Advanced Search**: Real-time search with debounced suggestions
- **Movie Details**: Comprehensive movie information with cast, crew, and recommendations
- **Dark/Light Theme**: Toggle between themes with persistent preferences
- **Responsive Design**: Optimized for various screen sizes

### 🎨 UI/UX Features
- **Modern Design**: Clean, intuitive interface with Material Design 3
- **Theme Support**: Light and dark theme with automatic switching
- **Smooth Animations**: Fluid transitions and loading states
- **Error Handling**: Graceful error states with retry functionality
- **Loading States**: Beautiful loading indicators throughout the app

### 🔧 Technical Features
- **Clean Architecture**: Well-organized code structure with separation of concerns
- **BLoC Pattern**: State management using Flutter BLoC
- **API Integration**: TMDB API for real movie data
- **Image Caching**: Efficient image loading with cached network images
- **Offline Support**: Persistent theme preferences using SharedPreferences

## 📱 Screenshots

<details>
<summary>Click to view screenshots</summary>

### Home Screen
- Popular, trending, and upcoming movies
- Search functionality with real-time suggestions
- Theme toggle in app bar

### Movie Details
- Comprehensive movie information
- Cast and crew details
- Movie recommendations
- YouTube trailer integration

### Search Results
- Grid layout for search results
- Real-time search suggestions
- Empty state handling

</details>

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/movie_app.git
   cd movie_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

The app uses TMDB API for movie data. The API key is already configured in the constants file:

```dart
// lib/core/utils/constants.dart
static const String tmdbApiKey = 'your_api_key_here';
```

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── cubit/
│   │   └── theme_cubit.dart
│   ├── models/
│   │   ├── movie.dart
│   │   ├── movie_details.dart
│   │   └── ...
│   ├── network/
│   │   └── api_client.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── style/
│   │   └── app_themes.dart
│   ├── utils/
│   │   └── constants.dart
│   └── widgets/
│       ├── error_message.dart
│       └── loading_indicator.dart
├── features/
│   ├── home/
│   │   ├── cubit/
│   │   ├── models/
│   │   └── ui/
│   ├── movie_details/
│   │   ├── cubit/
│   │   ├── models/
│   │   └── ui/
│   └── search/
│       ├── cubit/
│       └── ui/
└── main.dart
```

## 🛠️ Technologies Used

### Frontend
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Material Design 3**: Design system

### State Management
- **flutter_bloc**: BLoC pattern implementation
- **equatable**: Value equality for BLoC states

### Networking & Data
- **dio**: HTTP client for API calls
- **json_annotation**: JSON serialization
- **cached_network_image**: Image caching

### UI/UX
- **youtube_player_flutter**: Video player for trailers
- **shared_preferences**: Local storage for theme preferences

## 🎯 Key Features Explained

### 1. Movie Discovery
- **Popular Movies**: Fetches current popular movies from TMDB
- **Trending Movies**: Shows trending movies of the week
- **Upcoming Movies**: Displays upcoming releases

### 2. Advanced Search
- **Real-time Search**: Instant search results as you type
- **Debounced Input**: Optimized API calls with 500ms delay
- **Search Suggestions**: Live suggestions while typing
- **Search Results**: Grid layout for better visualization

### 3. Movie Details
- **Comprehensive Info**: Title, overview, rating, release date
- **Cast & Crew**: Detailed cast and crew information
- **Movie Trailers**: YouTube trailer integration
- **Recommendations**: Similar movies suggestions

### 4. Theme System
- **Light/Dark Themes**: Toggle between themes
- **Persistent Preferences**: Theme choice saved locally
- **Dynamic Icons**: Theme-aware UI elements

## 🔧 API Integration

The app integrates with The Movie Database (TMDB) API:

- **Base URL**: `https://api.themoviedb.org/3`
- **Image Base URL**: `https://image.tmdb.org/t/p/w500`
- **Endpoints Used**:
  - `/movie/popular` - Popular movies
  - `/trending/movie/week` - Trending movies
  - `/movie/upcoming` - Upcoming movies
  - `/search/movie` - Search movies
  - `/movie/{id}` - Movie details

## 🎨 Design System

### Color Scheme
- **Primary**: Material Design 3 colors
- **Secondary**: Theme-aware accent colors
- **Background**: Adaptive light/dark backgrounds

### Typography
- **Headlines**: Large, bold text for titles
- **Body**: Readable body text
- **Captions**: Small text for metadata

### Components
- **Movie Cards**: Rounded corners with shadows
- **Search Bar**: Material Design input field
- **Loading States**: Skeleton screens and spinners
- **Error States**: User-friendly error messages

## 🚀 Performance Optimizations

- **Image Caching**: Efficient image loading and caching
- **Debounced Search**: Reduced API calls during typing
- **Lazy Loading**: Load content as needed
- **Error Boundaries**: Graceful error handling
- **Memory Management**: Proper disposal of resources

## 🧪 Testing

The project includes comprehensive testing:

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart
```

## 📦 Dependencies

### Production Dependencies
```yaml
flutter_bloc: ^9.1.1
dio: ^5.8.0+1
shared_preferences: ^2.2.2
json_annotation: ^4.9.0
cached_network_image: ^3.4.1
youtube_player_flutter: ^9.1.1
equatable: ^2.0.7
```

### Development Dependencies
```yaml
flutter_lints: ^5.0.0
build_runner: ^2.6.0
json_serializable: ^6.10.0
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter coding conventions
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **TMDB**: For providing the movie data API
- **Flutter Team**: For the amazing framework
- **BLoC Team**: For the state management solution
- **Material Design**: For the design system

## 📞 Support

If you have any questions or need help:

- **Issues**: [GitHub Issues](https://github.com/abdul-rahman-shokry/movie_app/issues)
- **Email**: abdul.rahman.shokry2004@gmail.com

---

<div align="center">

**Made with ❤️ using Flutter**

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?style=for-the-badge&logo=dart)](https://dart.dev)

</div>
