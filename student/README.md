# 📱 MentorX — Student Application

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Role](https://img.shields.io/badge/Role-Student-183764?style=for-the-badge)](#)

The **MentorX Student App** is the primary mobile interface for students to engage with the educational ecosystem. It provides a personalized, AI-driven experience designed to optimize learning outcomes and academic tracking.

---

## 🌟 Student Features

-   **🎓 Course Management**: Seamless access to courses, materials, and progress tracking.
-   **🤖 AI Insights**: Personalized feedback and path suggestions based on performance.
-   **📊 Achievement Dashboard**: Visual representation of milestones and skill development.
-   **🔔 Real-time Notifications**: Vital updates on schedule changes and mentor feedback.
-   **🌓 Adaptive Theming**: Full support for light and dark modes using the Oxford Blue & Pumpkin Orange palette.

---

## 🏗️ Technical Highlights

-   **Architecture**: BLoC Pattern + Repository Pattern.
-   **Localization**: Dynamic Arabic/English support powered by `Slang`.
-   **Navigation**: Type-safe routing via `GoRouter`.
-   **UI Kit**: Consumes the shared `mentorx_ui` library for a consistent brand experience.

---

## 🚀 Getting Started

This app is part of the [MentorX Monorepo](../README.md).

### Installation
From the root directory:
```bash
melos bootstrap
cd student
flutter run
```

---

## 📂 Internal Modules
-   `features/onboarding`: User first-time experience.
-   `features/auth`: Secure login and OTP flows.
-   `features/home`: Main student dashboard.
-   `features/course`: Detailed course view and progress.
-   `features/account_status`: KYC and profile management.
