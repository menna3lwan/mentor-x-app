# 🎓 MentorX — AI-Powered Educational Ecosystem

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20DDD-183764?style=for-the-badge)](#technical-architecture)
[![Workspace](https://img.shields.io/badge/Workspace-Dart%20Workspaces-F59239?style=for-the-badge)](https://dart.dev/tools/pub/workspaces)

MentorX is a Flutter monorepo that delivers a premium, AI-augmented learning experience for students and real-time academic visibility for parents. The mobile apps are backed by the EduCore API, with shared domain models and UI foundations across the suite.

---

## 🌟 Apps in the Ecosystem

### 📱 Student App
A personalized learning companion that supports the full student journey.

- **Onboarding & secure authentication** with OTP flows
- **Course discovery and learning** with lesson content and progress tracking
- **Assignments and quizzes** with attempts, submission, and results
- **AI chat assistant** for guided study support
- **Attendance tracking** and performance awareness
- **Notifications** for updates, milestones, and mentor feedback
- **Wallet, products, and rewards** for purchases and incentives
- **Profile, account status, and settings** management

### 👨‍👩‍👧 Parent App
A dedicated companion for guardians to track performance and stay engaged.

- **Onboarding & authentication** tailored for parents
- **Children profiles** and academic overview per child
- **Course progress and assessments** visibility
- **Attendance monitoring** and engagement signals
- **Financial center** for fees, payments, and wallet activity
- **Communication** channels with mentors or the platform
- **Profile management** for family account settings

---

## 🔌 Backend API (Postman)

The repository includes Postman collections that define the full EduCore API surface used by the apps.

- `postman_collection.json` — primary mobile API collection
- `educore_api_postman_collection.json` — extended EduCore API collection
- `educore_api_environment.json` — environment variables (e.g., `baseUrl`)

### Core API Domains

- **Auth & session management** (login, OTP, refresh, logout)
- **Student registration** (phone checks, governorates, areas, application info)
- **Parent login** flow
- **Academic structure**: levels, categories, courses, sessions, weeks, materials
- **Learning flow**: assignments, quizzes, questions, attempts, statistics
- **Enrollments** and access control (including admin extensions)
- **Leaderboards** (global, course, quiz)
- **Payments** (wallet, orders, payment methods, processing)
- **Teacher workflows** (student approvals, access codes)

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
│   ├── mentorx_core/                 # Shared domain models
│   ├── mentorx_ui/                   # Design system and UI kit
│   ├── clients/dio_http_client/      # Shared Dio client
│   ├── common/                       # Shared utilities and repositories
│   ├── student/                      # Student Dio repositories
│   ├── parent/                       # Parent Dio repositories
│   └── mock/                         # Mock repositories for testing
├── postman_collection.json
├── educore_api_postman_collection.json
└── educore_api_environment.json
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
