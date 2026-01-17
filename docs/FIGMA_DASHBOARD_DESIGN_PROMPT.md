# MentorX Web Dashboard Design Prompt for Figma Pro AI

## Project Overview
MentorX is an AI-powered e-learning platform for high school students that integrates teachers, parents, and educational institutions. Create a modern, professional web dashboard with four distinct user interfaces: Student, Teacher, Parent, and Admin dashboards.

## Design System

### Color Palette
**Primary Colors:**
- **Platform Primary**: `#4A90E2` (Blue) - Main brand color for headers, primary buttons
- **Platform Primary Dark**: `#2E5C8A` (Dark Blue) - Borders, hover states

**Role-Specific Colors:**
- **Student**: `#50C878` (Emerald Green) with border `#2D7A4A`
- **Teacher**: `#FF6B6B` (Coral Red) with border `#C92A2A`
- **Parent**: `#FFD93D` (Golden Yellow) with border `#B8860B`
- **Admin**: `#A28BFE` (Purple) with border `#6C5CE7`

**Functional Colors:**
- **Success**: `#28A745` (Green)
- **Warning**: `#FFC107` (Amber)
- **Error**: `#DC3545` (Red)
- **Info**: `#17A2B8` (Cyan)

**Neutral Colors:**
- **Background**: `#F8F9FA` (Light Gray)
- **Card Background**: `#FFFFFF` (White)
- **Text Primary**: `#212529` (Dark Gray)
- **Text Secondary**: `#6C757D` (Medium Gray)
- **Border**: `#DEE2E6` (Light Gray)

### Typography
- **Primary Font**: Inter, system-ui, sans-serif
- **Heading Font**: Poppins (for dashboard titles)
- **Code Font**: JetBrains Mono (for technical content)

**Font Sizes:**
- H1 (Page Title): 32px, Bold
- H2 (Section Header): 24px, Semi-Bold
- H3 (Card Title): 18px, Semi-Bold
- Body: 14px, Regular
- Small: 12px, Regular
- Caption: 10px, Regular

### Spacing System
Use 8px grid system:
- xs: 4px
- sm: 8px
- md: 16px
- lg: 24px
- xl: 32px
- 2xl: 48px

### Border Radius
- Small (buttons, tags): 4px
- Medium (cards, inputs): 8px
- Large (modals): 12px
- Round (avatars): 50%

### Shadows
- Small: `0 1px 3px rgba(0,0,0,0.1)`
- Medium: `0 4px 6px rgba(0,0,0,0.1)`
- Large: `0 10px 25px rgba(0,0,0,0.15)`

---

## 1. Student Dashboard

### Layout Structure
**Sidebar Navigation (Left, 240px width):**
- Logo at top
- Navigation items:
  - 📚 My Courses (with count badge)
  - 📊 Progress
  - 📝 Assignments (with pending count)
  - 🎯 Quizzes
  - 🏆 Rewards & Leaderboard
  - 💬 AI Chatbot
  - 📱 Notifications (with unread count)
  - ⚙️ Settings
- User profile card at bottom with avatar, name, points display

**Top Bar (60px height):**
- Breadcrumb navigation
- Search bar (center)
- Points indicator with icon (🌟 1,250 pts)
- Notification bell icon (with red dot if unread)
- User avatar dropdown

**Main Content Area:**
Responsive grid layout with cards

### Key Components

#### 1. Dashboard Home View
**Stats Cards Row (4 cards):**
1. **Enrolled Courses**
   - Large number (e.g., "8")
   - Small text "Active Courses"
   - Icon: 📚
   - Background: Light blue gradient

2. **Completion Rate**
   - Large percentage (e.g., "68%")
   - Progress ring chart
   - Small text "Course Progress"
   - Icon: 📊
   - Background: Light green gradient

3. **Points Earned**
   - Large number (e.g., "1,250")
   - Small text "Total Points"
   - Icon: 🌟
   - Background: Light yellow gradient

4. **Assignments Due**
   - Large number (e.g., "5")
   - Small text "Pending Tasks"
   - Icon: 📝
   - Background: Light orange gradient
   - Red badge if overdue

**Active Courses Section:**
- Grid of course cards (3 columns on desktop)
- Each card shows:
  - Course thumbnail image (16:9 aspect ratio)
  - Subject badge (top-left corner)
  - Course title
  - Teacher name with small avatar
  - Progress bar with percentage
  - "Continue Learning" button (primary color)
  - Three-dot menu (top-right)

**Recent Activity Timeline:**
- Left-aligned timeline with color-coded events:
  - Green: Assignment completed
  - Blue: Quiz taken
  - Yellow: New lesson unlocked
  - Red: Missed session
- Each item shows: icon, action text, timestamp

**Upcoming Sessions Widget:**
- List of next 3 sessions
- Each shows: date/time, course name, session type (Online/Center), join button

#### 2. My Courses View
**Filters Bar:**
- Dropdown: All Grades / Grade 10 / Grade 11 / Grade 12
- Dropdown: All Subjects / Math / Science / English
- Dropdown: Status (All / In Progress / Completed)
- Search input

**Course Grid:**
- Responsive grid (3 columns desktop, 2 tablet, 1 mobile)
- Course cards with hover effect (slight elevation)
- Featured courses have "Featured" badge (gold border)
- Locked courses show lock icon overlay

#### 3. Progress View
**Performance Chart:**
- Line chart showing grade trends over time
- Multiple lines for different subjects (color-coded)
- Time range selector: Week / Month / Semester / Year

**Subject Performance Cards:**
- Grid of subject cards
- Each shows:
  - Subject name and icon
  - Average grade (large number with colored background)
  - Trend indicator (↑ improving / ↓ declining / → stable)
  - Mini sparkline chart
  - "View Details" link

**Achievements Section:**
- Horizontal scrollable badges gallery
- Earned badges: full color
- Locked badges: grayscale with lock icon
- Hover tooltip shows badge criteria

#### 4. Assignments View
**Tabs:**
- Pending (with count badge)
- Submitted
- Graded
- All

**Assignment Cards:**
- Card layout with:
  - Assignment title
  - Course name and subject badge
  - Due date (with warning color if soon)
  - Status badge (Not Started / In Progress / Submitted / Graded)
  - Points possible
  - "View Details" or "Submit" button

**Assignment Detail Modal:**
- Full description
- Attachments section
- File upload area (drag & drop)
- Text editor for answers
- Submit button (prominent, primary color)

#### 5. Rewards & Leaderboard View
**Two Column Layout:**

**Left Column - My Rewards:**
- Current points display (large, prominent)
- Points history graph (last 30 days)
- Available rewards carousel:
  - Each reward card shows: image, name, points cost, "Redeem" button
  - Featured reward has special border

**Right Column - Leaderboard:**
- Time period selector: Daily / Weekly / Monthly / All Time
- Scope selector: My Course / Grade Level / School Wide
- Top 3 highlighted with medals (🥇🥈🥉)
- List of remaining top 20:
  - Rank number
  - User avatar and name
  - Points
  - Trend indicator
- User's position highlighted (if not in top 20, shown separately)

#### 6. AI Chatbot View
**Chat Interface:**
- Chat history area (scrollable)
- Messages alternate left (bot) and right (user)
- Bot messages have:
  - Bot avatar (robot icon)
  - Message bubble (light blue background)
  - Timestamp
  - Helpful/Not Helpful buttons
- User messages have:
  - User avatar
  - Message bubble (primary color)
  - Timestamp
- Input area at bottom:
  - Text input field
  - Attachment button
  - Send button
- Suggested questions as chips above input

---

## 2. Teacher Dashboard

### Layout Structure
Similar sidebar + top bar layout, but Teacher color scheme (#FF6B6B)

**Sidebar Navigation:**
- 📚 My Courses
- 👥 Students
- 📊 Analytics
- ✅ Attendance
- 📝 Assignments
- 🎯 Quizzes
- 📈 Performance Reports
- 💬 Messages
- ⚙️ Settings

### Key Components

#### 1. Dashboard Home View
**Stats Cards Row (5 cards):**
1. **Total Students**
   - Large number (e.g., "324")
   - Across all courses
   - Icon: 👥

2. **Active Courses**
   - Number of ongoing courses
   - Icon: 📚

3. **Pending Grades**
   - Assignments awaiting grading
   - Red badge if overdue
   - Icon: 📝

4. **Average Performance**
   - Percentage across all students
   - Trend indicator
   - Icon: 📈

5. **Attendance Rate**
   - Weekly attendance percentage
   - Icon: ✅

**Quick Actions Section:**
- Prominent buttons:
  - "Create New Quiz" (primary button)
  - "Post Announcement" (secondary button)
  - "Upload Grades" (secondary button)
  - "View Attendance" (secondary button)

**Today's Schedule:**
- Timeline view of sessions
- Each session shows:
  - Time slot
  - Course name
  - Location (Online/Center name)
  - Student count
  - "Start Session" or "View" button

**Recent Activity Feed:**
- New student enrollments
- Assignment submissions
- Quiz completions
- Student questions
- Each with quick action button

**At-Risk Students Alert:**
- Warning card highlighting students predicted to struggle
- List with:
  - Student name and photo
  - Risk indicator (High/Medium/Low with colors)
  - Predicted issue (Low attendance / Poor grades / Missing assignments)
  - "View Details" link

#### 2. My Courses View
**Course Management Cards:**
- Each course card shows:
  - Course banner image
  - Course title and code
  - Enrollment count
  - Recent activity indicator
  - Quick stats: sessions, assignments, quizzes
  - Action buttons: Edit / Analytics / Manage Content

**Course Detail Page:**
- Tabs: Overview / Sessions / Students / Assignments / Quizzes / Analytics
- Session management table with drag-to-reorder
- "Add Session" button

#### 3. Students View
**Student Directory:**
- Filterable table or card view toggle
- Filters: Course / Grade / Performance / Status
- Each student entry shows:
  - Photo
  - Name
  - Student ID
  - Enrolled courses (tags)
  - Overall grade
  - Attendance rate
  - Last active
  - Action menu: View Profile / Message / View Progress

**Student Profile Modal:**
- Header with photo, name, contact info
- Tabs:
  - Overview: Quick stats
  - Courses: Enrollment list with grades
  - Attendance: Calendar view
  - Progress: Performance charts
  - Communications: Message history

#### 4. Analytics View
**Dashboard with Multiple Charts:**

**Top Section - Overall Metrics:**
- Time period selector
- KPI cards: Average Grade / Completion Rate / Attendance / Engagement Score

**Charts Section:**
- **Performance Distribution** (Bar chart)
  - Shows grade distribution across all students
  
- **Attendance Trends** (Line chart)
  - Weekly attendance over time
  
- **Course Comparison** (Radar chart)
  - Compare metrics across different courses
  
- **Assignment Completion** (Stacked bar chart)
  - On-time vs late vs missing

**Insights Panel:**
- AI-generated insights cards:
  - "📈 Math performance improved 12% this month"
  - "⚠️ 5 students have declining attendance"
  - "🎯 Quiz pass rate increased in Physics"

#### 5. Attendance Management
**Calendar View:**
- Monthly calendar
- Each day shows session count
- Click day to see session list

**Session Attendance View:**
- Session details at top
- QR Code generator button
- Student list with checkboxes
- Bulk actions: Mark All Present / Mark All Absent
- Each student row:
  - Photo
  - Name
  - Status buttons: Present / Absent / Excused / Late
  - Note field
- "Save Attendance" button

#### 6. Grading Center
**Tabs:** Pending / In Progress / Completed

**Assignment Queue:**
- Cards sorted by due date
- Each shows:
  - Assignment name
  - Course
  - Submissions count
  - Time remaining until deadline
  - "Grade Now" button

**Grading Interface:**
- Split view:
  - Left: Student submission (file viewer / text display)
  - Right: Grading panel
    - Rubric items with point sliders
    - Total score calculator
    - Grade input field
    - Feedback text area
    - "Save Draft" / "Submit Grade" buttons
- Navigation: Previous / Next student

---

## 3. Parent Dashboard

### Layout Structure
Parent color scheme (#FFD93D)

**Sidebar Navigation:**
- 👨‍👩‍👧 My Children (if multiple)
- 📊 Performance Overview
- ✅ Attendance
- 📝 Assignments & Grades
- 💰 Payments
- 📱 Notifications
- 💬 Messages
- ⚙️ Settings

### Key Components

#### 1. Dashboard Home View
**Child Selector:**
- If multiple children, prominent card selector at top
- Each child card shows: photo, name, grade level, recent activity
- Click to switch active child view

**Child Performance Summary (4 Cards):**
1. **Overall Grade**
   - Large letter grade or percentage
   - Trend indicator
   - Color: green if good, yellow if average, red if poor

2. **Attendance Rate**
   - Percentage
   - This week/month
   - Icon: ✅

3. **Assignments Status**
   - Completed / Pending count
   - Due soon highlighted
   - Icon: 📝

4. **Recent Activity**
   - Last login
   - Last quiz/assignment
   - Icon: 📱

**Weekly Overview:**
- Calendar-style widget
- Shows scheduled sessions
- Color-coded: Attended (green) / Missed (red) / Upcoming (blue)

**Recent Grades Table:**
- Latest 5 graded items
- Columns: Assignment | Course | Grade | Date | Teacher Feedback
- Each grade has color indicator
- "View All Grades" link

**Alerts & Notifications:**
- Important alerts card:
  - Missed classes
  - Low grades
  - Upcoming deadlines
  - Payment reminders
- Each with timestamp and action button

**Teacher Communication Section:**
- Recent messages from teachers
- "Send Message" button
- Unread count badge

#### 2. Performance Overview
**Academic Progress Dashboard:**

**GPA/Average Display:**
- Large number with trend
- Comparison to class average (optional)
- Semester selector

**Subject Performance Grid:**
- Card for each subject
- Shows: Subject name, current grade, teacher name, trend
- Click to expand details

**Detailed Subject View Modal:**
- Grade breakdown by category: Assignments / Quizzes / Exams / Participation
- Performance timeline chart
- Recent work list
- Teacher comments
- "Contact Teacher" button

**Comparison Charts:**
- Student vs Class Average (bar chart)
- Progress Over Time (line chart)
- Strengths & Weaknesses (radar chart)

#### 3. Attendance Tracking
**Monthly Calendar View:**
- Full calendar display
- Each day colored: Present (green) / Absent (red) / Excused (yellow) / No class (gray)
- Click day for session details

**Attendance Statistics:**
- Overall rate (large percentage)
- Days present / absent / excused
- Comparison to school average
- Trend chart (last 3 months)

**Absences List:**
- Table of all absences
- Columns: Date | Course | Reason | Makeup Status
- Filter by date range / course

**Alerts:**
- Warning if attendance drops below threshold
- Notification of consecutive absences

#### 4. Payments View
**Payment Dashboard:**

**Account Balance Card:**
- Current wallet balance (large)
- Recent transactions summary
- "Add Funds" button (prominent)

**Active Subscriptions:**
- Cards for each enrolled course
- Shows: Course name, amount paid, expiry date, status
- "Renew" button if expiring soon

**Payment History Table:**
- Columns: Date | Description | Amount | Payment Method | Receipt
- Downloadable receipts
- Filter by date range / status

**Upcoming Payments:**
- List of pending/scheduled payments
- "Pay Now" buttons

#### 5. Messages View
**Messaging Interface:**

**Left Sidebar (Conversations):**
- Search bar
- Filter: All / Teachers / School / Unread
- Conversation list:
  - Teacher avatar and name
  - Last message preview
  - Timestamp
  - Unread badge

**Main Chat Area:**
- Selected conversation header (teacher name, subject)
- Message thread
- Reply input box
- Attachment button

**Quick Actions:**
- "New Message" button
- Select teacher from dropdown
- Subject selector

---

## 4. Admin Dashboard

### Layout Structure
Admin color scheme (#A28BFE)

**Sidebar Navigation:**
- 📊 Overview
- 👥 User Management
- 🏫 Institutions & Centers
- 📚 Course Management
- 💰 Financial Analytics
- 📈 System Analytics
- 🔐 Security & Access
- ⚙️ System Settings
- 📝 Reports

### Key Components

#### 1. Dashboard Overview
**System-Wide Statistics (6 cards):**
1. **Total Users**
   - Students / Teachers / Parents count
   - Growth indicator

2. **Active Courses**
   - Currently running courses
   - Enrollment stats

3. **Revenue**
   - Monthly recurring revenue
   - Trend chart

4. **System Health**
   - Uptime percentage
   - Server status indicator (green/yellow/red)

5. **Pending Approvals**
   - New registrations / Course submissions
   - Action required badge

6. **Support Tickets**
   - Open tickets count
   - Priority breakdown

**Real-Time Activity Feed:**
- Live stream of system events
- User registrations
- Course enrollments
- Payment transactions
- System errors
- Auto-scroll with pause button

**Quick Actions Panel:**
- "Add User" (dropdown: Student/Teacher/Parent)
- "Create Course"
- "Generate Report"
- "System Backup"
- "View Logs"

**System Performance Charts:**
- **User Growth** (Line chart)
- **Revenue Trends** (Area chart)
- **Course Popularity** (Bar chart)
- **Server Load** (Gauge chart)

#### 2. User Management
**User Directory:**
- Tabbed interface: All / Students / Teachers / Parents / Admins
- Advanced filters panel (collapsible)
- Bulk actions toolbar (when rows selected)

**User Table:**
- Columns: Photo | Name | Role | Email | Status | Registration Date | Last Active | Actions
- Sortable columns
- Inline actions: Edit / Deactivate / Delete / View Profile
- Status indicators: Active (green) / Suspended (yellow) / Inactive (gray)

**User Detail/Edit Modal:**
- Form sections: Personal Info / Contact / Role & Permissions / Status / Activity Log
- "Save Changes" / "Cancel" buttons

**Bulk Operations:**
- Import users (CSV upload)
- Export selected users
- Send bulk notifications
- Assign roles/permissions

#### 3. Financial Analytics
**Revenue Dashboard:**

**Financial Summary Cards:**
- Total Revenue (MTD)
- Total Revenue (YTD)
- Outstanding Payments
- Refunds Processed
- Average Transaction Value

**Revenue Charts:**
- **Monthly Revenue Trend** (Line + bar combo)
- **Revenue by Course** (Pie chart)
- **Payment Methods Distribution** (Donut chart)
- **Revenue Forecast** (Projected line)

**Recent Transactions Table:**
- Columns: Date | User | Course | Amount | Method | Status
- Export button (CSV/PDF)
- Filter by date range, status, amount range

**Payment Gateway Status:**
- Integration status for each gateway
- Transaction success rate
- Average processing time

#### 4. System Analytics
**Performance Metrics:**

**Key Performance Indicators:**
- Concurrent Users (real-time gauge)
- API Response Time (line chart)
- Error Rate (percentage with threshold indicator)
- Database Query Performance (average ms)
- Cache Hit Rate (percentage)

**Traffic Analytics:**
- Visitors by time (area chart)
- Most visited pages (bar chart)
- User geography (map visualization)
- Device breakdown (pie chart)

**System Logs Viewer:**
- Tabbed by log type: All / Errors / Warnings / Info / Debug
- Real-time streaming option
- Search and filter
- Severity color coding
- Export logs

#### 5. Security & Access Control
**Security Dashboard:**

**Security Status Cards:**
- Active Sessions
- Failed Login Attempts (last 24h)
- Blocked IPs
- Security Alerts

**Access Control:**
- Role management table
- Permission matrix (grid view)
- Add/Edit role modal

**Security Logs:**
- Audit trail of sensitive actions
- Filter by user, action type, date
- Exportable

**Security Settings:**
- Password policies
- Session timeout
- IP whitelist/blacklist
- Two-factor authentication settings
- API rate limits

---

## Component Library

### Buttons
**Primary Button:**
- Background: Platform Primary (#4A90E2)
- Text: White
- Padding: 12px 24px
- Border radius: 6px
- Hover: Darken 10%
- Font weight: Semi-bold

**Secondary Button:**
- Background: Transparent
- Border: 1px solid Platform Primary
- Text: Platform Primary
- Same padding and radius as primary
- Hover: Light background

**Danger Button:**
- Background: Error color (#DC3545)
- Text: White
- Used for delete/remove actions

**Icon Buttons:**
- Square or circular
- 40px x 40px
- Light background hover

### Cards
**Standard Card:**
- Background: White
- Border: 1px solid #DEE2E6
- Border radius: 12px
- Padding: 24px
- Shadow: 0 2px 4px rgba(0,0,0,0.08)
- Hover: Subtle elevation increase

**Stat Card:**
- Similar to standard card
- Large number (36px, bold)
- Icon in top right (24px)
- Optional gradient background
- Optional trend indicator (↑/↓)

### Forms
**Input Fields:**
- Height: 40px
- Border: 1px solid #CED4DA
- Border radius: 6px
- Padding: 8px 12px
- Focus: Blue border, subtle glow
- Error state: Red border

**Dropdowns/Selects:**
- Similar to input fields
- Chevron icon on right
- Dropdown menu: white background, subtle shadow

**Checkboxes/Radio Buttons:**
- Custom styled
- Accent color: Platform Primary
- Size: 20px x 20px

**File Upload:**
- Dashed border drag-drop area
- "Choose File" button
- File list with remove buttons

### Tables
**Data Table:**
- Header: Light gray background (#F8F9FA)
- Rows: White background
- Alternate row: Very light gray (#FAFBFC)
- Hover: Highlighted background
- Borders: Light gray (#DEE2E6)
- Sortable columns: Indicator icon
- Actions column: Icon buttons

### Navigation
**Sidebar:**
- Background: White or light gray
- Active item: Primary color background (10% opacity), bold text, left border accent
- Hover: Light background
- Icons: 20px, colored based on role
- Collapsible on mobile

**Breadcrumb:**
- Light gray text
- Separator: "/" or "›"
- Current page: Bold, dark text
- Clickable ancestors: Hover underline

### Badges/Tags
**Status Badges:**
- Rounded corners (4px)
- Padding: 4px 8px
- Font size: 12px
- Colors based on status:
  - Active/Completed: Green
  - Pending: Yellow
  - Inactive/Cancelled: Gray
  - Overdue/Error: Red

**Count Badges:**
- Small circle (18px diameter)
- Positioned on top-right of icons
- Background: Red for notifications, primary for counts
- White text, bold

### Modal/Dialog
**Modal Container:**
- Max width: 600px (medium), 900px (large)
- Background: White
- Border radius: 12px
- Overlay: Dark semi-transparent (#000000 40% opacity)
- Close button: Top right

**Modal Content:**
- Header: 24px title, optional subtitle
- Body: Scrollable if needed
- Footer: Right-aligned buttons

### Charts
**Chart Container:**
- White background card
- Title and subtitle at top
- Legend (if needed)
- Tooltip on hover
- Responsive sizing

**Color Palette for Charts:**
- Primary series: #4A90E2
- Secondary: #50C878
- Tertiary: #FF6B6B
- Quaternary: #FFD93D
- Additional: #A28BFE, #17A2B8

### Loading States
**Skeleton Loaders:**
- Gray animated shimmer effect
- Match component dimensions
- Smooth transition when content loads

**Spinners:**
- Circular spinner
- Platform Primary color
- Size: small (16px), medium (32px), large (48px)

### Empty States
**No Data Display:**
- Centered illustration or icon
- Helpful message
- Call-to-action button if applicable

---

## Responsive Behavior

### Breakpoints
- Mobile: < 768px
- Tablet: 768px - 1024px
- Desktop: > 1024px
- Large Desktop: > 1440px

### Mobile Adaptations
- Sidebar: Collapsed by default, overlay when opened
- Top bar: Hamburger menu, condensed layout
- Cards: Stack vertically (full width)
- Tables: Horizontal scroll or card transformation
- Charts: Simplified, touch-friendly
- Modals: Full screen on mobile

### Tablet Adaptations
- Sidebar: Can be pinned or auto-hide
- Cards: 2-column grid
- Tables: Show key columns only, expandable rows

---

## Accessibility

### Requirements
- WCAG 2.1 Level AA compliance
- Keyboard navigation support (Tab, Enter, Escape, Arrow keys)
- Focus indicators (visible outline)
- ARIA labels and roles
- Screen reader friendly
- Color contrast ratio: 4.5:1 minimum for text
- Touch target size: Minimum 44px x 44px

### Interactive Elements
- All buttons keyboard accessible
- Form inputs labeled properly
- Error messages announced
- Loading states communicated
- Success/error feedback (visual + text)

---

## Interactions & Animations

### Micro-interactions
- Button hover: Scale 102%, brightness increase
- Card hover: Elevation increase (shadow)
- Input focus: Border color change, subtle glow
- Loading: Smooth spinner or progress bar
- Notifications: Slide in from top-right
- Modals: Fade in background, scale up modal
- Dropdowns: Smooth slide down

### Transitions
- Default duration: 200ms
- Easing: ease-in-out
- Page transitions: Fade between views

### Feedback
- Success: Green toast notification (3 seconds)
- Error: Red toast notification (persistent until dismissed)
- Warning: Yellow toast notification (5 seconds)
- Info: Blue toast notification (3 seconds)

---

## Special Features

### Real-Time Updates
- Notification bell: Red dot for new items
- Dashboard metrics: Auto-refresh every 30 seconds
- Chat messages: Real-time without page reload
- Attendance: Live updates during sessions

### Gamification Elements
- **Progress Rings:** Circular progress indicators for completion
- **Point Animations:** Confetti or spark effect when earning points
- **Badge Unlock:** Special animation when earning new badge
- **Level Up:** Full-screen celebration modal

### AI Integration
- **Chatbot Interface:** Typing indicator, message bubbles
- **AI Suggestions:** Highlighted with special icon
- **Predictions:** Displayed with confidence indicator

---

## Design Deliverables

Please create the following screens for each dashboard:

### Student Dashboard (10 screens)
1. Dashboard Home
2. My Courses Grid
3. Course Detail Page
4. Progress Overview
5. Assignment List
6. Assignment Detail/Submit
7. Quiz Taking Interface
8. Rewards & Leaderboard
9. AI Chatbot
10. User Settings

### Teacher Dashboard (10 screens)
1. Dashboard Home
2. My Courses Management
3. Student Directory
4. Student Profile Detail
5. Analytics Dashboard
6. Attendance Management
7. Grading Center
8. Quiz/Assignment Creation
9. Messages/Communications
10. Reports

### Parent Dashboard (6 screens)
1. Dashboard Home (with child selector)
2. Performance Overview
3. Attendance Calendar
4. Grades & Assignments
5. Payments & Billing
6. Messages

### Admin Dashboard (8 screens)
1. System Overview
2. User Management
3. Course Management
4. Financial Analytics
5. System Analytics
6. Security Dashboard
7. Reports Generator
8. Settings Panel

### Shared Components (5 screens)
1. Login Page
2. Registration Flow
3. Password Reset
4. Notification Center
5. User Profile Edit

---

## Additional Notes

- All dashboards should feel cohesive while maintaining role-specific identity
- Use role colors as accents, not dominant colors
- Maintain whitespace for readability
- Prioritize information hierarchy
- Ensure data is scannable (use of icons, badges, color coding)
- Include subtle animations for delight
- Design for both light mode (mandatory) and dark mode (optional)
- Include empty states, loading states, and error states for all components
- Consider internationalization (RTL support for Arabic languages)

---

## Export Specifications

- Design at 1920x1080 base resolution
- Provide 2x assets for retina displays
- Component library as separate file
- Color palette as swatches
- Typography styles defined
- Spacing system documented
- Export assets in SVG for icons, PNG for images
- Provide design tokens (JSON format) for developers
