# 🎓 MentorX Project Context

Welcome to the MentorX codebase. This document provides the foundational context, architectural patterns, and development workflows for the MentorX ecosystem.

---

## 🏗️ Architectural Overview

MentorX is built as a **Flutter Monorepo** using **Dart Workspaces**. It follows **Clean Architecture** and **Domain-Driven Design (DDD)** principles to ensure high maintainability and scalability.

### Project Structure
- **Apps:**
  - `student/`: The primary mobile application for students.
  - `parent/`: The primary mobile application for parents.
- **Shared Packages (`packages/`):**
  - `mentorx_core/`: The core domain layer containing models, value objects, and repository interfaces.
  - `mentorx_ui/`: A unified UI kit using **Mix** for styling, **Slang** for localization, and **AppAssets** for generated assets.
  - `clients/dio_http_client/`: A pre-configured Dio instance with global interceptors.
  - `mock_data/`: Centralized JSON/Dart mock data for rapid prototyping and testing.
- **Repositories:**
  - `packages/student/` & `packages/parent/`: Implementation-specific repositories (e.g., `dio_authentication_repository`).
  - `packages/mock/`: Mock implementations of repositories for offline development.

---

## 🛠️ Tech Stack & Patterns

- **State Management:** [BLoC / Cubit](https://bloclibrary.dev)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router) with type-safe routes.
- **Networking:** [Dio](https://pub.dev/packages/dio)
- **Styling:** [Mix](https://www.fluttermix.com) (Atomic design primitives)
- **Localization:** [Slang](https://pub.dev/packages/slang)
- **Dependency Injection:** Usually handled via `RepositoryProvider` and `BlocProvider` at the app shell level.
- **Code Generation:** Heavy use of `build_runner`, `flutter_gen`, and `slang`.

---

## 🚀 Development Workflows

### Setup & Bootstrapping
The project uses Dart Workspaces. Running commands at the root generally affects all packages.
```bash
flutter pub get
```

### Code Generation
Most packages and apps require code generation for models (json_serializable), routes, and assets.
```bash
# In any app or package directory
dart run build_runner build --delete-conflicting-outputs
```

### Localization
Localization files are managed via Slang.
```bash
# In mentorx_ui or app directories
dart run slang
```

### Makefiles
Common tasks are often wrapped in `makefile` files within the app directories (`student/`, `parent/`).
- `make generate`: Runs build_runner.
- `make update_localization`: Runs slang.
- `make clean_and_get`: Performs a deep clean and fetches dependencies.

---

## 🎨 Design & UI Conventions

- **Colors:**
  - Primary Blue: `#1E3ABA`
  - Accent Warm: `#FF9F1C`
  - Secondary Green: `#2EC4B6`
- **UI Kit:** Always prefer components from `packages/mentorx_ui`.
- **Styling:** Use `Mix` primitives rather than raw `Container` or `DecoratedBox` whenever possible to maintain theme consistency.
- **Assets:** Access assets via the generated `AppAssets` class (from `flutter_gen`).

---

## 🧪 Testing & Validation

- **Unit/Widget Tests:** Found in `test/` directories of respective apps/packages.
- **Integration Tests:** Located in `integration_test/`.
- **Mocks:** Use the `packages/mock/` repositories for building UI without a live backend.

---

## 📖 Key Documentation
- `README.md`: High-level ecosystem overview.
- `documentation/blueprint/PRODUCTION_BLUEPRINT.md`: Comprehensive guide to the monorepo architecture.
- `documentation/API_ENDPOINTS.md`: Backend integration details.
