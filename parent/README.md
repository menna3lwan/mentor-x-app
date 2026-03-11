# 👨‍👩‍👧 MentorX — Parent Application

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Role](https://img.shields.io/badge/Role-Parent-F59239?style=for-the-badge)](#)

The **MentorX Parent App** provides parents with direct visibility into their children's educational journey. It bridges the gap between students, educators, and guardians through real-time data and communication.

---

## 🌟 Parent Features

-   **📈 Progress Monitoring**: Detailed view of child's performance metrics and course completion.
-   **💬 Mentor Communication**: Direct channel to stay in touch with educational mentors.
-   **🔔 Academic Alerts**: Immediate notifications for important milestones or areas needing attention.
-   **💳 Payment Management**: Secure handling of course subscriptions and fees.
-   **🔐 Profile Security**: Management of family account settings and child permissions.

---

## 🏗️ Technical Highlights

-   **State Management**: predictable state handling with BLoC.
-   **Data Sync**: Real-time updates via optimized Dio repositories.
-   **UI Consistency**: Shares the same `mentorx_ui` tokens as the Student app for brand cohesion.

---

## 🚀 Getting Started

This app is part of the [MentorX Monorepo](../README.md).

### Installation
From the root directory:
```bash
melos bootstrap
cd parent
flutter run
```

---

## 📂 Internal Modules
-   `features/auth`: Multi-factor authentication.
-   `features/home`: Family overview and children's dashboards.
-   `features/monitoring`: In-depth performance reports.
