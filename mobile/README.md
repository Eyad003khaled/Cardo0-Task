# Mobile - Flutter Cross-Platform Application

## Overview

The mobile app is a **Flutter-based cross-platform application** that displays real-time temperature and humidity readings fetched from the backend API and updates automatically every 5 seconds.

## What This Component Does

- **Fetches latest sensor data** from backend `/readings/latest` endpoint
- **Auto-refreshes** temperature and humidity readings every 5 seconds
- **Displays data** with responsive Material Design UI
- **Handles network errors** gracefully with offline awareness
- **Maintains app state** using BLoC/Cubit pattern with dependency injection
- **Supports multiple platforms**: Android and iOS from single Dart codebase

## Architecture

```
lib/
├── main.dart                          # App entry point
├── app/
│   └── cardoo.dart                   # App config, routing, theme
├── core/
│   ├── api/
│   │   ├── endpoints.dart            # API configuration
│   │   ├── api_consumer.dart         # HTTP abstraction
│   │   └── dio_consumer.dart         # Dio implementation
│   ├── services/
│   │   └── injection.dart            # Dependency injection setup
│   ├── routes/
│   │   └── app_router.dart           # Navigation routes
│   └── utils/
│       └── app_colors.dart           # Theming constants
├── features/
│   └── readings/
│       ├── data/
│       │   ├── datasources/          # API data sources
│       │   ├── models/               # Data models (ReadingModel)
│       │   └── repositories/         # Repository implementations
│       ├── domain/
│       │   ├── entities/             # Business entities (ReadingEntity)
│       │   ├── repositories/         # Abstract repositories
│       │   └── usecases/             # Business logic (GetLatestReadingUsecase)
│       └── presentation/
│           ├── cubit/                # State management (ReadingCubit)
│           ├── screens/              # UI screens
│           └── widgets/              # Reusable components
└── connection/
    ├── network_info.dart             # Connectivity detection
    ├── network_aware_widget.dart     # Network wrapper
    └── no_internet_widget.dart       # Offline UI
```

## Key Technologies

- **Framework**: Flutter 3.5.3+
- **Language**: Dart
- **State Management**: BLoC (flutter_bloc 8.0.0+)
- **Dependency Injection**: GetIt service locator
- **HTTP Client**: Dio
- **Network Detection**: data_connection_checker_tv
- **UI Framework**: Material Design

## API Configuration

Backend connection is configured in `lib/core/api/endpoints.dart`:

```dart
class Endpoints {
  static String baseUrl = 'https://eyad-dev.loca.lt';
  static String latestReading = "/readings/latest";
}
```

To change for local development:
```dart
static String baseUrl = 'http://192.168.1.100:3000';  // Local IP
```

## Data Models

### ReadingEntity (Domain Layer)
```dart
class ReadingEntity {
  final double temperature;
  final double humidity;
  final String createdAt;
}
```

### ReadingModel (Data Layer)
Extends `ReadingEntity` with JSON deserialization:
```dart
factory ReadingModel.fromJson(Map<String, dynamic> json) {
  return ReadingModel(
    temperature: (json['temperature'] as num).toDouble(),
    humidity: (json['humidity'] as num).toDouble(),
    createdAt: json['createdAt'] as String,
  );
}
```

## State Management - ReadingCubit

The app uses **BLoC pattern** with Cubit for state management:

```dart
class ReadingCubit extends Cubit<ReadingState> {
  Future<void> fetchReading() async {
    emit(ReadingLoading());
    final result = await getLatestReadingUsecase();
    result.fold(
      (failure) => emit(ReadingError(failure.errMessage)),
      (reading) => emit(ReadingSuccess(reading: reading)),
    );
  }
  
  void startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchReading();
    });
  }
}
```

**States**:
- `ReadingInitial`: Initial state
- `ReadingLoading`: Fetching data
- `ReadingSuccess`: Data received (includes `reading` and `history`)
- `ReadingError`: Error occurred (includes error message)

## Dependency Injection

The `initGetIt()` function in `lib/core/services/injection.dart` configures all dependencies:

```dart
final getIt = GetIt.instance;

void initGetIt() {
  // API layer
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: Dio()),
  );
  
  // Network layer
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<DataConnectionChecker>()),
  );
  
  // Data layer
  getIt.registerLazySingleton<ReadingRepository>(
    () => ReadingRepositoryImpl(
      readingRemoteDataSource: getIt<ReadingRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  
  // Domain layer
  getIt.registerLazySingleton<GetLatestReadingUsecase>(
    () => GetLatestReadingUsecase(repository: getIt<ReadingRepository>()),
  );
  
  // Presentation layer
  getIt.registerFactory(() => ReadingCubit());
}
```

## Features

| Feature | Implementation |
|---------|-----------------|
| **Auto-Refresh** | ReadingCubit with Timer every 5 seconds |
| **Error Handling** | Network and API errors wrapped as Failures |
| **Offline Support** | NetworkInfo checks connectivity before API calls |
| **Responsive UI** | Flutter ScreenUtil for different screen sizes |
| **History Tracking** | ReadingCubit maintains last 10 readings for charting |

## Platform Support

| Platform | Minimum Version | Status |
|----------|-----------------|--------|
| Android | SDK 21 (Android 5.0) | ✓ Supported |
| iOS | iOS 12.0 | ✓ Supported |

### Build Output Paths
- **Android APK**: `build/app/outputs/flutter-app-release.apk`
- **iOS App**: Built via Xcode for TestFlight/App Store

## Responsive Design

- **Portrait Mode**: Optimized for phones
- **Landscape Mode**: Adapts to wider screens
- **Tablet Support**: Uses `DeviceTypeService` for layout detection
- **Dynamic Font Scaling**: Based on screen size and DPI

## Available Flutter Commands

```bash
flutter pub get              # Install dependencies
flutter run                  # Run on connected device
flutter run -d <device_id>   # Run on specific device
flutter build apk            # Build Android APK
flutter build ios            # Build iOS app
flutter test                 # Run tests
flutter clean                # Clean build artifacts
flutter analyze              # Check code quality
```

## Error Handling Strategy

```
API Error → Failure (with message)
           ↓
         Cubit catches → ReadingError state
                        ↓
                      UI shows error message
```

Graceful degradation:
- **No Internet**: Cached data displayed (if available)
- **API Timeout**: Error message shown to user
- **Invalid Data**: Error logged, UI updated

## Integration Points

- **API Input**: `GET https://eyad-dev.loca.lt/readings/latest`
- **Response Format**:
```json
{
  "id": 42,
  "temperature": 25.5,
  "humidity": 60.0,
  "createdAt": "2026-04-28T10:30:46.123Z"
}
```
- **Update Frequency**: Auto-refresh every 5 seconds
- **Serial Output**: None (native mobile app)

## Development Workflow

1. **Edit Dart code**
2. **Press `r`** in terminal for hot reload
3. **UI updates instantly** with code changes preserved
4. **Full restart** with `R` when needed

This enables rapid development and debugging cycles.

---

**Part of**: Cardoo IoT System  
**Created**: April 2026

