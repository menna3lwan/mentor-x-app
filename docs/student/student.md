# Software Requirements Specification (SRS)

## MentorX — Student Mobile Application

**Document Version:** 1.0
**Date:** July 2025
**Classification:** Confidential
**Prepared by:** Product & Business Analysis Team
**Target Audience:** Development Team, QA Engineers, UI/UX Designers

---

## Document Control

| Field | Value |
|---|---|
| **Product Name** | MentorX Student App |
| **Platform** | iOS & Android (Flutter Cross-Platform) |
| **Application Type** | Mobile Native Application |
| **Target Market** | Egyptian K-12 Private Tutoring Students |
| **Backend API** | RESTful JSON over HTTPS |
| **Document Status** | Final Draft |

---

## Table of Contents

1. Introduction
2. Product Overview
3. System Architecture Overview
4. Screen Specifications
5. User Flows
6. Functional Requirements
7. Non-Functional Requirements
8. Data Model Overview
9. Assumptions & Open Questions

---

## 1. Introduction

### 1.1 Purpose

This Software Requirements Specification defines every functional behavior, screen specification, business rule, API contract, and non-functional constraint for the **MentorX Student Mobile Application**. This document serves as the single source of truth for developers, QA engineers, and designers building the student-facing mobile experience.

The student application is the primary touchpoint through which learners interact with the MentorX platform. It enables students to consume educational content, complete assessments, track academic progress, manage digital wallets, interact with an AI-powered study assistant, earn rewards through gamification, and purchase products from the marketplace.

Every screen, interaction, validation rule, error state, and API call required to build the complete student application is specified in this document. No external references are needed.

### 1.2 Scope

This document covers exclusively the **student mobile application**. The following capabilities are within scope:

| Domain | Capabilities |
|---|---|
| **Onboarding** | Tenant selection, account registration, OTP verification, pending approval handling |
| **Authentication** | Login, logout, device binding, biometric authentication, password reset, session management |
| **Home Dashboard** | Personalized greeting, wallet quick view, banners, continue learning, featured courses, announcements, quick actions |
| **Course Discovery** | Browsing, searching, filtering, sorting course catalog |
| **Course Consumption** | Session navigation, video playback, PDF viewing, audio playback, notes, progress tracking |
| **Assessments** | Quiz taking with timer, assignment submission, grade viewing, performance analytics |
| **Attendance** | QR code scanning, attendance history, online attendance logging |
| **Wallet & Payments** | Balance management, top-up via multiple gateways, code redemption, purchase history |
| **AI Assistant** | RAG-based chatbot for curriculum-aligned academic help |
| **Gamification** | Points earning, rewards browsing, reward claiming |
| **Marketplace** | Product browsing, cart management, order placement, order tracking |
| **Communication** | Notifications, announcements, WhatsApp group access |
| **Profile Management** | View profile, request edits, device management, settings |
| **National ID Verification** | OCR-based identity verification for account activation |

### 1.3 Definitions

| Term | Definition |
|---|---|
| **Tenant** | An independent teacher or academy. Each student belongs to exactly one tenant. |
| **Session** | A unit or chapter within a course, containing one or more content items. |
| **Session Item** | An individual content piece: video, PDF, quiz, assignment, note, link, or audio. |
| **Ordering Mode** | Content access strategy: `free` (any order), `sequential` (session-by-session), `lock_session` (per-session purchase), `lock_item` (item-by-item unlock). |
| **Device Binding** | Security mechanism restricting a student account to a configured maximum number of physical devices. |
| **RAG** | Retrieval-Augmented Generation — AI generates responses grounded exclusively in teacher-uploaded course materials. |
| **OTP** | One-Time Password sent via SMS or WhatsApp for identity verification. |
| **Wallet** | Internal digital currency balance used for course purchases and marketplace transactions within a tenant. |
| **Code** | Redeemable alphanumeric string providing wallet credit, course access, or discounts. |
| **Study Type** | Student's learning mode: `online`, `center`, or `both`. |
| **Student Code** | Unique auto-generated identifier assigned to each student upon registration. |
| **FCM** | Firebase Cloud Messaging for push notification delivery. |

### 1.4 Target User

| Attribute | Description |
|---|---|
| **Age Range** | 10–18 years (K-12) |
| **Geography** | Egypt (all governorates) |
| **Language** | Arabic (primary), English (secondary) |
| **Device Ownership** | Personal or shared smartphone (Android dominant, some iOS) |
| **Technical Literacy** | Moderate; familiar with social media and messaging apps |
| **Internet Access** | Variable quality; urban 4G/Wi-Fi, rural areas may have intermittent connectivity |
| **Primary Motivation** | Academic improvement, exam preparation, organized access to tutor content |

---

## 2. Product Overview

### 2.1 Product Vision

The MentorX Student App transforms how Egyptian K-12 students engage with private tutoring. Instead of relying on scattered WhatsApp groups for content delivery, paper-based attendance sheets, and in-person-only interactions, students receive a unified digital learning environment that provides structured course content, automated assessments, real-time progress tracking, intelligent study assistance, and gamified motivation — all accessible from their personal mobile device.

### 2.2 Core Objectives

| ID | Objective | Success Metric |
|---|---|---|
| **SO-01** | Provide seamless access to all enrolled course content | Student can access any unlocked content item within 3 taps from the home screen |
| **SO-02** | Enable students to complete assessments securely and fairly | Quiz randomization prevents answer sharing; auto-save prevents data loss |
| **SO-03** | Track and visualize learning progress transparently | Student can view course completion percentage, session progress, and grade history at any time |
| **SO-04** | Deliver AI-powered academic assistance grounded in course materials | Chatbot answers are derived exclusively from teacher-uploaded content with ≥ 85% relevance rating |
| **SO-05** | Secure accounts against sharing and impersonation | Device binding + OTP verification + National ID OCR prevents unauthorized access |
| **SO-06** | Support flexible Egyptian payment methods | Vodafone Cash, InstaPay, Fawry, and wallet codes are all functional payment channels |
| **SO-07** | Motivate consistent engagement through gamification | Students earn points for course activities and redeem them for tangible rewards |
| **SO-08** | Function reliably on low-bandwidth connections | Critical content is accessible offline; graceful degradation on poor networks |
| **SO-09** | Deliver a native-feeling, fast, Arabic-first experience | RTL layout, Cairo font, sub-2-second screen transitions |

### 2.3 Student Capabilities Summary

| Capability Category | Specific Actions |
|---|---|
| **Account** | Register, verify phone, login, logout, reset password, manage device, request profile edits, verify National ID |
| **Learning** | Browse courses, enroll, consume video/PDF/audio/notes, track progress, resume learning |
| **Assessment** | Start quizzes, answer questions, submit quizzes, submit assignments, view grades and feedback |
| **Attendance** | Scan QR code for physical attendance, view attendance history and statistics |
| **Financial** | View wallet balance, top up wallet, redeem codes, pay for courses/sessions, view transaction history |
| **AI Assistant** | Start conversations, ask academic questions, receive curriculum-aligned answers, rate responses |
| **Gamification** | View points balance, browse reward store, claim rewards, track claim status |
| **Marketplace** | Browse products, add to cart, place orders, track order status |
| **Communication** | Receive push notifications, view announcements, access WhatsApp groups |
| **Settings** | Change language, toggle notification preferences, switch theme, manage devices |

---

## 3. System Architecture Overview

### 3.1 Student App Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Framework** | Flutter 3.x | Cross-platform iOS and Android from single codebase |
| **Language** | Dart | Application logic |
| **Architecture** | Clean Architecture | Separation of Presentation, Domain, and Data layers |
| **State Management** | Riverpod | Compile-safe, testable reactive state |
| **HTTP Client** | Dio | API communication with interceptors for auth, retry, logging |
| **Local Storage** | Hive | Lightweight NoSQL for cached data and offline support |
| **Secure Storage** | flutter_secure_storage | Encrypted storage for tokens and credentials |
| **Push Notifications** | Firebase Messaging (FCM) | Real-time notification delivery |
| **QR Scanning** | mobile_scanner | Attendance QR code reading |
| **Video Player** | video_player / chewie | Lesson video playback |
| **PDF Viewer** | flutter_pdfview | Document viewing |
| **Image Handling** | image_picker + image_cropper | Photo capture and editing for registration and ID verification |

### 3.2 Application Module Decomposition

```
┌──────────────────────────────────────────────────────┐
│              MentorX Student Application              │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Onboarding  │  │    Auth      │  │   Home     │ │
│  │  Module      │  │    Module    │  │   Module   │ │
│  │              │  │              │  │            │ │
│  │ -Tenant Pick │  │ -Login       │  │ -Dashboard │ │
│  │ -Register    │  │ -OTP         │  │ -Banners   │ │
│  │ -ID Verify   │  │ -Biometric   │  │ -Announce  │ │
│  │ -Pending     │  │ -Device Mgmt │  │ -Continue  │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Courses     │  │  Assessment  │  │ Attendance │ │
│  │  Module      │  │  Module      │  │ Module     │ │
│  │              │  │              │  │            │ │
│  │ -Catalog     │  │ -Quiz Engine │  │ -QR Scan   │ │
│  │ -Detail      │  │ -Assignment  │  │ -History   │ │
│  │ -Video       │  │ -Results     │  │ -Stats     │ │
│  │ -PDF         │  │ -Grades      │  │            │ │
│  │ -Progress    │  │ -Feedback    │  │            │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Wallet      │  │  AI Chat     │  │ Rewards    │ │
│  │  Module      │  │  Module      │  │ Module     │ │
│  │              │  │              │  │            │ │
│  │ -Balance     │  │ -Convo List  │  │ -Points    │ │
│  │ -Top Up      │  │ -Chat UI     │  │ -Store     │ │
│  │ -Code Redeem │  │ -Feedback    │  │ -Claims    │ │
│  │ -Transactions│  │              │  │            │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ Marketplace  │  │ Notifications│  │  Profile   │ │
│  │ Module       │  │ Module       │  │  Module    │ │
│  │              │  │              │  │            │ │
│  │ -Products    │  │ -List        │  │ -View      │ │
│  │ -Cart        │  │ -Detail      │  │ -Edit Req  │ │
│  │ -Orders      │  │ -Preferences │  │ -Devices   │ │
│  │              │  │              │  │ -Settings  │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### 3.3 Complete Navigation Map

```
App Launch
  │
  ├── [First Launch] Onboarding Screens
  │     └── Tenant Selection ─────────────────────────┐
  │           └── Student Registration (5 steps)       │
  │                 └── OTP Verification               │
  │                       └── National ID Verification │
  │                             └── Pending Approval   │
  │                                                    │
  ├── [Returning User] Login ◄─────────────────────────┘
  │     ├── [New Device] OTP Verification
  │     ├── [Device Limit] Device Management
  │     ├── [Forgot Password] Phone → OTP → New Password
  │     └── [Success]
  │           │
  │           ▼
  │     ╔═══════════════════════════════════════════╗
  │     ║     MAIN APP — Bottom Navigation Bar      ║
  │     ╠═══════════════════════════════════════════╣
  │     ║                                           ║
  │     ║  Tab 1: HOME                              ║
  │     ║  ├── Banners Carousel                     ║
  │     ║  ├── Continue Learning Cards              ║
  │     ║  │     └── → Course Detail                ║
  │     ║  ├── Featured Courses Grid                ║
  │     ║  │     └── → Course Detail                ║
  │     ║  ├── Recent Announcements                 ║
  │     ║  │     └── → Announcement Detail          ║
  │     ║  └── Quick Actions Grid                   ║
  │     ║        ├── → My Courses                   ║
  │     ║        ├── → Attendance                   ║
  │     ║        ├── → Grades                       ║
  │     ║        ├── → AI Assistant                 ║
  │     ║        ├── → Rewards                      ║
  │     ║        └── → Marketplace                  ║
  │     ║                                           ║
  │     ║  Tab 2: MY COURSES                        ║
  │     ║  ├── Enrolled Courses List                ║
  │     ║  │     └── Course Detail                  ║
  │     ║  │           ├── Sessions Accordion       ║
  │     ║  │           │     └── Session Items      ║
  │     ║  │           │           ├── Video Player ║
  │     ║  │           │           ├── PDF Viewer   ║
  │     ║  │           │           ├── Audio Player ║
  │     ║  │           │           ├── Note View    ║
  │     ║  │           │           ├── Quiz Screen  ║
  │     ║  │           │           │     └── Results║
  │     ║  │           │           └── Assignment   ║
  │     ║  │           │                 └── Submit ║
  │     ║  │           ├── Grades Tab               ║
  │     ║  │           └── Progress Tab             ║
  │     ║  └── Browse Courses (Catalog)             ║
  │     ║        └── Course Detail → Enroll → Pay   ║
  │     ║                                           ║
  │     ║  Tab 3: AI ASSISTANT                      ║
  │     ║  ├── Conversation List                    ║
  │     ║  └── Chat Interface                       ║
  │     ║        ├── Text Input                     ║
  │     ║        ├── Message Bubbles                ║
  │     ║        ├── Source Citations                ║
  │     ║        └── Rating Feedback                ║
  │     ║                                           ║
  │     ║  Tab 4: WALLET                            ║
  │     ║  ├── Balance Card                         ║
  │     ║  ├── Quick Actions (Top Up / Redeem Code) ║
  │     ║  ├── Transaction History                  ║
  │     ║  ├── Top Up Screen                        ║
  │     ║  │     ├── Vodafone Cash                  ║
  │     ║  │     ├── InstaPay                       ║
  │     ║  │     ├── Fawry                          ║
  │     ║  │     └── Confirmation                   ║
  │     ║  └── Code Redemption Screen               ║
  │     ║                                           ║
  │     ║  Tab 5: MORE                              ║
  │     ║  ├── Profile                              ║
  │     ║  │     ├── View Profile                   ║
  │     ║  │     └── Edit Request                   ║
  │     ║  ├── Attendance History                   ║
  │     ║  ├── My Grades (All Courses)              ║
  │     ║  ├── Points & Rewards                     ║
  │     ║  │     ├── Points History                 ║
  │     ║  │     ├── Reward Store                   ║
  │     ║  │     └── My Claims                      ║
  │     ║  ├── Marketplace                          ║
  │     ║  │     ├── Product List                   ║
  │     ║  │     ├── Product Detail                 ║
  │     ║  │     ├── Cart                           ║
  │     ║  │     └── Order History                  ║
  │     ║  ├── Notifications                        ║
  │     ║  ├── WhatsApp Groups                      ║
  │     ║  ├── Settings                             ║
  │     ║  │     ├── Language                       ║
  │     ║  │     ├── Theme                          ║
  │     ║  │     ├── Notification Preferences       ║
  │     ║  │     └── Device Management              ║
  │     ║  ├── Help & Support                       ║
  │     ║  └── Logout                               ║
  │     ║                                           ║
  │     ╚═══════════════════════════════════════════╝
  │
  └── [Overlay Screens — accessible globally]
        ├── Notification Detail (from push tap)
        └── Force Update Screen
```

---

## 4. Screen Specifications

---

### 4.1 Screen: Splash Screen

**Purpose**
Initialize the application, validate authentication state, verify device binding, check app version compatibility, and route the student to the appropriate entry point.

**UI Components**
- Tenant logo (centered, animated scale-in, 120x120dp)
- Application name "MentorX" (below logo, Cairo Bold 24sp)
- Tenant tagline (below app name, Cairo Regular 14sp, 60% opacity)
- Circular loading indicator (below tagline, accent color)
- App version text (bottom-aligned, Cairo Regular 12sp, 40% opacity)

**Features**
- Cached tenant branding retrieval from local storage
- JWT access token validation against backend
- Automatic token refresh if access token is expired but refresh token is valid
- Device hash verification
- Network connectivity detection
- Minimum app version compatibility check

**Displayed Data**
| Element | Source |
|---|---|
| Tenant Logo | Local cache → fallback: `tenants.logo_url` |
| App Name | Hardcoded "MentorX" |
| Tagline | Local cache → `tenants.tagline` |
| Version | Build configuration `CFBundleShortVersionString` / `versionName` |

**Navigation**
| Condition | Destination |
|---|---|
| No tenant selected (first launch) | Onboarding Screen |
| Tenant selected + no stored token | Login Screen |
| Valid access token + `status = active` | Home Dashboard |
| Valid access token + `status = pending` | Pending Approval Screen |
| Valid access token + `status = blocked` | Account Blocked Screen |
| Valid access token + `status = rejected` | Account Rejected Screen |
| Expired access token + valid refresh token | Silent refresh → route based on status |
| Expired access token + expired refresh token | Login Screen |
| Device hash mismatch | Login Screen (with device re-verification) |
| App version < minimum required | Force Update Screen |
| No network + cached auth | Home Dashboard (offline mode indicator) |
| No network + no cached auth | No Connection Screen with retry |

**Business Rules**
- BR-SPL-01: Token validation must complete within 3 seconds. If backend is unreachable within this window, use cached authentication state.
- BR-SPL-02: If device hash stored locally does not match the hash registered in `devices` table, invalidate the session and redirect to Login.
- BR-SPL-03: Minimum app version is retrieved from `GET /api/v1/config/app-version`. If the current installed version is below the required minimum, block access and display Force Update Screen.
- BR-SPL-04: Splash screen must display for a minimum of 1.5 seconds (even if validation completes faster) to ensure branding visibility.
- BR-SPL-05: If offline and cached authentication exists, show an "Offline Mode" banner on the Home Dashboard.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/verify-token` | Validate stored JWT access token |
| `POST` | `/api/v1/auth/refresh` | Refresh expired access token using refresh token |
| `GET` | `/api/v1/config/app-version` | Retrieve minimum required app version |

**States**
- **Loading:** Logo displayed with progress indicator; token validation in progress.
- **Error — Network Unavailable (no cache):** Illustration of disconnected cloud. Text: "No internet connection." Button: "Retry".
- **Error — Force Update:** App store icon. Text: "A new version is required. Please update to continue." Button: "Update Now" (links to App Store / Play Store).

---

### 4.2 Screen: Onboarding

**Purpose**
Introduce the MentorX platform to first-time users through a brief series of informational screens before directing them to tenant selection.

**UI Components**
- Page view with 3 swipeable screens
- Each screen:
  - Illustration (centered, 60% screen height)
  - Title (Cairo Bold 22sp)
  - Description (Cairo Regular 16sp, center-aligned, 70% opacity)
- Page indicator dots (bottom)
- "Skip" text button (top right)
- "Next" button (bottom, primary color, full width)
- "Get Started" button (on final screen, replaces "Next")

**Onboarding Content**
| Screen | Title | Description |
|---|---|---|
| 1 | "Learn Smarter" | "Access your teacher's courses, videos, and materials — all in one place." |
| 2 | "Track Your Progress" | "See your grades, attendance, and course completion at a glance." |
| 3 | "Get AI Help" | "Ask questions and get instant answers based on your course content." |

**Features**
- Horizontal swipe between screens
- Skip button bypasses all screens
- "Get Started" stores `onboarding_completed = true` in local storage

**Navigation**
| Action | Destination |
|---|---|
| Tap "Get Started" (final screen) | Tenant Selection Screen |
| Tap "Skip" | Tenant Selection Screen |

**Business Rules**
- BR-ONB-01: Onboarding screens are shown only once. After completion, the app skips directly to Tenant Selection or Login on subsequent launches.
- BR-ONB-02: Onboarding content is hardcoded in the client application; no API call required.

**API Requirements**
None.

**States**
- No loading, error, or empty states. This screen is entirely client-side.

---

### 4.3 Screen: Tenant Selection

**Purpose**
Allow the student to select the teacher or academy they wish to register with. This selection establishes the tenant context for the entire application lifecycle.

**UI Components**
- Header: "Choose Your Teacher" (Cairo Bold 20sp)
- Search bar with magnifying glass icon (placeholder: "Search by teacher name...")
- Tenant list (vertical scrollable)
  - Tenant card (each):
    - Tenant logo (48x48dp, circular)
    - Tenant name (Cairo SemiBold 16sp)
    - Tagline (Cairo Regular 13sp, 60% opacity)
    - Verified badge (blue checkmark icon, if applicable)
    - Student count indicator (e.g., "1.2K students")
  - Ripple effect on tap
- "Can't find your teacher?" help link (bottom, Cairo Regular 14sp, accent color)
- Loading shimmer placeholders (during fetch)

**Features**
- Real-time text search filtering (debounced 300ms)
- Pull-to-refresh
- Infinite scroll pagination (20 items per page)
- Tenant selection persists `tenant_id`, `tenant_name`, `tenant_logo_url`, `primary_color`, `accent_color` to local storage

**Displayed Data**
| Field | Source |
|---|---|
| Tenant Logo | `tenants.logo_url` |
| Tenant Name | `tenants.name` |
| Tagline | `tenants.tagline` |
| Verified Badge | `tenants.verified_at IS NOT NULL` |
| Student Count | Derived from count of active users per tenant |

**Navigation**
| Action | Destination |
|---|---|
| Tap on tenant card | Student Registration Screen (tenant context set) |
| Tap "Can't find your teacher?" | Help / Contact Support Screen or external link |
| System Back | Onboarding Screen (if first launch) or exit app |

**Business Rules**
- BR-TEN-01: Only tenants with `status = 'active'` appear in results.
- BR-TEN-02: Tenants with `subscription_end < NOW()` are excluded.
- BR-TEN-03: Search is case-insensitive and supports partial matching on `tenants.name`.
- BR-TEN-04: Selected `tenant_id` is stored in local secure storage and included as a header or parameter in all subsequent API requests.
- BR-TEN-05: If the student already has an account with a tenant and attempts to register again, the backend returns an error (handled on Registration Screen).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/tenants?search={query}&page={n}&limit=20` | Fetch active tenants with pagination and search |

**Response Body**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": 1,
        "name": "Mr. Ahmed Physics",
        "slug": "mr-ahmed-physics",
        "logo_url": "https://cdn.mentorx.com/tenants/1/logo.png",
        "tagline": "Physics made simple",
        "primary_color": "#183764",
        "accent_color": "#F59239",
        "verified_at": "2025-01-15T10:00:00Z",
        "student_count": 1247
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 94,
      "per_page": 20
    }
  }
}
```

**States**
- **Loading:** 6 shimmer placeholder cards in list layout.
- **Empty — No Results:** Illustration of empty search. Text: "No teachers found. Try a different name."
- **Empty — No Tenants:** Illustration. Text: "No teachers are available yet. Please check back later."
- **Error — Network:** "Unable to load teachers. Please check your connection." Button: "Retry".

---

### 4.4 Screen: Student Registration

**Purpose**
Collect all required personal, academic, location, parental, and security information to create a new student account within the selected tenant. The multi-step form reduces cognitive load and validates data incrementally.

**UI Components**

**Global Elements**
- Tenant logo and name (top bar)
- Step progress indicator (5 dots / numbered steps with connecting line)
- "Back" button (top left, returns to previous step)
- "Next" / "Submit" button (bottom, primary, full width)
- "Already have an account? Login" link (bottom of Step 1)

**Step 1 — Personal Information**
| Component | Type | Required | Validation |
|---|---|---|---|
| First Name | Text input | Yes | Min 2 chars, Arabic/English letters only |
| Last Name | Text input | Yes | Min 2 chars, Arabic/English letters only |
| Phone Number | Phone input with +20 prefix (non-editable) | Yes | 11 digits, starts with 010/011/012/015 |
| Email | Email input | No | RFC 5322 format if provided |
| Gender | Radio buttons (Male / Female) | Yes | — |
| Date of Birth | Date picker | Yes | Age between 5–25 years |
| Profile Photo | Image picker (camera / gallery) | No | JPG/PNG, max 5MB, square crop |

**Step 2 — Academic Information**
| Component | Type | Required | Validation |
|---|---|---|---|
| Grade | Dropdown | Yes | Populated from tenant's active grades |
| School Name | Text input | No | Max 200 chars |
| Study Type | Segmented control (Online / Center / Both) | Yes | — |
| Center | Dropdown (visible if Center or Both) | Conditional | Populated from tenant's active centers |
| Schedule | Dropdown (visible if Center or Both) | Conditional | Filtered by selected center and grade |
| Center Group | Dropdown (visible if Center or Both) | No | Filtered by selected schedule |

**Step 3 — Location**
| Component | Type | Required | Validation |
|---|---|---|---|
| Governorate | Dropdown | Yes | Populated from governorates lookup |
| District | Dropdown | Yes | Filtered by selected governorate |

**Step 4 — Parent Information**
| Component | Type | Required | Validation |
|---|---|---|---|
| Parent Name | Text input | Yes | Min 5 chars |
| Parent Phone | Phone input with +20 prefix | Yes | 11 digits, starts with 010/011/012/015, must differ from student phone |

**Step 5 — Security**
| Component | Type | Required | Validation |
|---|---|---|---|
| Password | Password input with visibility toggle | Yes | Min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special char |
| Confirm Password | Password input with visibility toggle | Yes | Must match password |
| ID Card Photo | Image picker (camera only) | Conditional | JPG/PNG, max 10MB |
| Password Strength Indicator | Visual bar (weak/medium/strong) | — | Real-time calculation |

**Features**
- Real-time inline validation on field blur
- Async phone uniqueness check (debounced 500ms after typing stops)
- Image cropping and compression before upload
- Dependent dropdown cascading (Governorate → District, Center → Schedule → Group)
- Step data preserved in local state when navigating back
- Password strength visual indicator

**Displayed Data (Dropdowns)**
| Dropdown | API Source |
|---|---|
| Grades | `GET /api/v1/tenants/{id}/grades` |
| Centers | `GET /api/v1/tenants/{id}/centers` |
| Schedules | `GET /api/v1/centers/{id}/schedules?grade_id={id}` |
| Center Groups | `GET /api/v1/centers/{id}/groups?grade_id={id}&schedule_id={id}` |
| Governorates | `GET /api/v1/lookups/governorates` |
| Districts | `GET /api/v1/lookups/governorates/{id}/districts` |

**Navigation**
| Action | Destination |
|---|---|
| "Next" (Steps 1-4) | Next step (after validation passes) |
| "Submit" (Step 5) | OTP Verification Screen |
| "Back" (Steps 2-5) | Previous step (data preserved) |
| "Back" (Step 1) | Tenant Selection Screen |
| "Already have an account? Login" | Login Screen |

**Business Rules**
- BR-REG-01: Phone number must be unique within the tenant. Async check via `POST /api/v1/auth/check-phone`.
- BR-REG-02: Password must meet complexity requirements: minimum 8 characters, at least one uppercase, one lowercase, one digit, one special character (`!@#$%^&*`).
- BR-REG-03: Date of birth validation: `NOW() - DOB` must be between 5 and 25 years.
- BR-REG-04: If the tenant has configured mandatory ID card verification, the ID Card Photo field in Step 5 becomes required.
- BR-REG-05: Upon successful submission, account `status` is set to `pending`. Student cannot access the main app until teacher approves (`status = 'active'`).
- BR-REG-06: An OTP is automatically sent to the provided phone number upon form submission.
- BR-REG-07: `student_code` is auto-generated by the backend following pattern `{TENANT_PREFIX}-{YEAR}-{SEQUENTIAL}` (e.g., "AHM-2025-00142").
- BR-REG-08: The current device hash is captured and stored as the initial bound device in the `devices` table.
- BR-REG-09: A `user_roles` entry with `role_id` = student role is automatically created.
- BR-REG-10: Parent phone triggers an automated SMS informing the parent that their child has registered on MentorX.
- BR-REG-11: Parent phone must differ from student phone.
- BR-REG-12: If study_type is "center" or "both", center_id and schedule_id become required.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/register` | Submit complete registration data |
| `POST` | `/api/v1/auth/check-phone` | Validate phone uniqueness |
| `POST` | `/api/v1/upload/image` | Upload profile photo and ID card |
| `GET` | `/api/v1/tenants/{id}/grades` | Fetch tenant grades |
| `GET` | `/api/v1/tenants/{id}/centers` | Fetch tenant centers |
| `GET` | `/api/v1/centers/{id}/schedules?grade_id={id}` | Fetch center schedules |
| `GET` | `/api/v1/centers/{id}/groups?grade_id={id}&schedule_id={id}` | Fetch center groups |
| `GET` | `/api/v1/lookups/governorates` | Fetch governorates |
| `GET` | `/api/v1/lookups/governorates/{id}/districts` | Fetch districts |

**Request Body — `POST /api/v1/auth/register`**
```json
{
  "tenant_id": 1,
  "first_name": "أحمد",
  "last_name": "محمد",
  "phone": "01012345678",
  "email": "ahmed@example.com",
  "gender": "male",
  "date_of_birth": "2008-03-15",
  "profile_photo_url": "https://cdn.mentorx.com/uploads/temp/photo_abc.jpg",
  "grade_id": 3,
  "school_name": "مدرسة النور",
  "study_type": "both",
  "center_id": 1,
  "schedule_id": 2,
  "center_group_id": 5,
  "governorate_id": 12,
  "district_id": 45,
  "parent_name": "محمد علي",
  "parent_phone": "01098765432",
  "password": "Secure@Pass1",
  "id_card_photo_url": "https://cdn.mentorx.com/uploads/temp/id_xyz.jpg",
  "device_hash": "a1b2c3d4e5f6",
  "device_name": "Samsung Galaxy A54",
  "device_model": "SM-A546B",
  "os_version": "Android 14",
  "app_version": "1.0.0",
  "fcm_token": "fMC:dGhpcyBpcyBhIHRva2Vu..."
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "user_id": 42,
    "student_code": "AHM-2025-00142",
    "status": "pending",
    "phone": "01012345678",
    "otp_sent": true,
    "otp_expires_in_seconds": 300
  },
  "message": "Registration successful. Please verify your phone number."
}
```

**States**
- **Loading (per step):** Dropdown shimmer loading for dependent data.
- **Loading (submit):** Submit button shows spinner; all inputs disabled; overlay prevents interaction.
- **Validation Error:** Red text below invalid field. "Next" button disabled if any required field in current step is invalid.
- **Error — Duplicate Phone:** Toast: "This phone number is already registered. Please login instead." Link to Login.
- **Error — Server:** Toast: "Registration failed. Please try again." Button: "Retry" (re-submits).
- **Error — Upload Failed:** Toast: "Photo upload failed. Please try again." Retry option on the image field.
- **Success:** Automatic navigation to OTP Verification with phone pre-filled.

---

### 4.5 Screen: OTP Verification

**Purpose**
Verify student phone number ownership by validating a one-time password sent via SMS or WhatsApp.

**UI Components**
- Back button (top left)
- Illustration (phone with code, 30% screen height)
- Title: "Verify Your Number" (Cairo Bold 22sp)
- Subtitle: "Enter the 6-digit code sent to +20 1XX XXXX X78" (Cairo Regular 15sp, phone partially masked)
- OTP input: 6 separate digit boxes (56x56dp each, 16sp, center-aligned)
- Countdown timer: "Resend in 0:45" (Cairo Regular 14sp, 50% opacity)
- "Resend Code" text button (enabled when timer expires, accent color)
- "Resend via WhatsApp" text button (alternative, enabled when timer expires)
- "Change Phone Number" link (small text, only in registration flow)
- "Verify" button (bottom, primary, full width)

**Features**
- Auto-focus first digit box on screen load
- Auto-advance cursor to next box on digit entry
- Auto-submit when all 6 digits are entered
- Clipboard paste support (auto-fill all 6 digits)
- SMS auto-read on Android (`SmsRetriever` API)
- Numeric keyboard only
- Shake animation on incorrect code entry
- Countdown timer (60 seconds default)

**Displayed Data**
| Element | Source |
|---|---|
| Masked Phone | From registration response or login context (e.g., "01X XXXX X78") |
| Timer | Client-side countdown starting at 60 seconds |
| Remaining Attempts | From API error response `remaining_attempts` field |

**Navigation**
| Condition | Destination |
|---|---|
| Success + registration flow | National ID Verification Screen (if enabled) or Pending Approval Screen |
| Success + login flow (new device) | Home Dashboard |
| Success + password reset flow | Set New Password Screen |
| Tap "Change Phone Number" | Back to Registration (Step 1) |
| Maximum failed OTPs exceeded | Temporary Lock Screen |
| Back button | Previous screen (registration or login) |

**Business Rules**
- BR-OTP-01: OTP codes are valid for 5 minutes from generation (`otp_verifications.expires_at = NOW() + 5 min`).
- BR-OTP-02: Maximum 3 verification attempts per OTP code (`otp_verifications.max_attempts = 3`).
- BR-OTP-03: Resend cooldown is 60 seconds between each OTP generation.
- BR-OTP-04: After 3 separate OTP generation failures (i.e., 3 codes generated, each failed all attempts), the account is temporarily locked for 30 minutes.
- BR-OTP-05: Upon successful verification, `users.phone_verified_at` is updated.
- BR-OTP-06: OTP purpose must match the current flow: `registration`, `login`, or `password_reset`.
- BR-OTP-07: WhatsApp resend option uses the same OTP code but delivers via WhatsApp Business API.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/verify-otp` | Validate OTP code |
| `POST` | `/api/v1/auth/resend-otp` | Generate and send new OTP code |

**Request Body — `POST /api/v1/auth/verify-otp`**
```json
{
  "phone": "01012345678",
  "otp_code": "482916",
  "purpose": "registration",
  "tenant_id": 1
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "phone_verified": true,
    "user_status": "pending",
    "requires_id_verification": true
  }
}
```

**Response Body — Failure**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_OTP",
    "message": "The code you entered is incorrect.",
    "remaining_attempts": 2
  }
}
```

**States**
- **Default:** Empty digit boxes, cursor on first box, timer counting down.
- **Loading:** "Verify" button shows spinner; digit boxes disabled.
- **Error — Wrong Code:** Shake animation on boxes. Red text: "Incorrect code. {n} attempts remaining." Boxes cleared.
- **Error — Expired:** "This code has expired." Resend button highlighted. Boxes cleared.
- **Error — Max Attempts:** Full-screen overlay: "Too many failed attempts. Please try again in {minutes} minutes." Only back button active.
- **Success:** Green checkmark animation (0.8 seconds) → auto-navigate.

---

### 4.6 Screen: National ID Verification

**Purpose**
Verify the student's identity by extracting their name from a National ID card photo using OCR and matching it against the registered name.

**UI Components**
- Title: "Verify Your Identity" (Cairo Bold 22sp)
- Instruction text: "Take a clear photo of your National ID card. Make sure the text is readable." (Cairo Regular 15sp)
- ID card frame overlay (camera preview with positioned rectangle guide, rounded corners)
- Capture button (large circle, center-bottom)
- "Use Gallery" text button (below capture)
- Preview section (after capture):
  - Captured image preview
  - "Retake" button
  - "Verify" button (primary)
- Processing animation (after verify tap)
- Result section:
  - Extracted name display
  - Match status (green checkmark or red X)
  - Confidence percentage

**Features**
- Live camera preview with positioned frame guide for ID card placement
- Auto-focus and flash control
- Image capture with high resolution
- Image preprocessing (client-side brightness/contrast adjustment)
- Image upload to OCR service
- Name extraction and fuzzy matching result display
- Manual retry on failure

**Displayed Data**
| Element | Source |
|---|---|
| Registered Name | From registration data: `first_name + " " + last_name` |
| Extracted Name | From OCR service response |
| Match Confidence | From matching engine response (percentage) |
| Match Status | `confidence ≥ 85%` → "Verified", else → "Mismatch" |

**Navigation**
| Condition | Destination |
|---|---|
| Verification success (confidence ≥ 85%) | Pending Approval Screen |
| Verification failure (confidence < 85%) + retries remaining | Stay on screen with retry option |
| Maximum retries (3) exceeded | Manual Review Pending Screen |
| Skip (if tenant allows) | Pending Approval Screen (with `id_verified = false` flag) |

**Business Rules**
- BR-IDV-01: This screen is shown only if the tenant has configured mandatory ID verification.
- BR-IDV-02: The OCR system extracts all text from the ID card image using EasyOCR.
- BR-IDV-03: Arabic name normalization is applied: `أ`, `إ`, `آ` → `ا`; remove diacritics; normalize whitespace.
- BR-IDV-04: String similarity is computed using RapidFuzz library. Threshold: ≥ 85% similarity between extracted name and `users.first_name + " " + users.last_name`.
- BR-IDV-05: If similarity ≥ 85%, the ID verification is marked as successful. The ID card image URL is stored in `users.id_card_photo_url`.
- BR-IDV-06: If similarity < 85%, the student is allowed up to 3 retries. After 3 failures, the case is flagged for manual teacher review.
- BR-IDV-07: The captured ID image is uploaded with client-side compression (max 2MB).
- BR-IDV-08: The verification process must complete within 10 seconds.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/upload/image` | Upload captured ID card image |
| `POST` | `/api/v1/auth/verify-identity` | Send image for OCR processing and name matching |

**Request Body — `POST /api/v1/auth/verify-identity`**
```json
{
  "user_id": 42,
  "id_card_image_url": "https://cdn.mentorx.com/uploads/temp/id_xyz.jpg"
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "extracted_name": "أحمد محمد علي",
    "registered_name": "أحمد محمد",
    "similarity_score": 92.5,
    "verified": true
  }
}
```

**Response Body — Mismatch**
```json
{
  "success": true,
  "data": {
    "extracted_name": "محمود أحمد",
    "registered_name": "أحمد محمد",
    "similarity_score": 45.2,
    "verified": false,
    "remaining_retries": 2
  }
}
```

**States**
- **Camera Active:** Live preview with frame overlay guide.
- **Image Captured:** Preview with retake/verify buttons.
- **Processing:** Full-screen overlay with animated scanning effect. Text: "Verifying your identity..."
- **Success:** Green checkmark animation. Extracted name displayed. "Continue" button.
- **Failure — Mismatch:** Red X icon. Text: "We couldn't match your ID. Please retake the photo." Retake button.
- **Failure — Max Retries:** Text: "Verification requires manual review. Your teacher will verify your identity." "Continue" button (proceeds to Pending Approval with manual review flag).
- **Error — OCR Failed:** "Unable to read the ID card. Please ensure good lighting and a clear image." Retake button.

---

### 4.7 Screen: Pending Approval

**Purpose**
Inform the student that their registration is complete but requires teacher approval before they can access the platform.

**UI Components**
- Illustration (hourglass or clock, 40% screen height)
- Title: "Waiting for Approval" (Cairo Bold 24sp)
- Message: "Your registration has been submitted. Your teacher will review and approve your account soon." (Cairo Regular 16sp, center-aligned)
- Student code display: "Your Student Code: AHM-2025-00142" (Cairo SemiBold 16sp, copyable)
- Status badge: "Pending Review" (amber color chip)
- "Refresh Status" button (outlined, accent color)
- "Contact Teacher" button (opens WhatsApp with tenant's number, if available)
- "Logout" text button (bottom)

**Features**
- Auto-refresh status every 30 seconds via polling
- Push notification listener for account approval
- Copy student code to clipboard on tap
- Deep link handling for approval notification

**Displayed Data**
| Element | Source |
|---|---|
| Student Code | `users.student_code` |
| Account Status | `users.status` |
| Tenant WhatsApp | `tenants.whatsapp_number` |

**Navigation**
| Condition | Destination |
|---|---|
| Status changes to `active` | Home Dashboard (with welcome animation) |
| Status changes to `rejected` | Account Rejected Screen |
| Tap "Logout" | Login Screen (clear local auth data) |
| Tap "Contact Teacher" | External WhatsApp app |

**Business Rules**
- BR-PEND-01: Polling interval is 30 seconds. Each poll calls `GET /api/v1/auth/account-status`.
- BR-PEND-02: When a push notification with type `profile_approved` is received, immediately navigate to Home Dashboard.
- BR-PEND-03: When a push notification with type `profile_rejected` is received, navigate to Rejected Screen showing `users.rejection_reason`.
- BR-PEND-04: Student code is read-only and provided for reference when contacting the teacher.
- BR-PEND-05: If the tenant has no WhatsApp number, the "Contact Teacher" button is hidden.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/auth/account-status` | Poll current account status |

**States**
- **Default:** Illustration with pending message and refresh button.
- **Refreshing:** "Refresh Status" button shows spinner.
- **Approved:** Green confetti animation. Text changes to: "Your account is approved! Welcome to MentorX." Auto-navigate after 2 seconds.
- **Rejected:** Red icon. Text: "Your registration was not approved." Reason: `{rejection_reason}`. Options: "Contact Teacher" or "Register Again".

---

### 4.8 Screen: Login

**Purpose**
Authenticate a returning student and establish a secure session with JWT token management and device verification.

**UI Components**
- Tenant logo (centered, 80x80dp)
- Tenant name (Cairo SemiBold 18sp)
- Phone number input with +20 prefix (Cairo Regular 16sp)
- Password input with visibility toggle
- "Remember me" checkbox (stores phone locally)
- "Forgot Password?" link (right-aligned, accent color)
- "Login" button (primary, full width)
- Divider line with "or" text
- Biometric login button (fingerprint/face icon, shown only if previously enabled)
- "Don't have an account? Register" link
- "Change Teacher" link (small, bottom-aligned)

**Features**
- Remember phone number (stores in local storage, unencrypted)
- Biometric authentication via device OS APIs (after first successful password login)
- Automatic FCM token registration on login
- Device hash computation and submission

**Displayed Data**
| Element | Source |
|---|---|
| Tenant Logo | Local storage `tenant_logo_url` |
| Tenant Name | Local storage `tenant_name` |
| Remembered Phone | Local storage `remembered_phone` |
| Biometric Available | Device capability check + previous biometric enrollment flag |

**Navigation**
| Condition | Destination |
|---|---|
| Success + same device + `status = active` | Home Dashboard |
| Success + new device | OTP Verification (purpose: `login`) |
| Success + `status = pending` | Pending Approval Screen |
| Success + `status = blocked` | Account Blocked Screen (showing `blocked_reason`) |
| Success + `status = suspended` | Account Suspended Screen |
| Success + `status = rejected` | Account Rejected Screen (showing `rejection_reason`) |
| Device limit exceeded | Device Management Dialog |
| Tap "Forgot Password?" | Forgot Password Screen |
| Tap "Register" | Registration Screen |
| Tap "Change Teacher" | Tenant Selection Screen (clears local tenant data) |

**Business Rules**
- BR-LOG-01: After 5 consecutive failed login attempts from the same phone number, the account is locked for 15 minutes. A `login_logs` entry is recorded with `success = false` and `failure_reason = 'max_attempts'`.
- BR-LOG-02: Device hash is computed from device hardware identifiers (Android ID, IDFV). If the hash does not match any active device in the `devices` table for this user, the API response includes `requires_otp = true`.
- BR-LOG-03: If the user has reached `users.device_limit` and the current device is not registered, the response includes `device_limit_reached = true`. The student must deactivate an existing device before proceeding.
- BR-LOG-04: On successful login:
  - `users.last_login_at` is updated
  - `login_logs` entry created with `success = true`
  - JWT access token issued (15-minute expiry)
  - Refresh token issued (7-day expiry), stored in `refresh_tokens` table
  - `devices.fcm_token` updated if changed
  - `devices.last_used_at` updated
- BR-LOG-05: Password verification uses bcrypt comparison against `users.password_hash`.
- BR-LOG-06: Biometric authentication retrieves the stored encrypted credentials and submits a standard login request.
- BR-LOG-07: "Remember me" stores only the phone number (not password) in unencrypted local storage.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/login` | Authenticate student |
| `POST` | `/api/v1/auth/forgot-password` | Initiate password reset (sends OTP) |

**Request Body — `POST /api/v1/auth/login`**
```json
{
  "tenant_id": 1,
  "phone": "01012345678",
  "password": "Secure@Pass1",
  "device_hash": "a1b2c3d4e5f6",
  "device_name": "Samsung Galaxy A54",
  "device_model": "SM-A546B",
  "os_version": "Android 14",
  "app_version": "1.0.0",
  "fcm_token": "fMC:dGhpcyBpcyBhIHRva2Vu..."
}
```

**Response Body — Success (Same Device)**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "refresh_token": "dGhpcyBpcyBhIHJlZnJl...",
    "token_type": "Bearer",
    "expires_in": 900,
    "requires_otp": false,
    "device_limit_reached": false,
    "user": {
      "id": 42,
      "first_name": "أحمد",
      "last_name": "محمد",
      "phone": "01012345678",
      "email": "ahmed@example.com",
      "student_code": "AHM-2025-00142",
      "status": "active",
      "gender": "male",
      "grade_id": 3,
      "grade_name": "الصف الثالث الثانوي",
      "study_type": "both",
      "profile_photo_url": "https://cdn.mentorx.com/...",
      "wallet_balance": 150.00,
      "total_points": 320
    }
  }
}
```

**Response Body — New Device Required OTP**
```json
{
  "success": true,
  "data": {
    "requires_otp": true,
    "otp_sent": true,
    "phone_masked": "010****5678",
    "otp_expires_in_seconds": 300
  }
}
```

**Response Body — Device Limit Reached**
```json
{
  "success": false,
  "error": {
    "code": "DEVICE_LIMIT_REACHED",
    "message": "Maximum number of devices reached.",
    "max_devices": 1,
    "active_devices": [
      {
        "id": 15,
        "device_name": "iPhone 13",
        "last_used_at": "2025-07-01T14:30:00Z"
      }
    ]
  }
}
```

**States**
- **Default:** Form fields enabled, login button enabled.
- **Loading:** Login button shows spinner; fields disabled.
- **Error — Invalid Credentials:** Red banner below form: "Incorrect phone number or password."
- **Error — Account Locked:** Dialog: "Account locked due to multiple failed attempts. Try again in {minutes} minutes."
- **Error — Account Blocked:** Navigate to Blocked Screen: "Your account has been blocked. Reason: {reason}. Contact your teacher."
- **Error — New Device:** Navigate to OTP Verification Screen.
- **Error — Device Limit:** Bottom sheet showing active devices with "Deactivate" option per device + "Cancel" button.
- **Error — Network:** Toast: "Unable to connect. Please check your internet."

---

### 4.9 Screen: Student Home Dashboard

**Purpose**
Primary landing screen providing a personalized overview of the student's learning activity, wallet status, announcements, featured content, and quick navigation to all major features.

**UI Components**

**Top Section**
- Greeting text: "صباح الخير، أحمد 👋" / "Good morning, Ahmed 👋" (Cairo Bold 20sp, dynamic by time of day)
- Notification bell icon (top right) with red badge showing unread count
- Profile avatar (32x32dp, circular, top left) — tappable

**Wallet Quick View Card**
- Card with gradient background (tenant primary/accent colors)
- Wallet balance: "EGP {amount}" (Cairo Bold 24sp, white)
- Points: "{n} نقطة" (Cairo Regular 14sp, white, 80% opacity)
- Small wallet icon
- Entire card tappable → Wallet Screen

**Banners Carousel**
- Horizontal auto-scrolling carousel (auto-rotate every 5 seconds)
- Each banner: full-width image (16:9 ratio), optional title overlay
- Page indicator dots below
- Swipeable manually
- Tappable → action destination

**Continue Learning Section**
- Section title: "أكمل التعلم" / "Continue Learning" (Cairo SemiBold 18sp)
- "عرض الكل" / "See All" link (right-aligned, accent color)
- Horizontal scrollable card list (max 5 items)
- Each card (width: 280dp):
  - Course thumbnail (16:9, top)
  - Course title (Cairo SemiBold 15sp, max 2 lines)
  - Linear progress bar with percentage text
  - "متابعة" / "Continue" text button (accent color)

**Featured Courses Section**
- Section title: "دورات مميزة" / "Featured Courses"
- "عرض الكل" / "See All" link
- Horizontal scrollable card list
- Each card (width: 200dp):
  - Course thumbnail (1:1, top)
  - Course title (Cairo SemiBold 14sp, max 2 lines)
  - Price or "مجاني" / "Free" badge
  - Enrolled count icon + number

**Recent Announcements Section**
- Section title: "الإعلانات" / "Announcements"
- "عرض الكل" / "See All" link
- Vertical list (max 3 items)
- Each item:
  - Pinned indicator (pin icon, amber, if applicable)
  - Title (Cairo SemiBold 15sp)
  - Preview text (first 80 chars, Cairo Regular 13sp, 60% opacity)
  - Relative date ("منذ ساعتين" / "2 hours ago")

**Quick Actions Grid**
- 2 rows × 3 columns of icon buttons
- Each: circular icon (48dp) + label below (Cairo Regular 12sp)
- Items: دوراتي (My Courses), الحضور (Attendance), الدرجات (Grades), المساعد الذكي (AI), المكافآت (Rewards), المتجر (Marketplace)

**Features**
- Pull-to-refresh reloads all sections
- Banner auto-rotation with manual swipe override
- Real-time unread notification count (polling every 60 seconds or WebSocket)
- Deep link support for banner actions
- Time-of-day greeting: "صباح الخير" (5am-12pm), "مساء الخير" (12pm-6pm), "مساء الخير" (6pm-5am)
- Lazy loading of each section independently
- Cache-first strategy: show cached data immediately, refresh in background

**Displayed Data**
| Section | API Source |
|---|---|
| User Name | Cached from login response `user.first_name` |
| Wallet Balance | `user.wallet_balance` (cached + background refresh) |
| Points | `user.total_points` (cached + background refresh) |
| Unread Count | `GET /api/v1/notifications/unread-count` |
| Banners | `GET /api/v1/banners?placement=home&grade_id={user.grade_id}` |
| Continue Learning | `GET /api/v1/student/courses?status=in_progress&sort=last_accessed&limit=5` |
| Featured Courses | `GET /api/v1/courses?featured=true&grade_id={user.grade_id}&limit=6` |
| Announcements | `GET /api/v1/announcements?limit=3` |

**Navigation**
| Action | Destination |
|---|---|
| Tap notification bell | Notifications Screen |
| Tap profile avatar | Profile Screen |
| Tap wallet card | Wallet Screen |
| Tap "Continue" on course card | Course Detail → Resume at last item |
| Tap featured course card | Course Detail Screen |
| Tap announcement | Announcement Detail (modal bottom sheet or full screen) |
| Tap banner | Banner action target (course, URL, announcement, or internal screen) |
| Tap quick action: My Courses | My Courses Screen (Tab 2) |
| Tap quick action: Attendance | Attendance History Screen |
| Tap quick action: Grades | My Grades Screen |
| Tap quick action: AI | AI Assistant Screen (Tab 3) |
| Tap quick action: Rewards | Points & Rewards Screen |
| Tap quick action: Marketplace | Marketplace Screen |
| Tap "See All" (Continue Learning) | My Courses Screen (Tab 2) |
| Tap "See All" (Featured) | Browse Courses (Catalog) |
| Tap "See All" (Announcements) | Announcements List Screen |

**Business Rules**
- BR-HOME-01: Continue Learning section displays only courses where `student_courses.progress_percent > 0` AND `student_courses.progress_percent < 100` AND `student_courses.expires_at IS NULL OR student_courses.expires_at > NOW()`.
- BR-HOME-02: Featured coursesexclude courses the student is already enrolled in (`student_courses` join does not exist for this user).
- BR-HOME-03: Announcements are filtered by matching the student's `grade_id`, `center_id`, and `center_group_id` against the announcement's `target_type` and `target_ids` JSON array. Announcements with `target_type = 'all'` are always shown.
- BR-HOME-04: Banners are shown only if: `banners.is_active = true` AND `banners.start_date ≤ NOW()` AND `banners.end_date ≥ NOW()` AND (`banners.grade_ids IS NULL` OR student's `grade_id` is contained in `banners.grade_ids`).
- BR-HOME-05: Each banner impression (visible in viewport for ≥ 1 second) increments `banners.views_count` (debounced — once per session per banner).
- BR-HOME-06: Each banner tap increments `banners.clicks_count` via `POST /api/v1/banners/{id}/click`.
- BR-HOME-07: If the student has no enrolled courses, the Continue Learning section is replaced by a promotional CTA card: "Start your learning journey! Browse available courses." Tappable → Course Catalog.
- BR-HOME-08: If there are no announcements, the Announcements section is hidden entirely (no empty state shown).
- BR-HOME-09: Dashboard data is cached locally with a 5-minute TTL. On pull-to-refresh, cache is invalidated and all sections reload.
- BR-HOME-10: Each section loads independently. A failure in one section (e.g., banners) does not block the rendering of other sections.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/dashboard` | Aggregated dashboard data (optional composite endpoint) |
| `GET` | `/api/v1/banners?placement=home&grade_id={id}` | Fetch active banners |
| `GET` | `/api/v1/student/courses?status=in_progress&sort=last_accessed&limit=5` | Fetch in-progress courses |
| `GET` | `/api/v1/courses?featured=true&grade_id={id}&limit=6` | Fetch featured courses |
| `GET` | `/api/v1/announcements?limit=3` | Fetch recent announcements |
| `GET` | `/api/v1/notifications/unread-count` | Fetch unread notification count |
| `POST` | `/api/v1/banners/{id}/click` | Track banner click |
| `GET` | `/api/v1/student/wallet/summary` | Refresh wallet balance and points |

**States**
- **Loading (Initial):** Shimmer placeholders for each section in their respective layouts (horizontal card shimmers for courses, vertical list shimmers for announcements).
- **Loading (Pull-to-Refresh):** Standard pull-to-refresh indicator at top; existing content remains visible below.
- **Empty — No Courses + No Announcements:** Greeting + wallet card + banners + CTA card "Start your learning journey!" + quick actions grid. Featured section may still show.
- **Error — Full Network Failure (no cache):** Full-screen illustration with cloud-disconnect icon. Text: "Unable to load dashboard. Please check your connection." Button: "Retry".
- **Error — Full Network Failure (with cache):** Show cached data with amber banner at top: "You are offline. Showing cached data."
- **Partial Load Failure:** Individual section shows inline: "Unable to load. Tap to retry." Other sections render normally.

---

### 4.10 Screen: My Courses (Enrolled)

**Purpose**
Display all courses the student is currently enrolled in, organized by status, with progress indicators and quick access to resume learning.

**UI Components**
- Tab bar at top: "In Progress" / "Completed" / "Expired"
- Search bar (below tabs, with filter icon)
- Course list (vertical, scrollable)
  - Each course card:
    - Course thumbnail (80x80dp, rounded corners, left-aligned)
    - Course title (Cairo SemiBold 16sp, max 2 lines)
    - Grade and category badges (small chips)
    - Progress bar (linear, full width below title)
    - Progress text: "{n}% complete" (Cairo Regular 12sp)
    - Session count: "{completed}/{total} sessions"
    - Last accessed: relative date ("Last opened 2 hours ago")
    - Expiry warning badge (if expires within 7 days, amber chip: "Expires in {n} days")
    - "Continue" button (accent, right-aligned)
- "Browse More Courses" button (bottom of list, outlined)
- Empty state illustrations per tab

**Features**
- Tab switching with independent data for each tab
- Search by course title within enrolled courses
- Pull-to-refresh
- Infinite scroll pagination
- Swipe-to-reveal quick actions (optional: unenroll request)

**Displayed Data**
| Field | Source |
|---|---|
| Course Thumbnail | `courses.image_url` |
| Title | `courses.title` |
| Grade | `grades.name` via `courses.grade_id` |
| Category | `categories.name` via `courses.category_id` |
| Progress | `student_courses.progress_percent` |
| Completed Sessions | `student_courses.completed_sessions` |
| Total Sessions | `courses.total_sessions` |
| Last Accessed | `student_courses.last_accessed_at` |
| Expires At | `student_courses.expires_at` |
| Completed At | `student_courses.completed_at` |

**Navigation**
| Action | Destination |
|---|---|
| Tap course card or "Continue" | Course Detail Screen |
| Tap "Browse More Courses" | Course Catalog Screen |
| Tab 2 — Completed tab | List of completed courses with completion date and certificate |
| Tab 3 — Expired tab | List of expired courses with renewal CTA |

**Business Rules**
- BR-MYCRS-01: "In Progress" tab shows courses where `progress_percent > 0 AND progress_percent < 100 AND (expires_at IS NULL OR expires_at > NOW())`.
- BR-MYCRS-02: "Completed" tab shows courses where `completed_at IS NOT NULL`.
- BR-MYCRS-03: "Expired" tab shows courses where `expires_at < NOW() AND completed_at IS NULL`.
- BR-MYCRS-04: Courses with `progress_percent = 0` (enrolled but never accessed) appear in "In Progress" tab.
- BR-MYCRS-05: Expiry warning badge appears when `expires_at - NOW() ≤ 7 days`.
- BR-MYCRS-06: Search is client-side filtering for cached data, server-side for paginated data.
- BR-MYCRS-07: Default sort is `last_accessed_at DESC` for In Progress, `completed_at DESC` for Completed, `expires_at DESC` for Expired.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/courses?status={in_progress\|completed\|expired}&search={q}&page={n}&limit=20` | Fetch enrolled courses by status |

**States**
- **Loading:** Shimmer list with 5 card placeholders.
- **Empty — In Progress:** Illustration of open book. Text: "You haven't started any courses yet. Browse available courses to begin." Button: "Browse Courses".
- **Empty — Completed:** Illustration of trophy. Text: "No completed courses yet. Keep learning!"
- **Empty — Expired:** Illustration of calendar. Text: "No expired courses."
- **Error:** "Unable to load your courses." Button: "Retry".

---

### 4.11 Screen: Course Catalog (Browse Courses)

**Purpose**
Allow students to discover, search, filter, and sort available courses within their tenant and grade level for potential enrollment.

**UI Components**
- Search bar (top, placeholder: "Search courses...")
- Category filter chips (horizontal scroll below search)
  - "All" chip (default selected)
  - One chip per active category from tenant's grade
- Sort dropdown button (right side below categories)
  - Options: Featured, Newest, Price (Low→High), Price (High→Low), Most Enrolled
- View toggle: Grid / List (icon buttons)
- Course cards (grid: 2 columns, list: full-width):
  - **Grid card:** Thumbnail (top, 1:1), title (2 lines max), price/free badge, enrollment count
  - **List card:** Thumbnail (80x80, left), title, subtitle (1 line), price/free, enrollment count, course type badge
  - "Enrolled" badge overlay (green, if already enrolled)
- Infinite scroll pagination
- Floating filter button (bottom right, shows active filter count)

**Features**
- Real-time search (debounced 300ms)
- Category chip selection (single select, replaces current filter)
- Sort persistence in local preferences
- Grid/list view persistence in local preferences
- Pull-to-refresh
- Price display respects locale (Arabic numerals or Western, based on language setting)

**Displayed Data**
| Field | Source |
|---|---|
| Course Thumbnail | `courses.image_url` |
| Title | `courses.title` |
| Subtitle | `courses.subtitle` |
| Current Price | `courses.price` |
| Old Price | `courses.old_price` (shown as strikethrough) |
| Free Badge | `courses.is_free = true` |
| Enrolled Badge | `student_courses` exists for current user |
| Enrollment Count | `courses.enrolled_count` |
| Course Type | `courses.type` (Online / Center / Both) |
| Categories | `categories` filtered by `tenant_id` and student's `grade_id` |

**Navigation**
| Action | Destination |
|---|---|
| Tap course card (not enrolled) | Course Detail Screen (with enrollment CTA) |
| Tap course card (enrolled) | Course Detail Screen (with progress view) |
| Back | Home Dashboard or My Courses |

**Business Rules**
- BR-CAT-01: Only courses with `is_active = true` AND `published_at IS NOT NULL` are displayed.
- BR-CAT-02: Courses are filtered by the student's `grade_id` by default. No cross-grade browsing.
- BR-CAT-03: Already-enrolled courses display an "Enrolled" badge overlay and do not show price.
- BR-CAT-04: Free courses (`is_free = true`) display "مجاني" / "Free" badge in green.
- BR-CAT-05: Courses with `old_price > price` show old price with strikethrough styling and current price highlighted.
- BR-CAT-06: Category "All" returns unfiltered (by category) results.
- BR-CAT-07: Default sort is "Featured" (`courses.featured DESC, courses.pinned DESC, courses.order_index ASC`).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/courses?grade_id={id}&category_id={id}&search={q}&sort={field}&order={asc\|desc}&page={n}&limit=20` | Fetch filtered, sorted, paginated course catalog |
| `GET` | `/api/v1/categories?grade_id={id}` | Fetch categories for filter chips |

**States**
- **Loading:** Grid of 6 shimmer card placeholders (or 4 list placeholders).
- **Empty — No Results:** Illustration with magnifying glass. Text: "No courses found. Try a different search or filter."
- **Empty — No Courses:** Illustration. Text: "No courses available yet. Check back soon!"
- **Error:** "Unable to load courses. Please try again." Button: "Retry".

---

### 4.12 Screen: Course Detail

**Purpose**
Display comprehensive course information including description, session breakdown, pricing, enrollment options, and learning progress for enrolled students. This is the central hub for all course-related student interactions.

**UI Components**

**Hero Section**
- Course cover image (full-width, 200dp height, parallax scroll effect)
- Back button (top left, white, circular semi-transparent background)
- Share button (top right, white)
- Course title (Cairo Bold 20sp, overlaid on gradient at bottom of image)
- Course subtitle (Cairo Regular 14sp, below title)

**Info Bar**
- Instructor/Tenant name with avatar
- Course type badge (Online / Center / Both)
- Statistics row (icon + text each):
  - 📚 {total_sessions} sessions
  - 🎥 {total_videos} videos
  - ⏱ {total_duration_minutes} minutes
  - 👥 {enrolled_count} enrolled

**Pricing Section (Not Enrolled)**
- Price card (elevated, full-width):
  - Current price: "EGP {price}" (Cairo Bold 28sp, primary color)
  - Old price: "EGP {old_price}" (strikethrough, 50% opacity, if applicable)
  - Discount percentage badge: "-{%}%" (red chip)
  - "Enroll Now" button (primary, full-width, 56dp height)
  - "Pay with Wallet (Balance: EGP {balance})" secondary option (if wallet sufficient)
  - "Free Enrollment" button (green, if `is_free = true`)

**Progress Section (Enrolled)**
- Progress card (elevated, full-width):
  - Circular progress indicator (large, centered, with percentage)
  - "{completed_sessions}/{total_sessions} sessions completed" text
  - "Continue Learning" button (primary, full-width)
  - Expiry notice: "Access expires on {date}" (amber text, if applicable)
  - Expiry warning: "⚠️ Expires in {n} days" (red text, if ≤ 7 days)

**Tab Bar**
- 3 tabs: Description | Sessions | Grades

**Description Tab Content**
- Full course description (rich text, supports headers, bold, lists, links)
- Course metadata cards:
  - Grade level
  - Category
  - Duration
  - Type (Online/Center/Both)
  - Ordering mode (Free/Sequential)
  - Points reward for completion

**Sessions Tab Content (Curriculum)**
- Expandable accordion list
- Each session header:
  - Expand/collapse arrow icon
  - Session number and title (Cairo SemiBold 16sp)
  - Item count badge: "{n} items"
  - Total duration: "{minutes} min"
  - Session status icon:
    - 🔒 Locked (not accessible)
    - ⬜ Available (not started)
    - 🔄 In Progress
    - ✅ Completed
  - Free badge (if `sessions.is_free = true`)
  - Price (if session sold individually: "EGP {price}")
- Expanded session content (list of items):
  - Item type icon:
    - 🎥 Video
    - 📄 PDF
    - 🎯 Quiz
    - 📝 Assignment
    - 📌 Note
    - 🔗 Link
    - 🎧 Audio
  - Item title (Cairo Regular 15sp)
  - Duration text for video/audio: "{minutes}:{seconds}"
  - Status icon:
    - ✅ Completed (green checkmark)
    - 🔒 Locked (gray lock)
    - 👁 Preview available (blue eye icon)
  - "Preview" badge (if `is_preview = true`)
  - Tap target: entire row

**Grades Tab Content (Enrolled Only)**
- List of graded assessments:
  - Assessment title
  - Type badge (Quiz / Assignment)
  - Score: "{score}/{total}" with color coding (green ≥ 70%, amber 50-69%, red < 50%)
  - Date completed
  - "View Details" link
- Overall course average (top of tab, large text)

**Features**
- Parallax scroll effect on hero image
- Tab switching with state preservation
- Session accordion expand/collapse with smooth animation
- Preview items playable without enrollment
- Share course via deep link (generates `mentorx.app/course/{slug}`)
- Enrollment triggers payment flow or instant enrollment (free courses)
- Progress auto-refresh on returning from content player

**Displayed Data**
| Section | API Source |
|---|---|
| Course Details | `GET /api/v1/courses/{id}` |
| Sessions & Items | `GET /api/v1/courses/{id}/sessions?include=items` |
| Enrollment & Progress | `GET /api/v1/student/courses/{course_id}/progress` |
| Grades | `GET /api/v1/student/courses/{course_id}/grades` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Enroll Now" (paid course) | Payment Screen |
| Tap "Pay with Wallet" | Enrollment Confirmation Dialog → Success: Course refreshes as enrolled |
| Tap "Free Enrollment" | Enrollment Confirmation Dialog → Success: Course refreshes as enrolled |
| Tap "Continue Learning" | Last accessed session item (Video Player, PDF Viewer, etc.) |
| Tap unlocked video item | Video Player Screen |
| Tap unlocked PDF item | PDF Viewer Screen |
| Tap unlocked quiz item | Quiz Start Confirmation → Quiz Taking Screen |
| Tap unlocked assignment item | Assignment Detail / Submission Screen |
| Tap unlocked note item | Note Viewer Screen |
| Tap unlocked audio item | Audio Player Screen |
| Tap unlocked link item | External browser / in-app WebView |
| Tap preview item (not enrolled) | Content Player (preview mode, limited access) |
| Tap locked item | Toast: "Complete previous content to unlock" or "Enroll to access this content" |
| Tap grade detail | Quiz Results Screen or Assignment Feedback Screen |
| Tap share | System share sheet with deep link |
| Back | Previous screen (Catalog, My Courses, or Home) |

**Business Rules**
- BR-CRS-01: Session and item accessibility follows the course's `ordering_mode`:
  - `free`: All sessions and all items within them are accessible to enrolled students.
  - `sequential`: Sessions unlock sequentially. Session N+1 unlocks when Session N has all required items completed.
  - `lock_session`: Each session requires individual purchase (via session price or code).
  - `lock_item`: Each item within a session unlocks only after the previous item is completed.
- BR-CRS-02: Items with `is_preview = true` or `is_free = true` are accessible without enrollment, regardless of ordering mode. These show a "Preview" badge.
- BR-CRS-03: Enrollment creates a `student_courses` record:
  - `enrolled_at = NOW()`
  - `expires_at = NOW() + courses.duration_days` (if `duration_days > 0`, else `NULL`)
  - `enrolled_by` = `self`, `code`, or `admin`
  - `progress_percent = 0`
- BR-CRS-04: For free courses (`is_free = true` OR `price = 0`), enrollment proceeds without payment.
- BR-CRS-05: For paid courses, if `users.wallet_balance ≥ courses.price`, show "Pay with Wallet" option.
- BR-CRS-06: After enrollment, `courses.enrolled_count` is incremented.
- BR-CRS-07: Expired enrollment (`expires_at < NOW()`) shows all items as locked with message: "Your access has expired."
- BR-CRS-08: Expiry warning appears when `expires_at - NOW() ≤ 7 days`.
- BR-CRS-09: Points reward notification: "Complete this course to earn {points_reward} points!" shown in description tab.
- BR-CRS-10: Upon course completion (`progress_percent = 100`), award `courses.points_reward` points via `points_transactions`, update `student_courses.completed_at`, and generate certificate URL if configured.
- BR-CRS-11: The "Continue Learning" button navigates to `student_courses.last_item_id`. If null, navigate to the first item of the first session.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/courses/{id}` | Fetch complete course details |
| `GET` | `/api/v1/courses/{id}/sessions?include=items` | Fetch sessions with nested items |
| `GET` | `/api/v1/student/courses/{course_id}/progress` | Fetch enrollment status and progress |
| `GET` | `/api/v1/student/courses/{course_id}/grades` | Fetch all assessment grades for this course |
| `POST` | `/api/v1/student/courses/{course_id}/enroll` | Enroll in course |

**Request Body — `POST /api/v1/student/courses/{course_id}/enroll`**
```json
{
  "payment_method": "wallet",
  "code": null
}
```

**Response Body — Enrollment Success**
```json
{
  "success": true,
  "data": {
    "enrollment_id": 789,
    "course_id": 5,
    "enrolled_at": "2025-07-15T10:30:00Z",
    "expires_at": "2025-10-15T10:30:00Z",
    "wallet_balance_after": 50.00,
    "points_earned": 0,
    "message": "Successfully enrolled! Start learning now."
  }
}
```

**States**
- **Loading:** Shimmer for hero section, info bar, and session list.
- **Not Enrolled:** Pricing section visible; all non-preview items locked; Grades tab hidden or shows "Enroll to see grades".
- **Enrolled — In Progress:** Progress section visible; items accessible per ordering mode; Grades tab active.
- **Enrolled — Completed:** Completion badge on hero image; "🎉 Course Completed!" banner; certificate download button; Grades tab shows final summary.
- **Enrolled — Expired:** All items locked; amber banner: "Your access expired on {date}. Contact your teacher to renew." Grades tab still visible (historical).
- **Enrollment Processing:** Full-screen overlay: "Processing enrollment..." spinner.
- **Enrollment Success:** Success dialog with confetti: "Welcome! You're now enrolled in {course_title}." Button: "Start Learning".
- **Enrollment Error — Insufficient Balance:** Dialog: "Insufficient wallet balance. Your balance is EGP {balance}. This course costs EGP {price}." Buttons: "Top Up Wallet" / "Cancel".
- **Error — Load Failed:** "Unable to load course details." Button: "Retry".

---

### 4.13 Screen: Video Player

**Purpose**
Play video lesson content with full playback controls, quality selection, progress tracking, and completion detection.

**UI Components**
- Video player area (full-width, 16:9 aspect ratio in portrait; fullscreen in landscape)
- Play/pause center overlay button
- Bottom control bar:
  - Play/pause button (left)
  - Current time / total time text ("02:35 / 15:00")
  - Seek bar (linear slider with buffer indicator)
  - 10-second rewind button
  - 10-second forward button
  - Quality selector button (cog icon → dropdown: Auto, 1080p, 720p, 480p, 360p)
  - Playback speed button → dropdown: 0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x
  - Fullscreen toggle button (right)
- Volume control (system volume or slider)
- Loading spinner (overlay on video during buffering)
- Content section (below player in portrait):
  - Item title (Cairo SemiBold 18sp)
  - Session context: "Session: {session_title}" (Cairo Regular 14sp, 60% opacity)
  - Item navigation: "← Previous" / "Next →" buttons
  - Item description (if present, expandable)
- Completion indicator: green checkmark overlay when video marked complete
- Offline available indicator (if downloaded)

**Features**
- Adaptive bitrate streaming (HLS/DASH)
- Resume from last position on re-entry
- Auto-save progress every 15 seconds and on pause/exit/background
- Mark complete when ≥ 90% of duration watched
- Orientation: auto-rotate to landscape when fullscreen tapped; lock portrait otherwise
- Background playback prevention (pause when app backgrounded)
- Screenshot/screen recording detection (display warning overlay if detected)
- Double-tap left/right side of video to rewind/forward 10 seconds
- Swipe up/down on right side for volume, left side for brightness (optional)
- Quality and speed preferences persist across sessions (local storage)

**Displayed Data**
| Field | Source |
|---|---|
| Video Stream URL | `GET /api/v1/session-items/{id}/stream` → signed URL with TTL |
| Quality Options | `session_items.video_quality` (JSON: `{"1080p": "url", "720p": "url", ...}`) |
| Video Duration | `session_items.duration_seconds` |
| Last Position | `student_progress.last_position_seconds` |
| Progress Status | `student_progress.status` |
| Item Title | `session_items.title` |
| Session Title | `sessions.title` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Next →" | Next session item (based on `order_index`) |
| Tap "← Previous" | Previous session item |
| Back (portrait) | Course Detail Screen (Sessions tab) |
| Back (landscape/fullscreen) | Exit fullscreen → portrait view |

**Business Rules**
- BR-VID-01: Video is marked complete when `watch_time_seconds ≥ 0.9 × duration_seconds`. Separate watched segments are tracked (not just last position) to prevent skipping to the end.
- BR-VID-02: Progress is persisted via `PUT /api/v1/student/progress/{item_id}` every 15 seconds, on pause, on exit (app lifecycle event), and on background transition.
- BR-VID-03: If `session_items.downloadable = false`, no download option is presented.
- BR-VID-04: Completion triggers:
  1. `student_progress.status = 'completed'`, `completed_at = NOW()`
  2. Recalculate `student_courses.completed_items` and `progress_percent`
  3. Check if session is now complete (all required items done)
  4. Check if course is now complete
  5. If next item exists and ordering mode permits, auto-prompt "Play next: {title}?"
- BR-VID-05: Streaming URL is signed with a 4-hour TTL. If expired, request a fresh URL transparently.
- BR-VID-06: If enrollment is expired, display overlay: "Your access has expired." and prevent playback.
- BR-VID-07: If screen recording is detected, display persistent overlay: "Screen recording is not allowed." and pause playback.
- BR-VID-08: Default quality is "Auto" (adaptive). User selection persists in local storage.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/session-items/{id}/stream` | Get signed streaming URL |
| `PUT` | `/api/v1/student/progress/{item_id}` | Update watch progress |
| `POST` | `/api/v1/student/progress/{item_id}/complete` | Mark item as complete |

**Request Body — `PUT /api/v1/student/progress/{item_id}`**
```json
{
  "status": "in_progress",
  "progress_percent": 65.5,
  "watch_time_seconds": 590,
  "last_position_seconds": 605
}
```

**Response Body — Complete**
```json
{
  "success": true,
  "data": {
    "item_completed": true,
    "session_completed": false,
    "course_completed": false,
    "course_progress_percent": 45.0,
    "next_item": {
      "id": 234,
      "title": "Practice Problems",
      "type": "quiz",
      "unlocked": true
    },
    "points_earned": 0
  }
}
```

**States**
- **Loading:** Spinner overlay centered on black video frame. Text: "Loading video..."
- **Buffering:** Spinner overlay during playback stall.
- **Playing:** Controls auto-hide after 3 seconds of no interaction; tap to show.
- **Paused:** Controls visible; play button centered.
- **Completed:** Green checkmark overlay (fades after 2 seconds). "Next: {item_title}" prompt.
- **Error — Stream Failed:** "Unable to play video. Please check your connection." Buttons: "Retry" / "Go Back".
- **Error — Access Denied:** "You don't have access to this video." (expired enrollment or unenrolled). Button: "Go to Course".
- **Error — Screen Recording:** Persistent red overlay: "Screen recording is not permitted during video playback."

---

### 4.14 Screen: PDF Viewer

**Purpose**
Display PDF lesson materials with page navigation, zoom controls, and optional download capability.

**UI Components**
- PDF rendering area (full-screen, pinch-to-zoom)
- Top bar: item title, close button
- Bottom bar:
  - Page indicator: "Page {current} / {total}"
  - Page slider (horizontal, for quick navigation)
  - Download button (if `downloadable = true`)
  - Bookmark current page button
- Thumbnail sidebar (optional, toggleable for quick page navigation)
- Loading progress bar (shows page loading percentage)

**Features**
- Smooth page scrolling (vertical continuous or page-by-page)
- Pinch-to-zoom (1x to 5x)
- Double-tap to zoom to fit / reset
- Download for offline access (if permitted)
- Page position saved on exit
- Text selection disabled (to protect content)
- Night mode toggle (dark background for reading comfort)
- Mark as complete when last page is reached

**Displayed Data**
| Field | Source |
|---|---|
| PDF URL | `session_items.content_url` |
| Page Count | `session_items.page_count` |
| File Size | `session_items.file_size_kb` |
| Last Position | `student_progress.last_position_seconds` (repurposed as last page number) |
| Downloadable | `session_items.downloadable` |

**Navigation**
| Action | Destination |
|---|---|
| Close / Back | Course Detail (Sessions tab) |
| "Next Item" (after completion) | Next session item |

**Business Rules**
- BR-PDF-01: PDF is marked complete when the student reaches the last page.
- BR-PDF-02: Progress is saved as page number (stored in `student_progress.last_position_seconds` as page index).
- BR-PDF-03: If `downloadable = true`, the download button is visible and stores the PDF locally for offline access.
- BR-PDF-04: Text selection and copy are disabled to protect teacher content.
- BR-PDF-05: Same enrollment and expiry checks as Video Player (BR-VID-06).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/session-items/{id}/content` | Get signed PDF URL |
| `PUT` | `/api/v1/student/progress/{item_id}` | Update page progress |
| `POST` | `/api/v1/student/progress/{item_id}/complete` | Mark PDF as complete |

**States**
- **Loading:** Progress bar with percentage. Text: "Loading document ({file_size_kb} KB)..."
- **Rendered:** Full PDF with controls.
- **Error — Load Failed:** "Unable to load document." Button: "Retry" / "Download for offline".
- **Error — Access Denied:** Same pattern as Video Player.

---

### 4.15 Screen: Quiz Taking

**Purpose**
Administer a timed, secure quiz with multiple question types, answer randomization, auto-save, and anti-cheating measures.

**UI Components**

**Quiz Header (Sticky — always visible)**
- Quiz title (Cairo SemiBold 16sp, truncated)
- Timer: "⏱ {MM}:{SS}" (Cairo Bold 18sp; red pulse animation when < 2 minutes)
- Question counter: "{current}/{total}" (Cairo Regular 14sp)
- "Submit" button (outlined red, right side)

**Question Area (Scrollable)**
- Question number badge: "Q{n}" (circular, primary color background, white text)
- Marks indicator: "({marks} marks)" (Cairo Regular 12sp, 50% opacity)
- Question text (Cairo Regular 16sp, supports rich text and inline LaTeX rendering)
- Question image (if present, full-width, tappable to zoom)
- Answer section (varies by question type):

| Question Type | UI Component |
|---|---|
| `mcq_single` | Radio button list. Each option: radio + text (Cairo Regular 15sp). Selected option highlighted with accent background. |
| `mcq_multiple` | Checkbox list. Same styling as single but with checkboxes. Hint: "Select all that apply." |
| `true_false` | Two large toggle cards: "True ✓" / "False ✗". Selected card fills with accent color. |
| `fill_blank` | Single-line text input with underline style. Placeholder: "Type your answer..." |
| `text` | Multi-line text area (4 lines visible, expandable). Character count indicator. |

- "Flag for Review" toggle (bookmark icon, amber when active)

**Question Navigation**
- Bottom navigation bar:
  - "← Previous" button (left)
  - Question number grid (scrollable horizontal): each number in a small circle
    - Gray: unanswered
    - Green: answered
    - Amber: flagged
    - Blue border: current
  - "Next →" button (right)

**Submit Confirmation Dialog (Modal)**
- Title: "Submit Quiz?"
- Summary text: "You answered {n} of {total} questions."
- Flagged count: "{flagged} flagged for review."
- Unanswered list: "Unanswered: Q3, Q7, Q12" (tappable to navigate)
- Buttons: "Review Answers" (outlined) / "Submit" (primary, red)

**Features**
- Auto-save every answer on selection/change
- Auto-submit when timer reaches zero
- Question shuffling (applied at attempt start)
- Option shuffling for MCQ questions
- Flag for review with visual indicator
- Free navigation between questions (not sequential-only)
- Paste detection in text fields (flag for review)
- App lifecycle monitoring: if app goes to background for > 30 seconds, auto-submit
- Offline answer queue: if network drops, answers are saved locally and synced when reconnected

**Displayed Data**
| Field | Source |
|---|---|
| Quiz Title | `quizzes.title` |
| Duration | `quizzes.duration_minutes` (timer starts from this value) |
| Questions | From `POST /api/v1/quizzes/{id}/start` response |
| Question text/image | `quiz_questions.question_text`, `quiz_questions.question_image_url` |
| Options | `quiz_questions.options` (JSON array, shuffled if configured) |
| Marks per question | `quiz_questions.marks` |

**Navigation**
| Action | Destination |
|---|---|
| Submit quiz (manual) | Quiz Results Screen |
| Auto-submit (timer expire) | Quiz Results Screen |
| Auto-submit (app background timeout) | Quiz Results Screen (submitted with status `timed_out`) |
| Back button pressed | Warning dialog: "Leave quiz? Progress is saved. You can resume if time hasn't expired." |

**Business Rules**
- BR-QZ-01: Starting a quiz creates a `quiz_attempts` record with `status = 'in_progress'`, `started_at = NOW()`, and `attempt_number` incremented.
- BR-QZ-02: If `quizzes.max_attempts` reached for this student, prevent quiz start. Display: "Maximum attempts reached ({max_attempts}/{max_attempts})."
- BR-QZ-03: If `quizzes.shuffle_questions = true`, generate random order at attempt creation, store in `quiz_attempts.question_order` JSON.
- BR-QZ-04: If `quizzes.shuffle_options = true`, randomize MCQ options per question per attempt.
- BR-QZ-05: If `quizzes.questions_per_attempt` is set (not null), randomly select that many questions from the full pool. Store selected IDs in `question_order`.
- BR-QZ-06: Each answer creates/updates `quiz_responses` with `attempt_id`, `question_id`, `selected_options` or `text_answer`, `answered_at`, and `time_spent_seconds`.
- BR-QZ-07: Timer expires: all answered questions are submitted. `quiz_attempts.status = 'timed_out'`.
- BR-QZ-08: Manual submit: `quiz_attempts.status = 'submitted'`, `submitted_at = NOW()`.
- BR-QZ-09: Automated grading:
  - `mcq_single`: Compare `selected_options[0]` with `correct_answer[0]`. Binary correct/incorrect.
  - `mcq_multiple`: All selected must match all correct answers exactly. Partial credit NOT given.
  - `true_false`: Compare selected with correct answer. Binary.
  - `fill_blank`: Case-insensitive trimmed comparison with correct answer. Exact match required.
  - `text`: Not auto-graded. Queued for instructor review.
- BR-QZ-10: Score = `SUM(marks_obtained)`. Percentage = `score / quizzes.total_marks × 100`.
- BR-QZ-11: `passed = (percentage ≥ quizzes.pass_percentage)`.
- BR-QZ-12: If passed, points earned = configurable per quiz or course. Added via `points_transactions`.
- BR-QZ-13: Quiz accessibility window: only available between `quizzes.available_from` and `quizzes.available_until`.
- BR-QZ-14: Negative marking: if `quiz_questions.negative_marks > 0`, deduct from score for incorrect answers (not for unanswered).
- BR-QZ-15: If student goes to app background for > 30 seconds during active quiz, auto-submit and flag the attempt.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/quizzes/{id}/start` | Create attempt, receive questions |
| `PUT` | `/api/v1/quiz-attempts/{attempt_id}/answer` | Save individual answer |
| `POST` | `/api/v1/quiz-attempts/{attempt_id}/submit` | Submit entire attempt |

**Request Body — `POST /api/v1/quizzes/{id}/start`**
```json
{
  "device_info": "Samsung Galaxy A54 / Android 14",
  "ip_address": "192.168.1.105"
}
```

**Response Body — Start Success**
```json
{
  "success": true,
  "data": {
    "attempt_id": 156,
    "attempt_number": 1,
    "max_attempts": 2,
    "duration_minutes": 30,
    "total_questions": 20,
    "total_marks": 100,
    "shuffle_options": true,
    "show_correct_answers": true,
    "questions": [
      {
        "id": 401,
        "order": 1,
        "question_text": "ما هي صيغة المعادلة التربيعية؟",
        "question_image_url": null,
        "question_type": "mcq_single",
        "options": [
          {"index": 0, "text": "x = -b ± √(b²-4ac) / 2a"},
          {"index": 1, "text": "x = b ± √(b²-4ac) / 2a"},
          {"index": 2, "text": "x = -b ± √(b²+4ac) / 2a"},
          {"index": 3, "text": "x = -b ± √(4ac-b²) / 2a"}
        ],
        "marks": 5
      }
    ]
  }
}
```

**Request Body — `PUT /api/v1/quiz-attempts/{attempt_id}/answer`**
```json
{
  "question_id": 401,
  "selected_options": [0],
  "text_answer": null,
  "time_spent_seconds": 45
}
```

**Request Body — `POST /api/v1/quiz-attempts/{attempt_id}/submit`**
```json
{
  "submit_type": "manual",
  "total_time_spent_seconds": 1245
}
```

**States**
- **Loading (Start):** Full-screen spinner: "Preparing your quiz..." (while questions are fetched).
- **In Progress:** Timer running, questions navigable, answer auto-saving active.
- **Submitting:** Full-screen overlay: "Submitting your answers..." Buttons disabled.
- **Error — Start Failed:** "Unable to start quiz. Please try again." Button: "Retry".
- **Error — Save Failed:** Non-blocking toast: "Answer save failed. Retrying..." Auto-retry 3 times. If persistent, save locally.
- **Error — Submit Failed:** Dialog: "Submission failed. Your answers are saved. Please try again." Button: "Retry Submit".
- **Error — Network Lost:** Amber banner: "Connection lost. Answers saved locally." Continue quiz; sync on reconnect.
- **Error — Max Attempts:** Full-screen: "You've used all {n} attempts for this quiz." Button: "Back to Course".
- **Error — Outside Window:** "This quiz is not available. Available from {date} to {date}." Button: "Back to Course".
- **Error — Already In Progress:** "You have an ongoing attempt. Resume?" Buttons: "Resume" / "Cancel".

---

### 4.16 Screen: Quiz Results

**Purpose**
Display the student's quiz score, pass/fail status, time spent, and optionally show correct answers with explanations.

**UI Components**
- Score circle (large, centered, animated counter from 0 to score):
  - Green fill if passed, red fill if failed
  - Percentage text inside circle (Cairo Bold 36sp)
  - "Passed ✓" or "Not Passed ✗" badge below
- Statistics row (4 columns):
  - Score: "{marks}/{total_marks}"
  - Time: "{mm}:{ss}"
  - Correct: "{n}"
  - Wrong: "{n}"
- Attempt info: "Attempt {n} of {max}"
- Points earned badge (green, if applicable): "+{n} points earned! 🎉"

**Answer Review Section (if `show_correct_answers = true`)**
- Vertical list of all questions:
  - Question number and text
  - Student's answer (highlighted green if correct, red if wrong)
  - Correct answer (shown for wrong answers, highlighted green)
  - Explanation text (if `show_explanations = true` and `quiz_questions.explanation` exists)
  - Marks obtained: "+{marks}" or "0" or "-{negative_marks}"
- Color coding:
  - Green background: correct answer
  - Red background: student's wrong answer
  - Gray: unanswered

**Bottom Actions**
- "Retake Quiz" button (primary, if attempts remaining)
- "Back to Course" button (outlined)
- "Share Score" button (optional, social sharing)

**Features**
- Animated score counter (0 → final percentage over 1.5 seconds)
- Confetti animation if passed
- Scroll through answer review
- Expandable explanations

**Displayed Data**
| Field | Source |
|---|---|
| Score | `quiz_attempts.score` |
| Total Marks | `quiz_attempts.total_marks` |
| Percentage | `quiz_attempts.percentage` |
| Passed | `quiz_attempts.passed` |
| Time Spent | `quiz_attempts.time_spent_seconds` |
| Attempt Number | `quiz_attempts.attempt_number` |
| Questions & Responses | `quiz_responses` joined with `quiz_questions` |
| Correct Answers | `quiz_questions.correct_answer` (only if `show_correct_answers = true`) |
| Explanations | `quiz_questions.explanation` (only if `show_explanations = true`) |
| Points Earned | From submission response or `points_transactions` |

**Navigation**
| Action | Destination |
|---|---|
| "Retake Quiz" | Quiz Start (creates new attempt) |
| "Back to Course" | Course Detail Screen (Sessions tab) |
| Share | System share sheet |

**Business Rules**
- BR-QR-01: Score animation plays only on first view of results for this attempt. Subsequent views show score immediately.
- BR-QR-02: "Retake Quiz" is shown only if `quiz_attempts.attempt_number < quizzes.max_attempts`.
- BR-QR-03: Correct answers are revealed only if `quizzes.show_correct_answers = true`. Otherwise, only show score/percentage without question-level review.
- BR-QR-04: Explanations are shown only if `quizzes.show_explanations = true`.
- BR-QR-05: If `quizzes.show_score_immediately = false`, display: "Your score is being reviewed by your teacher. You'll be notified when results are available." Hide score circle.
- BR-QR-06: Points are awarded only once per quiz (on first passing attempt). Subsequent passing retakes do not re-award.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/quiz-attempts/{attempt_id}/results` | Fetch detailed results with responses |

**States**
- **Loading:** Shimmer for score circle and question list.
- **Passed:** Green score circle, confetti, points badge.
- **Failed:** Red score circle, encouragement text: "Keep trying! You can retake this quiz."
- **Pending Review:** Gray score circle with hourglass. "Results pending teacher review."
- **Error:** "Unable to load results." Button: "Retry".

---

### 4.17 Screen: Assignment Detail & Submission

**Purpose**
Display assignment instructions and requirements, allow file upload and text submission, and show grading feedback after teacher review.

**UI Components**

**Assignment Info Section**
- Title (Cairo Bold 20sp)
- Description (Cairo Regular 15sp, rich text)
- Instructions (expandable card)
- Attachments from teacher (list of downloadable files with icon + name + size)
- Metadata row:
  - Total marks: "{marks} marks"
  - Due date: "{date}" with countdown ("Due in 3 days" or "Overdue" in red)
  - Late submission: "Late submissions allowed (penalty: {%}%)" or "No late submissions"
  - File requirements: "Accepted: PDF, DOCX, JPG. Max: {max_size_mb}MB. Max files: {n}"

**Submission Section (if not yet submitted or resubmission requested)**
- File upload area (dotted border, tappable):
  - "📎 Upload Files" text
  - Drag/drop not applicable on mobile; tap to open file picker
  - Selected files list: file name, size, remove (X) button
  - Upload progress bar per file
- Notes text area: "Add notes for your teacher..." (optional, multi-line)
- "Submit Assignment" button (primary, full-width)

**Submitted Section (if already submitted)**
- Status badge: "Submitted" (blue), "Graded" (green), "Resubmission Requested" (amber)
- Submitted files list (tappable to view)
- Submission timestamp
- Student notes (if provided)
- Is late indicator (red badge if `is_late = true`)

**Grading Section (if graded)**
- Score: "{score}/{total_marks}" (large text, color-coded)
- Teacher feedback (rich text area, bordered)
- Graded by: teacher name
- Graded at: timestamp

**Resubmission Section (if status = resubmit_requested)**
- Teacher's resubmission request notes
- New file upload area
- New notes area
- "Resubmit" button

**Features**
- Multi-file upload with progress tracking
- File type validation (client-side)
- File size validation (client-side)
- Download teacher attachments
- View own submitted files
- Resubmission workflow

**Displayed Data**
| Field | Source |
|---|---|
| Assignment Details | `assignments` table fields |
| Teacher Attachments | `assignments.attachment_urls` (JSON array) |
| Due Date | `assignments.due_date` |
| Late Policy | `assignments.allow_late_submission`, `assignments.late_penalty_percent` |
| File Requirements | `assignments.allowed_file_types`, `assignments.max_file_size_mb`, `assignments.max_files` |
| Submission | `assignment_submissions` for current user |
| Score | `assignment_submissions.score` |
| Feedback | `assignment_submissions.feedback` |

**Navigation**
| Action | Destination |
|---|---|
| Back | Course Detail (Sessions tab) |
| Tap teacher attachment | PDF Viewer or file download |
| Tap own submitted file | File viewer |
| Submit success | Confirmation → Stay on screen (status updated) |

**Business Rules**
- BR-ASN-01: Files are validated client-side against `assignments.allowed_file_types` (JSON array of extensions). Invalid files show error: "File type not accepted. Allowed: {types}."
- BR-ASN-02: Each file must be ≤ `assignments.max_file_size_mb`. Total file count must be ≤ `assignments.max_files`.
- BR-ASN-03: If `assignments.due_date < NOW()`:
  - If `allow_late_submission = true`: submission is accepted but `is_late = true`. Score penalty of `late_penalty_percent` is applied.
  - If `allow_late_submission = false`: submission is blocked. Display: "This assignment is past due and no longer accepting submissions."
- BR-ASN-04: Submission creates `assignment_submissions` record with `status = 'submitted'`.
- BR-ASN-05: Only one submission per student per assignment (unless resubmission requested).
- BR-ASN-06: If `assignment_submissions.status = 'resubmit_requested'`, the student can upload new files.
- BR-ASN-07: Students receive a push notification when their assignment is graded.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/assignments/{id}` | Fetch assignment details |
| `GET` | `/api/v1/assignments/{id}/submission` | Fetch student's submission (if exists) |
| `POST` | `/api/v1/upload/files` | Upload assignment files |
| `POST` | `/api/v1/assignments/{id}/submit` | Submit assignment |

**Request Body — `POST /api/v1/assignments/{id}/submit`**
```json
{
  "file_urls": [
    "https://cdn.mentorx.com/uploads/assignments/file1.pdf",
    "https://cdn.mentorx.com/uploads/assignments/file2.jpg"
  ],
  "notes": "Here is my solution for problem set 3."
}
```

**States**
- **Loading:** Shimmer for assignment info and submission area.
- **Not Submitted:** Upload area and submit button visible. Due date countdown displayed.
- **Uploading:** Progress bar per file. Submit button disabled until all uploads complete.
- **Submitted — Pending Grade:** Status badge: "Submitted ✓". Upload area hidden. "Your teacher will review this soon."
- **Graded:** Score and feedback displayed. If passed, green theme. If failed, encouragement message.
- **Resubmission Requested:** Amber status. Teacher notes shown. New upload area visible.
- **Past Due — No Late Submissions:** Upload area hidden. Red text: "Submission deadline has passed."
- **Past Due — Late Allowed:** Amber warning: "This submission will be marked as late. A {%}% penalty will apply." Upload area visible.
- **Error — Upload Failed:** Per-file error: "Upload failed. Tap to retry." Other files unaffected.
- **Error — Submit Failed:** "Submission failed. Your files are uploaded. Tap to retry submission."

---

### 4.18 Screen: Attendance History

**Purpose**
Display the student's attendance records across all courses and centers with summary statistics and detailed session-level records.

**UI Components**

**Summary Card (Top)**
- Attendance rate circle (large, with percentage): color-coded (green ≥ 80%, amber 60-79%, red < 60%)
- Statistics row:
  - Total sessions: "{n}"
  - Present: "{n}" (green)
  - Late: "{n}" (amber)
  - Absent: "{n}" (red)
  - Excused: "{n}" (blue)

**Filter Bar**
- Date range picker (this month / last month / custom)
- Course/center filter dropdown

**Attendance Records List**
- Grouped by date (section headers: "July 15, 2025")
- Each record:
  - Course/session name (Cairo SemiBold 15sp)
  - Center name (if physical attendance)
  - Time: "{start_time} - {end_time}"
  - Status badge: Present (green), Late (amber), Absent (red), Excused (blue), Online (teal)
  - Check-in time (if present/late): "Checked in at {time}"
  - Notes from teacher (if any, expandable)

**Features**
- Pull-to-refresh
- Infinite scroll pagination
- Date range filtering
- Course filtering
- Export attendance summary (optional — share as image/PDF)

**Displayed Data**
| Field | Source |
|---|---|
| Attendance Stats | `GET /api/v1/student/attendance/summary` → aggregated from `attendance_records` |
| Records | `GET /api/v1/student/attendance?from={date}&to={date}&course_id={id}&page={n}` → `attendance_records` joined with `attendance_sessions` |

**Navigation**
| Action | Destination |
|---|---|
| Back | More tab or Home |
| Tap record | Record detail (expandable in-place or bottom sheet with full details) |

**Business Rules**
- BR-ATT-01: Default date range is current month.
- BR-ATT-02: Statistics are calculated from filtered records (respecting date range and course filter).
- BR-ATT-03: Records are sorted by `attendance_sessions.date DESC, start_time DESC`.
- BR-ATT-04: Attendance data is read-only for students. Students cannot modify records.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/attendance/summary?from={date}&to={date}` | Fetch attendance statistics |
| `GET` | `/api/v1/student/attendance?from={date}&to={date}&course_id={id}&page={n}&limit=20` | Fetch attendance records |

**States**
- **Loading:** Shimmer for summary card and record list.
- **Empty:** Illustration of calendar. Text: "No attendance records found for this period."
- **Error:** "Unable to load attendance data." Button: "Retry".

---

### 4.19 Screen: QR Attendance Scanner

**Purpose**
Allow the student to scan a QR code generated by the teacher to record physical attendance at a center session.

**UI Components**
- Camera preview (full-screen background)
- QR frame overlay (centered square with animated scanning line)
- Title: "Scan Attendance QR" (top, white text on dark overlay)
- Instructions: "Point your camera at the QR code displayed by your teacher" (white text)
- Flash toggle button (top right)
- Manual code entry link: "Enter code manually" (bottom)
- Cancel / back button (top left)

**Features**
- Real-time QR code scanning
- Auto-detection and processing (no button tap needed)
- Flash/torch toggle
- Manual code entry fallback (text input)
- Haptic feedback on successful scan
- Auto-close after successful scan

**Navigation**
| Action | Destination |
|---|---|
| Successful scan | Success dialog → Attendance History or back to previous screen |
| Failed scan (3 attempts) | Manual entry mode |
| Cancel | Previous screen |
| Manual entry success | Success dialog |

**Business Rules**
- BR-QRS-01: QR code contains encoded data: `{attendance_session_id}_{qr_code}_{timestamp}`. The student's device decodes and sends to the API.
- BR-QRS-02: QR code is valid only between `attendance_sessions.qr_valid_from` and `attendance_sessions.qr_valid_until`.
- BR-QRS-03: If the current time is past `attendance_sessions.start_time + late_threshold_minutes`, the attendance is recorded as `late`.
- BR-QRS-04: A student can only check in once per attendance session (`UNIQUE KEY unique_attendance`).
- BR-QRS-05: The student must be enrolled in the course or assigned to the center group associated with the attendance session.
- BR-QRS-06: `check_in_method = 'qr_code'` is recorded.
- BR-QRS-07: GPS location may optionally be captured to verify proximity to the center (future enhancement).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/student/attendance/check-in` | Record attendance from QR scan |

**Request Body**
```json
{
  "attendance_session_id": 45,
  "qr_code": "ATT-2025-07-15-ABC123",
  "device_hash": "a1b2c3d4e5f6",
  "scanned_at": "2025-07-15T14:05:30Z"
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "status": "present",
    "check_in_time": "2025-07-15T14:05:30Z",
    "session_title": "Physics - Lecture 5",
    "message": "Attendance recorded successfully!"
  }
}
```

**States**
- **Scanning:** Camera active with animated scan line.
- **Processing:** Spinner overlay: "Recording attendance..."
- **Success:** Green checkmark animation + haptic. Text: "Attendance recorded! Status: {status}". Auto-dismiss after 3 seconds.
- **Error — Invalid QR:** Red X. "Invalid QR code. Please try again."
- **Error — Expired QR:** "This QR code has expired. Ask your teacher for a new code."
- **Error — Already Checked In:** "You've already checked in for this session."
- **Error — Not Enrolled:** "You are not enrolled in this session."
- **Error — Camera Permission:** "Camera access is required. Please enable it in Settings." Button: "Open Settings".

---

### 4.20 Screen: Wallet

**Purpose**
Display the student's digital wallet balance, transaction history, and provide access to top-up and code redemption features.

**UI Components**

**Balance Card (Top, elevated, gradient)**
- Wallet icon
- Balance: "EGP {amount}" (Cairo Bold 32sp, white)
- Points: "{n} points" (Cairo Regular 14sp, white, 70% opacity)
- Two action buttons (below balance):
  - "Top Up" (white button with accent icon)
  - "Redeem Code" (white button with code icon)

**Quick Top-Up Amounts (Horizontal scroll)**
- Predefined amount chips: EGP 50, EGP 100, EGP 200, EGP 500
- Tappable → Top Up Screen with amount pre-filled

**Transaction History Section**
- Section title: "Transaction History" (Cairo SemiBold 18sp)
- Filter chips: "All" / "Deposits" / "Purchases" / "Refunds"
- Transaction list (vertical, infinite scroll):
  - Each transaction:
    - Transaction icon (green ↑ for credit, red ↓ for debit)
    - Description text (Cairo Regular 15sp)
    - Amount: "+EGP {amount}" (green) or "-EGP {amount}" (red)
    - Balance after: "Balance: EGP {amount}" (12sp, 50% opacity)
    - Date: relative timestamp
    - Type badge: "Top Up" / "Course Purchase" / "Code" / "Reward" / "Admin" / "Refund"

**Features**
- Pull-to-refresh (reloads balance and transactions)
- Infinite scroll pagination for transactions
- Filter by transaction type
- Animated balance counter on load

**Displayed Data**
| Field | Source |
|---|---|
| Balance | `users.wallet_balance` via `GET /api/v1/student/wallet/summary` |
| Points | `users.total_points` |
| Transactions | `GET /api/v1/student/wallet/transactions?type={filter}&page={n}` → `wallet_transactions` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Top Up" | Top Up Screen |
| Tap "Redeem Code" | Code Redemption Screen |
| Tap quick amount chip | Top Up Screen (pre-filled) |
| Tap transaction | Transaction Detail bottom sheet (full details) |
| Back | Main tab (if accessed from tab) or previous screen |

**Business Rules**
- BR-WAL-01: Wallet balance is refreshed from the server on every screen visit and pull-to-refresh.
- BR-WAL-02: Transactions are sorted by `wallet_transactions.created_at DESC`.
- BR-WAL-03: Transaction type filters: `deposit` (all credits), `purchase` (course/session/marketplace), `refund`, or all.
- BR-WAL-04: Balance cannot go negative (enforced server-side).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/wallet/summary` | Fetch current balance and points |
| `GET` | `/api/v1/student/wallet/transactions?type={filter}&page={n}&limit=20` | Fetch transaction history |

**States**
- **Loading:** Shimmer for balance card and transaction list.
- **Empty Transactions:** Balance card visible. List area: "No transactions yet. Top up your wallet to get started." Button: "Top Up".
- **Error:** "Unable to load wallet data." Button: "Retry".

---

### 4.21 Screen: Top Up

**Purpose**
Allow the student to add funds to their digital wallet using supported Egyptian payment methods.

**UI Components**
- Amount input:
  - Large number display (Cairo Bold 36sp): "EGP {amount}"
  - Numeric keypad (custom or system)
  - Predefined amount buttons: 50, 100, 200, 500
  - Minimum amount note: "Minimum: EGP 10"
- Payment method selection (radio list):
  - Vodafone Cash (logo + name + brief instruction)
  - InstaPay (logo + name)
  - Fawry (logo + name)
- "Proceed" button (primary, full-width, disabled until amount + method selected)

**Payment Method Specific Screens**

**Vodafone Cash:**
- Instruction: "Send EGP {amount} to {vodafone_cash_number}"
- Copy number button
- "I've sent the payment" button → processing screen

**InstaPay:**
- Redirect to InstaPay app / deep link
- Return handling

**Fawry:**
- Generated reference number display
- Instruction: "Pay at any Fawry outlet using code: {reference}"
- Copy code button
- Expiry: "Code valid until {expiry_date}"
- "I've paid" button (optional, system detects automatically)

**Features**
- Custom amount entry with minimum validation
- Payment method logos and instructions
- Copy-to-clipboard for payment numbers/codes
- Payment status polling after submission
- Push notification on payment confirmation

**Navigation**
| Action | Destination |
|---|---|
| Payment success | Success Screen → Wallet Screen (balance updated) |
| Payment pending | Pending Screen with auto-refresh |
| Cancel | Back to Wallet |

**Business Rules**
- BR-TOP-01: Minimum top-up amount is EGP 10. Maximum is EGP 5,000 per transaction.
- BR-TOP-02: Payment creates a `payments` record with `payment_type = 'wallet_topup'`, `status = 'pending'`.
- BR-TOP-03: Upon gateway confirmation, `payments.status = 'completed'`, `wallet_transactions` entry created with `transaction_type = 'deposit'`, and `users.wallet_balance` is incremented.
- BR-TOP-04: Fawry reference codes expire after 48 hours.
- BR-TOP-05: Payment status is polled every 10 seconds for up to 5 minutes after "I've paid" confirmation.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/payments/initiate` | Create payment and get gateway instructions || `GET` | `/api/v1/payments/{id}/status` | Poll payment status |

**Request Body — `POST /api/v1/payments/initiate`**
```json
{
  "amount": 100.00,
  "currency": "EGP",
  "method": "vodafone_cash",
  "payment_type": "wallet_topup"
}
```

**Response Body — Vodafone Cash**
```json
{
  "success": true,
  "data": {
    "payment_id": 891,
    "method": "vodafone_cash",
    "amount": 100.00,
    "status": "pending",
    "instructions": {
      "phone_number": "01012345678",
      "message": "Send EGP 100.00 to this Vodafone Cash number",
      "reference": "MX-891-2025"
    },
    "expires_at": "2025-07-15T18:30:00Z"
  }
}
```

**Response Body — Fawry**
```json
{
  "success": true,
  "data": {
    "payment_id": 892,
    "method": "fawry",
    "amount": 100.00,
    "status": "pending",
    "instructions": {
      "reference_number": "9847362510",
      "message": "Pay at any Fawry outlet using this reference number",
      "expires_at": "2025-07-17T18:30:00Z"
    }
  }
}
```

**States**
- **Default:** Amount input active, method list visible, proceed button disabled.
- **Amount Below Minimum:** Red text: "Minimum amount is EGP 10."
- **Processing:** Full-screen overlay: "Setting up your payment..."
- **Payment Instructions:** Method-specific instructions displayed with copy buttons.
- **Polling:** After "I've paid": spinner with "Verifying payment..." and auto-refresh every 10 seconds.
- **Success:** Green checkmark. "EGP {amount} added to your wallet!" New balance displayed. Button: "Done" → Wallet.
- **Timeout:** "We haven't confirmed your payment yet. If you've already paid, it may take a few minutes to reflect." Button: "Check Again" / "Go to Wallet".
- **Failed:** "Payment was not completed." Button: "Try Again" / "Go to Wallet".
- **Error — Network:** "Unable to process payment. Please check your connection." Button: "Retry".

---

### 4.22 Screen: Code Redemption

**Purpose**
Allow the student to enter a promotional or access code to receive wallet credit, course access, session access, or discounts.

**UI Components**
- Illustration (gift box or voucher, 30% screen height)
- Title: "Redeem Code" (Cairo Bold 22sp)
- Description: "Enter your code below to redeem wallet credit, course access, or discounts." (Cairo Regular 15sp)
- Code input field (large, centered, uppercase auto-conversion, Cairo Bold 20sp, monospace, 16 chars max)
- "Redeem" button (primary, full-width)
- Recent redemptions section (below, expandable):
  - List of last 5 redeemed codes with date and value

**Features**
- Uppercase auto-conversion on input
- Paste support
- Input sanitization (alphanumeric only, no spaces)
- Haptic feedback on successful redemption
- Animated result display

**Displayed Data**
| Field | Source |
|---|---|
| Recent Redemptions | `GET /api/v1/student/codes/history?limit=5` → `code_redemptions` |

**Navigation**
| Action | Destination |
|---|---|
| Successful redemption (wallet) | Success animation → stay on screen (balance updated) |
| Successful redemption (course access) | Success animation → option to "Go to Course" |
| Back | Wallet Screen |

**Business Rules**
- BR-CODE-01: Code is validated against `codes` table with: `codes.tenant_id` = student's tenant, `codes.status = 'active'`, `codes.valid_from ≤ NOW()`, `codes.valid_until ≥ NOW()`.
- BR-CODE-02: If `codes.max_uses` is reached (`used_count ≥ max_uses`), code is invalid: "This code has been fully redeemed."
- BR-CODE-03: Per-user limit: if the student has already redeemed this code `per_user_limit` times, reject: "You've already used this code."
- BR-CODE-04: Code types and effects:
  - `wallet`: Add `codes.value` to `users.wallet_balance` via `wallet_transactions`.
  - `course_access`: Create `student_courses` enrollment for `codes.course_id`.
  - `session_access`: Unlock specific session for the student.
  - `discount_percent`: Apply percentage discount on next purchase (stored in user context).
  - `discount_amount`: Apply fixed discount on next purchase.
- BR-CODE-05: Each redemption creates a `code_redemptions` record and increments `codes.used_count`.
- BR-CODE-06: Grade restrictions: if `codes.grade_restrictions` JSON is not null, the student's `grade_id` must be in the array.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/student/codes/redeem` | Validate and redeem code |
| `GET` | `/api/v1/student/codes/history?limit=5` | Fetch recent redemption history |

**Request Body — `POST /api/v1/student/codes/redeem`**
```json
{
  "code": "PHYSICS2025"
}
```

**Response Body — Wallet Code Success**
```json
{
  "success": true,
  "data": {
    "code_type": "wallet",
    "value": 50.00,
    "new_wallet_balance": 200.00,
    "message": "EGP 50.00 has been added to your wallet!"
  }
}
```

**Response Body — Course Access Code Success**
```json
{
  "success": true,
  "data": {
    "code_type": "course_access",
    "course_id": 5,
    "course_title": "Physics - Term 1",
    "message": "You now have access to Physics - Term 1!"
  }
}
```

**States**
- **Default:** Empty input field, redeem button disabled until ≥ 4 characters entered.
- **Loading:** Redeem button shows spinner.
- **Success — Wallet:** Green animation. "+EGP {amount}" floating text. New balance shown.
- **Success — Course Access:** Green animation. Course title shown. Button: "Go to Course".
- **Error — Invalid Code:** Red shake on input. "This code is invalid or does not exist."
- **Error — Expired:** "This code has expired."
- **Error — Fully Redeemed:** "This code has been fully redeemed."
- **Error — Already Used:** "You've already redeemed this code."
- **Error — Grade Restriction:** "This code is not available for your grade level."
- **Error — Network:** "Unable to verify code. Please check your connection."

---

### 4.23 Screen: AI Assistant — Conversation List

**Purpose**
Display the student's AI chat conversation history and allow starting new conversations.

**UI Components**
- Header: "AI Assistant 🤖" (Cairo Bold 20sp)
- "New Conversation" floating action button (FAB, bottom right, accent color, + icon)
- Conversation list (vertical, scrollable):
  - Each conversation card:
    - AI avatar icon (left, 40dp)
    - Conversation title (Cairo SemiBold 15sp, auto-generated or user-set)
    - Subject badge (if tagged to a subject)
    - Last message preview (1 line, Cairo Regular 13sp, 60% opacity)
    - Relative timestamp ("2 hours ago")
    - Message count badge
    - Swipe-to-delete gesture
- Search bar (top, searches conversation titles and content)

**Features**
- Pull-to-refresh
- Infinite scroll pagination
- Swipe-to-delete with confirmation
- Search conversations
- Long-press to rename conversation

**Displayed Data**
| Field | Source |
|---|---|
| Conversations | `GET /api/v1/student/ai/conversations?page={n}&limit=20` → `ai_conversations` |
| Title | `ai_conversations.title` (auto-generated from first message if null) |
| Subject | `ai_conversations.subject` |
| Message Count | `ai_conversations.message_count` |
| Last Message | Latest `ai_messages.content` (truncated) |
| Timestamp | `ai_conversations.updated_at` |

**Navigation**
| Action | Destination |
|---|---|
| Tap conversation | AI Chat Screen (existing conversation) |
| Tap FAB (New Conversation) | AI Chat Screen (new conversation) |
| Back | Main tab navigation |

**Business Rules**
- BR-AIC-01: Conversations are sorted by `updated_at DESC` (most recent first).
- BR-AIC-02: Only conversations with `is_active = true` are displayed.
- BR-AIC-03: Delete sets `is_active = false` (soft delete). Conversations are not permanently removed.
- BR-AIC-04: Auto-generated title is derived from the first user message (first 50 characters).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/ai/conversations?page={n}&limit=20` | Fetch conversation list |
| `DELETE` | `/api/v1/student/ai/conversations/{id}` | Soft-delete conversation |
| `PATCH` | `/api/v1/student/ai/conversations/{id}` | Rename conversation |

**States**
- **Loading:** Shimmer list with 5 card placeholders.
- **Empty:** Illustration of friendly robot. "Start a conversation with your AI study assistant! Ask questions about your courses." Button: "Start Chat".
- **Error:** "Unable to load conversations." Button: "Retry".

---

### 4.24 Screen: AI Chat Interface

**Purpose**
Provide an interactive chat experience where the student can ask academic questions and receive curriculum-aligned answers generated exclusively from teacher-uploaded course materials using RAG (Retrieval-Augmented Generation).

**UI Components**

**Header Bar**
- Back button (left)
- Conversation title (center, editable on tap)
- Subject selector dropdown (right): filter AI context to a specific course/subject
- Options menu (⋮): rename, delete conversation

**Chat Area (Scrollable, reverse list)**
- Message bubbles:
  - **User messages:** Right-aligned, accent color background, white text
  - **AI messages:** Left-aligned, light gray background, dark text, AI avatar (left, 32dp)
  - **System messages:** Center-aligned, small text, gray (e.g., "Conversation started")
- AI message enhancements:
  - Rich text support (bold, lists, code blocks)
  - LaTeX rendering for mathematical formulas
  - Source citations: "📚 Based on: {session_title} - {item_title}" (tappable → content)
  - "Was this helpful?" feedback row: 👍 / 👎 buttons
- Typing indicator: three animated dots when AI is generating response
- Scroll-to-bottom FAB (appears when scrolled up)
- Date separators: "Today", "Yesterday", "July 14"

**Input Area (Bottom, sticky)**
- Text input field (expandable, max 4 lines visible)
- Placeholder: "Ask a question about your courses..."
- Send button (accent color, right, enabled only when text is non-empty)
- Character count (subtle, shows when approaching limit): "{n}/2000"

**Features**
- Real-time streaming response (character by character or chunk by chunk)
- Auto-scroll to latest message
- Message copy (long-press)
- Source citation tapping navigates to referenced content
- Feedback rating per AI message
- Subject/course context selection
- Offline message queuing (sent when connection restored)
- LaTeX and markdown rendering in AI responses

**Displayed Data**
| Field | Source |
|---|---|
| Messages | `GET /api/v1/student/ai/conversations/{id}/messages` → `ai_messages` |
| Message Content | `ai_messages.content` |
| Message Role | `ai_messages.role` (user / assistant / system) |
| Timestamp | `ai_messages.created_at` |
| User Rating | `ai_messages.user_rating` |
| Source Citations | Embedded in AI response metadata |

**Navigation**
| Action | Destination |
|---|---|
| Tap source citation | Course Detail → specific session item |
| Back | Conversation List |
| Tap subject selector | Dropdown with enrolled courses |

**Business Rules**
- BR-CHAT-01: AI responses are generated **exclusively** from teacher-uploaded content for courses the student is enrolled in. The RAG pipeline retrieves relevant chunks from the vector database filtered by `tenant_id` and optionally `course_id`.
- BR-CHAT-02: If no relevant content is found (similarity score < 0.6), the AI responds: "I couldn't find information about this topic in your course materials. Try asking your teacher directly."
- BR-CHAT-03: Students **cannot** upload files to the AI chat. Only text queries are accepted.
- BR-CHAT-04: Each message is stored in `ai_messages` with `role`, `content`, `tokens_used`.
- BR-CHAT-05: `ai_conversations.message_count` and `tokens_used` are incremented with each exchange.
- BR-CHAT-06: Rate limiting: maximum 50 messages per conversation per day, maximum 200 messages total per day across all conversations.
- BR-CHAT-07: If rate limit is reached, display: "You've reached the daily message limit. Try again tomorrow."
- BR-CHAT-08: Subject context selection filters the RAG retrieval to materials from the selected course only.
- BR-CHAT-09: Maximum query length: 2,000 characters. Maximum response length: 4,000 characters.
- BR-CHAT-10: AI response latency target: ≤ 3 seconds for simple queries, ≤ 8 seconds for complex queries requiring multiple retrieval steps.
- BR-CHAT-11: Feedback (👍/👎) updates `ai_messages.user_rating` (1 for positive, -1 for negative). Optional text feedback stored in `ai_messages.user_feedback`.
- BR-CHAT-12: Conversation context window: last 10 messages are included as context for each new query (to maintain conversational coherence).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/ai/conversations/{id}/messages?page={n}&limit=30` | Fetch message history (paginated, newest first) |
| `POST` | `/api/v1/student/ai/conversations/{id}/messages` | Send new message and receive AI response |
| `POST` | `/api/v1/student/ai/conversations` | Create new conversation |
| `POST` | `/api/v1/student/ai/messages/{id}/feedback` | Submit message feedback |

**Request Body — `POST /api/v1/student/ai/conversations/{id}/messages`**
```json
{
  "content": "اشرح لي قانون نيوتن الثاني للحركة",
  "course_id": 5
}
```

**Response Body — Streamed or Complete**
```json
{
  "success": true,
  "data": {
    "message_id": 1234,
    "role": "assistant",
    "content": "قانون نيوتن الثاني ينص على أن القوة المحصلة المؤثرة على جسم تساوي حاصل ضرب كتلته في تسارعه:\n\n**F = m × a**\n\nحيث:\n- F = القوة (نيوتن)\n- m = الكتلة (كجم)\n- a = التسارع (م/ث²)\n\nهذا يعني أنه كلما زادت القوة المؤثرة على جسم، زاد تسارعه، وكلما زادت كتلة الجسم، قل تسارعه عند تطبيق نفس القوة.",
    "tokens_used": 245,
    "sources": [
      {
        "session_id": 12,
        "session_title": "قوانين نيوتن للحركة",
        "item_id": 56,
        "item_title": "الفيديو: شرح القانون الثاني",
        "relevance_score": 0.94
      }
    ],
    "confidence": "high"
  }
}
```

**Request Body — `POST /api/v1/student/ai/messages/{id}/feedback`**
```json
{
  "rating": 1,
  "feedback": "Very clear explanation"
}
```

**States**
- **Loading (History):** Shimmer message bubbles.
- **Empty (New Conversation):** Welcome message from AI: "مرحباً! أنا مساعدك الذكي. اسألني أي سؤال عن موادك الدراسية 📚"
- **Typing (AI Generating):** Three animated dots in AI bubble. Input disabled.
- **Streaming:** AI message bubble growing character by character.
- **Rate Limited:** Input disabled. Banner: "You've reached today's message limit ({n}/{max}). Resets at midnight."
- **Error — Send Failed:** Red indicator on message bubble. "Failed to send. Tap to retry."
- **Error — AI Unavailable:** "AI assistant is temporarily unavailable. Please try again later."
- **Error — Network:** Amber banner: "You're offline. Messages will be sent when connection is restored."
- **No Relevant Content:** AI response: "I couldn't find information about this in your courses. Try rephrasing or ask your teacher."

---

### 4.25 Screen: Points & Rewards

**Purpose**
Display the student's points balance, earning history, and provide access to the reward store where points can be redeemed for items.

**UI Components**

**Points Summary Card (Top)**
- Large points number: "{total_points} pts" (Cairo Bold 36sp, accent color)
- Subtitle: "Your reward points" (Cairo Regular 14sp)
- "Points History" link (right-aligned)

**How to Earn Points Section**
- Horizontal card scroll:
  - "Complete a course: +{n} pts"
  - "Pass a quiz: +{n} pts"
  - "Daily login: +{n} pts"
  - "Perfect attendance: +{n} pts"

**Reward Store Section**
- Section title: "Reward Store" (Cairo SemiBold 18sp)
- Grid of reward items (2 columns):
  - Each card:
    - Item image (1:1, top)
    - Title (Cairo SemiBold 14sp)
    - Required points: "{n} pts" (accent badge)
    - Remaining quantity: "{n} left" (if limited)
    - Availability status: "Available" (green) or "Out of Stock" (gray)
    - "Claim" button (primary, small, disabled if insufficient points or out of stock)

**My Claims Section**
- "My Claims" tab/link
- List of claimed rewards:
  - Item title
  - Points spent
  - Status badge: Pending (amber) / Approved (green) / Rejected (red) / Delivered (blue)
  - Claimed date

**Features**
- Pull-to-refresh
- Animated points counter on load
- Claim confirmation dialog
- Filter reward store by availability

**Displayed Data**
| Field | Source |
|---|---|
| Points Balance | `users.total_points` |
| Points History | `GET /api/v1/student/points/history?page={n}` → `points_transactions` |
| Reward Items | `GET /api/v1/student/rewards?page={n}` → `reward_items` filtered by `tenant_id` and `is_active = true` |
| My Claims | `GET /api/v1/student/rewards/claims?page={n}` → `reward_claims` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Points History" | Points History Screen (full list of `points_transactions`) |
| Tap "Claim" on reward | Claim Confirmation Dialog |
| Tap claimed reward | Claim Detail bottom sheet |
| Back | More tab |

**Business Rules**
- BR-PTS-01: Points balance = `users.total_points`. Server is the source of truth; never computed client-side.
- BR-PTS-02: "Claim" button is disabled if `users.total_points < reward_items.required_points` or `reward_items.remaining_quantity ≤ 0`.
- BR-PTS-03: Claiming a reward:
  1. Creates `reward_claims` with `status = 'pending'`, `points_spent = required_points`
  2. Deducts points from `users.total_points` via `points_transactions` with `transaction_type = 'spend'`
  3. Decrements `reward_items.remaining_quantity`
- BR-PTS-04: Per-user claim limit: a student cannot claim the same reward item more than `reward_items.per_user_limit` times.
- BR-PTS-05: Reward items are only shown if `available_from ≤ NOW()` AND `available_until ≥ NOW()` (or both null).
- BR-PTS-06: If a claim is rejected, points are refunded (via `points_transactions` with `transaction_type = 'earn'` and source `reward_refund`).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/points/history?page={n}&limit=20` | Fetch points transaction history |
| `GET` | `/api/v1/student/rewards?page={n}&limit=20` | Fetch available reward items |
| `GET` | `/api/v1/student/rewards/claims?page={n}&limit=20` | Fetch student's reward claims |
| `POST` | `/api/v1/student/rewards/{item_id}/claim` | Claim a reward item |

**Request Body — `POST /api/v1/student/rewards/{item_id}/claim`**
```json
{}
```

**Response Body — Claim Success**
```json
{
  "success": true,
  "data": {
    "claim_id": 56,
    "reward_title": "Study Notebook",
    "points_spent": 200,
    "remaining_points": 120,
    "status": "pending",
    "message": "Reward claimed! Your teacher will review your request."
  }
}
```

**States**
- **Loading:** Shimmer for points card and reward grid.
- **Empty — No Rewards:** Illustration. "No rewards available right now. Keep earning points!"
- **Empty — No Claims:** "You haven't claimed any rewards yet."
- **Insufficient Points:** "Claim" button grayed out with tooltip: "You need {n} more points."
- **Out of Stock:** "Claim" button replaced with "Out of Stock" text.
- **Claim Confirmation:** Dialog: "Claim {item_title} for {n} points? Your balance will be {remaining} points." Buttons: "Cancel" / "Confirm".
- **Claim Success:** Green animation. "Reward claimed! Pending approval."
- **Error:** "Unable to load rewards." Button: "Retry".

---

### 4.26 Screen: Marketplace — Product List

**Purpose**
Display a catalog of physical and digital products available for purchase by the student within their tenant's marketplace.

**UI Components**
- Category filter chips (horizontal scroll): "All", then categories from tenant
- Search bar
- Product grid (2 columns):
  - Each card:
    - Product image (1:1, top)
    - Title (Cairo SemiBold 14sp, 2 lines max)
    - Price: "EGP {price}" (Cairo Bold 16sp)
    - Old price (strikethrough, if applicable)
    - "Featured" badge (star icon, if `is_featured = true`)
    - Stock indicator: "In Stock" (green) / "Out of Stock" (red)
    - "Add to Cart" icon button (bottom right corner)
- Floating cart button (bottom right, with item count badge)

**Features**
- Category filtering
- Search by product title
- Pull-to-refresh
- Infinite scroll
- Add to cart without leaving the list
- Cart badge updates in real-time

**Displayed Data**
| Field | Source |
|---|---|
| Categories | `GET /api/v1/marketplace/categories` → `marketplace_categories` |
| Products | `GET /api/v1/marketplace/items?category_id={id}&search={q}&page={n}` → `marketplace_items` |

**Navigation**
| Action | Destination |
|---|---|
| Tap product card | Product Detail Screen |
| Tap "Add to Cart" | Add to local cart + toast confirmation |
| Tap floating cart | Cart Screen |
| Back | More tab |

**Business Rules**
- BR-MKT-01: Only products with `is_active = true` are displayed.
- BR-MKT-02: Out-of-stock products (`stock_quantity = 0` AND `track_inventory = true`) show "Out of Stock" and disable "Add to Cart".
- BR-MKT-03: Cart is stored locally until order is placed.
- BR-MKT-04: Featured products appear first in the default sort order.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/marketplace/categories` | Fetch product categories |
| `GET` | `/api/v1/marketplace/items?category_id={id}&search={q}&page={n}&limit=20` | Fetch products |

**States**
- **Loading:** Grid shimmer with 4 card placeholders.
- **Empty:** Illustration. "No products available in the store right now."
- **Error:** "Unable to load store." Button: "Retry".

---

### 4.27 Screen: Marketplace — Product Detail

**Purpose**
Display full product information and allow the student to add it to their cart with quantity selection.

**UI Components**
- Image carousel (horizontal, full-width, multiple product images)
- Product title (Cairo Bold 20sp)
- Price section:
  - Current price: "EGP {price}" (Cairo Bold 24sp)
  - Old price (strikethrough, if applicable)
- Description (Cairo Regular 15sp, expandable)
- Stock status: "In Stock ({n} available)" or "Out of Stock"
- Quantity selector: - / {n} / + (min 1, max stock or 10)
- "Add to Cart" button (primary, full-width)
- "Buy Now" button (outlined, full-width, goes directly to checkout)

**Navigation**
| Action | Destination |
|---|---|
| "Add to Cart" | Toast: "Added to cart!" Stay on screen. |
| "Buy Now" | Cart Screen → Checkout |
| Back | Product List |

**Business Rules**
- BR-MKPD-01: Quantity cannot exceed `stock_quantity` (if `track_inventory = true`) or 10 (maximum per order).
- BR-MKPD-02: "Buy Now" adds to cart and navigates to Cart Screen immediately.

**States**
- **Loading:** Shimmer for image, title, price area.
- **Out of Stock:** Quantity selector disabled. Both buttons disabled. Red text: "This product is currently out of stock."
- **Added to Cart:** Green toast with cart icon. Cart badge updated.

---

### 4.28 Screen: Marketplace — Cart & Checkout

**Purpose**
Display cart contents, allow quantity adjustments, and process the order through wallet payment.

**UI Components**

**Cart Items List**
- Each item:
  - Product image (60x60)
  - Title
  - Unit price
  - Quantity selector (- / n / +)
  - Line total: "EGP {unit_price × quantity}"
  - Remove button (trash icon)
- Empty cart illustration (if no items)

**Order Summary Card (Bottom, sticky)**
- Subtotal: "EGP {sum}"
- Delivery fee: "EGP {fee}" or "Free"
- Total: "EGP {total}" (Cairo Bold 20sp)
- Wallet balance indicator: "Wallet: EGP {balance}" (green if sufficient, red if insufficient)

**Delivery Information (Expandable)**
- Delivery address text field
- Delivery phone (pre-filled from profile)
- Delivery notes text area

**"Place Order" button (primary, full-width, disabled if cart empty or insufficient balance)**

**Features**
- Quantity adjustment with real-time total recalculation
- Remove items with swipe or tap
- Wallet balance check before order placement
- Order confirmation dialog

**Navigation**
| Action | Destination |
|---|---|
| "Place Order" success | Order Confirmation Screen |
| Insufficient balance | "Top Up Wallet" CTA |
| Back | Product List |

**Business Rules**
- BR-CART-01: Cart is stored locally. Cart persists across app sessions until order is placed or manually cleared.
- BR-CART-02: On "Place Order":
  1. Validate stock availability for all items (server-side)
  2. Deduct `total_amount` from `users.wallet_balance` via `wallet_transactions`
  3. Create `payments` record with `payment_type = 'marketplace'`
  4. Create `marketplace_orders` with `status = 'pending'`
  5. Create `marketplace_order_items` for each cart item
  6. Decrement `marketplace_items.stock_quantity` for tracked items
  7. Clear local cart
- BR-CART-03: If wallet balance < total, disable "Place Order" and show: "Insufficient balance. Top up EGP {deficit} to place this order."
- BR-CART-04: `order_number` is auto-generated: `ORD-{TENANT_PREFIX}-{TIMESTAMP}-{RANDOM}`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/marketplace/orders` | Place order |

**Request Body**
```json
{
  "items": [
    {"item_id": 10, "quantity": 2},
    {"item_id": 15, "quantity": 1}
  ],
  "delivery_address": "15 شارع التحرير، الجيزة",
  "delivery_phone": "01012345678",
  "delivery_notes": "الطابق الثالث"
}
```

**Response Body**
```json
{
  "success": true,
  "data": {
    "order_id": 234,
    "order_number": "ORD-AHM-20250715-X4K9",
    "total_amount": 350.00,
    "wallet_balance_after": 150.00,
    "status": "pending",
    "message": "Order placed successfully!"
  }
}
```

**States**
- **Empty Cart:** Illustration of empty cart. "Your cart is empty. Browse the store!" Button: "Go to Store".
- **Processing Order:** Overlay: "Placing your order..."
- **Order Success:** Green checkmark. Order number displayed. "Your order has been placed!" Buttons: "View Order" / "Continue Shopping".
- **Error — Stock Unavailable:** "Some items are no longer available: {items}. Please update your cart."
- **Error — Insufficient Balance:** "Not enough balance. Top up your wallet." Button: "Top Up".

---

### 4.29 Screen: Marketplace — Order History

**Purpose**
Display the student's order history with status tracking.

**UI Components**
- Order list (vertical, chronological):
  - Each order card:
    - Order number (Cairo SemiBold 15sp)
    - Date placed
    - Total amount
    - Item count: "{n} items"
    - Status badge: Pending (amber) / Confirmed (blue) / Processing (purple) / Shipped (teal) / Delivered (green) / Cancelled (red)
    - Tappable for detail

**Displayed Data**
| Field | Source |
|---|---|
| Orders | `GET /api/v1/student/marketplace/orders?page={n}` → `marketplace_orders` |

**Navigation**
| Action | Destination |
|---|---|
| Tap order | Order Detail bottom sheet (items, delivery info, status timeline) |

**States**
- **Loading:** Shimmer list.
- **Empty:** "You haven't placed any orders yet."
- **Error:** "Unable to load orders." Button: "Retry".

---

### 4.30 Screen: Notifications

**Purpose**
Display all notifications received by the student, organized chronologically with read/unread indicators and actionable navigation.

**UI Components**
- "Mark All as Read" text button (top right)
- Notification list (vertical, grouped by date):
  - Each notification:
    - Type icon (left, colored by type):
      - 📢 Announcement (blue)
      - 📚 Course Enrolled (green)
      - 🎯 Quiz Result (purple)
      - 📝 Assignment Graded (orange)
      - ✅ Attendance Marked (teal)
      - 💰 Payment (green)
      - 🎁 Points Earned (amber)
      - 🏆 Reward Status (gold)
      - 👤 Profile Status (gray)
      - ⚙️ System (gray)
    - Title (Cairo SemiBold 15sp)
    - Body preview (1-2 lines, Cairo Regular 13sp, 60% opacity)
    - Timestamp (relative)
    - Unread indicator: blue dot (left edge) for unread notifications
    - Image thumbnail (if `image_url` present)
  - Swipe-to-delete gesture

**Features**
- Pull-to-refresh
- Infinite scroll pagination
- Tap to mark as read and navigate to action target
- Mark all as read
- Swipe-to-delete (individual)
- Badge count updates on main tab icon

**Displayed Data**
| Field | Source |
|---|---|
| Notifications | `GET /api/v1/student/notifications?page={n}&limit=20` → `notifications` |

**Navigation**
| Notification Type | Tap Destination |
|---|---|
| `announcement` | Announcement Detail |
| `course_enrolled` | Course Detail |
| `session_available` | Session Detail |
| `quiz_result` | Quiz Results Screen |
| `assignment_graded` | Assignment Detail |
| `attendance_marked` | Attendance History |
| `payment_success` / `payment_failed` | Wallet Screen |
| `wallet_updated` | Wallet Screen |
| `points_earned` | Points & Rewards |
| `reward_status` | My Claims |
| `profile_approved` / `profile_rejected` | Profile Screen |
| `system` | In-app detail or no navigation |

**Business Rules**
- BR-NOT-01: Tapping a notification marks it as read (`is_read = true`, `read_at = NOW()`).
- BR-NOT-02: "Mark All as Read" updates all unread notifications for the current user.
- BR-NOT-03: Notifications are sorted by `created_at DESC`.
- BR-NOT-04: Push notifications received while the app is open are prepended to the list in real-time.
- BR-NOT-05: Deleting a notification is a soft-delete (or hard-delete based on implementation preference).
- BR-NOT-06: The tab bar badge count reflects `COUNT(notifications WHERE is_read = false)`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/notifications?page={n}&limit=20` | Fetch notifications |
| `PATCH` | `/api/v1/student/notifications/{id}/read` | Mark single notification as read |
| `PATCH` | `/api/v1/student/notifications/read-all` | Mark all as read |
| `DELETE` | `/api/v1/student/notifications/{id}` | Delete notification |
| `GET` | `/api/v1/notifications/unread-count` | Get unread count (for badge) |

**States**
- **Loading:** Shimmer list.
- **Empty:** Illustration of bell. "No notifications yet. You'll see updates here."
- **All Read:** Blue dots disappear. "Mark All" button hidden.
- **Error:** "Unable to load notifications." Button: "Retry".

---

### 4.31 Screen: Profile

**Purpose**
Display the student's complete profile information with the ability to request edits for fields that require teacher approval.

**UI Components**

**Profile Header**
- Profile photo (large, 100dp, circular, with camera icon overlay for edit)
- Student name (Cairo Bold 22sp)
- Student code (Cairo Regular 14sp, copyable)
- Grade badge
- Status badge (Active / Pending / etc.)

**Information Sections (Card-based)**

**Personal Information Card**
- First Name: {value} — edit icon
- Last Name: {value} — edit icon
- Phone: {value} (non-editable, displayed only)
- Email: {value} — edit icon
- Gender: {value}
- Date of Birth: {value}

**Academic Information Card**
- Grade: {value}
- School: {value}
- Study Type: {value}
- Center: {value}
- Schedule: {value}
- Group: {value}

**Location Card**
- Governorate: {value}
- District: {value}

**Parent Information Card**
- Parent Name: {value}
- Parent Phone: {value}

**Account Card**
- Wallet Balance: "EGP {amount}"
- Total Points: "{n} pts"
- Member Since: "{date}"
- Last Login: "{date}"

**Pending Edit Requests Section (if any)**
- List of pending requests with status indicators

**Features**
- Tap edit icon → Edit Request dialog (field name, current value, new value, reason)
- Profile photo change (camera/gallery → crop → upload → creates edit request)
- Copy student code to clipboard
- Pull-to-refresh

**Displayed Data**
| Field | Source |
|---|---|
| All profile fields | `GET /api/v1/student/profile` → `users` table |
| Pending Requests | `GET /api/v1/student/profile/edit-requests?status=pending` → `profile_edit_requests` |

**Navigation**
| Action | Destination |
|---|---|
| Tap edit icon | Edit Request Dialog |
| Tap "Device Management" | Device Management Screen |
| Back | More tab |

**Business Rules**
- BR-PRF-01: Students **cannot** directly edit profile fields. All changes go through `profile_edit_requests` with `status = 'pending'`.
- BR-PRF-02: Phone number changes require additional OTP verification and are subject to uniqueness validation.
- BR-PRF-03: Profile photo changes are submitted as edit requests (teacher must approve).
- BR-PRF-04: Edit requests include: `field_name`, `old_value`, `new_value`, `reason` (optional text).
- BR-PRF-05: Students can see pending edit requests and their status.
- BR-PRF-06: When an edit request is approved by teacher, the corresponding `users` field is updated and the student receives a notification.
- BR-PRF-07: When rejected, the student sees `review_notes` from the teacher.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/profile` | Fetch complete profile |
| `POST` | `/api/v1/student/profile/edit-requests` | Submit edit request |
| `GET` | `/api/v1/student/profile/edit-requests?status=pending` | Fetch pending requests |

**Request Body — `POST /api/v1/student/profile/edit-requests`**
```json
{
  "field_name": "first_name",
  "old_value": "أحمد",
  "new_value": "أحمد محمد",
  "reason": "My full first name was not entered correctly"
}
```

**States**
- **Loading:** Shimmer for profile sections.
- **Default:** All fields displayed, edit icons active.
- **Pending Edits:** Section shows pending requests with amber status chips.
- **Edit Request Submitted:** Toast: "Edit request submitted. Your teacher will review it."
- **Error:** "Unable to load profile." Button: "Retry".

---

### 4.32 Screen: Device Management

**Purpose**
Display registered devices and allow the student to deactivate devices to free up device slots.

**UI Components**
- Device limit info: "You are using {active}/{limit} devices"
- Device list:
  - Each device card:
    - Device icon (phone/tablet)
    - Device name and model
    - OS version
    - Last used: relative timestamp
    - "Current" badge (green, for active device)
    - "Deactivate" button (red, outlined — not shown for current device)

**Features**
- Deactivation confirmation dialog
- Cannot deactivate the current device

**Displayed Data**
| Field | Source |
|---|---|
| Devices | `GET /api/v1/student/devices` → `devices` table for current user |
| Device Limit | `users.device_limit` |

**Navigation**
| Action | Destination |
|---|---|
| Deactivate success | List refreshes; device removed |
| Back | Profile or Settings |

**Business Rules**
- BR-DEV-01: Students can deactivate any device except the current one.
- BR-DEV-02: Deactivation sets `devices.is_active = false` and revokes the `refresh_tokens` associated with that device.
- BR-DEV-03: After deactivation, a new device slot is available for login.
- BR-DEV-04: `users.device_limit` is configurable per tenant (default: 1).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/devices` | Fetch registered devices |
| `DELETE` | `/api/v1/student/devices/{id}` | Deactivate device |

**States**
- **Loading:** Shimmer list.
- **Single Device (Current):** Device shown with "Current" badge. No deactivate option. Info text: "This is your only registered device."
- **Deactivation Confirmation:** Dialog: "Deactivate {device_name}? This device will be logged out and a new device can be used." Buttons: "Cancel" / "Deactivate" (red).
- **Deactivation Success:** Toast: "Device deactivated." List updated.
- **Error:** "Unable to load devices." Button: "Retry".

---

### 4.33 Screen: Settings

**Purpose**
Allow the student to configure application preferences including language, theme, notification settings, and account actions.

**UI Components**

**Preferences Section**
- Language: Toggle between Arabic / English (with RTL/LTR layout switch)
- Theme: Toggle between Light / Dark / System Default
- Video Quality: Default quality selection (Auto / 1080p / 720p / 480p / 360p)
- Playback Speed: Default speed (0.5x - 2.0x)

**Notification Preferences Section**
- Push Notifications: Toggle (on/off)
- WhatsApp Notifications: Toggle
- Email Notifications: Toggle
- Notification categories (expandable):
  - Course updates: Toggle
  - Quiz results: Toggle
  - Assignment grades: Toggle
  - Attendance alerts: Toggle
  - Payment confirmations: Toggle
  - Announcements: Toggle

**Account Section**
- Change Password: → Change Password Screen
- Device Management: → Device Management Screen

**Support Section**
- Help & FAQ: → WebView or internal FAQ screen
- Contact Support: → WhatsApp or email
- Terms of Service: → WebView
- Privacy Policy: → WebView

**App Info Section**
- App Version: "{version} (build {number})"
- "Check for Updates" button

**Danger Zone**
- "Logout" button (red text)
- "Delete Account" button (red outlined — future feature)

**Features**
- Settings persist locally and sync to server
- Language change triggers full app reload with new locale
- Theme change applies immediately
- Notification toggles update server-side preferences

**Displayed Data**
| Field | Source |
|---|---|
| Current Settings | `GET /api/v1/student/settings` → `user_settings` table |

**Navigation**
| Action | Destination |
|---|---|
| Change Password | Change Password Screen |
| Device Management | Device Management Screen |
| Help | FAQ WebView |
| Logout | Login Screen (clear all local data) |

**Business Rules**
- BR-SET-01: Language preference is stored in both `user_settings.language` and local storage. On change, the entire app rerenders in the selected language.
- BR-SET-02: Theme preference is stored in `user_settings.theme` and local storage.
- BR-SET-03: Notification preferences update `user_settings` (push, email, whatsapp toggles) and affect server-side notification delivery.
- BR-SET-04: Logout clears: JWT tokens, refresh tokens (server revocation), cached data, FCM token association. Retains: tenant selection, language preference, onboarding completion flag.
- BR-SET-05: Logout revokes the current refresh token via `POST /api/v1/auth/logout`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/student/settings` | Fetch current settings |
| `PUT` | `/api/v1/student/settings` | Update settings |
| `POST` | `/api/v1/auth/logout` | Revoke refresh token, clear server session |
| `POST` | `/api/v1/auth/change-password` | Change password |

**Request Body — `POST /api/v1/auth/change-password`**
```json
{
  "current_password": "OldP@ss1",
  "new_password": "NewP@ss2",
  "confirm_password": "NewP@ss2"
}
```

**States**
- **Default:** All settings shown with current values.
- **Saving:** Individual toggle shows loading indicator during API call.
- **Language Change:** Full-screen loading overlay during locale switch.
- **Logout Confirmation:** Dialog: "Are you sure you want to logout?" Buttons: "Cancel" / "Logout" (red).
- **Error:** Toast: "Unable to save settings. Please try again."

---

### 4.34 Screen: WhatsApp Groups

**Purpose**
Display the WhatsApp group invite links relevant to the student's grade, center, and group for easy joining.

**UI Components**
- Group list:
  - Each group card:
    - WhatsApp icon (green)
    - Group name
    - Targeting badge: "Your Grade" / "Your Center" / "Your Group"
    - "Join Group" button (green, opens WhatsApp)

**Displayed Data**
| Field | Source |
|---|---|
| Groups | `GET /api/v1/student/whatsapp-groups` → `whatsapp_groups` filtered by student's `grade_id`, `center_id`, `center_group_id` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Join Group" | External WhatsApp app with invite link |
| Back | More tab |

**Business Rules**
- BR-WA-01: Only groups matching the student's `grade_id`, `center_id`, or `center_group_id` are shown.
- BR-WA-02: Only groups with `is_active = true` are displayed.

**States**
- **Loading:** Shimmer list.
- **Empty:** "No WhatsApp groups available for your class."
- **Error:** "Unable to load groups." Button: "Retry".

---

### 4.35 Screen: My Grades (All Courses)

**Purpose**
Provide a consolidated view of all quiz scores and assignment grades across all enrolled courses.

**UI Components**
- Overall GPA / average section (if applicable)
- Course filter dropdown
- Grade list (grouped by course):
  - Course section header: course title + overall course average
  - Assessment items:
    - Type icon (Quiz 🎯 / Assignment 📝)
    - Title
    - Score: "{marks}/{total}" with color coding
    - Percentage bar
    - Date
    - Status: Graded / Pending
    - "View Details" link

**Displayed Data**
| Field | Source |
|---|---|
| Grades | `GET /api/v1/student/grades?course_id={id}` → aggregated from `quiz_attempts` and `assignment_submissions` |

**Navigation**
| Action | Destination |
|---|---|
| Tap quiz grade | Quiz Results Screen |
| Tap assignment grade | Assignment Feedback Screen |
| Back | More tab or Home |

**Business Rules**
- BR-GRD-01: Only the best attempt score is shown for quizzes with multiple attempts.
- BR-GRD-02: Color coding: Green ≥ 70%, Amber 50-69%, Red < 50%.
- BR-GRD-03: "Pending" status shown for submitted but ungraded assignments.

**States**
- **Loading:** Shimmer.
- **Empty:** "No grades available yet. Complete quizzes and assignments to see your grades."
- **Error:** "Unable to load grades." Button: "Retry".

---

## 5. User Flows

### UF-01: First-Time Student Registration

```
1. Student launches app for the first time
2. Splash Screen → detects first launch (no tenant stored)
3. → Onboarding Screens (3 swipeable pages)
4. Student taps "Get Started"
5. → Tenant Selection Screen
6. Student searches for teacher name
7. Student taps on teacher card
8. → Registration Screen (Step 1: Personal Info)
9. Student fills: name, phone, email, gender, DOB, photo
10. System validates fields in real-time
11. System checks phone uniqueness (async API call)
12. Student taps "Next"
13. → Step 2: Academic Info
14. Student selects grade, study type, center (if applicable), schedule
15. Student taps "Next"
16. → Step 3: Location
17. Student selects governorate → districts auto-populate
18. Student selects district
19. Student taps "Next"
20. → Step 4: Parent Info
21. Student enters parent name and phone
22. Student taps "Next"
23. → Step 5: Security
24. Student creates password (strength indicator shown)
25. Student uploads ID card photo (if required by tenant)
26. Student taps "Submit"
27. System sends registration data to API
28. API creates user with status = "pending"
29. API sends OTP to student's phone
30. → OTP Verification Screen
31. Student enters 6-digit code
32. System verifies OTP
33. [If tenant requires ID verification]:
    33a. → National ID Verification Screen
    33b. Student captures ID card photo
    33c. System processes OCR and matches name
    33d. [If match ≥ 85%]: verification passes
    33e. [If match < 85%]: retry up to 3 times → manual review
34. → Pending Approval Screen
35. Student waits for teacher approval (polls every 30s)
36. [When teacher approves]:
    36a. Push notification received
    36b. → Home Dashboard (with welcome animation)
```

### UF-02: Returning Student Login

```
1. Student launches app
2. Splash Screen → detects stored tenant, checks token
3. [If token valid + status active]: → Home Dashboard
4. [If token expired]: attempt refresh
   4a. [Refresh success]: → Home Dashboard
   4b. [Refresh failed]: → Login Screen
5. [If no token]: → Login Screen
6. Student enters phone and password
7. Student taps "Login"
8. System sends credentials + device hash to API
9. [If same device]: API returns tokens → Home Dashboard
10. [If new device]:
    10a. API sends OTP
    10b. → OTP Verification Screen
    10c. Student verifies OTP
    10d. Device registered → Home Dashboard
11. [If device limit reached]:
    11a. Show active devices dialog
    11b. Student deactivates old device
    11c. Retry login → success
```

### UF-03: Course Enrollment (Paid)

```
1. Student browses Course Catalog or taps Featured Course
2. → Course Detail Screen
3. Student reviews course info, sessions, pricing
4. Student taps "Enroll Now"
5. [If wallet balance ≥ price]:
   5a. Confirmation dialog: "Pay EGP {price} from wallet?"
   5b. Student confirms
   5c. API deducts from wallet, creates enrollment
   5d. Success animation → course refreshes as enrolled
   5e. "Start Learning" button appears
6. [If wallet balance < price]:
   6a. Dialog: "Insufficient balance (EGP {balance}). Top up EGP {deficit}?"
   6b. Student taps "Top Up"
   6c. → Wallet Top Up Screen
   6d. Student completes top-up
   6e. → Returns to Course Detail
   6f. Student retries enrollment → success
7. [If student has a course access code]:
   7a. Student goes to Code Redemption Screen
   7b. Enters code → enrollment granted
   7c. Returns to Course Detail as enrolled
```

### UF-04: Learning a Video Lesson

```
1. Student navigates: Home → My Courses → Course → Session
2. Student taps on video item
3. [If unlocked]: → Video Player Screen
4. [If locked]: Toast: "Complete previous items first"
5. Video loads (signed streaming URL)
6. [If previously watched]: resumes from last position
7. Student watches video
8. Progress auto-saves every 15 seconds
9. [When ≥ 90% watched]:
   9a. Item marked as complete
   9b. Session progress recalculated
   9c. Course progress recalculated
   9d. [If next item available]: "Play Next: {title}?" prompt
10. Student taps "Next" → next content item
11. [On background/exit]: progress saved immediately
```

### UF-05: Taking a Quiz

```
1. Student navigates to quiz item in session
2. Student taps quiz → Start Confirmation dialog
3. Dialog shows: title, duration, max attempts, attempt number
4. Student taps "Start Quiz"
5. → Quiz Taking Screen
6. Timer begins counting down
7. Student answers questions:
   - Navigate freely between questions
   - Flag questions for review
   - Answers auto-save on each interaction
8. [When ready to submit]:
   8a. Student taps "Submit"
   8b. Confirmation dialog shows answer summary
   8c. Student can review or confirm
   8d. Taps "Submit" → API processes submission
9. [If timer expires]:
   9a. Auto-submit all answered questions
   9b. Status: "timed_out"
10. → Quiz Results Screen
11. [If show_score_immediately]:
    11a. Score circle animation
    11b. Pass/fail badge
    11c. [If show_correct_answers]: answer review list
12. [If !show_score_immediately]:
    12a. "Pending teacher review" message
    12b. Student notified later via push notification
13. [If passed and first time]: points awarded
```

### UF-06: Submitting an Assignment

```
1. Student navigates to assignment item
2. → Assignment Detail Screen
3. Student reads instructions and downloads teacher attachments
4. Student taps file upload area
5. Selects files from device (validated: type, size, count)
6. Files upload with progress bars
7. Student optionally adds notes
8. [If before due date]: Student taps "Submit"
9. [If after due date + late allowed]: Warning shown, student confirms late submission
10. [If after due date + no late]: Submit button disabled
11. API records submission
12. Status changes to "Submitted"
13. Student waits for teacher grading
14. [When graded]: push notification received
15. Student views score and feedback on Assignment screen
16. [If resubmission requested]:
    16a. Teacher notes shown
    16b. New upload area appears
    16c. Student uploads corrected files
    16d. Taps "Resubmit"
```

### UF-07: Recording QR Attendance

```
1. Teacher generates QR code for attendance session
2. Student navigates: More → Attendance → Scan QR
3. OR: Quick Action from Home → Attendance Scanner
4. → QR Scanner Screen
5. Camera preview with frame overlay
6. Student points camera at QR code
7. QR detected and decoded
8. API validates:
   - QR code validity window
   - Student enrollment in session
   - Not already checked in
9. [If valid + on time]: status = "present"
10. [If valid + late (past threshold)]: status = "late"
11. Success animation with status badge
12. Student views updated attendance in Attendance History
```

### UF-08: Using AI Assistant

```
1. Student taps AI Assistant tab
2. → Conversation List (or empty state)
3. Student taps "New Conversation" FAB
4. → Chat Interface (new conversation)
5. AI sends welcome message
6. Student optionally selects subject/course context
7. Student types academic question
8. Student taps send
9. Typing indicator appears
10. RAG pipeline:
    10a. Query embedded
    10b. Relevant content retrieved from vector DB (filtered by tenant + optional course)
    10c. [If relevance < 0.6]: "I couldn't find info in your materials"
    10d. [If relevance ≥ 0.6]: LLM generates response using retrieved context
11. AI message appears with:
    - Answer text (formatted, with LaTeX if needed)
    - Source citations (tappable)
12. Student rates response (👍/👎)
13. Student can continue conversation (context window: last 10 messages)
14. [If rate limited]: input disabled with limit message
```

### UF-09: Wallet Top-Up and Course Purchase

```
1. Student checks wallet balance (Home card or Wallet tab)
2. Balance insufficient for desired course
3. Student taps "Top Up"
4. → Top Up Screen
5. Student enters amount (or selects preset)
6. Student selects payment method (Vodafone Cash / InstaPay / Fawry)
7. Student taps "Proceed"
8. [Vodafone Cash]:
   8a. Instructions shown with phone number
   8b. Student sends money externally
   8c. Returns to app, taps "I've paid"
   8d. System polls for confirmation
9. [Fawry]:
   9a. Reference number generated
   9b. Student pays at Fawry outlet
   9c. System receives webhook confirmation
10. Balance updated → notification sent
11. Student navigates to course → taps "Enroll Now"
12. Wallet payment confirmed → enrollment complete
```

### UF-10: Claiming a Reward

```
1. Student navigates: More → Points & Rewards
2. Views current points balance
3. Browses reward store
4. Student taps "Claim" on desired item
5. [If sufficient points]:
   5a. Confirmation dialog: "Claim {item} for {n} points?"
   5b. Student confirms
   5c. Points deducted, claim created with status "pending"
   5d. Success message: "Reward claimed! Pending teacher approval."
6. [If insufficient points]:
   6a. Button disabled. Tooltip: "Need {n} more points"
7. Student checks "My Claims" for status updates
8. [When teacher approves]:
   8a. Notification received
   8b. Claim status → "approved" → "delivered"
9. [If teacher rejects]:
   9a. Notification received with reason
   9b. Points refunded automatically
```

---

## 6. Functional Requirements

### 6.1 Authentication & Account Management

| ID | Requirement | Priority |
|---|---|---|
| **FR-01** | The system shall allow students to register by providing personal information, academic details, location, parent information, and a secure password through a multi-step form. | Critical |
| **FR-02** | The system shall validate phone number uniqueness within the tenant during registration via asynchronous API check. | Critical |
| **FR-03** | The system shall send a 6-digit OTP via SMS to the student's phone number upon registration and require verification before proceeding. | Critical |
| **FR-04** | The system shall support OTP resend with a 60-second cooldown and maximum 3 OTP generation attempts before temporary lock (30 minutes). | Critical |
| **FR-05** | The system shall create student accounts with `status = pending` requiring teacher approval before granting platform access. | Critical |
| **FR-06** | The system shall support National ID photo verification using OCR text extraction and fuzzy name matching (≥ 85% similarity threshold) with Arabic text normalization. | High |
| **FR-07** | The system shall authenticate students using phone number and password with bcrypt hash verification. | Critical |
| **FR-08** | The system shall issue JWT access tokens (15-minute expiry) and refresh tokens (7-day expiry) upon successful authentication. | Critical |
| **FR-09** | The system shall implement device binding by capturing and validating device hardware hashes against registered devices. | Critical |
| **FR-10** | The system shall require OTP re-verification when a student logs in from an unrecognized device. | Critical |
| **FR-11** | The system shall enforce configurable device limits per student and prevent login when the limit is reached until a device is deactivated. | High |
| **FR-12** | The system shall lock accounts after 5 consecutive failed login attempts for 15 minutes. | High |
| **FR-13** | The system shall support biometric authentication (fingerprint/Face ID) as a secondary login method after initial password authentication. | Medium |
| **FR-14** | The system shall support password reset flow via phone OTP verification. | High |
| **FR-15** | The system shall allow students to view their profile information and submit edit requests that require teacher approval. | High |
| **FR-16** | The system shall allow students to view and deactivate registered devices (except the current device). | High |
| **FR-17** | The system shall revoke all refresh tokens and clear cached data upon student logout. | Critical |
| **FR-18** | The system shall poll account status every 30 seconds while on the Pending Approval screen and auto-navigate upon approval or rejection. | Medium |

### 6.2 Home Dashboard

| ID | Requirement | Priority |
|---|---|---|
| **FR-19** | The system shall display a personalized greeting based on time of day and the student's first name. | Medium |
| **FR-20** | The system shall display the student's wallet balance and points total on a prominently positioned card. | High |
| **FR-21** | The system shall display an auto-rotating banner carousel filtered by student's grade and current date. | Medium |
| **FR-22** | The system shall display up to 5 in-progress courses sorted by last access date in a horizontally scrollable section. | High |
| **FR-23** | The system shall display featured courses (not yet enrolled) in a scrollable section. | Medium |
| **FR-24** | The system shall display up to 3 recent announcements filtered by the student's grade, center, and group. | Medium |
| **FR-25** | The system shall display unread notification count as a badge on the notification bell icon. | High |
| **FR-26** | The system shall track banner views and clicks for analytics. | Low |
| **FR-27** | Each dashboard section shall load independently; failure in one section shall not block others. | High |

### 6.3 Course Management

| ID | Requirement | Priority |
|---|---|---|
| **FR-28** | The system shall display a searchable, filterable, sortable course catalog showing courses available for the student's grade level. | Critical |
| **FR-29** | The system shall display course details including description, session curriculum, pricing, enrollment count, and content type indicators. | Critical |
| **FR-30** | The system shall support course enrollment via wallet payment, free enrollment, or access code redemption. | Critical |
| **FR-31** | The system shall enforce content ordering modes (free, sequential, lock_session, lock_item) controlling which sessions and items are accessible. | Critical |
| **FR-32** | The system shall display preview/free items to non-enrolledstudents without requiring enrollment. | High |
| **FR-33** | The system shall track and display course progress as a percentage based on completed items relative to total items. | Critical |
| **FR-34** | The system shall support course enrollment expiry based on configurable duration (days) and prevent access to content after expiry. | High |
| **FR-35** | The system shall display expiry warnings when course access is within 7 days of expiration. | Medium |
| **FR-36** | The system shall enable "Continue Learning" functionality by navigating to the last accessed session item. | High |
| **FR-37** | The system shall display enrolled courses organized by tabs: In Progress, Completed, and Expired. | High |
| **FR-38** | The system shall award configurable points to students upon course completion (100% progress). | Medium |
| **FR-39** | The system shall generate a course completion certificate URL when a student completes a course (if configured by tenant). | Low |

### 6.4 Content Consumption

| ID | Requirement | Priority |
|---|---|---|
| **FR-40** | The system shall play video content with adaptive bitrate streaming (HLS/DASH) supporting quality levels: Auto, 1080p, 720p, 480p, 360p. | Critical |
| **FR-41** | The system shall resume video playback from the last saved position when re-entering a video. | Critical |
| **FR-42** | The system shall auto-save video watch progress every 15 seconds, on pause, on exit, and on app background transition. | Critical |
| **FR-43** | The system shall mark a video as complete when cumulative watch time reaches ≥ 90% of total duration. | Critical |
| **FR-44** | The system shall support playback speed adjustment (0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x) with persistence across sessions. | Medium |
| **FR-45** | The system shall detect and respond to screen recording attempts by pausing playback and displaying a warning overlay. | High |
| **FR-46** | The system shall prevent video playback when enrollment has expired. | Critical |
| **FR-47** | The system shall display PDF documents with pinch-to-zoom, page navigation, and progress tracking. | High |
| **FR-48** | The system shall mark PDF items as complete when the student reaches the last page. | High |
| **FR-49** | The system shall disable text selection and copy in PDF viewer to protect teacher content. | Medium |
| **FR-50** | The system shall support downloadable content items for offline access when permitted by the teacher (`downloadable = true`). | Medium |
| **FR-51** | The system shall play audio content with standard playback controls and progress tracking. | Medium |
| **FR-52** | The system shall display note-type items as formatted text content with completion tracking. | Low |
| **FR-53** | The system shall open link-type items in an in-app WebView or external browser. | Low |
| **FR-54** | The system shall prompt "Play Next: {title}?" when a content item is completed and the next item is available. | Medium |

### 6.5 Quiz & Assessment

| ID | Requirement | Priority |
|---|---|---|
| **FR-55** | The system shall support quiz creation with five question types: MCQ Single, MCQ Multiple, True/False, Fill in the Blank, and Free Text. | Critical |
| **FR-56** | The system shall enforce configurable maximum attempt limits per quiz per student. | Critical |
| **FR-57** | The system shall implement countdown timer for timed quizzes with automatic submission when time expires. | Critical |
| **FR-58** | The system shall support question shuffling per attempt when configured (`shuffle_questions = true`). | High |
| **FR-59** | The system shall support answer option shuffling for MCQ questions per attempt when configured (`shuffle_options = true`). | High |
| **FR-60** | The system shall support random question selection from a pool when `questions_per_attempt` is configured. | High |
| **FR-61** | The system shall auto-save individual question answers on each selection or text change. | Critical |
| **FR-62** | The system shall allow students to flag questions for review and navigate freely between questions during the quiz. | High |
| **FR-63** | The system shall display a submit confirmation dialog showing answered count, unanswered count, and flagged count before final submission. | High |
| **FR-64** | The system shall automatically grade MCQ Single, MCQ Multiple, True/False, and Fill in the Blank questions upon submission. | Critical |
| **FR-65** | The system shall queue Free Text questions for instructor manual grading. | High |
| **FR-66** | The system shall apply negative marking for incorrect answers when `negative_marks > 0` is configured on a question. | Medium |
| **FR-67** | The system shall calculate quiz score, percentage, and pass/fail status based on `pass_percentage` threshold. | Critical |
| **FR-68** | The system shall display quiz results with score circle animation, statistics, and answer review (when `show_correct_answers = true`). | High |
| **FR-69** | The system shall display question explanations in results when `show_explanations = true`. | Medium |
| **FR-70** | The system shall withhold score display and show "Pending Review" when `show_score_immediately = false`. | Medium |
| **FR-71** | The system shall enforce quiz availability windows (`available_from` and `available_until`) and prevent access outside these windows. | High |
| **FR-72** | The system shall auto-submit the quiz if the student backgrounds the app for more than 30 seconds during an active attempt. | High |
| **FR-73** | The system shall save answers locally when network is unavailable and sync when connection is restored. | High |
| **FR-74** | The system shall award points for first-time passing of a quiz (no duplicate point awards on retakes). | Medium |

### 6.6 Assignments

| ID | Requirement | Priority |
|---|---|---|
| **FR-75** | The system shall display assignment details including instructions, teacher attachments, due date, grading criteria, and file requirements. | Critical |
| **FR-76** | The system shall allow students to download teacher-provided attachment files. | High |
| **FR-77** | The system shall allow students to upload multiple files for assignment submission with client-side validation of file type, file size, and file count limits. | Critical |
| **FR-78** | The system shall display individual file upload progress during submission. | High |
| **FR-79** | The system shall allow students to add optional text notes with their submission. | Medium |
| **FR-80** | The system shall enforce submission deadlines: block submission after due date when `allow_late_submission = false`. | Critical |
| **FR-81** | The system shall accept late submissions with a visible warning and automatic `is_late = true` flag when `allow_late_submission = true`. | High |
| **FR-82** | The system shall display grading results including score, teacher feedback, graded-by name, and graded timestamp when available. | Critical |
| **FR-83** | The system shall support resubmission workflow: when teacher requests resubmission, new upload area appears with teacher notes. | High |
| **FR-84** | The system shall send push notifications when assignment grading is completed. | High |

### 6.7 Attendance

| ID | Requirement | Priority |
|---|---|---|
| **FR-85** | The system shall provide a QR code scanner that reads attendance QR codes generated by the teacher. | Critical |
| **FR-86** | The system shall validate QR code data against the server including: code validity window, student enrollment, and duplicate check-in prevention. | Critical |
| **FR-87** | The system shall automatically determine attendance status as "present" or "late" based on `late_threshold_minutes` configuration. | High |
| **FR-88** | The system shall support manual code entry as a fallback when QR scanning fails. | Medium |
| **FR-89** | The system shall display attendance history with summary statistics (total sessions, present, late, absent, excused counts and percentage). | High |
| **FR-90** | The system shall support date range filtering and course filtering on attendance history. | Medium |
| **FR-91** | The system shall display attendance records grouped by date with individual session details. | Medium |

### 6.8 Wallet & Payments

| ID | Requirement | Priority |
|---|---|---|
| **FR-92** | The system shall display current wallet balance and points total on the Wallet screen. | Critical |
| **FR-93** | The system shall display a filterable transaction history list sorted by most recent. | High |
| **FR-94** | The system shall support wallet top-up via Vodafone Cash with phone number display and payment confirmation polling. | Critical |
| **FR-95** | The system shall support wallet top-up via Fawry with reference number generation and auto-detection of payment. | Critical |
| **FR-96** | The system shall support wallet top-up via InstaPay with app redirect or deep link integration. | High |
| **FR-97** | The system shall enforce minimum (EGP 10) and maximum (EGP 5,000) top-up amounts. | High |
| **FR-98** | The system shall poll payment status every 10 seconds for up to 5 minutes after the student confirms payment. | High |
| **FR-99** | The system shall allow students to redeem alphanumeric codes for wallet credit, course access, session access, or discounts. | Critical |
| **FR-100** | The system shall validate codes against tenant, status, validity dates, max uses, per-user limit, and grade restrictions. | Critical |
| **FR-101** | The system shall display specific error messages for each code validation failure reason (invalid, expired, fully redeemed, already used, grade restriction). | High |
| **FR-102** | The system shall deduct wallet balance for course enrollment and marketplace purchases with real-time balance update. | Critical |
| **FR-103** | The system shall prevent any transaction that would result in a negative wallet balance. | Critical |

### 6.9 AI Assistant

| ID | Requirement | Priority |
|---|---|---|
| **FR-104** | The system shall provide an AI chatbot that generates responses exclusively from teacher-uploaded course materials using Retrieval-Augmented Generation (RAG). | Critical |
| **FR-105** | The system shall restrict AI retrieval to materials from courses the student is enrolled in, filtered by tenant. | Critical |
| **FR-106** | The system shall return a fallback message ("I couldn't find information about this in your course materials") when retrieval similarity score is below 0.6. | High |
| **FR-107** | The system shall not allow students to upload files to the AI assistant; only text input is accepted. | Critical |
| **FR-108** | The system shall allow students to select a specific course/subject to focus the AI context. | High |
| **FR-109** | The system shall maintain conversation context using the last 10 messages for coherent multi-turn conversations. | High |
| **FR-110** | The system shall display source citations in AI responses with tappable links to the referenced course content. | High |
| **FR-111** | The system shall support rich text, LaTeX mathematical formula rendering, and code block formatting in AI responses. | Medium |
| **FR-112** | The system shall allow students to rate AI responses with thumbs up/down and optional text feedback. | Medium |
| **FR-113** | The system shall enforce rate limits: maximum 50 messages per conversation per day and 200 messages total per day. | High |
| **FR-114** | The system shall support conversation management: create, list, rename, and soft-delete conversations. | Medium |
| **FR-115** | The system shall deliver AI responses within 3 seconds for simple queries and 8 seconds for complex queries. | High |

### 6.10 Gamification & Rewards

| ID | Requirement | Priority |
|---|---|---|
| **FR-116** | The system shall display the student's total points balance and earning history. | High |
| **FR-117** | The system shall award points for configurable activities: course completion, quiz passing, daily login, and attendance streaks. | High |
| **FR-118** | The system shall display a reward store with items available for point redemption. | High |
| **FR-119** | The system shall enforce point sufficiency, stock availability, and per-user claim limits before allowing reward claims. | High |
| **FR-120** | The system shall deduct points upon reward claim and create a pending claim for teacher approval. | High |
| **FR-121** | The system shall refund points automatically when a claim is rejected by the teacher. | High |
| **FR-122** | The system shall display claim history with status tracking (pending, approved, rejected, delivered). | Medium |

### 6.11 Marketplace

| ID | Requirement | Priority |
|---|---|---|
| **FR-123** | The system shall display a searchable, filterable product catalog organized by categories. | Medium |
| **FR-124** | The system shall display product details including images, description, pricing, and stock status. | Medium |
| **FR-125** | The system shall maintain a local cart that persists across app sessions until order is placed. | Medium |
| **FR-126** | The system shall enforce quantity limits based on stock availability and maximum per-order limits. | Medium |
| **FR-127** | The system shall process orders via wallet payment with stock validation, balance deduction, and order record creation. | Medium |
| **FR-128** | The system shall display order history with status tracking (pending, confirmed, processing, shipped, delivered, cancelled). | Medium |

### 6.12 Communication & Notifications

| ID | Requirement | Priority |
|---|---|---|
| **FR-129** | The system shall receive and display push notifications via Firebase Cloud Messaging (FCM). | Critical |
| **FR-130** | The system shall display a notification list with type-specific icons, read/unread indicators, and chronological ordering. | High |
| **FR-131** | The system shall navigate to the relevant screen when a notification is tapped based on notification type and action data. | High |
| **FR-132** | The system shall support "Mark as Read" for individual notifications and "Mark All as Read" for bulk operation. | Medium |
| **FR-133** | The system shall display the unread notification count as a badge on the bottom navigation tab. | High |
| **FR-134** | The system shall display tenant announcements filtered by student's grade, center, and group. | High |
| **FR-135** | The system shall display WhatsApp group invite links relevant to the student's grade, center, and group. | Medium |
| **FR-136** | The system shall allow students to configure notification preferences (push, email, WhatsApp) per notification category. | Medium |

### 6.13 Settings & Preferences

| ID | Requirement | Priority |
|---|---|---|
| **FR-137** | The system shall support language switching between Arabic and English with full RTL/LTR layout adaptation. | High |
| **FR-138** | The system shall support theme switching between Light, Dark, and System Default modes. | Medium |
| **FR-139** | The system shall persist video quality and playback speed preferences across sessions. | Medium |
| **FR-140** | The system shall support secure password change requiring current password verification. | High |
| **FR-141** | The system shall allow students to view registered devices and deactivate non-current devices. | High |
| **FR-142** | The system shall provide access to Help & FAQ, Terms of Service, and Privacy Policy documents. | Medium |
| **FR-143** | The system shall support secure logout with server-side token revocation and local data clearance. | Critical |

---

## 7. Non-Functional Requirements

### 7.1 Performance

| ID | Requirement | Target |
|---|---|---|
| **NFR-01** | API response time for standard operations (CRUD, listing, filtering) | 95th percentile ≤ 2 seconds |
| **NFR-02** | Dashboard initial load time (all sections) | ≤ 3 seconds on 4G connection |
| **NFR-03** | Screen transition animation latency | ≤ 300 milliseconds |
| **NFR-04** | Video stream startup time | ≤ 4 seconds to first frame on 4G |
| **NFR-05** | AI chatbot response time for simple queries | ≤ 3 seconds |
| **NFR-06** | AI chatbot response time for complex queries | ≤ 8 seconds |
| **NFR-07** | Image/PDF load time | ≤ 2 seconds for assets under 5MB |
| **NFR-08** | Quiz answer auto-save latency | ≤ 500 milliseconds (local); ≤ 2 seconds (server sync) |
| **NFR-09** | Push notification delivery latency | ≤ 5 seconds from server trigger to device receipt |
| **NFR-10** | App cold start time (splash to ready) | ≤ 3 seconds |
| **NFR-11** | Search results rendering | ≤ 1 second after debounce period |
| **NFR-12** | App memory usage under normal operation | ≤ 300MB RAM |
| **NFR-13** | App installation size (APK/IPA) | ≤ 50MB base download |

### 7.2 Security

| ID | Requirement | Implementation |
|---|---|---|
| **NFR-14** | All network communication shall use HTTPS with TLS 1.2 minimum (TLS 1.3 preferred). | Dio HTTP client configured with certificate pinning |
| **NFR-15** | JWT access tokens shall expire after 15 minutes; refresh tokens after 7 days. | Token rotation on each refresh |
| **NFR-16** | Passwords shall be hashed using bcrypt with a cost factor of 12 on the server. | Never stored or logged in plaintext |
| **NFR-17** | Authentication tokens shall be stored in platform-secure storage (Keychain on iOS, EncryptedSharedPreferences on Android). | flutter_secure_storage library |
| **NFR-18** | Device binding shall be enforced by computing a hardware-based device hash and validating against server records. | Android ID / IDFV used as hash input |
| **NFR-19** | Account lockout shall be enforced after 5 consecutive failed login attempts for 15 minutes. | Server-side rate limiting with login_logs tracking |
| **NFR-20** | OTP codes shall expire after 5 minutes with maximum 3 verification attempts per code. | Server-side validation with otp_verifications table |
| **NFR-21** | Screen recording and screenshot detection shall pause video playback and display a warning. | Platform-specific DRM and lifecycle event detection |
| **NFR-22** | Video streaming URLs shall be signed with a 4-hour TTL to prevent unauthorized sharing. | Server-side URL signing with expiry |
| **NFR-23** | All user input shall be sanitized to prevent XSS and injection attacks. | Server-side validation; client-side input sanitization |
| **NFR-24** | Sensitive data (tokens, credentials) shall never be logged in debug output or crash reports. | Custom log filters; ProGuard/R8 for production builds |
| **NFR-25** | Text selection shall be disabled in PDF viewer to protect teacher content. | Flutter PDF viewer configuration |
| **NFR-26** | Quiz anti-cheating: auto-submit on app background > 30 seconds; prevent multi-device simultaneous access. | Client lifecycle monitoring + server-side session locking |
| **NFR-27** | API requests shall include tenant_id validation to ensure students cannot access cross-tenant data. | Server-side middleware enforcing tenant isolation |
| **NFR-28** | Biometric credentials shall be stored and processed exclusively within the device's secure enclave. | Platform-native biometric APIs |

### 7.3 Reliability & Availability

| ID | Requirement | Target |
|---|---|---|
| **NFR-29** | Backend API uptime | ≥ 99.5% measured monthly |
| **NFR-30** | Video streaming availability | ≥ 99.0% measured monthly |
| **NFR-31** | AI assistant availability | ≥ 98.0% measured monthly |
| **NFR-32** | Payment gateway availability | ≥ 99.0% measured monthly |
| **NFR-33** | Data backup frequency | Incremental: hourly; Full: daily |
| **NFR-34** | Recovery Point Objective (RPO) | ≤ 1 hour for core data |
| **NFR-35** | Recovery Time Objective (RTO) | ≤ 30 minutes for critical services |
| **NFR-36** | App crash rate | ≤ 0.5% of sessions |
| **NFR-37** | Offline graceful degradation: cached content accessible, changes queued for sync | Applicable to dashboard, course content, quiz answers |
| **NFR-38** | Individual section failure shall not cause full-screen errors; independent section retry shall be supported. | Dashboard sections, course tabs |

### 7.4 Scalability

| ID | Requirement | Target |
|---|---|---|
| **NFR-39** | Concurrent active users supported | ≥ 10,000 across all tenants |
| **NFR-40** | Concurrent quiz-takers supported | ≥ 1,000 simultaneous attempts |
| **NFR-41** | AI chatbot concurrent requests | ≥ 200 simultaneous conversations |
| **NFR-42** | Video streaming concurrent viewers | ≥ 2,000 simultaneous streams |
| **NFR-43** | Database query performance at scale | Response time degradation ≤ 20% at 10× normal load |
| **NFR-44** | Auto-scaling response time | New instances provisioned within 3 minutes of threshold breach |
| **NFR-45** | Horizontal scaling for stateless services | All API services shall be stateless and horizontally scalable |

### 7.5 Usability

| ID | Requirement | Implementation |
|---|---|---|
| **NFR-46** | The application shall support Arabic as the primary language with full RTL layout. | Flutter Directionality, Cairo font family |
| **NFR-47** | The application shall support English as a secondary language with LTR layout. | i18n with ARB files |
| **NFR-48** | Any core feature shall be accessible within 3 taps from the home screen. | Navigation structure validation |
| **NFR-49** | All interactive elements shall have minimum touch target size of 48x48dp. | Material Design guidelines compliance |
| **NFR-50** | Form validation errors shall be displayed inline below the respective field in real-time. | On-blur and on-change validation |
| **NFR-51** | Loading states shall use shimmer placeholders matching the expected content layout. | Shimmer package with matching skeleton UI |
| **NFR-52** | Error states shall provide actionable recovery options (retry, navigate, contact support). | Standardized error widget with action buttons |
| **NFR-53** | Empty states shall provide context and primary action CTA. | Illustrations + descriptive text + CTA button |
| **NFR-54** | The application shall use the Cairo font family for consistent Arabic/Latin typography. | Google Fonts integration |
| **NFR-55** | Color contrast ratios shall meet WCAG 2.1 AA standards (minimum 4.5:1 for text). | Design system compliance |
| **NFR-56** | The application shall support responsive layouts for phone screens (360dp–428dp width) and tablets (600dp+). | MediaQuery-based responsive breakpoints |

### 7.6 Compatibility

| ID | Requirement | Target |
|---|---|---|
| **NFR-57** | Minimum Android version supported | Android 8.0 (API level 26) |
| **NFR-58** | Minimum iOS version supported | iOS 14.0 |
| **NFR-59** | Flutter SDK version | 3.x stable channel |
| **NFR-60** | Screen size support | 4.7" to 12.9" (phones and tablets) |
| **NFR-61** | Orientation support | Portrait primary; landscape for video fullscreen only |
| **NFR-62** | Network compatibility | Wi-Fi, 3G, 4G, 5G with graceful degradation |
| **NFR-63** | Low-bandwidth optimization | Compressed images, adaptive video quality, lazy loading |

### 7.7 Accessibility

| ID | Requirement | Implementation |
|---|---|---|
| **NFR-64** | All images and icons shall have semantic labels for screen readers. | Flutter Semantics widget |
| **NFR-65** | All form fields shall have associated labels and error descriptions accessible to assistive technology. | InputDecoration with label and error text |
| **NFR-66** | Logical tab/focus order shall be maintained across all screens. | FocusTraversalGroup configuration |
| **NFR-67** | Video player shall support subtitle/caption display when available. | SubRip (.srt) or WebVTT format support |
| **NFR-68** | Font size shall respect system accessibility settings (Dynamic Type on iOS, font scale on Android). | MediaQuery.textScaleFactor-aware layouts |
| **NFR-69** | Interactive elements shall provide haptic feedback on significant actions (submit, success, error). | HapticFeedback API |

### 7.8 Maintainability

| ID | Requirement | Implementation |
|---|---|---|
| **NFR-70** | Codebase shall follow Clean Architecture with clear separation of Presentation, Domain, and Data layers. | Directory structure enforcement via code review |
| **NFR-71** | All public API service methods shall have corresponding unit tests with ≥ 80% coverage for domain layer. | flutter_test + mockito |
| **NFR-72** | All UI screens shall have widget tests validating rendering and interaction. | flutter_test widget testing |
| **NFR-73** | Critical user flows shall have integration tests. | integration_test package |
| **NFR-74** | All API endpoints shall be documented with request/response schemas. | Swagger/OpenAPI specification |
| **NFR-75** | State management shall use Riverpod with typed providers for compile-time safety. | riverpod_lint enforcement |
| **NFR-76** | Error handling shall use a standardized Result type pattern across all data operations. | Either/Result pattern with typed failures |
| **NFR-77** | Logging shall use structured JSON format with severity levels and shall exclude sensitive data. | Custom logger with filters |
| **NFR-78** | App shall support over-the-air updates for minor fixes via CodePush or equivalent. | Shorebird or similar service |

---

## 8. Data Model Overview

### 8.1 Core Entities and Relationships

```
┌─────────────────────────────────────────────────────────────────────┐
│                     STUDENT DATA MODEL                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────┐     ┌──────────┐     ┌──────────────┐               │
│  │  Tenant   │────<│   User   │>────│  User_Roles  │               │
│  │           │     │ (Student)│     │              │               │
│  └────┬─────┘     └────┬─────┘     └──────────────┘               │
│       │                │                                            │
│       │                ├──────── Devices (1:N)                      │
│       │                ├──────── OTP_Verifications (1:N)            │
│       │                ├──────── Profile_Edit_Requests (1:N)        │
│       │                ├──────── Refresh_Tokens (1:N)               │
│       │                ├──────── Login_Logs (1:N)                   │
│       │                ├──────── Parent_Students (N:M → Parents)    │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     LEARNING DOMAIN             │                │
│       │          │                                 │                │
│       │          │  Student_Courses (enrollment)   │                │
│       │          │     ├── progress_percent        │                │
│       │          │     ├── completed_sessions      │                │
│       │          │     ├── expires_at              │                │
│       │          │     └── certificate_url         │                │
│       │          │                                 │                │
│       │          │  Student_Progress (per item)    │                │
│       │          │     ├── status                  │                │
│       │          │     ├── watch_time_seconds      │                │
│       │          │     └── last_position_seconds   │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     ASSESSMENT DOMAIN           │                │
│       │          │                                 │                │
│       │          │  Quiz_Attempts                  │                │
│       │          │     ├── score / percentage      │                │
│       │          │     ├── passed                  │                │
│       │          │     └── status                  │                │
│       │          │                                 │                │
│       │          │  Quiz_Responses (per question)  │                │
│       │          │     ├── selected_options        │                │
│       │          │     ├── is_correct              │                │
│       │          │     └── marks_obtained          │                │
│       │          │                                 │                │
│       │          │  Assignment_Submissions         │                │
│       │          │     ├── file_urls               │                │
│       │          │     ├── score                   │                │
│       │          │     ├── feedback                │                │
│       │          │     └── status                  │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     ATTENDANCE DOMAIN           │                │
│       │          │                                 │                │
│       │          │  Attendance_Records             │                │
│       │          │     ├── status (present/late/   │                │
│       │          │     │    absent/excused/online) │                │
│       │          │     ├── check_in_time           │                │
│       │          │     └── check_in_method         │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     FINANCIAL DOMAIN            │                │
│       │          │                                 │                │
│       │          │  Wallet_Transactions            │                │
│       │          │     ├── transaction_type        │                │
│       │          │     ├── amount                  │                │
│       │          │     └── balance_after           │                │
│       │          │                                 │                │
│       │          │  Payments                       │                │
│       │          │     ├── method                  │                │
│       │          │     ├── payment_type            │                │
│       │          │     └── status                  │                │
│       │          │                                 │                │
│       │          │  Code_Redemptions               │                │
│       │          │     ├── value_received          │                │
│       │          │     └── result_type             │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     GAMIFICATION DOMAIN         │                │
│       │          │                                 │                │
│       │          │  Points_Transactions            │                │
│       │          │     ├── transaction_type        │                │
│       │          │     ├── points                  │                │
│       │          │     └── balance_after           │                │
│       │          │                                 │                │
│       │          │  Reward_Claims                  │                │
│       │          │     ├── points_spent            │                │
│       │          │     └── status                  │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     AI DOMAIN                   │                │
│       │          │                                 │                │
│       │          │  AI_Conversations               │                │
│       │          │     ├── title / subject         │                │
│       │          │     ├── message_count           │                │
│       │          │     └── tokens_used             │                │
│       │          │                                 │                │
│       │          │  AI_Messages                    │                │
│       │          │     ├── role (user/assistant)   │                │
│       │          │     ├── content                 │                │
│       │          │     └── user_rating             │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     MARKETPLACE DOMAIN          │                │
│       │          │                                 │                │
│       │          │  Marketplace_Orders             │                │
│       │          │     ├── order_number            │                │
│       │          │     ├── total_amount            │                │
│       │          │     └── status                  │                │
│       │          │                                 │                │
│       │          │  Marketplace_Order_Items        │                │
│       │          │     ├── quantity                │                │
│       │          │     └── total_price             │                │
│       │          └─────────────────────────────────┘                │
│       │                │                                            │
│       │          ┌─────┴──────────────────────────┐                │
│       │          │     COMMUNICATION DOMAIN        │                │
│       │          │                                 │                │
│       │          │  Notifications                  │                │
│       │          │     ├── type                    │                │
│       │          │     ├── title / body            │                │
│       │          │     ├── is_read                 │                │
│       │          │     └── action_data             │                │
│       │          └─────────────────────────────────┘                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 8.2 Content Hierarchy (Read-Only for Students)

```
Tenant
  └── Grade
        └── Category
              └── Course
                    ├── price / is_free
                    ├── ordering_mode
                    ├── duration_days
                    ├── points_reward
                    │
                    └── Session (ordered)
                          ├── price / is_free
                          ├── available_from / until
                          │
                          └── Session_Item (ordered)
                                ├── item_type (video/pdf/quiz/assignment/note/link/audio)
                                ├── content_url
                                ├── is_free / is_preview
                                ├── required / skippable
                                ├── downloadable
                                │
                                ├── → Quiz (if type = quiz)
                                │     └── Quiz_Questions
                                │           ├── question_type
                                │           ├── options (JSON)
                                │           ├── correct_answer (JSON)
                                │           └── marks / negative_marks
                                │
                                └── → Assignment (if type = assignment)
                                      ├── due_date
                                      ├── allow_late_submission
                                      ├── attachment_urls
                                      └── allowed_file_types
```

### 8.3 Key Entity Cardinalities

| Relationship | Cardinality | Description |
|---|---|---|
| Tenant → Users (Students) | 1:N | Each student belongs to exactly one tenant |
| User → Devices | 1:N | Students can have multiple devices (limited by device_limit) |
| User → Student_Courses | 1:N | Students can enroll in multiple courses |
| Course → Sessions | 1:N | Each course has ordered sessions |
| Session → Session_Items | 1:N | Each session has ordered content items |
| User → Quiz_Attempts | 1:N | Students can have multiple quiz attempts |
| Quiz_Attempt → Quiz_Responses | 1:N | Each attempt has responses per question |
| User → Assignment_Submissions | 1:N per assignment | One submission per assignment (resubmission updates) |
| User → Attendance_Records | 1:N | One record per attendance session |
| User → Wallet_Transactions | 1:N | Full transaction history |
| User → Payments | 1:N | All payment records |
| User → AI_Conversations | 1:N | Multiple conversations |
| AI_Conversation → AI_Messages | 1:N | Messages within conversation |
| User → Points_Transactions | 1:N | Points earning and spending history |
| User → Reward_Claims | 1:N | Reward redemption records |
| User → Marketplace_Orders | 1:N | Order history |
| Marketplace_Order → Order_Items | 1:N | Items within each order |
| User → Notifications | 1:N | All notifications received |
| Parent → Students | N:M | Via parent_students junction table |

---

## 9. Assumptions & Open Questions

### 9.1 Assumptions

| ID | Assumption | Impact |
|---|---|---|
| **A-01** | Students will have personal or accessible smartphones with Android 8.0+ or iOS 14.0+. | Defines minimum OS compatibility. |
| **A-02** | Students have active Egyptian mobile phone numbers (010/011/012/015 prefixes) for OTP verification. | Registration and authentication flow design. |
| **A-03** | Internet connectivity is generally available but may be intermittent, especially in rural areas. | Requires offline support, caching, and graceful degradation. |
| **A-04** | The primary user language is Arabic with optional English support. | RTL-first design, Cairo font, Arabic content. |
| **A-05** | Teachers will pre-configure their tenant (grades, centers, schedules, courses) before students register. | Dropdown data availability during registration. |
| **A-06** | Each student registers with exactly one tenant. Multi-tenant enrollment is not supported in v1. | Simplified tenant context management. |
| **A-07** | Payment gateway integrations (Vodafone Cash, Fawry, InstaPay) will be available via third-party APIs or webhook-based confirmation. | Payment flow design and polling mechanism. |
| **A-08** | Teacher-uploaded content will be processed and indexed in the vector database before students can query the AI assistant. | Content must be uploaded before AI becomes useful. |
| **A-09** | National ID verification OCR accuracy is sufficient for the 85% similarity threshold with Arabic text normalization. | Verification flow design; fallback to manual review. |
| **A-10** | Device hash (Android ID / IDFV) is stable across app reinstalls and OS updates. | Device binding reliability. |
| **A-11** | FCM push notifications are reliably delivered to the majority of student devices. | Notification delivery as primary communication channel. |
| **A-12** | Students may share devices with family members; device binding should support at least 1 device per student by default. | Device management and login UX. |
| **A-13** | Backend API and database schema are designed and available as specified in the companion backend SRS document. | API contract dependencies. |
| **A-14** | The AI service (FastAPI + RAG pipeline) is deployed as a separate microservice accessible via internal API. | AI feature availability and latency. |

### 9.2 Open Questions

| ID | Question | Required Decision By | Impact Area |
|---|---|---|---|
| **OQ-01** | Should students be allowed to enroll in courses from multiple tenants in future versions? If so, how should the tenant context switch work in the mobile app? | Product Owner | Architecture, navigation, data model |
| **OQ-02** | What is the exact device hash computation algorithm? Is Android ID sufficient, or should IMEI/MAC address components be included for stronger binding? | Security Lead | Device binding implementation |
| **OQ-03** | Should the AI assistant support image-based queries (e.g., student photographs a math problem)? This would require multimodal AI capabilities. | Product Owner + AI Team | AI service architecture, chat UI |
| **OQ-04** | What is the exact Fawry integration model: direct API, aggregator (e.g., Paymob), or manual reconciliation? | Payment Integration Team | Top-up flow, webhook handling |
| **OQ-05** | Should offline video playback be supported (download-to-device)? This requires DRM implementation and significantly increases app complexity. | Product Owner | Content delivery architecture, storage management |
| **OQ-06** | What is the tenant's configurable threshold for quiz background detection auto-submit (currently 30 seconds)? Should this be configurable per quiz? | Product Owner | Quiz business rules |
| **OQ-07** | Should the marketplace support digital products (e.g., premium study guides, formula sheets) with instant delivery, or only physical products? | Product Owner | Marketplace order flow |
| **OQ-08** | What is the exact points award configuration? Is it global (platform-level) or per-tenant configurable? What activities earn how many points? | Product Owner | Gamification configuration |
| **OQ-09** | Should the system support partial grading for MCQ Multiple questions (partial credit for some correct options), or is it all-or-nothing? | Academic Advisor | Quiz grading algorithm |
| **OQ-10** | What happens when a student's parent also wants to register? Is the parent registration flow separate from this app, or do parents use the same app with a role switch? | Product Owner | App architecture, registration flow |
| **OQ-11** | Should late assignment penalty be applied as a flat percentage of the total score, or as a per-day increasing penalty? | Academic Advisor | Assignment grading calculation |
| **OQ-12** | What is the data retention policy for AI conversations? Should old conversations be automatically archived or deleted after a configurable period? | Legal / Product Owner | Data storage, privacy compliance |
| **OQ-13** | Should QR attendance scanning verify student proximity via GPS coordinates? If so, what is the acceptable radius? | Product Owner | Attendance accuracy, privacy |
| **OQ-14** | What is the policy for handling students who attempt to register with a phone number already used in another tenant? Error message only, or allow multi-tenant accounts? | Product Owner | Registration uniqueness rules |
| **OQ-15** | Should video progress tracking distinguish between segments watched vs. total timeline position (to prevent skipping to 90% and immediately completing)? | Product Owner | Video completion algorithm complexity |
| **OQ-16** | What is the maximum file size for video content? Should adaptive transcoding be handled by the platform or pre-processed by the teacher? | Infrastructure Team | Storage costs, CDN configuration |
| **OQ-17** | Should the app implement certificate pinning? This improves security but complicates certificate rotation. | Security Lead | HTTPS configuration |
| **OQ-18** | What analytics events should be tracked for business intelligence (screen views, feature usage, engagement time)? Is a third-party analytics SDK (Firebase Analytics, Mixpanel) required? | Product Owner + Analytics Team | SDK integration, privacy compliance |

---

**— End of Document —**

**Document prepared for the MentorX Development Team.**
**All specifications are final draft and subject to review sign-off before implementation begins.**