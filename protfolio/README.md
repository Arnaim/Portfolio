# Naimur Rahman Arnab - Modern Flutter Portfolio

A professional, high-performance portfolio application built with **Flutter**, featuring a modern Slate & Indigo aesthetic, reactive state management, and seamless Firebase integration.

## 🚀 Key Features

-   **Modern Visuals:** Glassmorphic UI elements, refined typography, and a sophisticated dark theme.
-   **Dynamic Animations:** Smooth entry transitions and interactive effects powered by `flutter_animate`.
-   **Reactive Architecture:** Built with **Riverpod** for robust state management and dependency injection.
-   **Firebase Integrated:** Real-time data fetching from Cloud Firestore for projects and certificates.
-   **Responsive Design:** Fully optimized for Web, Tablet, and Mobile interfaces.
-   **Clean Navigation:** Declarative routing implemented with **Go Router**.

## 🛠 Tech Stack

-   **Framework:** [Flutter](https://flutter.dev/) (Web/Mobile)
-   **State Management:** [Riverpod](https://riverpod.dev/)
-   **Navigation:** [Go Router](https://pub.dev/packages/go_router)
-   **Animations:** [Flutter Animate](https://pub.dev/packages/flutter_animate)
-   **Backend:** [Firebase](https://firebase.google.com/) (Firestore)
-   **Version Management:** [FVM](https://fvm.app/)

## 📂 Project Structure

-   `lib/core/`: Theme definitions, global constants, and Riverpod providers.
-   `lib/layouts/`: Main application shell with glassmorphic navigation.
-   `lib/sections/`: Individual feature sections (Home, About, Projects, Contact).
-   `lib/widgets/`: Reusable UI components like `ProjectCard` and `SkillChip`.
-   `lib/router/`: App routing configuration.

## ⚙️ Getting Started

This project uses **FVM** to ensure consistent Flutter versions.

### Prerequisites
1.  Install [FVM](https://fvm.app/docs/getting_started/installation).
2.  Install [Flutter SDK](https://docs.flutter.dev/get-started/install).

### Setup
All commands should be executed within the `protfolio/` directory.

1.  **Install dependencies:**
    ```bash
    fvm flutter pub get
    ```

2.  **Run in Debug mode (Web):**
    ```bash
    fvm flutter run -d chrome
    ```

3.  **Build for Production (Web):**
    ```bash
    fvm flutter build web --release
    ```

## 📝 License

© 2024 Naimur Rahman Arnab. All rights reserved.
