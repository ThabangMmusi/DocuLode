# Project Architecture

## Overview
This document outlines the high-level architecture of the DocuLode Flutter application, following Clean Architecture principles and using BLoC for state management.

## Clean Architecture Layers

### 1. Presentation Layer (UI)
- **Screens**: UI components and pages
- **Widgets**: Reusable UI components
- **BLoCs**: State management and business logic presentation
  - Auth BLoC
  - User Profile BLoC
  - Document Management BLoC

### 2. Domain Layer (Business Logic)
- **Entities**: Core business objects
- **Use Cases**: Application-specific business rules
- **Repository Interfaces**: Abstract definitions of data operations

### 3. Data Layer
- **Repositories**: Implementation of repository interfaces
- **Data Sources**:
  - Remote (Supabase API)
  - Local (SQLite, SharedPreferences)
- **Models**: Data transfer objects (DTOs)

## Folder Structure
```
lib/
├── core/                    # Core functionality
│   ├── error/              # Error handling
│   ├── network/            # Network utilities
│   └── utils/              # Utility functions
│
├── data/                   # Data Layer
│   ├── datasources/        # Data sources
│   │   ├── remote/        # Remote data sources
│   │   └── local/         # Local data sources
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
│
├── domain/                # Domain Layer
│   ├── entities/          # Business objects
│   ├── repositories/      # Repository interfaces
│   └── usecases/         # Use cases
│
├── presentation/          # Presentation Layer
│   ├── blocs/            # BLoC components
│   ├── pages/            # Screen implementations
│   └── widgets/          # Reusable widgets
│
└── main.dart             # Application entry point
```

## BLoC Architecture
- **State Management**: Using BLoC pattern for predictable state management
- **BLoC Structure**:
  - Events: User actions and system events
  - States: UI states and data models
  - BLoC: Business logic and state management

## Dependency Injection
- Using `get_it` for dependency injection
- Registering dependencies at app startup
- Providing mock implementations for testing

## Supabase Integration
- **Authentication**: User management and auth flows
- **Database**: Real-time and offline data storage
- **Storage**: File storage and management
- **Functions**: Serverless functions for complex operations

## Key Design Decisions
1. Clean Architecture for separation of concerns
2. BLoC for state management
3. Supabase for backend services
4. Dependency injection for better testing
5. Repository pattern for data abstraction

## Dependencies
- Flutter SDK
- flutter_bloc: State management
- get_it: Dependency injection
- supabase_flutter: Backend services
- [Other key dependencies to be listed]

## Testing Strategy
1. **Unit Tests**
   - Use cases
   - BLoCs
   - Repositories

2. **Integration Tests**
   - Feature flows
   - API integration
   - Database operations

3. **Widget Tests**
   - UI components
   - Screen interactions
   - State changes

## Future Considerations
- Performance optimization strategies
- Scaling considerations
- Security measures
- Offline-first capabilities
- Caching strategies
