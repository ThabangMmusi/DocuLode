# Project Structure Documentation

## Overview
This document provides a detailed overview of the DocuLode project structure, following Clean Architecture principles and feature-first organization.

## Root Structure
```
lib/
├── animated/          # Animation-related code
├── commands/          # Command pattern implementations
├── constants/         # Application constants
├── core/             # Core functionality and shared code
├── cubits/           # BLoC cubits for state management
├── features/         # Feature modules
├── operations/       # Business operations
├── presentation/     # UI components
├── routes/           # Navigation routes
├── services/         # Service layer implementations
├── widgets/          # Shared widgets
├── app_keys.dart     # Keys for testing and identification
├── firebase_options.dart  # Firebase configuration
├── injection_container.dart  # Dependency injection setup
├── main.dart         # Application entry point
├── main2.dart        # Alternative entry point
├── styles.dart       # Global styles
└── themes.dart       # Theme configurations
```

## Core Module (`lib/core/`)
```
core/
├── _utils/          # Internal utilities
├── app_logo/        # Application logo components
├── common/          # Common functionality
├── components/      # Reusable components
├── data/           # Data layer implementations
├── domain/         # Domain layer implementations
├── enums/          # Enumeration definitions
├── error/          # Error handling
├── progress/       # Progress indicators
├── usecase/        # Use case implementations
└── utils/          # Utility functions
```

## Features Module (`lib/features/`)
```
features/
├── auth/           # Authentication feature
├── dashboard/      # Dashboard feature
├── profile/        # User profile feature
├── profile_setup/  # Profile setup flow
├── settings/       # Application settings
├── setup/          # Initial setup
├── shell/          # Application shell/layout
├── shared/         # Shared feature components
├── upload_edit/    # Upload editing
├── upload_preview/ # Upload preview
├── upload_progress/# Upload progress tracking
└── uploads/        # File uploads
```

## Key Files
1. **`main.dart`**
   - Application entry point
   - Initial setup and configuration
   - Root widget tree

2. **`injection_container.dart`**
   - Dependency injection setup
   - Service registration
   - BLoC provider configuration

3. **`themes.dart`**
   - Theme configuration
   - Color schemes
   - Typography settings

4. **`styles.dart`**
   - Global style definitions
   - Common styling utilities

## Architecture Implementation

### Clean Architecture Layers
1. **Presentation Layer**
   - `presentation/` directory
   - `widgets/` directory
   - Feature-specific UI components in `features/`

2. **Domain Layer**
   - `core/domain/` for shared domain logic
   - Feature-specific domain logic in `features/`

3. **Data Layer**
   - `core/data/` for shared data implementations
   - `services/` for external service integrations
   - Feature-specific data implementations in `features/`

### State Management
- Using BLoC pattern with cubits
- Cubits located in `cubits/` directory
- Feature-specific state management in respective feature directories

### Dependency Injection
- Centralized in `injection_container.dart`
- Service locator pattern using `get_it`
- Feature-specific dependencies in feature modules

## Feature Organization
Each feature module follows a consistent structure:
```
feature_name/
├── data/           # Data layer
├── domain/         # Domain layer
├── presentation/   # UI components
└── feature.dart    # Feature barrel file
```

## Best Practices
1. **Feature-First Organization**
   - Features are self-contained
   - Clear separation of concerns
   - Easy to maintain and scale

2. **Code Organization**
   - Related code is kept together
   - Clear file naming conventions
   - Consistent directory structure

3. **Dependency Management**
   - Centralized dependency injection
   - Clear dependency boundaries
   - Easy to test and mock

## Future Considerations
1. **Modularization**
   - Consider breaking into separate packages
   - Feature-based modularization
   - Shared module extraction

2. **Testing Structure**
   - Unit test organization
   - Integration test setup
   - Widget test structure

3. **Documentation**
   - Code documentation
   - Architecture documentation
   - API documentation 