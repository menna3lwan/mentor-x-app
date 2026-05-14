# 🎓 MentorX — AI-Powered Educational Ecosystem

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20DDD-1E3ABA?style=for-the-badge)](#technical-architecture)
[![Workspaces](https://img.shields.io/badge/Monorepo-Melos-FF9F1C?style=for-the-badge)](https://melos.invertase.dev)

MentorX is a Flutter monorepo that delivers a premium, AI-augmented learning experience for students and real-time academic visibility for parents. The mobile apps are backed by the EduCore API, with shared domain models and UI foundations across the suite.

---

## 🌟 The Ecosystem

MentorX is built as a unified monorepo containing multiple specialized applications and packages:

*   **📱 Student App**: A personalized learning companion for high school students featuring course tracking, AI insights, and achievement milestones.
*   **👨‍👩‍👧 Parent App**: Real-time visibility into student progress, performance metrics, and direct communication with mentors.
*   **🖥️ Admin/Teacher Dashboards**: Powerful interfaces for curriculum management and student support.

---

## ✨ Key Features

-   **🤖 AI-Powered Path Tracking**: Intelligent analysis of student performance to suggest the most efficient learning paths.
-   **📈 Deep Performance Insights**: Visual dashboards showing progress across various subjects and skill sets.
-   **🌍 Multilingual Support**: Fully localized experience using `Slang` for seamless switching between languages.
-   **🎨 Dynamic Brand Theming**: A premium UI kit built with a curated palette:
    -   **Primary Blue (#1E3ABA)**: Authority and Professionalism (Primary)
    -   **Accent Warm (#FF9F1C)**: Energy and Action (Accent/CTA)
    -   **Secondary Green (#2EC4B6)**: Growth and Success
-   **🔒 Secure & Resilient**: Modern authentication flows and robust offline caching.

---

## 🏗️ Technical Architecture

The project follows clean architecture principles with domain-driven organization and shared libraries.

### 🛠️ Tech Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | Flutter (Stable) |
| **State Management** | BLoC, Cubit |
| **Networking** | Dio (typed repositories) |
| **State Persistence** | Flutter Secure Storage |
| **Localization** | Slang |
| **Navigation** | GoRouter (codegen) |
| **UI Components** | `mentorx_ui` design system |

---

## 📂 Repository Structure

```text
.
├── student/                          # Student-facing mobile app
├── parent/                           # Parent-facing mobile app
├── packages/
│   ├── mentorx_core/       # Shared domain models and logic
│   ├── mentorx_ui/         # Unified UI kit and theme tokens (Primary Blue / Accent Warm)
│   ├── clients/            # Shared networking clients (Dio)
│   ├── common/             # Shared utilities & repository interfaces
│   └── mock_data/          # Centralized mock data for rapid prototyping
├── docs/                   # Full system documentation & blueprints
└── melos.yaml              # Monorepo configuration
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (stable)
- Dart SDK

### Installation

```bash
flutter pub get
```

### Run the Student App

```bash
cd student
flutter run
```

### Run the Parent App

```bash
cd parent
flutter run
```

### Quality Checks

```bash
flutter analyze
flutter test
```

---

## 📄 License

Internal use only. Copyright © 2026 MentorX.
