# Project Overview: Protfolio

This project is a personal portfolio application built with **Flutter**. It is designed to showcase the developer's profile, projects, and contact information through a responsive and visually appealing web/mobile interface.

## Technologies and Tools
- **Framework:** Flutter (Web/Mobile)
- **Navigation:** [Go Router](https://pub.dev/packages/go_router) for declarative routing.
- **State Management:** [Riverpod](https://riverpod.dev/) for reactive state and dependency injection.
- **Backend:** [Firebase](https://firebase.google.com/) (Firebase Core and Cloud Firestore).
- **Icons:** Font Awesome Flutter.
- **Version Management:** [FVM](https://fvm.app/) (Flutter Version Management).
- **Styling:** Custom theme with a triadic palette, defined in `lib/core/theme.dart` and `lib/core/constants.dart`.

## Project Structure
The core application logic is located in the `protfolio/` directory.

- `protfolio/lib/main.dart`: Entry point of the application.
- `protfolio/lib/core/`: Contains global constants, theme definitions, and utility functions.
- `protfolio/lib/router/`: Defines the navigation structure using `GoRouter` and `ShellRoute`.
- `protfolio/lib/layouts/`: Contains the `MainLayout` widget which provides a consistent AppBar and Footer across sections.
- `protfolio/lib/sections/`: Individual pages/sections of the portfolio (Home, About, Projects, Contact).
- `protfolio/lib/widgets/`: Reusable UI components used throughout the application.
- `protfolio/assets/`: Static assets such as images and PDFs (e.g., CV).

## Building and Running

Since this project uses FVM, it is recommended to prefix commands with `fvm`.

### Prerequisites
- Flutter SDK (version specified in `.fvmrc` or `pubspec.yaml`)
- FVM (optional but recommended)

### Commands
All commands should be run from the `protfolio/` directory.

- **Install Dependencies:**
  ```bash
  fvm flutter pub get
  ```
- **Run the Application:**
  ```bash
  fvm flutter run -d chrome
  ```
- **Build for Web:**
  ```bash
  fvm flutter build web
  ```
- **Run Tests:**
  ```bash
  fvm flutter test
  ```

## Development Conventions

- **State Management:** Currently uses standard Flutter state management or Firebase streams for data.
- **Routing:** All routes are defined in `lib/router/app_router.dart`. Use `context.go('/path')` for navigation.
- **Styling:** Avoid hardcoding colors or text styles. Use `AppConstants` from `lib/core/constants.dart` or `Theme.of(context)` to maintain consistency.
- **Responsiveness:** Use `MediaQuery` to adjust layouts for different screen sizes (breakpoints are often around 900px as seen in `MainLayout`).
- **Assets:** Register all new assets in `pubspec.yaml` under the `flutter: assets` section.
 in `MainLayout`).
- **Assets:** Register all new assets in `pubspec.yaml` under the `flutter: assets` section.
