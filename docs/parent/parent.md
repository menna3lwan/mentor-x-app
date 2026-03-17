# Software Requirements Specification (SRS)

## MentorX — Parent Mobile Application

**Document Version:** 1.0
**Date:** July 2025
**Classification:** Confidential
**Prepared by:** Product & Business Analysis Team
**Target Audience:** Development Team, QA Engineers, UI/UX Designers

---

## Document Control

| Field | Value |
|---|---|
| **Product Name** | MentorX Parent App |
| **Platform** | iOS & Android (Flutter Cross-Platform) |
| **Application Type** | Mobile Native Application |
| **Target Market** | Parents/Guardians of Egyptian K-12 Students |
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

This Software Requirements Specification defines every functional behavior, screen specification, business rule, API contract, and non-functional constraint for the **MentorX Parent Mobile Application**. This document serves as the single source of truth for developers, QA engineers, and designers building the parent-facing mobile experience.

The parent application is a dedicated monitoring and transparency portal through which guardians gain real-time visibility into their children's educational journey. The app enables parents to track academic performance, monitor attendance, review grades and assessment results, observe course progress, view financial transactions on children's wallets, receive timely notifications about important events, and communicate with teachers — all without requiring direct teacher intervention.

The parent app operates on a **read-only model with selective action capabilities**. Parents can observe all academic and financial data but cannot modify course enrollments, submit assignments, or alter attendance records. This design preserves the integrity of the student-teacher relationship while empowering parents with the information they need to provide effective support.

Every screen, interaction, validation rule, error state, and API call required to build the complete parent application is specified in this document.

### 1.2 Scope

This document covers exclusively the **parent mobile application**. The following capabilities are within scope:

| Domain | Capabilities |
|---|---|
| **Onboarding** | Tenant selection, parent account registration, OTP verification, child linking |
| **Authentication** | Login, logout, biometric authentication, password reset, session management |
| **Children Overview** | Multi-child dashboard, child switching, summary cards |
| **Academic Monitoring** | Course progress tracking, session completion status, content access history |
| **Grade Monitoring** | Quiz scores, assignment grades, performance trends, comparative analytics |
| **Attendance Monitoring** | Attendance records, statistics, absence alerts, late arrival tracking |
| **Financial Monitoring** | Child wallet balance, transaction history, payment records |
| **Notifications** | Push notifications for grades, attendance, payments, announcements |
| **Teacher Communication** | View teacher notes, announcements, WhatsApp group access |
| **Settings** | Language, theme, notification preferences, linked children management |

**Explicitly Out of Scope for Parent App:**
- Course enrollment or unenrollment
- Content consumption (watching videos, reading PDFs)
- Quiz taking or assignment submission
- Wallet top-up or payment initiation
- AI assistant access
- Reward claiming or marketplace purchases
- Attendance recording (QR scanning)
- Profile editing for children

### 1.3 Definitions

| Term | Definition |
|---|---|
| **Linked Child** | A student account associated with the parent account through the `parent_students` junction table with a verified relationship. |
| **Active Child** | The currently selected child whose data is displayed across all monitoring screens. Parents switch between children when multiple are linked. |
| **Relationship Type** | The parent's relationship to the child: father, mother, guardian, or other. |
| **Tenant** | The teacher or academy the child is registered with. A parent may have children in different tenants. |
| **Read-Only Access** | The parent can view but not modify academic data, attendance records, grades, or wallet transactions. |
| **Child Linking** | The process of associating a parent account with a student account, requiring verification via the student's phone number or student code. |
| **OTP** | One-Time Password sent via SMS or WhatsApp for identity verification. |
| **FCM** | Firebase Cloud Messaging for push notification delivery. |

### 1.4 Target User

| Attribute | Description |
|---|---|
| **Role** | Parent, guardian, or responsible adult for one or more enrolled students |
| **Age Range** | 30–55 years (typical) |
| **Geography** | Egypt (all governorates) |
| **Language** | Arabic (primary), English (secondary) |
| **Device Ownership** | Personal smartphone; may share with other family members |
| **Technical Literacy** | Low to moderate; comfortable with WhatsApp and basic apps |
| **Internet Access** | Variable; urban 4G/Wi-Fi, some rural intermittent connectivity |
| **Primary Motivation** | Monitor child's academic progress, ensure attendance, track spending, stay informed |
| **Usage Pattern** | Periodic check-ins (1-3 times daily), spike after receiving notifications |

---

## 2. Product Overview

### 2.1 Product Vision

The MentorX Parent App bridges the information gap between educators and families. Instead of relying on second-hand accounts from children, occasional WhatsApp messages from teachers, or end-of-term report cards, parents gain instant, structured, and continuous access to their child's academic data.

The app is designed with simplicity as a core principle — recognizing that many parents have limited technical experience. Every screen prioritizes clarity over complexity, presenting information in visual formats (progress bars, color-coded grades, attendance calendars) that communicate meaning at a glance.

Parents with multiple children enrolled across different tenants can manage all monitoring from a single app, switching between children with a single tap.

### 2.2 Core Objectives

| ID | Objective | Success Metric |
|---|---|---|
| **PO-01** | Provide parents with real-time visibility into their child's academic progress | Parent can view updated course progress within 5 minutes of any student activity |
| **PO-02** | Deliver immediate notification of important academic events | Parents receive push notifications for attendance, grades, and announcements within 5 seconds |
| **PO-03** | Enable multi-child monitoring from a single interface | Parents with multiple children can switch between children within 1 tap |
| **PO-04** | Present academic data in visually intuitive formats | Parents understand their child's status within 3 seconds of viewing any summary screen |
| **PO-05** | Support parents with low technical literacy | All core features accessible within 2 taps from home screen; no complex interactions required |
| **PO-06** | Maintain transparency in financial transactions on child's wallet | Parents can view every wallet transaction and payment in chronological order |
| **PO-07** | Facilitate timely parental intervention for attendance issues | Absence and late arrival notifications sent within 30 minutes of attendance recording |
| **PO-08** | Build trust between educators and families | Structured, factual data presentation without editorialization |

### 2.3 Parent Capabilities Summary

| Capability Category | Specific Actions | Access Level |
|---|---|---|
| **Account** | Register, verify phone, login, logout, reset password, manage linked children | Full Control |
| **Child Switching** | View all linked children, select active child, add new child link | Full Control |
| **Academic Monitoring** | View enrolled courses, course progress, session completion, content access logs | Read-Only |
| **Grade Monitoring** | View quiz scores, assignment grades, grade history, performance trends | Read-Only |
| **Attendance Monitoring** | View attendance records, summary statistics, absence/late history | Read-Only |
| **Financial Monitoring** | View child's wallet balance, transaction history, payment records | Read-Only |
| **Communication** | View announcements, teacher notes, access WhatsApp groups | Read + External Links |
| **Notifications** | Receive and view push notifications for all child-related events | Read + Mark as Read |
| **Settings** | Language, theme, notification preferences, manage linked children | Full Control |

---

## 3. System Architecture Overview

### 3.1 Parent App Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Framework** | Flutter 3.x | Cross-platform iOS and Android |
| **Language** | Dart | Application logic |
| **Architecture** | Clean Architecture | Presentation, Domain, Data layer separation |
| **State Management** | Riverpod | Compile-safe reactive state management |
| **HTTP Client** | Dio | API communication with auth interceptors |
| **Local Storage** | Hive | Cached child data and offline access |
| **Secure Storage** | flutter_secure_storage | Token and credential encryption |
| **Push Notifications** | Firebase Messaging (FCM) | Real-time notification delivery |
| **Charts** | fl_chart | Performance visualization and analytics |

### 3.2 Application Module Decomposition

```
┌──────────────────────────────────────────────────────┐
│              MentorX Parent Application               │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Onboarding  │  │    Auth      │  │  Children  │ │
│  │  Module      │  │    Module    │  │  Module    │ │
│  │              │  │              │  │            │ │
│  │ -Tenant Pick │  │ -Login       │  │ -Overview  │ │
│  │ -Register    │  │ -OTP         │  │ -Switcher  │ │
│  │ -Link Child  │  │ -Biometric   │  │ -Add Child │ │
│  │              │  │ -Password    │  │ -Unlink    │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Academic    │  │  Grades      │  │ Attendance │ │
│  │  Monitor     │  │  Monitor     │  │ Monitor    │ │
│  │              │  │              │  │            │ │
│  │ -Courses     │  │ -Quiz Scores │  │ -Records   │ │
│  │ -Progress    │  │ -Assignments │  │ -Stats     │ │
│  │ -Sessions    │  │ -Trends      │  │ -Calendar  │ │
│  │ -Activity    │  │ -Compare     │  │ -Alerts    │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  Financial   │  │ Notifications│  │  Settings  │ │
│  │  Monitor     │  │ Module       │  │  Module    │ │
│  │              │  │              │  │            │ │
│  │ -Balance     │  │ -List        │  │ -Profile   │ │
│  │ -Transactions│  │ -Detail      │  │ -Children  │ │
│  │ -Payments    │  │ -Preferences │  │ -Language  │ │
│  │              │  │              │  │ -Theme     │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                      │
│  ┌──────────────┐                                    │
│  │Communication │                                    │
│  │  Module      │                                    │
│  │              │                                    │
│  │ -Announce    │                                    │
│  │ -WhatsApp    │                                    │
│  │ -Teacher     │                                    │
│  │  Notes       │                                    │
│  └──────────────┘                                    │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### 3.3 Complete Navigation Map

```
App Launch
  │
  ├── [First Launch] Onboarding Screens (3 pages)
  │     └── Registration Type Selection
  │           ├── [Option A] Register with Child's Phone
  │           │     └── Parent Registration Form
  │           │           └── OTP Verification
  │           │                 └── Child Linking Verification
  │           │                       └── Link Success → Home
  │           │
  │           └── [Option B] Register with Child's Student Code
  │                 └── Parent Registration Form
  │                       └── OTP Verification
  │                             └── Child Linking Verification
  │                                   └── Link Success → Home
  │
  ├── [Returning User] Login
  │     ├── [Forgot Password] Phone → OTP → New Password
  │     └── [Success] → Home
  │
  └── [Token Valid] → Home (auto-login)
        │
        ╔═══════════════════════════════════════════════╗
        ║     MAIN APP — Bottom Navigation Bar          ║
        ╠═══════════════════════════════════════════════╣
        ║                                               ║
        ║  ┌─────────────────────────────────────────┐  ║
        ║  │  CHILD SWITCHER (Global Top Bar)        │  ║
        ║  │  [Child 1 ▼] ← Dropdown / Horizontal   │  ║
        ║  │  scroll if multiple children             │  ║
        ║  └─────────────────────────────────────────┘  ║
        ║                                               ║
        ║  Tab 1: HOME (Children Overview)              ║
        ║  ├── Active Child Summary Card                ║
        ║  │     ├── Name, Grade, Photo                 ║
        ║  │     ├── Overall Progress Ring               ║
        ║  │     ├── Attendance Rate                    ║
        ║  │     └── Wallet Balance                     ║
        ║  ├── Quick Stats Row                          ║
        ║  │     ├── Courses Enrolled                   ║
        ║  │     ├── Avg Grade                          ║
        ║  │     ├── Attendance %                       ║
        ║  │     └── Points                             ║
        ║  ├── Recent Activity Feed                     ║
        ║  │     ├── Grade received                     ║
        ║  │     ├── Attendance marked                  ║
        ║  │     ├── Course progress                    ║
        ║  │     └── Payment made                       ║
        ║  ├── Announcements Section                    ║
        ║  └── Quick Actions Grid                       ║
        ║        ├── Courses → Academic Monitor          ║
        ║        ├── Grades → Grade Monitor              ║
        ║        ├── Attendance → Attendance Monitor     ║
        ║        └── Wallet → Financial Monitor          ║
        ║                                               ║
        ║  Tab 2: ACADEMICS                             ║
        ║  ├── Enrolled Courses List                    ║
        ║  │     └── Course Progress Detail             ║
        ║  │           ├── Session Progress Breakdown   ║
        ║  │           ├── Content Access Log            ║
        ║  │           └── Time Spent Analytics          ║
        ║  ├── Overall Progress Summary                 ║
        ║  └── Learning Activity Timeline               ║
        ║                                               ║
        ║  Tab 3: GRADES                                ║
        ║  ├── Grade Summary Card                       ║
        ║  │     ├── Overall Average                    ║
        ║  │     └── Grade Distribution Chart           ║
        ║  ├── Assessment List (All Courses)            ║
        ║  │     ├── Quiz Results                       ║
        ║  │     │     └── Quiz Detail                  ║
        ║  │     │           ├── Score & Percentage     ║
        ║  │     │           ├── Pass/Fail Status       ║
        ║  │     │           └── Question Breakdown     ║
        ║  │     └── Assignment Results                 ║
        ║  │           └── Assignment Detail            ║
        ║  │                 ├── Score & Feedback       ║
        ║  │                 └── Submission Status      ║
        ║  ├── Performance Trend Chart                  ║
        ║  └── Course-wise Grade Breakdown              ║
        ║                                               ║
        ║  Tab 4: NOTIFICATIONS                         ║
        ║  ├── Notification List                        ║
        ║  │     ├── Attendance Alerts                  ║
        ║  │     ├── Grade Notifications                ║
        ║  │     ├── Payment Notifications              ║
        ║  │     ├── Announcements                      ║
        ║  │     └── System Notifications               ║
        ║  └── Notification Preferences                 ║
        ║                                               ║
        ║  Tab 5: MORE                                  ║
        ║  ├── My Profile                               ║
        ║  ├── Linked Children Management               ║
        ║  │     ├── View Linked Children               ║
        ║  │     ├── Add New Child                      ║
        ║  │     └── Unlink Child                       ║
        ║  ├── Attendance History (Detailed)            ║
        ║  │     ├── Calendar View                      ║
        ║  │     └── List View                          ║
        ║  ├── Financial History (Detailed)             ║
        ║  │     ├── Wallet Transactions                ║
        ║  │     └── Payment Records                    ║
        ║  ├── Announcements Archive                    ║
        ║  ├── WhatsApp Groups                          ║
        ║  ├── Settings                                 ║
        ║  │     ├── Language (Arabic / English)        ║
        ║  │     ├── Theme (Light / Dark / System)      ║
        ║  │     ├── Notification Preferences           ║
        ║  │     └── Change Password                    ║
        ║  ├── Help & Support                           ║
        ║  └── Logout                                   ║
        ║                                               ║
        ╚═══════════════════════════════════════════════╝
```

---

## 4. Screen Specifications

---

### 4.1 Screen: Splash Screen

**Purpose**
Initialize the application, validate authentication state, load linked children data, and route the parent to the appropriate entry point.

**UI Components**
- MentorX logo (centered, animated scale-in, 120x120dp)
- Subtitle: "Parent Portal" (Cairo Regular 16sp, below logo)
- Circular loading indicator (accent color)
- App version text (bottom-aligned, Cairo Regular 12sp, 40% opacity)

**Features**
- JWT token validation against backend
- Automatic token refresh if access token expired
- Pre-fetch linked children list on successful auth
- Network connectivity detection
- Minimum app version check

**Navigation**
| Condition | Destination |
|---|---|
| First launch (no account) | Onboarding Screen |
| No stored token | Login Screen |
| Valid token + has linked children | Home Dashboard (first child selected) |
| Valid token + no linked children | Add Child Screen |
| Expired token + valid refresh | Silent refresh → Home |
| Expired token + invalid refresh | Login Screen |
| App version outdated | Force Update Screen |
| No network + cached auth | Home Dashboard (offline mode) |

**Business Rules**
- BR-SPL-01: Token validation must complete within 3 seconds.
- BR-SPL-02: On successful auth, pre-fetch linked children list and cache locally.
- BR-SPL-03: If parent has linked children, auto-select the first child (or last viewed child from local storage).
- BR-SPL-04: Splash screen displays for minimum 1.5 seconds.
- BR-SPL-05: App version check against `GET /api/v1/config/app-version`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/verify-token` | Validate JWT |
| `POST` | `/api/v1/auth/refresh` | Refresh expired token |
| `GET` | `/api/v1/parent/children` | Pre-fetch linked children |
| `GET` | `/api/v1/config/app-version` | Check minimum version |

**States**
- **Loading:** Logo with spinner; validation in progress.
- **Error — Network (no cache):** "No internet connection." Button: "Retry".
- **Error — Force Update:** "Please update to continue." Button: "Update Now".

---

### 4.2 Screen: Onboarding

**Purpose**
Introduce the MentorX Parent Portal to first-time parents through informational screens before directing to registration.

**UI Components**
- 3 swipeable pages with illustrations:
  - Page 1: "Track Your Child's Learning" — illustration of parent viewing dashboard
  - Page 2: "Stay Informed in Real-Time" — illustration of notification bell with grade card
  - Page 3: "Monitor Attendance & Spending" — illustration of attendance calendar and wallet
- Page indicator dots
- "Skip" button (top right)
- "Next" button (bottom)
- "Get Started" button (final page)

**Navigation**
| Action | Destination |
|---|---|
| "Get Started" or "Skip" | Login Screen (with "Register" option) |

**Business Rules**
- BR-ONB-01: Shown only once. `onboarding_completed = true` stored locally.
- BR-ONB-02: Content is hardcoded; no API call required.

**API Requirements**
None.

**States**
- No loading, error, or empty states. Fully client-side.

---

### 4.3 Screen: Parent Registration

**Purpose**
Create a new parent account and establish the initial link to at least one child (student) account. Registration requires identifying the child through their registered phone number or student code.

**UI Components**

**Step 1 — Child Identification**
- Title: "Link to Your Child" (Cairo Bold 22sp)
- Description: "Enter your child's phone number or student code to connect your accounts." (Cairo Regular 15sp)
- Toggle: "Phone Number" / "Student Code" (segmented control)
- **Phone Number mode:**
  - Phone input with +20 prefix
  - Tenant auto-detected from student's account
- **Student Code mode:**
  - Student code input (e.g., "AHM-2025-00142")
  - Tenant dropdown (if student code doesn't uniquely identify tenant)
- "Find Student" button (primary)
- Result preview: Student name, grade, tenant name, profile photo (masked partially for privacy: "أح** مح**")
- "Confirm — This is my child" button
- "Not my child" link

**Step 2 — Parent Information**
| Component | Type | Required | Validation |
|---|---|---|---|
| First Name | Text input | Yes | Min 2 chars, Arabic/English |
| Last Name | Text input | Yes | Min 2 chars, Arabic/English |
| Phone Number | Phone input (+20) | Yes | 11 digits, Egyptian format |
| Email | Email input | No | RFC 5322 if provided |
| Relationship | Dropdown (Father / Mother / Guardian / Other) | Yes | — |

**Step 3 — Security**
| Component | Type | Required | Validation |
|---|---|---|---|
| Password | Password input with toggle | Yes | Min 8 chars, 1 upper, 1 lower, 1 digit, 1 special |
| Confirm Password | Password input with toggle | Yes | Must match password |

**Step Navigation**
- Progress indicator (3 dots)
- "Back" / "Next" / "Submit" buttons
- "Already have an account? Login" link

**Features**
- Student lookup by phone or code with privacy-masked preview
- Async phone uniqueness check for parent
- Parent phone must differ from child's phone
- Relationship type selection
- Password strength indicator

**Displayed Data (Step 1 Result)**
| Field | Source |
|---|---|
| Student Name (masked) | From `POST /api/v1/parent/find-student` response |
| Grade | Student's grade name |
| Tenant Name | Student's tenant name |
| Profile Photo | Student's photo (blurred or placeholder) |

**Navigation**
| Action | Destination |
|---|---|
| "Submit" (Step 3) | OTP Verification Screen |
| "Already have an account?" | Login Screen |
| "Back" (Step 1) | Onboarding or Login |

**Business Rules**
- BR-PREG-01: The child identification step validates that the student exists and is in `active` or `pending` status.
- BR-PREG-02: Parent phone number must be unique across the platform (not just per tenant).
- BR-PREG-03: Parent phone must differ from the child's phone number.
- BR-PREG-04: Student preview is privacy-masked: only first 2 characters of first/last name are shown, rest replaced with asterisks.
- BR-PREG-05: Upon registration, a `parent_students` record is created with `verified_at = NULL`. Verification completes after OTP + optional teacher approval.
- BR-PREG-06: The parent's `users` record is created with `tenant_id = NULL` (parents are not tenant-specific) and assigned the `parent` role.
- BR-PREG-07: An OTP is sent to the parent's phone upon form submission.
- BR-PREG-08: After OTP verification, a confirmation SMS is sent to the child's phone: "Your parent {name} has linked to your MentorX account."
- BR-PREG-09: The parent can register without tenant selection — the tenant context is inherited from the linked child.
- BR-PREG-10: If the student's `parent_phone` field matches the registering parent's phone, the link is auto-verified (`verified_at = NOW()`). Otherwise, teacher approval may be required.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/parent/find-student` | Look up student by phone or code |
| `POST` | `/api/v1/auth/check-phone` | Validate parent phone uniqueness |
| `POST` | `/api/v1/auth/register-parent` | Submit parent registration |

**Request Body — `POST /api/v1/parent/find-student`**
```json
{
  "lookup_type": "phone",
  "value": "01012345678"
}
```

**Response Body — Student Found**
```json
{
  "success": true,
  "data": {
    "student_id": 42,
    "first_name_masked": "أح**",
    "last_name_masked": "مح**",
    "grade_name": "الصف الثالث الثانوي",
    "tenant_name": "Mr. Ahmed Physics",
    "tenant_id": 1,
    "profile_photo_url": null,
    "can_auto_verify": true
  }
}
```

**Request Body — `POST /api/v1/auth/register-parent`**
```json
{
  "first_name": "محمد",
  "last_name": "علي",
  "phone": "01098765432",
  "email": "mohamed@example.com",
  "password": "ParentP@ss1",
  "relationship": "father",
  "student_id": 42,
  "device_hash": "x1y2z3",
  "device_name": "iPhone 13",
  "fcm_token": "fMC:token..."
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "user_id": 100,
    "status": "active",
    "child_link_status": "verified",
    "otp_sent": true,
    "otp_expires_in_seconds": 300
  }
}
```

**States**
- **Loading (Find Student):** Spinner on "Find Student" button.
- **Student Found:** Preview card with masked name, grade, tenant. "Confirm" button.
- **Student Not Found:** Red text: "No student found with this phone number/code. Please check and try again."
- **Loading (Submit):** Spinner overlay; inputs disabled.
- **Error — Duplicate Phone:** "This phone is already registered. Login instead."
- **Error — Server:** "Registration failed. Please try again."
- **Success:** Navigate to OTP Verification.

---

### 4.4 Screen: OTP Verification (Parent)

**Purpose**
Verify the parent's phone number ownership before activating the account.

**UI Components**
- Title: "Verify Your Number" (Cairo Bold 22sp)
- Subtitle: "Enter the code sent to +20 {masked_phone}"
- 6-digit OTP input boxes
- Countdown timer: "Resend in 0:45"
- "Resend Code" / "Resend via WhatsApp" buttons
- "Verify" button

**Features**
- Auto-advance, auto-submit, SMS auto-read (Android)
- Paste support
- Numeric keyboard

**Navigation**
| Condition | Destination |
|---|---|
| Verification success + child auto-verified | Home Dashboard |
| Verification success + child pending verification | Child Link Pending Screen |
| Max attempts exceeded | Temporary Lock Screen |

**Business Rules**
- BR-POTP-01: OTP valid for 5 minutes, max 3 attempts per code.
- BR-POTP-02: Resend cooldown: 60 seconds.
- BR-POTP-03: After 3 failed codes, lock for 30 minutes.
- BR-POTP-04: If the parent's phone matches `users.parent_phone` for the student, the child link is auto-verified.
- BR-POTP-05: If auto-verification is not possible, the link enters `pending` status awaiting teacher approval.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/verify-otp` | Validate OTP |
| `POST` | `/api/v1/auth/resend-otp` | Resend OTP |

**States**
Same as Student OTP screen (Section 4.5 of Student SRS).

---

### 4.5 Screen: Login (Parent)

**Purpose**
Authenticate a returning parent and establish a secure session.

**UI Components**
- MentorX logo with "Parent Portal" subtitle
- Phone number input with +20 prefix
- Password input with visibility toggle
- "Remember me" checkbox
- "Forgot Password?" link
- "Login" button (primary, full width)
- Biometric login button (if previously enabled)
- "Don't have an account? Register" link

**Features**
- Remember phone number
- Biometric authentication
- FCM token registration on login

**Navigation**
| Condition | Destination |
|---|---|
| Success + has linked children | Home Dashboard |
| Success + no linked children | Add Child Screen |
| Tap "Forgot Password?" | Phone → OTP → New Password |
| Tap "Register" | Registration Screen |

**Business Rules**
- BR-PLOG-01: Account lockout after 5 failed attempts for 15 minutes.
- BR-PLOG-02: JWT access token (15 min) + refresh token (7 days) issued on success.
- BR-PLOG-03: Device hash captured but device binding is less strict for parents (device_limit = 3 by default for parent accounts).
- BR-PLOG-04: On login, pre-fetch linked children list.
- BR-PLOG-05: If parent has no linked children (all unlinked), redirect to Add Child Screen.
- BR-PLOG-06: Password verified via bcrypt.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/auth/login` | Authenticate parent |
| `GET` | `/api/v1/parent/children` | Fetch linked children |

**Request Body — `POST /api/v1/auth/login`**
```json
{
  "phone": "01098765432",
  "password": "ParentP@ss1",
  "device_hash": "x1y2z3",
  "device_name": "iPhone 13",
  "app_version": "1.0.0",
  "fcm_token": "fMC:token..."
}
```

**Response Body — Success**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbG...",
    "refresh_token": "dGhpcyB...",
    "token_type": "Bearer",
    "expires_in": 900,
    "user": {
      "id": 100,
      "first_name": "محمد",
      "last_name": "علي",
      "phone": "01098765432",
      "role": "parent",
      "status": "active",
      "profile_photo_url": null
    },
    "children": [
      {
        "student_id": 42,
        "first_name": "أحمد",
        "last_name": "محمد",
        "profile_photo_url": "...",
        "grade_name": "الصف الثالث الثانوي",
        "tenant_id": 1,
        "tenant_name": "Mr. Ahmed Physics",
        "relationship": "father",
        "link_status": "verified"
      }
    ]
  }
}
```

**States**
- **Default:** Form fields enabled.
- **Loading:** Login button spinner; fields disabled.
- **Error — Invalid Credentials:** Red banner: "Incorrect phone or password."
- **Error — Account Locked:** "Account locked. Try again in {n} minutes."
- **Error — No Children:** Redirect to Add Child Screen after login.
- **Error — Network:** Toast: "Unable to connect."

---

### 4.6 Screen: Child Switcher (Global Component)

**Purpose**
Allow the parent to switch between linked children. This is a persistent global component visible at the top of all main screens.

**UI Components**

**Single Child Mode (1 linked child):**
- Child avatar (32dp, circular) + child name + grade badge
- Non-interactive (no dropdown)

**Multi-Child Mode (2+ linked children):**
- **Option A — Dropdown:** Active child name + avatar with dropdown arrow. Tap opens dropdown list.
- **Option B — Horizontal Scroll:** Horizontally scrollable chips of children. Active child highlighted.
- Each child entry: avatar, first name, grade, tenant name (if different tenants)
- "Add Child" button at the end of the list (+ icon)

**Features**
- Switching children refreshes all data on the current screen
- Active child selection persists in local storage
- Visual distinction for the active child
- Unverified child links shown with amber "Pending" badge (data not accessible)

**Displayed Data**
| Field | Source |
|---|---|
| Children List | Cached from login response or `GET /api/v1/parent/children` |
| Child Avatar | `users.profile_photo_url` for each student |
| Child Name | `users.first_name` for each student |
| Grade | `grades.name` via student's `grade_id` |
| Tenant Name | `tenants.name` via student's `tenant_id` |
| Link Status | `parent_students.verified_at` (verified / pending) |

**Navigation**
| Action | Destination |
|---|---|
| Select different child | Current screen refreshes with new child's data |
| Tap "Add Child" | Add Child Screen |
| Tap unverified child | Toast: "This link is pending verification. Data will be available once verified." |

**Business Rules**
- BR-CSW-01: Only children with `parent_students.verified_at IS NOT NULL` allow data access.
- BR-CSW-02: Unverified children appear in the list with "Pending" badge but are not selectable for data viewing.
- BR-CSW-03: Active child ID is stored in local storage as `active_child_id`.
- BR-CSW-04: On child switch, all API calls on the current screen are re-executed with the new `student_id`.
- BR-CSW-05: If a parent has children in different tenants, the API context switches tenant automatically based on the selected child's `tenant_id`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children` | Fetch all linked children with status |

**States**
- **Single Child:** Static display, no interaction.
- **Multi-Child:** Dropdown/scroll active.
- **No Verified Children:** All children shown as pending. Toast: "No verified children. Please wait for teacher verification."

---

### 4.7 Screen: Home Dashboard (Parent)

**Purpose**
Provide a comprehensive at-a-glance summary of the active child's academic status, recent activity, announcements, and quick access to all monitoring features.

**UI Components**

**Child Switcher (Top — global component, see 4.6)**

**Child Summary Card (Hero)**
- Child profile photo (64dp, circular)
- Child full name (Cairo Bold 20sp)
- Grade and tenant name (Cairo Regular 14sp)
- Student code (small, copyable)
- Overall statistics row:
  - 📊 Overall Progress: circular ring with percentage
  - ✅ Attendance Rate: percentage with color coding
  - 💰 Wallet Balance: "EGP {amount}"
  - ⭐ Points: "{n} pts"

**Quick Stats Cards (2x2 Grid)**
| Card | Content | Tap Destination |
|---|---|---|
| Courses | "{enrolled} enrolled, {in_progress} active" | Academics Tab |
| Average Grade | "{avg}%" with trend arrow (↑ or ↓ vs last month) | Grades Tab |
| Attendance | "{present}/{total} sessions ({%}%)" | Attendance Screen |
| Wallet | "EGP {balance}" | Financial Screen |

**Recent Activity Feed**
- Section title: "Recent Activity" (Cairo SemiBold 18sp)
- Vertical list (max 10 items, infinite scroll)
- Each activity item:
  - Activity type icon (color-coded):
    - 📚 Course progress (blue)
    - 🎯 Quiz graded (purple)
    - 📝 Assignment graded (orange)
    - ✅ Attendance marked (green for present, red for absent)
    - 💰 Payment/wallet (teal)
  - Description text: e.g., "أحمد scored 85% on Physics Quiz 3"
  - Relative timestamp
  - Tappable → detail screen

**Announcements Section**
- Section title: "Announcements"
- Max 3 recent announcements matching child's grade/center/group
- Each: pinned indicator, title, preview text, date
- "See All" link

**Quick Actions Grid**
- 2x2 grid: Courses, Grades, Attendance, Wallet
- Each: icon + label, tappable to respective screen

**Features**
- Pull-to-refresh reloads all sections
- Auto-refresh data every 5 minutes in background
- Offline display with cached data and amber "Offline" banner
- Each section loads independently
- Activity feed combines data from multiple domains (grades, attendance, courses, payments)

**Displayed Data**
| Section | API Source |
|---|---|
| Child Info | Cached from children list + `GET /api/v1/parent/children/{student_id}/summary` |
| Quick Stats | Aggregated from summary endpoint |
| Recent Activity | `GET /api/v1/parent/children/{student_id}/activity?limit=10` |
| Announcements | `GET /api/v1/parent/children/{student_id}/announcements?limit=3` |

**Navigation**
| Action | Destination |
|---|---|
| Tap Courses quick stat | Academics Tab |
| Tap Grades quick stat | Grades Tab |
| Tap Attendance quick stat | Attendance Detail Screen |
| Tap Wallet quick stat | Financial Detail Screen |
| Tap activity item (grade) | Grade Detail Screen |
| Tap activity item (attendance) | Attendance Detail |
| Tap activity item (course progress) | Course Progress Detail |
| Tap activity item (payment) | Financial Detail |
| Tap announcement | Announcement Detail |
| Tap "See All" announcements | Announcements Archive |

**Business Rules**
- BR-PHOME-01: All data is scoped to the active child (`student_id` from child switcher).
- BR-PHOME-02: Activity feed is a combined, chronologically sorted stream from: `quiz_attempts`, `assignment_submissions`, `attendance_records`, `wallet_transactions`, `student_progress`.
- BR-PHOME-03: Attendance rate is calculated as `(present + late) / total × 100` from the current academic period (semester/term as configured by tenant).
- BR-PHOME-04: Average grade is calculated from all graded quizzes and assignments in the current period.
- BR-PHOME-05: Grade trend arrow: compare current month's average with previous month's. ↑ if improved, ↓ if declined, — if stable (≤ 2% change).
- BR-PHOME-06: Data cache TTL: 5 minutes. Background refresh every 5 minutes when app is in foreground.
- BR-PHOME-07: If child has no data (newly enrolled), show onboarding message: "Your child just started! Data will appear as they use the platform."

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/summary` | Aggregated child summary stats |
| `GET` | `/api/v1/parent/children/{student_id}/activity?limit=10&page={n}` | Recent activity feed |
| `GET` | `/api/v1/parent/children/{student_id}/announcements?limit=3` | Recent announcements |

**Response Body — `GET /api/v1/parent/children/{student_id}/summary`**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": 42,
      "first_name": "أحمد",
      "last_name": "محمد",
      "student_code": "AHM-2025-00142",
      "grade_name": "الصف الثالث الثانوي",
      "tenant_name": "Mr. Ahmed Physics",
      "profile_photo_url": "...",
      "study_type": "both",
      "status": "active"
    },
    "academics": {
      "enrolled_courses": 4,
      "in_progress_courses": 3,
      "completed_courses": 1,
      "overall_progress_percent": 62.5
    },
    "grades": {
      "average_percentage": 78.3,
      "trend": "up",
      "total_assessments": 15,
      "passed": 13,
      "failed": 2
    },
    "attendance": {
      "total_sessions": 30,
      "present": 25,
      "late": 3,
      "absent": 2,
      "excused": 0,
      "attendance_rate": 93.3
    },
    "financial": {
      "wallet_balance": 150.00,
      "total_points": 320,
      "total_spent_this_month": 200.00
    }
  }
}
```

**States**
- **Loading:** Shimmer for summary card, stats grid, and activity feed.
- **Empty — New Child:** Illustration. "Your child just started! Academic data will appear as they begin learning."
- **Error — Network (no cache):** "Unable to load data. Please check your connection." Button: "Retry".
- **Error — Network (with cache):** Cached data displayed with amber banner: "Offline. Showing last updated data."
- **Partial Failure:** Individual sections show inline retry. Other sections render normally.
- **Unverified Child Selected:** Full-screen message: "This child's account link is pending verification. You'll be able to view their data once verified."

---

### 4.8 Screen: Academic Monitor (Courses)

**Purpose**
Display all courses the child is enrolled in with progress details, session breakdowns, and learning activity metrics.

**UI Components**

**Overall Progress Section**
- Circular progress ring (large): overall completion across all courses
- Text: "{completed}/{total} courses completed"
- Total learning time: "{hours}h {minutes}m"

**Course List**
- Tab bar: "All" / "In Progress" / "Completed" / "Expired"
- Each course card:
  - Course thumbnail (80x80dp)
  - Course title (Cairo SemiBold 16sp)
  - Tenant/teacher name (if parent has children in multiple tenants)
  - Linear progress bar with percentage
  - Session count: "{completed}/{total} sessions"
  - Last accessed: relative date
  - Total time spent on this course
  - Expiry warning (if applicable)
  - Tappable → Course Progress Detail

**Features**
- Tab filtering
- Pull-to-refresh
- Search by course title

**Displayed Data**
| Field | Source |
|---|---|
| Courses | `GET /api/v1/parent/children/{student_id}/courses?status={filter}` |

**Navigation**
| Action | Destination |
|---|---|
| Tap course card | Course Progress Detail Screen |
| Tab switch | Filter course list |

**Business Rules**
- BR-PACAD-01: All data is read-only. No enrollment or content access actions available.
- BR-PACAD-02: "In Progress" = `progress_percent > 0 AND progress_percent < 100 AND not expired`.
- BR-PACAD-03: "Completed" = `completed_at IS NOT NULL`.
- BR-PACAD-04: "Expired" = `expires_at < NOW() AND completed_at IS NULL`.
- BR-PACAD-05: Total learning time is approximated from video `watch_time_seconds` across all items.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/courses?status={filter}&page={n}` | Fetch child's enrolled courses |

**States**
- **Loading:** Shimmer list.
- **Empty:** "Your child hasn't enrolled in any courses yet."
- **Error:** "Unable to load courses." Button: "Retry".

---

### 4.9 Screen: Course Progress Detail (Parent View)

**Purpose**
Display detailed progress breakdown for a specific course including session-level completion, time spent, and content access log.

**UI Components**

**Course Header**
- Course thumbnail + title + grade badge
- Overall progress ring (large)
- Enrolled date and expiry date
- Time spent on course

**Session Progress Breakdown**
- Expandable accordion per session:
  - Session title
  - Session progress bar with percentage
  - Item completion count: "{completed}/{total} items"
  - Expanded view: list of items with:
    - Item type icon (video/PDF/quiz/assignment/note/audio)
    - Item title
    - Status: ✅ Completed / ⏳ In Progress / ⬜ Not Started / 🔒 Locked
    - Time spent (for videos: watched duration)
    - Completion date (if completed)

**Content Access Log**
- Section title: "Learning Activity"
- Chronological list of child's interactions:
  - "Watched 'Newton's Laws' for 12 minutes" — 2 hours ago
  - "Completed Quiz 3 — scored 85%" — yesterday
  - "Submitted Assignment 2" — 3 days ago
- Tappable for details

**Time Analytics**
- Weekly study time bar chart (last 4 weeks)
- Daily average study time
- Most active time of day

**Features**
- Session accordion expand/collapse
- Time analytics chart (fl_chart library)
- Pull-to-refresh

**Displayed Data**
| Field | Source |
|---|---|
| Course Progress | `GET /api/v1/parent/children/{student_id}/courses/{course_id}/progress` |
| Access Log | `GET /api/v1/parent/children/{student_id}/courses/{course_id}/activity?page={n}` |

**Navigation**
| Action | Destination |
|---|---|
| Tap quiz result in log | Quiz Grade Detail |
| Tap assignment result in log | Assignment Grade Detail |
| Back | Academic Monitor |

**Business Rules**
- BR-PCPD-01: Parent cannot view actual content (videos, PDFs). Only metadata (title, duration, completion status) is displayed.
- BR-PCPD-02: Access log shows the child's interaction timestamps and durations, not content itself.
- BR-PCPD-03: Time analytics aggregated from `student_progress` records.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/courses/{course_id}/progress` | Detailed course progress with session breakdown |
| `GET` | `/api/v1/parent/children/{student_id}/courses/{course_id}/activity?page={n}` | Content access activity log |

**States**
- **Loading:** Shimmer for header and session list.
- **Empty (No Activity):** "Your child hasn't started this course yet."
- **Error:** "Unable to load course progress." Button: "Retry".

---

### 4.10 Screen: Grade Monitor

**Purpose**
Provide a comprehensive view of the child's assessment performance across all courses with trends, distribution analysis, and detailed grade breakdowns.

**UI Components**

**Grade Summary Card (Top)**
- Overall average: large percentage with color ring (green ≥ 70%, amber 50-69%, red < 50%)
- Total assessments: "{graded}/{total}" with pass/fail breakdown
- Trend indicator: "↑ 5% from last month" (green) or "↓ 3%" (red)

**Performance Trend Chart**
- Line chart: monthly average percentage over last 6 months
- X-axis: months; Y-axis: percentage
- Color-coded zones: green (≥70%), amber (50-69%), red (<50%)

**Grade Distribution Chart**
- Pie or bar chart: distribution of grades
  - Excellent (≥90%): green
  - Good (70-89%): blue
  - Average (50-69%): amber
  - Below Average (<50%): red

**Course Filter**
- "All Courses" dropdown or horizontal filter chips

**Assessment List**
- Tab bar: "All" / "Quizzes" / "Assignments"
- Each assessment card:
  - Course name badge (small, top)
  - Assessment title
  - Type icon: 🎯 Quiz / 📝 Assignment
  - Score: "{marks}/{total}" (Cairo Bold, color-coded)
  - Percentage bar
  - Date
  - Status badge: "Graded" (green) / "Pending" (amber) / "Not Submitted" (red)
  - Pass/Fail badge
  - Tappable → Assessment Detail

**Features**
- Performance charts (fl_chart)
- Course filtering
- Tab switching (All/Quizzes/Assignments)
- Pull-to-refresh
- Infinite scroll

**Displayed Data**
| Section | API Source |
|---|---|
| Summary Stats | `GET /api/v1/parent/children/{student_id}/grades/summary` |
| Trend Data | `GET /api/v1/parent/children/{student_id}/grades/trend?months=6` |
| Assessment List | `GET /api/v1/parent/children/{student_id}/grades?type={filter}&course_id={id}&page={n}` |

**Response Body — `GET /api/v1/parent/children/{student_id}/grades/summary`**
```json
{
  "success": true,
  "data": {
    "overall_average": 78.3,
    "trend": "up",
    "trend_change": 5.2,
    "total_assessments": 15,
    "graded": 13,
    "pending": 2,
    "passed": 11,
    "failed": 2,
    "distribution": {
      "excellent": 4,
      "good": 5,
      "average": 2,
      "below_average": 2
    },
    "by_course": [
      {
        "course_id": 5,
        "course_title": "Physics - Term 1",
        "average": 82.5,
        "assessments_count": 5
      }
    ]
  }
}
```

**Response Body — `GET /api/v1/parent/children/{student_id}/grades/trend`**
```json
{
  "success": true,
  "data": {
    "months": [
      {"month": "2025-02", "average": 72.1},
      {"month": "2025-03", "average": 74.5},
      {"month": "2025-04", "average": 76.8},
      {"month": "2025-05", "average": 73.2},
      {"month": "2025-06", "average": 78.3},
      {"month": "2025-07", "average": 80.1}
    ]
  }
}
```

**Navigation**
| Action | Destination |
|---|---|
| Tap quiz assessment | Quiz Grade Detail Screen |
| Tap assignment assessment | Assignment Grade Detail Screen |
| Tap course filter | Filter assessment list by course |
| Back | Home or tab navigation |

**Business Rules**
- BR-PGRADE-01: Overall average calculated from all graded assessments' percentages with equal weighting.
- BR-PGRADE-02: Trend comparison: current month average vs previous month average.
- BR-PGRADE-03: Distribution categories: Excellent (≥90%), Good (70-89%), Average (50-69%), Below Average (<50%).
- BR-PGRADE-04: For quizzes with multiple attempts, the best score is used for averages and display.
- BR-PGRADE-05: "Pending" status shown for submitted but ungraded assignments and quizzes with `show_score_immediately = false`.
- BR-PGRADE-06: "Not Submitted" for assignments past due date with no submission.
- BR-PGRADE-07: Parent can see scores and pass/fail status but not the actual quiz questions or assignment content (teacher-configurable).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/grades/summary` | Grade summary stats |
| `GET` | `/api/v1/parent/children/{student_id}/grades/trend?months=6` | Monthly trend data |
| `GET` | `/api/v1/parent/children/{student_id}/grades?type={quiz\|assignment}&course_id={id}&page={n}&limit=20` | Assessment list |

**States**
- **Loading:** Shimmer for summary card, chart placeholders, and list.
- **Empty:** "No graded assessments yet. Grades will appear here as your child completes quizzes and assignments."
- **Error:** "Unable to load grades." Button: "Retry".

---

### 4.11 Screen: Quiz Grade Detail (Parent View)

**Purpose**
Display detailed quiz results for the parent including score, pass/fail, time spent, and optionally the question-level breakdown.

**UI Components**
- Quiz title + course name
- Score circle (animated, color-coded)
- Pass/Fail badge
- Statistics row: Score, Percentage, Time Spent, Attempt Number
- Question breakdown (if teacher allows parent view):
  - Each question: question number, correct/incorrect indicator, marks obtained
  - No question text or options shown (configurable by teacher)
- OR: "Detailed question breakdown is not available for this quiz."

**Displayed Data**
| Field | Source |
|---|---|
| Quiz Results | `GET /api/v1/parent/children/{student_id}/quiz-attempts/{attempt_id}` |

**Navigation**
| Action | Destination |
|---|---|
| Back | Grade Monitor |

**Business Rules**
- BR-PQD-01: Parent can see score, percentage, pass/fail, time spent, and attempt number.
- BR-PQD-02: Question-level detail visibility is controlled by teacher configuration. If disabled, show summary only.
- BR-PQD-03: Question text and options are never shown to parents — only question numbers and correct/incorrect indicators.
- BR-PQD-04: For quizzes with `show_score_immediately = false` and not yet graded, show "Pending Review" message.

**States**
- **Loading:** Shimmer.
- **Graded:** Score and details displayed.
- **Pending Review:** "Score is being reviewed by the teacher."
- **Error:** "Unable to load quiz details." Button: "Retry".

---

### 4.12 Screen: Assignment Grade Detail (Parent View)

**Purpose**
Display assignment submission status, grade, and teacher feedback.

**UI Components**
- Assignment title + course name
- Status badge: Submitted / Graded / Not Submitted / Late / Resubmission Requested
- Due date and submission date
- Late indicator (if applicable)
- Score (if graded): "{score}/{total}" with color coding
- Teacher feedback text (if provided)
- Submitted file names (names only, not downloadable by parent)
- Teacher notes (if any)

**Navigation**
| Action | Destination |
|---|---|
| Back | Grade Monitor |

**Business Rules**
- BR-PAD-01: Parent can see submission status, timestamps, scores, and feedback.
- BR-PAD-02: Parent cannot view or download submitted files (student privacy).
- BR-PAD-03: Late submissions are indicated with red "Late" badge and penalty notice.

**States**
- **Loading:** Shimmer.
- **Graded:** Score and feedback displayed.
- **Submitted (Pending):** "Submitted. Awaiting teacher review."
- **Not Submitted + Past Due:** Red alert: "This assignment was not submitted by the deadline."
- **Error:** "Unable to load details." Button: "Retry".

---

### 4.13 Screen: Attendance Monitor

**Purpose**
Display comprehensive attendance records with calendar view, statistics, and detailed session-level information for the active child.

**UI Components**

**Attendance Summary Card**
- Attendance rate ring (large, color-coded: green ≥80%, amber 60-79%, red <60%)
- Statistics row:
  - Total: "{n} sessions"
  - Present: "{n}" (green)
  - Late: "{n}" (amber)
  - Absent: "{n}" (red)
  - Excused: "{n}" (blue)

**Calendar View**
- Month calendar grid
- Each day color-coded:
  - Green dot: all present
  - Amber dot: late
  - Red dot: absent
  - Blue dot: excused
  - Gray: no session
- Month navigation (← →)
- Tap day → shows sessions for that day

**Filter Bar**
- Date range: This Month / Last Month / This Semester / Custom
- Course/center filter dropdown

**Attendance Records List**
- Grouped by date (section headers)
- Each record:
  - Session/course name
  - Center name (if physical)
  - Time: "{start} - {end}"
  - Status badge with color
  - Check-in time (if present/late)
  - Teacher notes (if any)
  - Late threshold info (if late): "Arrived {n} minutes after start"

**Features**
- Calendar view with color-coded days
- List view toggle (calendar / list)
- Date range filtering
- Course/center filtering
- Pull-to-refresh

**Displayed Data**
| Section | API Source |
|---|---|
| Summary Stats | `GET /api/v1/parent/children/{student_id}/attendance/summary?from={}&to={}` |
| Calendar Data | `GET /api/v1/parent/children/{student_id}/attendance/calendar?month={YYYY-MM}` |
| Records | `GET /api/v1/parent/children/{student_id}/attendance?from={}&to={}&course_id={}&page={n}` |

**Response Body — `GET /api/v1/parent/children/{student_id}/attendance/summary`**
```json
{
  "success": true,
  "data": {
    "period": {"from": "2025-07-01", "to": "2025-07-31"},
    "total_sessions": 20,
    "present": 15,
    "late": 3,
    "absent": 2,
    "excused": 0,
    "online": 5,
    "attendance_rate": 90.0,
    "punctuality_rate": 75.0
  }
}
```

**Response Body — `GET /api/v1/parent/children/{student_id}/attendance/calendar`**
```json
{
  "success": true,
  "data": {
    "month": "2025-07",
    "days": [
      {"date": "2025-07-01", "sessions": [{"status": "present", "course": "Physics"}]},
      {"date": "2025-07-02", "sessions": [{"status": "late", "course": "Physics"}]},
      {"date": "2025-07-05", "sessions": [{"status": "absent", "course": "Physics"}]},
      {"date": "2025-07-07", "sessions": []}
    ]
  }
}
```

**Navigation**
| Action | Destination |
|---|---|
| Tap calendar day | Shows sessions for that day (bottom sheet or inline expansion) |
| Tap record | Record detail (bottom sheet) |
| Back | Home or More tab |

**Business Rules**
- BR-PATT-01: Default period is current month.
- BR-PATT-02: Attendance rate = `(present + late) / total × 100`.
- BR-PATT-03: Punctuality rate = `present / (present + late) × 100`.
- BR-PATT-04: Records sorted by `date DESC, start_time DESC`.
- BR-PATT-05: Read-only. Parents cannot modify attendance records.
- BR-PATT-06: Calendar days with no scheduled sessions are gray.
- BR-PATT-07: If a day has multiple sessions with different statuses, show the worst status dot (absent > late > present).

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/attendance/summary?from={}&to={}` | Summary stats |
| `GET` | `/api/v1/parent/children/{student_id}/attendance/calendar?month={YYYY-MM}` | Calendar day data |
| `GET` | `/api/v1/parent/children/{student_id}/attendance?from={}&to={}&course_id={}&page={n}&limit=20` | Detailed records |

**States**
- **Loading:** Shimmer for summary card, calendar grid, and record list.
- **Empty:** "No attendance records found for this period."
- **Error:** "Unable to load attendance data." Button: "Retry".

---

### 4.14 Screen: Financial Monitor

**Purpose**
Display the child's wallet balance, complete transaction history, and payment records for the parent's oversight.

**UI Components**

**Balance Card (Top)**
- Wallet icon
- Balance: "EGP {amount}" (Cairo Bold 28sp)
- Points: "{n} points" (Cairo Regular 14sp)
- Month spending summary: "Spent this month: EGP {amount}"

**Spending Analytics**
- Bar chart: monthly spending over last 6 months
- Category breakdown pie chart:
  - Course purchases
  - Session purchases
  - Marketplace
  - Other

**Transaction History**
- Filter chips: "All" / "Credits" / "Purchases" / "Codes" / "Refunds"
- Transaction list (vertical, infinite scroll):
  - Each transaction:    - Transaction icon (green ↑ credit, red ↓ debit)
    - Description: e.g., "Course Purchase: Physics Term 1"
    - Amount: "+EGP {amount}" (green) or "-EGP {amount}" (red)
    - Balance after: "Balance: EGP {amount}" (12sp, 50% opacity)
    - Date and time
    - Type badge: "Top Up" / "Course" / "Code" / "Reward" / "Admin" / "Refund" / "Marketplace"
    - Payment method (for top-ups): "Vodafone Cash" / "Fawry" / "InstaPay"

**Payment Records Section**
- Section title: "Payment History"
- List of all payment transactions:
  - Each record:
    - Payment ID / reference
    - Amount
    - Method icon + name
    - Purpose: "Wallet Top Up" / "Course Purchase" / "Marketplace"
    - Status badge: Completed (green) / Pending (amber) / Failed (red) / Refunded (blue)
    - Date

**Features**
- Spending analytics charts (fl_chart)
- Transaction type filtering
- Pull-to-refresh
- Infinite scroll pagination
- Date range filtering (this month / last month / custom)

**Displayed Data**
| Section | API Source |
|---|---|
| Balance & Points | `GET /api/v1/parent/children/{student_id}/wallet/summary` |
| Spending Analytics | `GET /api/v1/parent/children/{student_id}/wallet/analytics?months=6` |
| Transactions | `GET /api/v1/parent/children/{student_id}/wallet/transactions?type={filter}&from={}&to={}&page={n}` |
| Payments | `GET /api/v1/parent/children/{student_id}/payments?page={n}` |

**Response Body — `GET /api/v1/parent/children/{student_id}/wallet/summary`**
```json
{
  "success": true,
  "data": {
    "wallet_balance": 150.00,
    "total_points": 320,
    "spent_this_month": 200.00,
    "total_credits_this_month": 350.00,
    "total_transactions": 45
  }
}
```

**Response Body — `GET /api/v1/parent/children/{student_id}/wallet/analytics`**
```json
{
  "success": true,
  "data": {
    "monthly_spending": [
      {"month": "2025-02", "amount": 150.00},
      {"month": "2025-03", "amount": 200.00},
      {"month": "2025-04", "amount": 100.00},
      {"month": "2025-05", "amount": 250.00},
      {"month": "2025-06", "amount": 180.00},
      {"month": "2025-07", "amount": 200.00}
    ],
    "category_breakdown": {
      "course_purchase": 650.00,
      "session_purchase": 120.00,
      "marketplace": 80.00,
      "other": 30.00
    }
  }
}
```

**Navigation**
| Action | Destination |
|---|---|
| Tap transaction | Transaction detail bottom sheet (full details) |
| Tap payment record | Payment detail bottom sheet |
| Filter change | Refresh transaction list |
| Back | Home or More tab |

**Business Rules**
- BR-PFIN-01: All financial data is read-only. Parents cannot initiate top-ups, payments, or wallet transfers.
- BR-PFIN-02: Transactions sorted by `created_at DESC`.
- BR-PFIN-03: Spending analytics aggregated from `wallet_transactions` where `transaction_type IN ('purchase')`.
- BR-PFIN-04: Category breakdown derived from `wallet_transactions.description` and linked `payments.payment_type`.
- BR-PFIN-05: Balance shown is real-time (or cached with 5-minute TTL).
- BR-PFIN-06: If child has never used the wallet, show: "No financial activity yet."
- BR-PFIN-07: Parent can see all transaction details including admin-initiated adjustments with notes.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/wallet/summary` | Balance and spending summary |
| `GET` | `/api/v1/parent/children/{student_id}/wallet/analytics?months=6` | Monthly spending and category data |
| `GET` | `/api/v1/parent/children/{student_id}/wallet/transactions?type={filter}&from={date}&to={date}&page={n}&limit=20` | Transaction history |
| `GET` | `/api/v1/parent/children/{student_id}/payments?page={n}&limit=20` | Payment records |

**States**
- **Loading:** Shimmer for balance card, chart area, and transaction list.
- **Empty — No Transactions:** Balance card shows EGP 0.00. List area: "No financial activity yet."
- **Empty — No Spending Analytics:** Charts hidden. Text: "Not enough data for spending analysis."
- **Error:** "Unable to load financial data." Button: "Retry".

---

### 4.15 Screen: Notifications (Parent)

**Purpose**
Display all notifications related to the parent's linked children, organized chronologically with child attribution and type-specific routing.

**UI Components**

**Child Filter Chips (Top)**
- "All Children" chip (default)
- One chip per linked child (avatar + first name)
- Selected chip is highlighted

**"Mark All as Read" text button (right)**

**Notification List**
- Grouped by date: "Today", "Yesterday", "July 14"
- Each notification:
  - **Child avatar** (left, 32dp — important differentiator from student app)
  - **Child name badge** (small, above title)
  - Type icon (color-coded):
    - 📢 Announcement (blue)
    - 🎯 Quiz graded (purple)
    - 📝 Assignment graded (orange)
    - ✅ Attendance: Present (green)
    - ❌ Attendance: Absent (red)
    - ⏰ Attendance: Late (amber)
    - 💰 Payment (teal)
    - ⭐ Points earned (gold)
    - 👤 Profile update (gray)
    - ⚙️ System (gray)
  - Title (Cairo SemiBold 15sp)
  - Body preview (1-2 lines, 60% opacity)
  - Relative timestamp
  - Unread indicator: blue dot
  - Tappable → relevant detail screen

**Features**
- Filter by child
- Mark all as read
- Pull-to-refresh
- Infinite scroll pagination
- Swipe-to-dismiss (optional)
- Badge count on tab icon

**Displayed Data**
| Field | Source |
|---|---|
| Notifications | `GET /api/v1/parent/notifications?child_id={id}&page={n}&limit=20` |

**Navigation**
| Notification Type | Tap Destination |
|---|---|
| `quiz_result` | Quiz Grade Detail (child context auto-set) |
| `assignment_graded` | Assignment Grade Detail |
| `attendance_marked` (present/late) | Attendance Monitor |
| `attendance_marked` (absent) | Attendance Monitor (with date filter) |
| `payment_success` | Financial Monitor |
| `wallet_updated` | Financial Monitor |
| `announcement` | Announcement Detail |
| `points_earned` | Home Dashboard (child summary) |
| `profile_approved` / `profile_rejected` | Home Dashboard |
| `system` | Notification detail bottom sheet |

**Business Rules**
- BR-PNOT-01: Notifications are delivered for ALL linked and verified children.
- BR-PNOT-02: Each notification includes `student_id` to attribute to the correct child.
- BR-PNOT-03: Tapping a notification for a specific child auto-switches the active child to that student before navigating.
- BR-PNOT-04: "All Children" filter shows all notifications sorted by `created_at DESC`.
- BR-PNOT-05: Child-specific filter shows only notifications for that `student_id`.
- BR-PNOT-06: Mark as read updates `notifications.is_read = true`, `read_at = NOW()`.
- BR-PNOT-07: Absence notifications are priority-highlighted with red background tint.
- BR-PNOT-08: Unread count badge on tab icon = `COUNT(notifications WHERE is_read = false)` for all children.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/notifications?child_id={id}&page={n}&limit=20` | Fetch notifications |
| `PATCH` | `/api/v1/parent/notifications/{id}/read` | Mark single as read |
| `PATCH` | `/api/v1/parent/notifications/read-all` | Mark all as read |
| `GET` | `/api/v1/parent/notifications/unread-count` | Get unread count for badge |

**Response Body — `GET /api/v1/parent/notifications`**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": 501,
        "student_id": 42,
        "student_name": "أحمد",
        "type": "attendance_marked",
        "title": "Absence Alert",
        "body": "أحمد was marked absent in Physics - Lecture 15",
        "is_read": false,
        "action_data": {
          "attendance_session_id": 45,
          "status": "absent"
        },
        "created_at": "2025-07-15T14:30:00Z"
      },
      {
        "id": 500,
        "student_id": 42,
        "student_name": "أحمد",
        "type": "quiz_result",
        "title": "Quiz Graded",
        "body": "أحمد scored 85% on Physics Quiz 3",
        "is_read": true,
        "action_data": {
          "quiz_attempt_id": 156,
          "score": 85,
          "passed": true
        },
        "created_at": "2025-07-15T10:15:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 8,
      "total_items": 156,
      "per_page": 20
    }
  }
}
```

**States**
- **Loading:** Shimmer list with child avatar placeholders.
- **Empty — All Children:** Illustration of bell. "No notifications yet. You'll be notified about your children's activities."
- **Empty — Specific Child:** "No notifications for {child_name}."
- **All Read:** Blue dots removed. "Mark All" button hidden.
- **Error:** "Unable to load notifications." Button: "Retry".

---

### 4.16 Screen: Add Child (Link New Child)

**Purpose**
Allow an existing parent to link an additional child to their account.

**UI Components**
- Title: "Add a Child" (Cairo Bold 22sp)
- Description: "Enter your child's phone number or student code to link their account." (Cairo Regular 15sp)
- Toggle: "Phone Number" / "Student Code"
- Input field (phone or code)
- "Find Student" button
- Result preview (masked name, grade, tenant)
- Relationship dropdown (Father / Mother / Guardian / Other)
- "Link Child" button (primary)
- Linked children list below (with unlink option)

**Features**
- Same student lookup as registration Step 1
- Relationship selection per child
- Immediate feedback on student found/not found

**Navigation**
| Action | Destination |
|---|---|
| Link success (auto-verified) | Home Dashboard (new child visible in switcher) |
| Link success (pending) | Home Dashboard (child shown with pending badge) |
| Back | Settings / More |

**Business Rules**
- BR-PADD-01: Same student lookup rules as BR-PREG-01 through BR-PREG-10.
- BR-PADD-02: A parent can link up to 10 children.
- BR-PADD-03: A student cannot be linked to more than 2 parent accounts.
- BR-PADD-04: If the parent's phone matches the student's `parent_phone` field, the link is auto-verified.
- BR-PADD-05: Otherwise, the link enters `pending` status requiring teacher verification.
- BR-PADD-06: Duplicate links (same parent + same student) are rejected: "This child is already linked to your account."

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/v1/parent/find-student` | Look up student |
| `POST` | `/api/v1/parent/children/link` | Create parent-student link |

**Request Body — `POST /api/v1/parent/children/link`**
```json
{
  "student_id": 55,
  "relationship": "mother"
}
```

**Response Body — Success (Auto-Verified)**
```json
{
  "success": true,
  "data": {
    "link_id": 12,
    "student_id": 55,
    "student_name": "سارة",
    "relationship": "mother",
    "verified": true,
    "message": "Successfully linked! You can now monitor سارة's academic data."
  }
}
```

**Response Body — Success (Pending)**
```json
{
  "success": true,
  "data": {
    "link_id": 13,
    "student_id": 55,
    "student_name": "سارة",
    "relationship": "mother",
    "verified": false,
    "message": "Link request submitted. The teacher will verify your relationship."
  }
}
```

**States**
- **Default:** Input fields active.
- **Student Found:** Preview card with confirm button.
- **Student Not Found:** "No student found. Check the information."
- **Link Success (Verified):** Green animation. "Linked! You can now view {name}'s data."
- **Link Success (Pending):** Amber message. "Pending teacher verification."
- **Error — Already Linked:** "This child is already linked to your account."
- **Error — Max Children:** "Maximum number of linked children reached (10)."
- **Error — Max Parents:** "This student already has the maximum number of linked parents."

---

### 4.17 Screen: Linked Children Management

**Purpose**
Display all linked children with their status and allow unlinking.

**UI Components**
- Children list:
  - Each child card:
    - Profile photo (48dp, circular)
    - Full name (Cairo SemiBold 16sp)
    - Grade and tenant name
    - Student code
    - Relationship badge (Father / Mother / Guardian)
    - Link status: "Verified ✓" (green) or "Pending ⏳" (amber)
    - Linked since: date
    - "Unlink" button (red text, right side)
- "Add Child" button (bottom, primary, full width)

**Features**
- Unlink with confirmation dialog
- Visual distinction between verified and pending links

**Displayed Data**
| Field | Source |
|---|---|
| Children | `GET /api/v1/parent/children` → `parent_students` joined with `users` |

**Navigation**
| Action | Destination |
|---|---|
| Tap "Add Child" | Add Child Screen |
| Tap child card | Home Dashboard (child auto-selected) |
| Back | More / Settings |

**Business Rules**
- BR-PLCM-01: Unlinking removes the `parent_students` record. The parent loses all access to the child's data immediately.
- BR-PLCM-02: Unlink confirmation dialog: "Are you sure you want to unlink {child_name}? You will no longer be able to view their academic data." Buttons: "Cancel" / "Unlink" (red).
- BR-PLCM-03: If the parent unlinks their last child, they are redirected to Add Child Screen on next app launch.
- BR-PLCM-04: Unlinking does not affect the student's account in any way.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children` | Fetch all linked children |
| `DELETE` | `/api/v1/parent/children/{student_id}/unlink` | Remove parent-student link |

**States**
- **Loading:** Shimmer list.
- **Single Child:** Unlink button shown with warning that it will remove all monitoring access.
- **Multiple Children:** Full list with individual unlink buttons.
- **Unlink Success:** Toast: "{name} has been unlinked." List refreshes.
- **Error:** "Unable to load children." Button: "Retry".

---

### 4.18 Screen: Announcements Archive

**Purpose**
Display all announcements from the active child's tenant, filtered by the child's grade, center, and group.

**UI Components**
- Search bar
- Filter: "Pinned" toggle
- Announcement list (vertical, infinite scroll):
  - Each announcement:
    - Pinned indicator (📌 icon, if pinned)
    - Title (Cairo SemiBold 16sp)
    - Preview (first 100 chars, Cairo Regular 14sp, 60% opacity)
    - Image thumbnail (if `image_url` present)
    - Date (relative)
    - Priority indicator (high priority: red accent bar)
  - Tappable → Announcement Detail

**Announcement Detail (Full Screen or Bottom Sheet)**
- Title (Cairo Bold 20sp)
- Published date
- Full content (rich text)
- Image (full width, if present)
- "Shared by: {tenant_name}" footer

**Displayed Data**
| Field | Source |
|---|---|
| Announcements | `GET /api/v1/parent/children/{student_id}/announcements?search={q}&pinned={bool}&page={n}` |

**Navigation**
| Action | Destination |
|---|---|
| Tap announcement | Announcement Detail |
| Back | Home or More |

**Business Rules**
- BR-PANN-01: Announcements filtered by child's `grade_id`, `center_id`, `center_group_id` and `target_type` matching logic (same as student BR-HOME-03).
- BR-PANN-02: Only announcements with `status = 'published'` and `publish_at ≤ NOW()` and (`expire_at IS NULL OR expire_at ≥ NOW()`) are shown.
- BR-PANN-03: Pinned announcements appear first regardless of sort order.
- BR-PANN-04: Default sort: `is_pinned DESC, priority DESC, created_at DESC`.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/children/{student_id}/announcements?search={q}&pinned={bool}&page={n}&limit=20` | Fetch announcements |

**States**
- **Loading:** Shimmer list.
- **Empty:** "No announcements from your child's teacher."
- **Error:** "Unable to load announcements." Button: "Retry".

---

### 4.19 Screen: WhatsApp Groups (Parent)

**Purpose**
Display WhatsApp group invite links relevant to the parent of the active child.

**UI Components**
- Group list:
  - Each group card:
    - WhatsApp icon (green)
    - Group name
    - Targeting badge: "Parents Group" / "Grade Group"
    - "Join Group" button (green, opens WhatsApp)

**Displayed Data**
| Field | Source |
|---|---|
| Groups | `GET /api/v1/parent/children/{student_id}/whatsapp-groups` |

**Business Rules**
- BR-PWA-01: Shows groups matching child's `grade_id`, `center_id`, or `center_group_id`.
- BR-PWA-02: Only `is_active = true` groups displayed.
- BR-PWA-03: Parent-specific groups may be configured by the teacher (future feature — currently shows same groups as student).

**States**
- **Loading:** Shimmer.
- **Empty:** "No WhatsApp groups available."
- **Error:** "Unable to load groups." Button: "Retry".

---

### 4.20 Screen: Parent Profile

**Purpose**
Display and allow editing of the parent's own profile information.

**UI Components**
- Profile photo (100dp, circular, editable)
- Full name (Cairo Bold 22sp)
- Information cards:
  - Phone number (read-only)
  - Email (editable)
  - Relationship to children (per child)
  - Account creation date
- "Change Password" button
- "Edit Profile" button → inline editing

**Features**
- Direct profile editing (unlike students who require edit requests)
- Profile photo upload

**Navigation**
| Action | Destination |
|---|---|
| "Change Password" | Change Password Screen |
| Back | More tab |

**Business Rules**
- BR-PPRF-01: Parents can directly edit their own profile (name, email, photo) without teacher approval.
- BR-PPRF-02: Phone number changes require OTP verification of the new number.
- BR-PPRF-03: Phone number must remain unique.
- BR-PPRF-04: Profile updates are immediately reflected.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/profile` | Fetch parent profile |
| `PUT` | `/api/v1/parent/profile` | Update parent profile |
| `POST` | `/api/v1/upload/image` | Upload profile photo |

**Request Body — `PUT /api/v1/parent/profile`**
```json
{
  "first_name": "محمد",
  "last_name": "علي حسن",
  "email": "mohamed.ali@example.com",
  "profile_photo_url": "https://cdn.mentorx.com/uploads/parents/photo.jpg"
}
```

**States**
- **Default:** Profile displayed with edit options.
- **Editing:** Fields become editable; "Save" button appears.
- **Saving:** Spinner on save button.
- **Success:** Toast: "Profile updated successfully."
- **Error:** "Unable to update profile." Button: "Retry".

---

### 4.21 Screen: Settings (Parent)

**Purpose**
Allow the parent to configure application preferences, notification settings, and account management.

**UI Components**

**Preferences Section**
- Language: Arabic / English toggle
- Theme: Light / Dark / System Default

**Notification Preferences Section**
- Push Notifications: Global toggle (on/off)
- Per-category toggles:
  - Attendance alerts (absent/late): Toggle (default: ON)
  - Grade notifications: Toggle (default: ON)
  - Assignment deadlines: Toggle (default: ON)
  - Payment confirmations: Toggle (default: ON)
  - Announcements: Toggle (default: ON)
  - System notifications: Toggle (default: ON)
- Per-child notification toggles (if multiple children):
  - "{Child 1 name}": Toggle (default: ON)
  - "{Child 2 name}": Toggle (default: ON)

**Account Section**
- Change Password → Change Password Screen
- Linked Children → Linked Children Management Screen

**Support Section**
- Help & FAQ → WebView
- Contact Support → WhatsApp or email
- Terms of Service → WebView
- Privacy Policy → WebView

**App Info**
- Version: "{version} (build {number})"
- "Check for Updates"

**Danger Zone**
- "Logout" button (red text)

**Features**
- Settings persist locally and sync to server
- Language change triggers full app reload
- Notification toggles update server-side preferences
- Per-child notification control

**Navigation**
| Action | Destination |
|---|---|
| Change Password | Change Password Screen |
| Linked Children | Linked Children Management Screen |
| Logout | Login Screen |

**Business Rules**
- BR-PSET-01: Language and theme stored in `user_settings.language` and `user_settings.theme`.
- BR-PSET-02: Notification preferences stored in `user_settings.preferences` JSON field with per-category and per-child controls.
- BR-PSET-03: Disabling per-child notifications stops push delivery for that child's events but notifications are still visible in-app.
- BR-PSET-04: Absence/late notifications are ON by default and prominently recommended to remain ON.
- BR-PSET-05: Logout clears: tokens, cached data, FCM association. Retains: language, theme, onboarding flag.
- BR-PSET-06: Logout revokes refresh token server-side.

**API Requirements**
| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/api/v1/parent/settings` | Fetch current settings |
| `PUT` | `/api/v1/parent/settings` | Update settings |
| `POST` | `/api/v1/auth/logout` | Revoke refresh token |
| `POST` | `/api/v1/auth/change-password` | Change password |

**Request Body — `PUT /api/v1/parent/settings`**
```json
{
  "language": "ar",
  "theme": "light",
  "push_notifications": true,
  "notification_preferences": {
    "attendance_alerts": true,
    "grade_notifications": true,
    "assignment_deadlines": true,
    "payment_confirmations": true,
    "announcements": true,
    "system": true,
    "per_child": {
      "42": true,
      "55": true
    }
  }
}
```

**States**
- **Default:** All settings shown with current values.
- **Saving:** Individual toggle shows loading.
- **Logout Confirmation:** Dialog: "Are you sure you want to logout?" Buttons: "Cancel" / "Logout" (red).
- **Error:** Toast: "Unable to save settings."

---

## 5. User Flows

### UF-01: First-Time Parent Registration and Child Linking

```
1. Parent launches app for the first time
2. Splash Screen → detects first launch
3. → Onboarding Screens (3 pages)
4. Parent taps "Get Started"
5. → Login Screen
6. Parent taps "Don't have an account? Register"
7. → Registration Screen — Step 1: Child Identification
8. Parent toggles to "Phone Number" mode
9. Parent enters child's registered phone number
10. Parent taps "Find Student"
11. System looks up student by phone
12. [If found]: masked student preview shown (name, grade, tenant)
13. Parent confirms: "This is my child"
14. → Step 2: Parent Information
15. Parent fills: name, phone, email, relationship
16. System validates parent phone uniqueness (async)
17. Parent taps "Next"
18. → Step 3: Security
19. Parent creates password
20. Parent taps "Submit"
21. System creates parent account + parent_students link
22. OTP sent to parent's phone
23. → OTP Verification Screen
24. Parent enters OTP
25. [If parent phone matches student's parent_phone]:
    25a. Link auto-verified (verified_at = NOW())
    25b. → Home Dashboard (child data accessible)
26. [If parent phone does NOT match]:
    26a. Link status = pending
    26b. → Home Dashboard (child shown with "Pending" badge)
    26c. Teacher receives notification to verify relationship
    26d. [When teacher verifies]: parent receives notification
    26e. Child data becomes accessible
```

### UF-02: Returning Parent Login

```
1. Parent launches app
2. Splash Screen → checks stored token
3. [If valid token + has verified children]:
   3a. Pre-fetch children list
   3b. Auto-select last viewed child
   3c. → Home Dashboard
4. [If expired token]: attempt refresh
   4a. [Success]: → Home Dashboard
   4b. [Failure]: → Login Screen
5. [If no token]: → Login Screen
6. Parent enters phone and password
7. Parent taps "Login"
8. [If success]:
   8a. Tokens issued
   8b. Children list fetched
   8c. [If children exist]: → Home Dashboard
   8d. [If no children]: → Add Child Screen
9. [If failure]: error message displayed
```

### UF-03: Monitoring Child's Attendance After Absence Notification

```
1. Parent receives push notification: "أحمد was marked absent in Physics"
2. Parent taps notification
3. App opens → auto-switches to أحمد as active child
4. → Attendance Monitor (filtered to today's date)
5. Parent sees absence record:
   - Session: Physics - Lecture 15
   - Status: Absent (red badge)
   - Time: 2:00 PM - 3:30 PM
   - No check-in recorded
6. Parent reviews attendance summary:
   - Attendance rate: 85% (amber, dropped from 90%)
   - Total absences this month: 3
7. Parent checks calendar view for pattern:
   - Identifies absences were all on Wednesdays
8. Parent taps WhatsApp groups → contacts teacher
```

### UF-04: Reviewing Child's Quiz Results

```
1. Parent receives notification: "أحمد scored 72% on Chemistry Quiz 4"
2. Parent taps notification
3. → Quiz Grade Detail Screen (child auto-selected)
4. Parent sees:
   - Score: 72/100 (72%)
   - Status: Passed ✓ (pass threshold: 50%)
   - Time spent: 22 minutes (out of 30)
   - Attempt: 1 of 2
5. [If teacher allows parent view]:
   5a. Parent sees question breakdown:
       - Q1: ✓ 5/5
       - Q2: ✗ 0/5
       - Q3: ✓ 5/5
       - (Question text not shown)
6. Parent navigates to Grade Monitor
7. Reviews overall trend: average dropped 3% this month
8. Reviews performance by course: Chemistry lowest at 68% average
9. Parent decides to discuss study strategy with child
```

### UF-05: Monitoring Multiple Children

```
1. Parent logs in (has 2 children: أحمد in Physics, سارة in Math)
2. Home Dashboard shows أحمد's data (last viewed child)
3. Parent reviews أحمد's summary:
   - Progress: 65%, Attendance: 90%, Average Grade: 78%
4. Parent taps child switcher dropdown
5. Selects سارة
6. All dashboard sections reload with سارة's data:
   - Progress: 80%, Attendance: 95%, Average Grade: 85%
7. Parent navigates to Grades tab → sees سارة's assessments
8. Parent taps back to Home → data remains on سارة
9. Parent receives notification for أحمد
10. Taps notification → app auto-switches to أحمد
11. Returns to Home → أحمد is now active child
```

### UF-06: Tracking Child's Financial Activity

```
1. Parent navigates: Wallet tab or Quick Action → Financial Monitor
2. Sees أحمد's wallet:
   - Balance: EGP 50
   - Spent this month: EGP 350
3. Parent reviews spending chart:
   - Highest month: March (EGP 500 — multiple course purchases)
   - Current month: EGP 350
4. Parent checks category breakdown:
   - Courses: EGP 300
   - Marketplace: EGP 50
5. Parent scrolls transaction history:
   - Jul 15: -EGP 100 (Course: Chemistry Term 2)
   - Jul 12: +EGP 200 (Wallet Top Up - Vodafone Cash)
   - Jul 10: -EGP 50 (Marketplace: Study Notebook)
   - Jul 5: +EGP 100 (Code Redemption: PHYSICS100)
6. Parent identifies spending patterns and decides to discuss budget
```

### UF-07: Adding a Second Child

```
1. Parent navigates: More → Linked Children → "Add Child"
2. → Add Child Screen
3. Parent enters second child's student code: "MAT-2025-00089"
4. Taps "Find Student"
5. System finds: سارة (Grade 2, Math Academy)
6. Parent confirms: "This is my child"
7. Parent selects relationship: "Mother"
8. Parent taps "Link Child"
9. [If auto-verification passes]: link verified immediately
10. → Home Dashboard
11. Child switcher now shows 2 children: أحمد, سارة
12. Parent can switch between children with one tap
```

---

## 6. Functional Requirements

### 6.1 Authentication & Account Management

| ID | Requirement | Priority |
|---|---|---|
| **PFR-01** | The system shall allow parents to register by identifying a child (via phone or student code), providing personal information, selecting a relationship type, and creating a secure password. | Critical |
| **PFR-02** | The system shall look up students by phone number or student code during registration and display privacy-masked preview information. | Critical |
| **PFR-03** | The system shall validate parent phone number uniqueness across the platform. | Critical |
| **PFR-04** | The system shall enforce that parent phone differs from child phone. | High |
| **PFR-05** | The system shall send OTP to parent phone for verification during registration and password reset. | Critical |
| **PFR-06** | The system shall create parent-student links with automatic verification when parent phone matches student's `parent_phone` field. | Critical |
| **PFR-07** | The system shall route unverifiable parent-student links to pending status requiring teacher approval. | High |
| **PFR-08** | The system shall authenticate parents using phone and password with JWT token management. | Critical |
| **PFR-09** | The system shall support biometric login after initial password authentication. | Medium |
| **PFR-10** | The system shall lock accounts after 5 consecutive failed attempts for 15 minutes. | High |
| **PFR-11** | The system shall support password reset via phone OTP flow. | High |
| **PFR-12** | The system shall allow parents to directly edit their own profile (name, email, photo) without teacher approval. | Medium |
| **PFR-13** | The system shall require OTP verification for parent phone number changes. | High |
| **PFR-14** | The system shall revoke tokens and clear data on logout. | Critical |

### 6.2 Child Linking & Management

| ID | Requirement | Priority |
|---|---|---|
| **PFR-15** | The system shall allow parents to link up to 10 children to their account. | High |
| **PFR-16** | The system shall enforce a maximum of 2 parent accounts per student. | High |
| **PFR-17** | The system shall prevent duplicate parent-student links. | High |
| **PFR-18** | The system shall display all linked children with verification status (verified/pending). | Critical |
| **PFR-19** | The system shall only allow data access for verified child links (`verified_at IS NOT NULL`). | Critical |
| **PFR-20** | The system shall allow parents to unlink children with confirmation dialog. | Medium |
| **PFR-21** | The system shall redirect parents with no linked children to the Add Child screen. | High |
| **PFR-22** | The system shall notify the child's phone when a parent link is established. | Medium |
| **PFR-23** | The system shall support children across different tenants under a single parent account. | High |

### 6.3 Child Switching

| ID | Requirement | Priority |
|---|---|---|
| **PFR-24** | The system shall provide a global child switcher component visible on all main screens. | Critical |
| **PFR-25** | The system shall refresh all on-screen data when the active child is changed. | Critical |
| **PFR-26** | The system shall persist the last selected child in local storage. | Medium |
| **PFR-27** | The system shall auto-switch to the relevant child when a child-specific notification is tapped. | High |
| **PFR-28** | The system shall display unverified children with "Pending" badge and prevent data access. | High |
| **PFR-29** | The system shall switch API tenant context automatically based on the selected child's `tenant_id`. | Critical |

### 6.4 Home Dashboard

| ID | Requirement | Priority |
|---|---|---|
| **PFR-30** | The system shall display a child summary card showing name, grade, overall progress, attendance rate, wallet balance, and points. | Critical |
| **PFR-31** | The system shall display quick statistics cards (courses, average grade, attendance, wallet) with tap navigation. | High |
| **PFR-32** | The system shall display a combined chronological activity feed from grades, attendance, course progress, and financial events. | High |
| **PFR-33** | The system shall display grade trend indicators (up/down/stable) compared to the previous month. | Medium |
| **PFR-34** | The system shall display recent announcements filtered by child's grade, center, and group. | Medium |
| **PFR-35** | The system shall auto-refresh dashboard data every 5 minutes when in foreground. | Medium |
| **PFR-36** | The system shall load each dashboard section independently; section failures shall not block other sections. | High |

### 6.5 Academic Monitoring

| ID | Requirement | Priority |
|---|---|---|
| **PFR-37** | The system shall display all courses the child is enrolled in with progress percentages and session completion counts. | Critical |
| **PFR-38** | The system shall categorize courses as In Progress, Completed, or Expired. | High |
| **PFR-39** | The system shall display session-level progress breakdown within each course. | High |
| **PFR-40** | The system shall display content item completion status (completed/in progress/not started/locked) without revealing actual content. | High |
| **PFR-41** | The system shall display learning activity timeline (what the child accessed and when). | Medium |
| **PFR-42** | The system shall display time spent analytics (weekly study time, daily averages). | Medium |
| **PFR-43** | The system shall display course expiry warnings when access is within 7 days of expiration. | Medium |

### 6.6 Grade Monitoring

| ID | Requirement | Priority |
|---|---|---|
| **PFR-44** | The system shall display overall grade average with color coding and trend indication. | Critical |
| **PFR-45** | The system shall display grade distribution chart (Excellent/Good/Average/Below Average). | High |
| **PFR-46** | The system shall display monthly performance trend line chart (last 6 months). | High |
| **PFR-47** | The system shall display all assessments (quizzes and assignments) with scores, pass/fail status, and dates. | Critical |
| **PFR-48** | The system shall support filtering assessments by course and type (quiz/assignment). | High |
| **PFR-49** | The system shall display quiz results including score, percentage, time spent, and attempt number. | High |
| **PFR-50** | The system shall display question-level accuracy indicators (correct/incorrect per question number) only when teacher configuration allows parent access. | Medium |
| **PFR-51** | The system shall never display actual quiz questions, answer options, or correct answers to parents. | Critical |
| **PFR-52** | The system shall display assignment submission status, score, teacher feedback, and late indicators. | High |
| **PFR-53** | The system shall not allow parents to download student-submitted assignment files. | High |
| **PFR-54** | The system shall use the best attempt score for quizzes with multiple attempts in average calculations. | Medium |

### 6.7 Attendance Monitoring

| ID | Requirement | Priority |
|---|---|---|
| **PFR-55** | The system shall display attendance summary statistics (total, present, late, absent, excused) with rate calculations. | Critical |
| **PFR-56** | The system shall display a color-coded calendar view of attendance records. | High |
| **PFR-57** | The system shall display detailed attendance records grouped by date with session details. | High |
| **PFR-58** | The system shall support date range and course/center filtering on attendance data. | Medium |
| **PFR-59** | The system shall calculate and display attendance rate and punctuality rate separately. | Medium |
| **PFR-60** | The system shall show the worst status for days with multiple sessions in calendar view. | Medium |
| **PFR-61** | The system shall display check-in times and late arrival details. | Medium |
| **PFR-62** | The system shall display teacher notes on attendance records when available. | Low |

### 6.8 Financial Monitoring

| ID | Requirement | Priority |
|---|---|---|
| **PFR-63** | The system shall display the child's current wallet balance and points total. | Critical |
| **PFR-64** | The system shall display monthly spending summaries and trends. | High |
| **PFR-65** | The system shall display spending category breakdown (courses, marketplace, other). | Medium |
| **PFR-66** | The system shall display complete transaction history with type, amount, balance, and date. | Critical |
| **PFR-67** | The system shall support filtering transactions by type and date range. | Medium |
| **PFR-68** | The system shall display payment records with method, status, and reference details. | High |
| **PFR-69** | The system shall not allow parents to initiate wallet top-ups, payments, or transfers. | Critical |

### 6.9 Communication & Notifications

| ID | Requirement | Priority |
|---|---|---|
| **PFR-70** | The system shall deliver push notifications for all linked verified children's events. | Critical |
| **PFR-71** | The system shall attribute each notification to a specific child with name and avatar. | Critical |
| **PFR-72** | The system shall auto-switch active child when a child-specific notification is tapped. | High |
| **PFR-73** | The system shall support filtering notifications by child. | High |
| **PFR-74** | The system shall priority-highlight absence notifications with red visual treatment. | High |
| **PFR-75** | The system shall support "Mark as Read" and "Mark All as Read" operations. | Medium |
| **PFR-76** | The system shall display unread notification count badge on the tab icon for all children combined. | High |
| **PFR-77** | The system shall display announcements from child's tenant filtered by grade, center, and group. | Medium |
| **PFR-78** | The system shall display WhatsApp group invite links relevant to the child's class. | Medium |

### 6.10 Settings & Preferences

| ID | Requirement | Priority |
|---|---|---|
| **PFR-79** | The system shall support language switching between Arabic and English with RTL/LTR adaptation. | High |
| **PFR-80** | The system shall support theme switching (Light/Dark/System). | Medium |
| **PFR-81** | The system shall allow per-category notification preference configuration. | Medium |
| **PFR-82** | The system shall allow per-child notification preference configuration. | Medium |
| **PFR-83** | The system shall support secure password change. | High |
| **PFR-84** | The system shall support secure logout with server-side token revocation. | Critical |

---

## 7. Non-Functional Requirements

### 7.1 Performance

| ID | Requirement | Target |
|---|---|---|
| **PNFR-01** | API response time for monitoring data | 95th percentile ≤ 2 seconds |
| **PNFR-02** | Dashboard initial load (all sections) | ≤ 3 seconds on 4G |
| **PNFR-03** | Child switching data reload | ≤ 2 seconds for all visible sections |
| **PNFR-04** | Chart rendering time | ≤ 1 second |
| **PNFR-05** | App cold start | ≤ 3 seconds |
| **PNFR-06** | Notification delivery latency | ≤ 5 seconds from server trigger |
| **PNFR-07** | App memory usage | ≤ 200MB RAM (lighter than student app) |
| **PNFR-08** | App installation size | ≤ 35MB |

### 7.2 Security

| ID | Requirement | Implementation |
|---|---|---|
| **PNFR-09** | All network communication via HTTPS with TLS 1.2+ | Dio with certificate configuration |
| **PNFR-10** | JWT access tokens expire after 15 minutes; refresh tokens after 7 days | Token rotation on refresh |
| **PNFR-11** | Passwords hashed with bcrypt (cost factor 12) server-side | Never plaintext |
| **PNFR-12** | Tokens stored in platform-secure storage | flutter_secure_storage |
| **PNFR-13** | Parent can only access data for verified linked children | Server-side enforcement via `parent_students.verified_at` check |
| **PNFR-14** | Cross-child data isolation: parent API endpoints validate `student_id` against `parent_students` | Middleware validation |
| **PNFR-15** | Account lockout after 5 failed attempts | Server-side rate limiting |
| **PNFR-16** | No actual educational content (video, PDF) accessible to parents | API does not return content URLs for parent role |
| **PNFR-17** | No student-submitted files accessible to parents | API does not return file URLs for parent role |
| **PNFR-18** | Sensitive data not logged in debug output | Custom log filters |
| **PNFR-19** | Parent-student link verification required before data access | Database-level enforcement |

### 7.3 Reliability & Availability

| ID | Requirement | Target |
|---|---|---|
| **PNFR-20** | Backend API uptime | ≥ 99.5% monthly |
| **PNFR-21** | Push notification delivery reliability | ≥ 98% |
| **PNFR-22** | Data freshness (cache TTL) | 5 minutes for dashboard, 10 minutes for historical data |
| **PNFR-23** | Offline graceful degradation | Cached summaries viewable offline with "Offline" banner |
| **PNFR-24** | App crash rate | ≤ 0.3% of sessions |
| **PNFR-25** | Section-independent failure handling | Individual section retry without full-screen errors |

### 7.4 Scalability

| ID | Requirement | Target |
|---|---|---|
| **PNFR-26** | Concurrent parent users | ≥ 5,000 |
| **PNFR-27** | Children per parent | Up to 10 |
| **PNFR-28** | Notification throughput | Support batch delivery for 10,000+ parents simultaneously |

### 7.5 Usability

| ID | Requirement | Implementation |
|---|---|---|
| **PNFR-29** | Arabic as primary language with full RTL layout | Cairo font, Directionality widget |
| **PNFR-30** | Core features accessible within 2 taps from home | Simplified navigation |
| **PNFR-31** | Minimum touch target 48x48dp | Material Design compliance |
| **PNFR-32** | Color-coded data (green/amber/red) for instant comprehension | Consistent color system |
| **PNFR-33** | Large readable fonts for summary data (≥ 16sp for values) | Typography scale |
| **PNFR-34** | Shimmer loading, inline errors with retry, contextual empty states | Standardized UX patterns |
| **PNFR-35** | Responsive layouts for phones and tablets | MediaQuery-based breakpoints |
| **PNFR-36** | WCAG 2.1 AA color contrast compliance | 4.5:1 minimum ratio |

### 7.6 Compatibility

| ID | Requirement | Target |
|---|---|---|
| **PNFR-37** | Minimum Android: 8.0 (API 26) | — |
| **PNFR-38** | Minimum iOS: 14.0 | — |
| **PNFR-39** | Screen sizes: 4.7" to 12.9" | — |
| **PNFR-40** | Portrait orientation primary | — |
| **PNFR-41** | Network: Wi-Fi, 3G, 4G, 5G with graceful degradation | — |

### 7.7 Accessibility

| ID | Requirement | Implementation |
|---|---|---|
| **PNFR-42** | Semantic labels on all images and icons | Flutter Semantics |
| **PNFR-43** | Form fields with accessible labels and error descriptions | InputDecoration ARIA |
| **PNFR-44** | Respect system font size settings | textScaleFactor-aware |
| **PNFR-45** | Haptic feedback on significant interactions | HapticFeedback API |

---

## 8. Data Model Overview

### 8.1 Core Entities (Parent Perspective)

```
┌─────────────────────────────────────────────────────────────┐
│                    PARENT DATA MODEL                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐                                           │
│  │    User      │                                           │
│  │   (Parent)   │                                           │
│  │              │                                           │
│  │  - id        │                                           │
│  │  - name      │                                           │
│  │  - phone     │                                           │
│  │  - email     │                                           │
│  │  - role:     │                                           │
│  │    parent    │                                           │
│  └──────┬───────┘                                           │
│         │                                                   │
│         │ parent_students (1:N)                              │
│         │   - relationship (father/mother/guardian/other)    │
│         │   - verified_at                                   │
│         │                                                   │
│         ▼                                                   │
│  ┌──────────────┐     ┌───────────────────────────────────┐│
│  │    User      │     │  DATA ACCESSIBLE (Read-Only)      ││
│  │  (Student)   │────>│                                   ││
│  │  [Child 1]   │     │  student_courses (progress)       ││
│  │              │     │  student_progress (per item)       ││
│  │  tenant_id=1 │     │  quiz_attempts (scores)           ││
│  └──────────────┘     │  quiz_responses (accuracy only)   ││
│                       │  assignment_submissions (grades)   ││
│  ┌──────────────┐     │  attendance_records (status)       ││
│  │    User      │     │  wallet_transactions (amounts)     ││
│  │  (Student)   │────>│  payments (records)                ││
│  │  [Child 2]   │     │  notifications (events)            ││
│  │              │     │  announcements (filtered)          ││
│  │  tenant_id=2 │     │                                   ││
│  └──────────────┘     │  NOT ACCESSIBLE:                  ││
│                       │  - Content URLs (video, PDF)       ││
│                       │  - Quiz questions/answers          ││
│                       │  - Submitted file downloads        ││
│                       │  - AI conversations                ││
│                       │  - Reward claims                   ││
│                       │  - Marketplace orders              ││
│                       └───────────────────────────────────┘│
│                                                             │
│  ┌──────────────────────────────────────┐                   │
│  │  PARENT-OWNED DATA                   │                   │
│  │                                      │                   │
│  │  user_roles (parent role)            │                   │
│  │  user_settings (preferences)         │                   │
│  │  notifications (parent-specific)     │                   │
│  │  devices (registered devices)        │                   │
│  │  refresh_tokens (sessions)           │                   │
│  │  login_logs (audit)                  │                   │
│  └──────────────────────────────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 8.2 Key Entity Cardinalities

| Relationship | Cardinality | Constraint |
|---|---|---|
| Parent → Children (Students) | 1:N (max 10) | Via `parent_students` junction |
| Student → Parents | N:M (max 2 parents) | Via `parent_students` junction |
| Parent → Notifications | 1:N | Notifications for all linked children |
| Parent → User Settings | 1:1 | Preferences and notification config |
| Parent → Devices | 1:N (limit 3) | Less strict than student binding |
| Parent → Tenants | Indirect (via children) | No direct tenant association |

### 8.3 API Access Pattern

All parent data access follows a consistent pattern:

```
/api/v1/parent/children/{student_id}/{resource}
```

Server-side middleware enforces:
1. Authenticated parent (`user_roles.role = 'parent'`)
2. Valid parent-student link (`parent_students` exists)
3. Link is verified (`verified_at IS NOT NULL`)
4. Resource access appropriate for parent role (no content URLs, no file downloads)

---

## 9. Assumptions & Open Questions

### 9.1 Assumptions

| ID | Assumption | Impact |
|---|---|---|
| **PA-01** | Parents have access to their child's phone number or student code for initial linking. | Registration flow design |
| **PA-02** | Parents have personal smartphones with Android 8.0+ or iOS 14.0+. | Minimum OS compatibility |
| **PA-03** | Parents have active Egyptian mobile phone numbers for OTP. | Authentication flow |
| **PA-04** | Primary language is Arabic; parents may have low technical literacy. | UX simplicity, large text, color coding |
| **PA-05** | Teachers will verify unrecognized parent-student links within 48 hours. | Link pending state duration |
| **PA-06** | Parents do not need access to actual educational content (videos, PDFs). | Read-only metadata model |
| **PA-07** | Parent accounts are not tenant-specific; they inherit tenant context from children. | Multi-tenant support for parents |
| **PA-08** | Parents check the app 1-3 times daily, primarily after receiving notifications. | Caching and data freshness strategy |
| **PA-09** | FCM push notifications are reliably delivered to parent devices. | Primary communication channel |
| **PA-10** | The student app and parent app share the same backend API with role-based response filtering. | API design consistency |
| **PA-11** | Parents may have children registered with different teachers (tenants). | Cross-tenant child management |
| **PA-12** | Student data visible to parents is the same as what teachers can see, minus content and files. | Data access scope |

### 9.2 Open Questions

| ID | Question | Required Decision By | Impact |
|---|---|---|---|
| **POQ-01** | Should parents be able to initiate wallet top-ups for their children? This would add financial capability beyond read-only monitoring. | Product Owner | Financial module scope, payment integration |
| **POQ-02** | Should parents receive notifications for positive events (quiz passed, attendance streak) in addition to negative events (absence, low grade)? If so, what is the default configuration? | Product Owner | Notification volume, engagement strategy |
| **POQ-03** | Should parents have a direct messaging channel to the teacher within the app, or is WhatsApp integration sufficient? | Product Owner | Communication module scope |
| **POQ-04** | When a parent has children in different tenants, should the app display data from all tenants simultaneously or require switching? Current design requires switching via child selector. | Product Owner | Dashboard aggregation complexity |
| **POQ-05** | Should parent access to quiz question-level breakdown be a global setting or configurable per quiz by the teacher? | Product Owner + Academic Team | Quiz detail visibility logic |
| **POQ-06** | Should the parent app support a comparative view showing performance across multiple children (e.g., attendance comparison chart)? | Product Owner | Analytics feature scope |
| **POQ-07** | What should happen when a child is deleted or blocked by the teacher? Should the parent lose all historical data access or retain read-only access to historical records? | Product Owner + Legal | Data retention policy |
| **POQ-08** | Should parents be able to request a report export (PDF) of their child's academic summary for school meetings or personal records? | Product Owner | Report generation feature |
| **POQ-09** | Should the parent receive a notification when the child enrolls in a new course or makes a wallet purchase? This provides financial transparency but may feel intrusive to the child. | Product Owner + UX Team | Notification scope, parent-child trust |
| **POQ-10** | Is there a need for a "family account" concept where multiple parents (e.g., both father and mother) can be linked and share a dashboard, or should each parent have an independent account? | Product Owner | Account architecture |
| **POQ-11** | Should the parent app include a brief onboarding tutorial overlay on first use of each major screen (e.g., "Tap here to see attendance calendar")? | UX Team | Onboarding complexity for low-literacy users |
| **POQ-12** | What is the data retention period for historical data visible to parents? Should they see all-time records or only current academic year/semester? | Product Owner + Legal | Query performance, data scope |
| **POQ-13** | Should the child be notified when a parent views their grades or attendance? Some argue this promotes transparency; others say it may cause anxiety. | Product Owner + Academic Team | Student notification scope |
| **POQ-14** | How should the system handle the scenario where a parent tries to link to a child who already has 2 linked parents? Should it show a generic "Maximum parents reached" or suggest contacting the teacher? | UX Team | Error messaging |

---

**— End of Document —**

**Document prepared for the MentorX Development Team.**
**All specifications are final draft and subject to review sign-off before implementation begins.**