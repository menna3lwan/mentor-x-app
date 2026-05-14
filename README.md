# 🎓 MentorX — AI-Powered Educational Ecosystem

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20DDD-1E3ABA?style=for-the-badge)](#technical-architecture)
[![Workspaces](https://img.shields.io/badge/Monorepo-Melos-FF9F1C?style=for-the-badge)](https://melos.invertase.dev)

MentorX is a state-of-the-art, AI-driven educational platform designed to transform the learning experience for high school students. By integrating advanced performance analysis and personalized path-tracking, MentorX empowers students, parents, and educators with the tools needed for academic excellence.

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

The project follows high-standard software engineering principles to ensure scalability and maintainability.

### High-Level Design
-   **Monorepo Structure**: Managed via [Melos](https://melos.invertase.dev) and integrated Flutter Workspaces.
-   **Clean Architecture**: Separation of concerns into Data, Domain, and Presentation layers.
-   **State Management**: Orchestrated by [BLoC](https://bloclibrary.dev) for predictable state transitions.
-   **Type-Safe Navigation**: Powered by [GoRouter](https://pub.dev/packages/go_router) with code generation.

### 🛠️ Tech Stack
| Category | Technology |
| :--- | :--- |
| **Framework** | Flutter (Stable) |
| **State Management** | BLoC, Cubit |
| **Networking** | Dio (Custom intercepts & repositories) |
| **State Persistence** | Flutter Secure Storage (Cache Repositories) |
| **Localization** | Slang |
| **UI Components** | Custom Modular UI Kit (`mentorx_ui`) |
| **Tools** | Build Runner, Flutter Gen, Melos |

---

## 📂 Project Organization

```text
.
├── apps/
│   ├── student/            # Student-facing mobile application
│   └── parent/             # Parent-facing mobile application
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
-   Flutter SDK (^3.9.2)
-   Dart SDK
-   [Melos](https://melos.invertase.dev) (for package management)

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-org/mentor-x-app.git
    cd mentor-x-app
    ```

2.  **Bootstrap the workspace**:
    ```bash
    dart pub global activate melos
    melos bootstrap
    ```

3.  **Generate code**:
    ```bash
    melos run generate
    ```

4.  **Run the Student App**:
    ```bash
    cd student
    flutter run
    ```

---

## 📄 License

Internal use only. Copyright © 2026 MentorX.
