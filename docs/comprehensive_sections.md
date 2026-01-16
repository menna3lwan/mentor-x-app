
---

## **3.0 Completion of System Design Diagrams**

### **3.1 Activity Diagrams (Complete Set)**

**Figure 3.17: Activity Diagram - Register User**

```mermaid
graph TD
    Start([Start]) --> InputData["Input Registration Data<br/>(Name, Email, Password, Role)"]
    InputData --> ValidateEmail{Email Valid?}
    ValidateEmail -->|No| ErrorEmail["Display Error:<br/>Invalid Email Format"]
    ErrorEmail --> InputData
    ValidateEmail -->|Yes| ValidatePassword{Password Meets<br/>Requirements?}
    ValidatePassword -->|No| ErrorPassword["Display Error:<br/>Weak Password"]
    ErrorPassword --> InputData
    ValidatePassword -->|Yes| CheckEmail{Email Already<br/>Exists?}
    CheckEmail -->|Yes| ErrorExists["Display Error:<br/>Email Exists"]
    ErrorExists --> InputData
    CheckEmail -->|No| SendOTP["Send OTP<br/>via Email & SMS"]
    SendOTP --> VerifyOTP{User Verifies<br/>OTP?}
    VerifyOTP -->|Incorrect| ResendOTP["Resend OTP"]
    ResendOTP --> VerifyOTP
    VerifyOTP -->|Correct| BindDevice["Bind Device<br/>to Account"]
    BindDevice --> CreateUser["Create User<br/>Record in Database"]
    CreateUser --> SendConfirmation["Send Confirmation<br/>Email"]
    SendConfirmation --> Success([Registration Success])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
    style ErrorEmail fill:#FF6B6B,stroke:#C92A2A
    style ErrorPassword fill:#FF6B6B,stroke:#C92A2A
    style ErrorExists fill:#FF6B6B,stroke:#C92A2A
```

**Figure 3.18: Activity Diagram - Locate Nearest Center**

```mermaid
graph TD
    Start([Start]) --> RequestLocation["Request User<br/>Location Permission"]
    RequestLocation --> GetCoords["Get User GPS<br/>Coordinates"]
    GetCoords --> Query["Query Database<br/>for Nearby Centers"]
    Query --> CalcDistance["Calculate Distance<br/>from User to Centers"]
    CalcDistance --> Sort["Sort Centers by<br/>Distance"]
    Sort --> Filter["Filter by:<br/>- Open Hours<br/>- Available Courses<br/>- Rating"]
    Filter --> DisplayResults["Display Map with<br/>Center Markers"]
    DisplayResults --> UserSelect{User Selects<br/>Center?}
    UserSelect -->|Yes| ShowDetails["Show Center Details:<br/>- Address<br/>- Contact Info<br/>- Courses Offered"]
    ShowDetails --> DirectionsPrompt{Request<br/>Directions?}
    DirectionsPrompt -->|Yes| OpenMaps["Open Google Maps<br/>Navigation"]
    DirectionsPrompt -->|No| End1([End])
    OpenMaps --> End2([Directions Started])
    UserSelect -->|No| End3([Cancel])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style End1 fill:#4A90E2,stroke:#2E5C8A
    style End2 fill:#4A90E2,stroke:#2E5C8A
    style End3 fill:#FF6B6B,stroke:#C92A2A
```

**Figure 3.19: Activity Diagram - Respond to Student Inquiries**

```mermaid
graph TD
    Start([New Inquiry]) --> NotifyTeacher["Notify Teacher<br/>of New Inquiry"]
    NotifyTeacher --> TeacherLogIn["Teacher Logs Into<br/>Dashboard"]
    TeacherLogIn --> ViewInquiry["View Student<br/>Inquiry Details"]
    ViewInquiry --> ReadMessage["Read:<br/>- Question<br/>- Context<br/>- Student Profile"]
    ReadMessage --> TypeResponse["Type Response<br/>Message"]
    TypeResponse --> AttachResources{Include<br/>Resources?}
    AttachResources -->|Yes| SelectFiles["Select:<br/>- Links<br/>- Documents<br/>- Videos"]
    SelectFiles --> ReviewResponse
    AttachResources -->|No| ReviewResponse["Review Complete<br/>Response"]
    ReviewResponse --> SendResponse["Send Response<br/>to Student"]
    SendResponse --> NotifyStudent["Notify Student<br/>of Response"]
    NotifyStudent --> LogResponse["Log Inquiry<br/>in Database"]
    LogResponse --> Success([Inquiry Resolved])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.20: Activity Diagram - Upload Assignment**

```mermaid
graph TD
    Start([Start]) --> NavAssignments["Navigate to<br/>Assignments Section"]
    NavAssignments --> ViewPending["View Pending<br/>Assignments"]
    ViewPending --> SelectAssignment["Select Assignment<br/>to Submit"]
    SelectAssignment --> ReviewInstructions["Review Instructions<br/>and Deadline"]
    ReviewInstructions --> PrepareWork["Prepare Work<br/>File"]
    PrepareWork --> ChooseFile["Choose File<br/>from Device"]
    ChooseFile --> ValidateFile{File Valid?<br/>- Type<br/>- Size<br/>- Format}
    ValidateFile -->|No| ErrorFile["Display Error<br/>Message"]
    ErrorFile --> ChooseFile
    ValidateFile -->|Yes| SetName["Set Submission<br/>Name/Notes"]
    SetName --> PreviewSubmission["Preview Submission<br/>Before Upload"]
    PreviewSubmission --> ConfirmSubmit{Confirm<br/>Upload?}
    ConfirmSubmit -->|No| ModifyOrCancel["Modify or Cancel"]
    ModifyOrCancel --> ChooseFile
    ConfirmSubmit -->|Yes| UploadFile["Upload File<br/>to Server"]
    UploadFile --> GenerateReceipt["Generate<br/>Submission Receipt"]
    GenerateReceipt --> NotifyTeacher["Notify Teacher<br/>of Submission"]
    NotifyTeacher --> Success([Submission Complete])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
    style ErrorFile fill:#FF6B6B,stroke:#C92A2A
```

**Figure 3.21: Activity Diagram - Send Reports to Parents**

```mermaid
graph TD
    Start([Start - Admin Portal]) --> SelectReport{Report<br/>Type?}
    SelectReport -->|Attendance| AttendanceReport["Generate Attendance<br/>Summary"]
    SelectReport -->|Grades| GradesReport["Generate Grades<br/>Report"]
    SelectReport -->|Progress| ProgressReport["Generate Progress<br/>Analysis"]
    AttendanceReport --> SelectRecipients
    GradesReport --> SelectRecipients["Select Parent<br/>Recipients"]
    ProgressReport --> SelectRecipients
    SelectRecipients --> CompileData["Compile Child Data:<br/>- Name<br/>- Grades<br/>- Attendance<br/>- Comments"]
    CompileData --> FormatReport["Format Report<br/>as PDF/Document"]
    FormatReport --> SendWhatsApp["Send via WhatsApp<br/>with Message"]
    SendWhatsApp --> LogSent["Log Sent Message<br/>in Database"]
    LogSent --> NotifyInApp["Send In-App<br/>Notification"]
    NotifyInApp --> Success([Report Sent])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.22: Activity Diagram - Upload Grades**

```mermaid
graph TD
    Start([Start - Teacher Portal]) --> SelectClass["Select Class/<br/>Subject"]
    SelectClass --> ViewStudents["View List of<br/>Students"]
    ViewStudents --> ChooseGrading{Grading<br/>Method?}
    ChooseGrading -->|Manual Entry| EnterGrades["Enter Grades<br/>Manually"]
    ChooseGrading -->|Import CSV| UploadCSV["Upload CSV<br/>File"]
    ChooseGrading -->|AI Grading| ReviewAI["Review AI<br/>Generated Grades"]
    EnterGrades --> ValidateGrades
    UploadCSV --> ParseCSV["Parse CSV Data"]
    ParseCSV --> ValidateGrades
    ReviewAI --> ValidateGrades["Validate All<br/>Grades:<br/>- Range: 0-100<br/>- No missing values"]
    ValidateGrades --> AddComments{Add<br/>Comments?}
    AddComments -->|Yes| TypeFeedback["Type Feedback<br/>for Each Student"]
    TypeFeedback --> ReviewAll
    AddComments -->|No| ReviewAll["Review All<br/>Grades & Feedback"]
    ReviewAll --> ConfirmUpload{Confirm<br/>Upload?}
    ConfirmUpload -->|No| ModifyGrades["Modify Grades"]
    ModifyGrades --> EnterGrades
    ConfirmUpload -->|Yes| SaveGrades["Save to Database"]
    SaveGrades --> NotifyStudents["Notify Students<br/>of Grade Release"]
    NotifyStudents --> NotifyParents["Notify Parents<br/>via WhatsApp"]
    NotifyParents --> UpdateAnalytics["Update Performance<br/>Analytics"]
    UpdateAnalytics --> Success([Grades Uploaded])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.23: Activity Diagram - View Analytics Dashboard**

```mermaid
graph TD
    Start([Access Dashboard]) --> SelectPeriod["Select Time Period:<br/>- This Week<br/>- This Month<br/>- Custom Range"]
    SelectPeriod --> FetchData["Fetch Data from<br/>Database"]
    FetchData --> ProcessMetrics["Process Metrics:<br/>- Attendance %<br/>- Avg Grades<br/>- Completion Rate"]
    ProcessMetrics --> GenerateCharts["Generate Charts:<br/>- Line Graphs<br/>- Bar Charts<br/>- Pie Charts"]
    GenerateCharts --> DisplayDashboard["Display Dashboard<br/>with Widgets"]
    DisplayDashboard --> UserInteract{User<br/>Interaction?}
    UserInteract -->|Drill Down| DetailedView["Show Detailed<br/>Student Data"]
    UserInteract -->|Export| ExportReport["Export as PDF/<br/>Excel"]
    UserInteract -->|Filter| ApplyFilters["Apply Filters:<br/>- Grade Level<br/>- Subject<br/>- Class"]
    DetailedView --> UpdateDisplay
    ExportReport --> Success
    ApplyFilters --> UpdateDisplay["Update Display<br/>with Filters"]
    UpdateDisplay --> DisplayDashboard
    UserInteract -->|Exit| Success([Close Dashboard])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.24: Activity Diagram - Create Quiz**

```mermaid
graph TD
    Start([Start - Quiz Builder]) --> SelectCourse["Select Course/<br/>Subject"]
    SelectCourse --> SetBasics["Set Quiz Basics:<br/>- Title<br/>- Description<br/>- Duration"]
    SetBasics --> ChooseQType{Question<br/>Type?}
    ChooseQType -->|Multiple Choice| AddMC["Add Multiple<br/>Choice Question"]
    ChooseQType -->|True/False| AddTF["Add True/False<br/>Question"]
    ChooseQType -->|Short Answer| AddSA["Add Short<br/>Answer Question"]
    AddMC --> ReviewQuestion
    AddTF --> ReviewQuestion
    AddSA --> ReviewQuestion["Review Question<br/>Wording & Answers"]
    ReviewQuestion --> MoreQuestions{Add More<br/>Questions?}
    MoreQuestions -->|Yes| ChooseQType
    MoreQuestions -->|No| SetRules
    SetRules["Set Quiz Rules:<br/>- Randomize Questions<br/>- Show/Hide Answers<br/>- Time Limit<br/>- Passing Score"]
    SetRules --> PreviewQuiz["Preview Quiz"]
    PreviewQuiz --> PublishPrompt{Publish<br/>Now?}
    PublishPrompt -->|No| SaveDraft["Save as Draft"]
    SaveDraft --> End1([Draft Saved])
    PublishPrompt -->|Yes| PublishQuiz["Publish Quiz"]
    PublishQuiz --> NotifyStudents["Notify Students<br/>of New Quiz"]
    NotifyStudents --> Success([Quiz Published])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
    style End1 fill:#FFD700,stroke:#DAA520
```

**Figure 3.25: Activity Diagram - Take Quiz**

```mermaid
graph TD
    Start([Start Quiz]) --> LoadQuiz["Load Quiz<br/>Questions"]
    LoadQuiz --> StartTimer["Start Timer"]
    StartTimer --> DisplayQ1["Display Question 1"]
    DisplayQ1 --> AnswerQ{"Answer<br/>Question?"}
    AnswerQ -->|Yes| SelectAnswer["Select/Enter<br/>Answer"]
    AnswerQ -->|Skip| SkipQ["Mark as Skipped"]
    SelectAnswer --> SaveAnswer
    SkipQ --> SaveAnswer["Save Answer<br/>to Session"]
    SaveAnswer --> CheckMore{More<br/>Questions?}
    CheckMore -->|Yes| NextQ["Move to Next<br/>Question"]
    NextQ --> DisplayQ1
    CheckMore -->|No| ReviewAnswers["Review All<br/>Answers"]
    ReviewAnswers --> FinalCheck{Submit<br/>Quiz?}
    FinalCheck -->|No| EditAnswers["Return to Edit<br/>Answers"]
    EditAnswers --> SelectAnswer
    FinalCheck -->|Yes| SubmitQuiz["Submit Quiz"]
    SubmitQuiz --> GradeQuiz["Grade Quiz<br/>with AI"]
    GradeQuiz --> CalculateScore["Calculate Final<br/>Score"]
    CalculateScore --> DisplayResult["Display Score<br/>and Feedback"]
    DisplayResult --> Success([Quiz Complete])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.26: Activity Diagram - View Student Distribution**

```mermaid
graph TD
    Start([Access Analytics]) --> SelectMetric["Select Metric:<br/>- Grade Distribution<br/>- Performance Level<br/>- Attendance Status"]
    SelectMetric --> FetchStudentData["Fetch Student<br/>Data from DB"]
    FetchStudentData --> Categorize["Categorize Students:<br/>- Excellent (A)<br/>- Good (B)<br/>- Average (C)<br/>- Below Average (D)"]
    Categorize --> CountPerCategory["Count Students<br/>per Category"]
    CountPerCategory --> CalcPercentages["Calculate<br/>Percentages"]
    CalcPercentages --> GenerateChart["Generate<br/>Distribution Chart:<br/>- Pie Chart<br/>- Bar Chart"]
    GenerateChart --> DisplayChart["Display Chart<br/>with Statistics"]
    DisplayChart --> OffersAction{User<br/>Action?}
    OffersAction -->|View Details| DrillDown["Show List of<br/>Students in<br/>Selected Category"]
    OffersAction -->|Export| ExportData["Export Data<br/>as CSV/PDF"]
    OffersAction -->|Filter| ApplyFilter["Apply Filters"]
    DrillDown --> EndAction
    ExportData --> EndAction
    ApplyFilter --> DisplayChart
    OffersAction -->|Exit| EndAction([Close Analytics])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style EndAction fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.27: Activity Diagram - View Activity Timeline**

```mermaid
graph TD
    Start([Open Timeline]) --> SelectUser["Select User/Class:<br/>- Specific Student<br/>- Entire Class<br/>- All Users"]
    SelectUser --> SelectPeriod["Select Time Period:<br/>- Today<br/>- This Week<br/>- This Month<br/>- Custom"]
    SelectPeriod --> FetchEvents["Fetch Events from<br/>Activity Log"]
    FetchEvents --> ProcessEvents["Process Events:<br/>- Logins<br/>- Submissions<br/>- Grades Released<br/>- Quiz Taken"]
    ProcessEvents --> SortChronological["Sort Events<br/>Chronologically<br/>Newest First"]
    SortChronological --> DisplayTimeline["Display Timeline<br/>with Cards"]
    DisplayTimeline --> UserScroll["User Scrolls<br/>Timeline"]
    UserScroll --> ShowDetails{Click on<br/>Event?}
    ShowDetails -->|Yes| DisplayEventDetail["Show Full<br/>Event Details"]
    ShowDetails -->|No| UserScroll
    DisplayEventDetail --> UserDone{Continue<br/>Browsing?}
    UserDone -->|Yes| UserScroll
    UserDone -->|No| Success([Close Timeline])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.28: Activity Diagram - Contact Support**

```mermaid
graph TD
    Start([Open Support]) --> SelectIssueType["Select Issue Type:<br/>- Technical Problem<br/>- Account Issue<br/>- Course Question<br/>- Other"]
    SelectIssueType --> DescribeProblem["Describe Problem:<br/>- Title<br/>- Detailed Description<br/>- Screenshots"]
    DescribeProblem --> AttachFile["Attach Supporting<br/>Files if Needed"]
    AttachFile --> SetUrgency["Set Priority:<br/>- Low<br/>- Medium<br/>- High"]
    SetUrgency --> SubmitTicket["Submit Support<br/>Ticket"]
    SubmitTicket --> GenerateTicketID["Generate Ticket ID"]
    GenerateTicketID --> NotifySupport["Notify Support<br/>Team"]
    NotifySupport --> CreateTicketRecord["Create Ticket<br/>in Database"]
    CreateTicketRecord --> SendConfirmation["Send Confirmation<br/>Email to User"]
    SendConfirmation --> ShowTicketStatus["Show Ticket Status<br/>in Dashboard"]
    ShowTicketStatus --> End1([Ticket Created])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style End1 fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.29: Activity Diagram - Monitor Attendance**

```mermaid
graph TD
    Start([Open Attendance]) --> SelectClass["Select Class/Section"]
    SelectClass --> SelectDate["Select Date or<br/>Date Range"]
    SelectDate --> FetchAttendance["Fetch Attendance<br/>Records"]
    FetchAttendance --> DisplayList["Display Attendance<br/>List:<br/>- Present (✓)<br/>- Absent (✗)<br/>- Late (!)"]
    DisplayList --> CalcStats["Calculate Statistics:<br/>- Total Present %<br/>- Absent Count<br/>- Late Count"]
    CalcStats --> ShowStats["Display Statistics<br/>and Trends"]
    ShowStats --> IdentifyRisk["Identify At-Risk<br/>Students:<br/>- >3 Absences<br/>- Low Attendance %"]
    IdentifyRisk --> DisplayWarning["Highlight<br/>At-Risk Students"]
    DisplayWarning --> UserAction{User<br/>Action?}
    UserAction -->|Mark Manual| ManualAttendance["Mark Attendance<br/>Manually"]
    UserAction -->|Send Alert| SendNotification["Send Alert to<br/>Parents"]
    UserAction -->|Export| ExportReport["Export Report"]
    ManualAttendance --> UpdateDB["Update Database"]
    SendNotification --> Success
    ExportReport --> Success
    UpdateDB --> Success([Close Attendance])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.30: Activity Diagram - View Detailed Reports**

```mermaid
graph TD
    Start([Open Reports]) --> SelectReport["Select Report Type:<br/>- Student Performance<br/>- Class Analytics<br/>- Financial Report<br/>- Attendance Summary"]
    SelectReport --> SetFilters["Set Report Filters:<br/>- Date Range<br/>- Class/Student<br/>- Subject"]
    SetFilters --> GenerateReport["Generate Report<br/>from Database"]
    GenerateReport --> FormatData["Format Data:<br/>- Tables<br/>- Charts<br/>- Summary Stats"]
    FormatData --> DisplayReport["Display Full<br/>Report"]
    DisplayReport --> UserOptions{User<br/>Action?}
    UserOptions -->|Export| ExportFormat["Choose Format:<br/>- PDF<br/>- Excel<br/>- CSV"]
    UserOptions -->|Print| PrintReport["Send to<br/>Printer"]
    UserOptions -->|Share| ShareReport["Share Report<br/>via Email"]
    UserOptions -->|Drill Down| DetailedAnalysis["View Detailed<br/>Analysis"]
    ExportFormat --> SaveFile["Save File"]
    PrintReport --> Success
    ShareReport --> Success
    DetailedAnalysis --> DisplayReport
    SaveFile --> Success([Report Ready])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.31: Activity Diagram - View Bought Sessions and Books**

```mermaid
graph TD
    Start([Open Purchase History]) --> SelectFilter["Select Filter:<br/>- All Purchases<br/>- Active Sessions<br/>- Purchased Books<br/>- Expired"]
    SelectFilter --> FetchPurchases["Fetch Purchase<br/>Records from DB"]
    FetchPurchases --> DisplayList["Display List of<br/>Purchased Items:<br/>- Title<br/>- Date Purchased<br/>- Status<br/>- Cost"]
    DisplayList --> ShowDetails{Click<br/>Item?}
    ShowDetails -->|Yes| DisplayItemDetails["Show Item Details:<br/>- Full Description<br/>- Access Link<br/>- Expiration Date<br/>- Receipt"]
    ShowDetails -->|No| UserScroll["Continue Browsing"]
    DisplayItemDetails --> OfferActions{More<br/>Actions?}
    UserScroll --> ShowDetails
    OfferActions -->|Re-download| DownloadMaterial["Download Material<br/>Again"]
    OfferActions -->|Renew| RenewSubscription["Renew Subscription"]
    OfferActions -->|Get Help| ContactSupport["Contact Support"]
    DownloadMaterial --> Success
    RenewSubscription --> ProcessPayment["Process Payment"]
    ProcessPayment --> Success
    ContactSupport --> Success([Close Purchase])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.32: Activity Diagram - View Quiz Grades**

```mermaid
graph TD
    Start([Open Quiz Grades]) --> SelectQuiz["Select Quiz to<br/>View Results:<br/>- List of All Quizzes<br/>Taken"]
    SelectQuiz --> DisplayQuizInfo["Display Quiz Info:<br/>- Title<br/>- Date Taken<br/>- Score<br/>- Grade"]
    DisplayQuizInfo --> ShowStats["Show Statistics:<br/>- Correct Answers<br/>- Wrong Answers<br/>- Percentage Score<br/>- Time Taken"]
    ShowStats --> UserAction{User<br/>Action?}
    UserAction -->|Review Answers| ShowAnswers["Display All<br/>Questions & Answers:<br/>- Correct Answers<br/>- User Answers<br/>- Explanations"]
    UserAction -->|View Feedback| ShowFeedback["Show Detailed<br/>Feedback from<br/>Teacher"]
    UserAction -->|Compare Results| CompareQuizzes["Compare Multiple<br/>Quiz Results"]
    ShowAnswers --> Success
    ShowFeedback --> Success
    CompareQuizzes --> Success([Close Quiz Grades])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.33: Activity Diagram - View Child Statistics**

```mermaid
graph TD
    Start([Parent Opens Child Stats]) --> SelectChild["Select Child<br/>from List"]
    SelectChild --> DisplayOverview["Display Overview:<br/>- Name<br/>- Grade Level<br/>- Current Courses<br/>- Overall GPA"]
    DisplayOverview --> ShowMetrics["Display Key Metrics:<br/>- Average Grade<br/>- Attendance %<br/>- Assignments Completed<br/>- Hours Studied"]
    ShowMetrics --> GenerateCharts["Generate Charts:<br/>- Grade Trend<br/>- Attendance Pattern<br/>- Subject Comparison"]
    GenerateCharts --> DisplayCharts["Display Visual<br/>Charts"]
    DisplayCharts --> OfferDetails{View<br/>Details?}
    OfferDetails -->|Subject Analysis| SubjectDetail["Show Performance<br/>by Subject"]
    OfferDetails -->|Timeline| ViewTimeline["View Activity<br/>Timeline"]
    OfferDetails -->|Comparison| ComparePerformance["Compare to<br/>Class Average"]
    SubjectDetail --> Success
    ViewTimeline --> Success
    ComparePerformance --> Success([Close Stats])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.34: Activity Diagram - Solve Assignment**

```mermaid
graph TD
    Start([Open Assignment]) --> LoadAssignment["Load Assignment:<br/>- Title<br/>- Instructions<br/>- Resources"]
    LoadAssignment --> ReadInstructions["Student Reads<br/>Instructions<br/>and Requirements"]
    ReadInstructions --> CheckResources["Check Available<br/>Resources:<br/>- Lesson Notes<br/>- Reference Links<br/>- Hints"]
    CheckResources --> WorkOnSolution["Student Works<br/>on Solution"]
    WorkOnSolution --> PrepareSubmission["Prepare Answer:<br/>- Write Text<br/>- Upload Files<br/>- Add Attachments"]
    PrepareSubmission --> PreviewBefore["Preview Solution<br/>Before Submission"]
    PreviewBefore --> FinalReview{Ready to<br/>Submit?}
    FinalReview -->|No| KeepWorking["Continue Working"]
    KeepWorking --> WorkOnSolution
    FinalReview -->|Yes| SubmitAssignment["Submit Assignment"]
    SubmitAssignment --> SaveToServer["Save to Server"]
    SaveToServer --> GenerateReceipt["Generate<br/>Submission Receipt"]
    GenerateReceipt --> NotifyTeacher["Notify Teacher<br/>of Submission"]
    NotifyTeacher --> Success([Assignment Submitted])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.35: Activity Diagram - View Classes**

```mermaid
graph TD
    Start([Open Classes]) --> SelectLevel["Select Filter:<br/>- Current Enrollment<br/>- Available Classes<br/>- My Schedule"]
    SelectLevel --> FetchClasses["Fetch Class List<br/>from Database"]
    FetchClasses --> DisplayClasses["Display Classes:<br/>- Class Name<br/>- Teacher Name<br/>- Subject<br/>- Schedule<br/>- Status"]
    DisplayClasses --> UserInteract{User<br/>Interaction?}
    UserInteract -->|View Details| ShowClassDetail["Show Full Class<br/>Details:<br/>- Description<br/>- Objectives<br/>- Syllabus<br/>- Cost"]
    UserInteract -->|Enroll| ProcessEnrollment["Process Enrollment"]
    UserInteract -->|View Schedule| ViewTimetable["Show Class<br/>Schedule/Timetable"]
    UserInteract -->|Exit| Success
    ShowClassDetail --> OfferAction["Offer Enrollment<br/>or Exit"]
    ProcessEnrollment --> Confirmation["Show Enrollment<br/>Confirmation"]
    Confirmation --> Success
    ViewTimetable --> UserInteract
    OfferAction --> UserInteract
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.36: Activity Diagram - Logout**

```mermaid
graph TD
    Start([User Initiates Logout]) --> ConfirmLogout["Confirm Logout<br/>Action"]
    ConfirmLogout --> SaveSession["Save Session State<br/>- Last Activity<br/>- Unsaved Data"]
    SaveSession --> ClearCache["Clear Local Cache"]
    ClearCache --> DestroyToken["Destroy Session Token"]
    DestroyToken --> LogoutEvent["Log Logout Event<br/>in Audit Trail"]
    LogoutEvent --> CloseSession["Close Session<br/>on Server"]
    CloseSession --> ClearCookies["Clear Authentication<br/>Cookies"]
    ClearCookies --> RedirectLogin["Redirect to<br/>Login Page"]
    RedirectLogin --> Success([Logout Complete])
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

**Figure 3.37: Activity Diagram - Upload New Class**

```mermaid
graph TD
    Start([Teacher Opens Class Upload]) --> FillClassInfo["Fill Class Information:<br/>- Class Name<br/>- Subject<br/>- Grade Level<br/>- Description"]
    FillClassInfo --> SetSchedule["Set Class Schedule:<br/>- Days of Week<br/>- Start Time<br/>- Duration"]
    SetSchedule --> AddContent["Add Class Content:<br/>- Select Lessons<br/>- Upload Materials<br/>- Add Resources"]
    AddContent --> ConfigureAccess["Configure Access:<br/>- Price (if paid)<br/>- Max Students<br/>- Enrollment Type"]
    ConfigureAccess --> SetEnrollmentRules["Set Enrollment Rules:<br/>- Open/Closed<br/>- Prerequisites<br/>- Requirements"]
    SetEnrollmentRules --> ReviewAll["Review All<br/>Class Details"]
    ReviewAll --> ConfirmPublish{Publish<br/>Now?}
    ConfirmPublish -->|No| SaveDraft["Save as Draft"]
    SaveDraft --> DraftConfirm["Show Draft<br/>Confirmation"]
    ConfirmPublish -->|Yes| PublishClass["Publish Class"]
    PublishClass --> SaveToDatabase["Save to Database"]
    SaveToDatabase --> NotifyStudents["Notify Potential<br/>Students"]
    NotifyStudents --> Success([Class Published])
    DraftConfirm --> Success
    
    style Start fill:#50C878,stroke:#2D7A4A
    style Success fill:#4A90E2,stroke:#2E5C8A
```

### **3.2 State Diagrams (Essential User States)**

**Figure 3.38: State Diagram - User Login States**

```mermaid
stateDiagram-v2
    [*] --> LoggedOut: App Start
    LoggedOut --> EnteringCredentials: Click Login
    EnteringCredentials --> ValidatingCreds: Submit
    ValidatingCreds --> InvalidCreds: Creds Wrong
    InvalidCreds --> EnteringCredentials: Retry
    ValidatingCreds --> OTPSent: Creds Valid
    OTPSent --> EnteringOTP: Display OTP Input
    EnteringOTP --> VerifyingOTP: Submit OTP
    VerifyingOTP --> InvalidOTP: OTP Wrong
    InvalidOTP --> EnteringOTP: Retry
    VerifyingOTP --> CheckingDevice: OTP Valid
    CheckingDevice --> DeviceRecognized: Device Known
    DeviceRecognized --> SessionCreated: Create Session
    CheckingDevice --> UnknownDevice: Device New
    UnknownDevice --> AdditionalVerification: Request Extra Auth
    AdditionalVerification --> SessionCreated
    SessionCreated --> LoggedIn: Session Valid
    LoggedIn --> ActiveSession: User Interacting
    ActiveSession --> IdleSession: No Activity
    IdleSession --> LoggedOut: Session Timeout
    LoggedIn --> LoggedOut: User Logout
    ActiveSession --> LoggedOut: Session Revoked
```

**Figure 3.39: State Diagram - Assignment Submission States**

```mermaid
stateDiagram-v2
    [*] --> NotStarted: Assignment Assigned
    NotStarted --> InProgress: Student Views
    InProgress --> InProgress: Editing
    InProgress --> Submitted: Student Submits
    InProgress --> PartiallyCompleted: Timeout Close
    PartiallyCompleted --> InProgress: Resume
    PartiallyCompleted --> Cancelled: Abandon
    Submitted --> PendingGrading: Submission Valid
    PendingGrading --> AIGrading: AI Grades
    AIGrading --> AwaitingReview: Graded by AI
    AwaitingReview --> TeacherReviewing: Teacher Reviews
    TeacherReviewing --> Graded: Teacher Completes
    Graded --> NotificationSent: Notify Student
    NotificationSent --> [*]
    Cancelled --> [*]
```

**Figure 3.40: State Diagram - Quiz Taking States**

```mermaid
stateDiagram-v2
    [*] --> QuizAvailable: Quiz Published
    QuizAvailable --> NotStarted: Student Accesses
    NotStarted --> InProgress: Student Begins
    InProgress --> AnsweringQuestions: Load Q1
    AnsweringQuestions --> AnsweringQuestions: Answer Q & Next
    AnsweringQuestions --> ReviewingAnswers: All Questions Done
    ReviewingAnswers --> ConfirmingSubmission: User Reviews
    ConfirmingSubmission --> QuizSubmitted: Submit Quiz
    InProgress --> TimedOut: Time Expired
    TimedOut --> AutoSubmitted: Auto Submit
    AutoSubmitted --> Grading
    QuizSubmitted --> Grading: Grade Quiz
    Grading --> Graded: Score Calculated
    Graded --> ResultsAvailable: Results Released
    ResultsAvailable --> [*]
```

**Figure 3.41: State Diagram - Course Enrollment States**

```mermaid
stateDiagram-v2
    [*] --> CourseAvailable: Course Published
    CourseAvailable --> ViewingCourse: Student Browses
    ViewingCourse --> Enrolled: Student Enrolls
    ViewingCourse --> [*]: Exit
    Enrolled --> Active: Course Started
    Active --> InProgress: Student Learning
    InProgress --> InProgress: Complete Lessons
    InProgress --> Paused: Student Pauses
    Paused --> InProgress: Student Resumes
    InProgress --> Completed: Complete Course
    InProgress --> Dropped: Student Drops
    Completed --> CertificateIssued: Issue Certificate
    CertificateIssued --> [*]
    Dropped --> [*]
```

**Figure 3.42: State Diagram - Grade Release States**

```mermaid
stateDiagram-v2
    [*] --> GradeEntered: Teacher Enters Grade
    GradeEntered --> UnderReview: Awaiting Approval
    UnderReview --> AdminReviewing: Admin Checks
    AdminReviewing --> Approved: Admin Approves
    AdminReviewing --> Rejected: Admin Rejects
    Rejected --> GradeEntered: Revise
    Approved --> Releasing: Prepare Release
    Releasing --> Released: Published to Student
    Released --> NotificationSent: Notify Parent
    NotificationSent --> [*]
```

### **3.3 Sequence Diagram - System Interactions**

**Figure 3.43: Sequence Diagram - Complete Login Flow**

```mermaid
sequenceDiagram
    actor Student
    participant Mobile as Mobile App
    participant Gateway as API Gateway
    participant AuthService as Auth Service
    participant DB as Database
    participant OTPService as OTP Service
    participant DeviceService as Device Service

    Student->>Mobile: Enter Email & Password
    Mobile->>Gateway: POST /login
    Gateway->>AuthService: Validate Credentials
    AuthService->>DB: Query User
    DB-->>AuthService: User Found
    AuthService->>DB: Verify Password Hash
    DB-->>AuthService: Password Valid
    AuthService->>OTPService: Generate OTP
    OTPService->>DB: Store OTP (temp)
    OTPService-->>Mobile: Send OTP via SMS/Email
    Student->>Mobile: Enter OTP
    Mobile->>Gateway: POST /verify-otp
    Gateway->>AuthService: Verify OTP Code
    AuthService->>DB: Check OTP
    DB-->>AuthService: OTP Valid
    Mobile->>DeviceService: Get Device Info
    DeviceService->>DB: Retrieve Device Binding
    DB-->>DeviceService: Device Data
    DeviceService-->>AuthService: Device Verified
    AuthService->>DB: Create Session Token
    DB-->>AuthService: Token Generated
    AuthService-->>Mobile: Return JWT Token
    Mobile->>Gateway: Load Dashboard (with token)
    Gateway->>DB: Fetch User Profile
    DB-->>Mobile: Return Profile Data
    Mobile-->>Student: Display Dashboard
```

### **3.4 Class Diagram**

**Figure 3.44: Class Diagram - System Architecture**

```mermaid
classDiagram
    class User {
        -id: Long
        -email: String
        -passwordHash: String
        -fullName: String
        -phone: String
        -roleId: Long
        -createdAt: Timestamp
        +login(): Boolean
        +logout(): void
        +updateProfile(): void
        +changePassword(): void
    }
    
    class Student {
        -studentId: Long
        -enrolledCourses: List
        -attendance: Float
        -averageGrade: Float
        +viewCourses(): List
        +submitAssignment(): void
        +takeQuiz(): void
        +viewGrades(): List
    }
    
    class Teacher {
        -teacherId: Long
        -managedCourses: List
        -students: List
        +createCourse(): void
        +uploadMaterial(): void
        +gradeAssignment(): void
        +createQuiz(): void
        +viewAnalytics(): Map
    }
    
    class Parent {
        -parentId: Long
        -linkedStudents: List
        +viewChildGrades(): List
        +viewAttendance(): List
        +contactTeacher(): void
    }
    
    class Course {
        -courseId: Long
        -title: String
        -description: String
        -teacherId: Long
        -price: Decimal
        -duration: Int
        +addLesson(): void
        +publish(): void
        +updateContent(): void
    }
    
    class Lesson {
        -lessonId: Long
        -courseId: Long
        -title: String
        -content: String
        -videoUrl: String
        +addResource(): void
        +markComplete(): void
    }
    
    class Assignment {
        -assignmentId: Long
        -lessonId: Long
        -title: String
        -description: String
        -dueDate: Date
        +submit(): void
        +grade(): void
    }
    
    class Quiz {
        -quizId: Long
        -courseId: Long
        -title: String
        -questions: List
        -duration: Int
        +addQuestion(): void
        +generateAIQuestions(): void
        +grade(): void
    }
    
    class Grade {
        -gradeId: Long
        -studentId: Long
        -assignmentId: Long
        -score: Float
        -feedback: String
        -gradedBy: Long
        -gradedAt: Timestamp
    }
    
    class Attendance {
        -attendanceId: Long
        -studentId: Long
        -sessionId: Long
        -status: String
        -date: Date
        -recordedAt: Timestamp
    }
    
    class Device {
        -deviceId: Long
        -userId: Long
        -deviceHash: String
        -ipAddress: String
        -lastUsed: Timestamp
        +bindDevice(): void
        +validateDevice(): Boolean
    }
    
    User <|-- Student
    User <|-- Teacher
    User <|-- Parent
    Student "1" -- "*" Course : enrolls
    Teacher "1" -- "*" Course : teaches
    Course "1" -- "*" Lesson : contains
    Lesson "1" -- "*" Assignment : has
    Course "1" -- "*" Quiz : includes
    Student "1" -- "*" Grade : receives
    Student "1" -- "*" Attendance : has
    User "1" -- "*" Device : owns
```

### **3.5 Entity Relationship Diagram (ERD)**

**Figure 3.45: ER Diagram - Database Schema**

```mermaid
erDiagram
    USERS ||--o{ STUDENTS : creates
    USERS ||--o{ TEACHERS : creates
    USERS ||--o{ PARENTS : creates
    USERS ||--o{ DEVICES : binds
    USERS ||--o{ SESSIONS : initiates
    
    STUDENTS ||--o{ ENROLLMENTS : has
    STUDENTS ||--o{ GRADES : receives
    STUDENTS ||--o{ ATTENDANCE : has
    STUDENTS ||--o{ QUIZ_ATTEMPTS : takes
    STUDENTS ||--o{ ASSIGNMENTS_SUBMITTED : submits
    
    TEACHERS ||--o{ COURSES : creates
    TEACHERS ||--o{ GRADES : assigns
    TEACHERS ||--o{ QUIZ_QUESTIONS : creates
    TEACHERS ||--o{ SUPPORT_TICKETS : resolves
    
    PARENTS ||--o{ STUDENTS : monitors
    PARENTS ||--o{ NOTIFICATIONS : receives
    
    COURSES ||--o{ SESSIONS : organizes
    COURSES ||--o{ LESSONS : contains
    COURSES ||--o{ QUIZZES : includes
    COURSES ||--o{ ASSIGNMENTS : has
    COURSES ||--o{ ENROLLMENTS : offers
    
    LESSONS ||--o{ SESSION_ITEMS : structures
    LESSONS ||--o{ ASSIGNMENTS : includes
    
    QUIZZES ||--o{ QUIZ_QUESTIONS : contains
    QUIZZES ||--o{ QUIZ_ATTEMPTS : tests
    
    ASSIGNMENTS ||--o{ GRADES : grades
    ASSIGNMENTS ||--o{ ASSIGNMENTS_SUBMITTED : tracks
    
    QUIZ_ATTEMPTS ||--o{ QUIZ_ANSWERS : records
    QUIZ_ATTEMPTS ||--o{ GRADES : generates
    
    SESSIONS ||--o{ ATTENDANCE : records
    SESSIONS ||--o{ SESSION_ITEMS : contains
```

### **3.6 Block Diagram - System Architecture**

**Figure 3.46: Block Diagram - MentorX System Architecture**

```mermaid
graph TB
    subgraph Client["Client Layer"]
        Web["Web Application<br/>React/Next.js"]
        Mobile["Mobile App<br/>Flutter"]
        Admin["Admin Console"]
    end
    
    subgraph API["API Gateway & Services"]
        Gateway["API Gateway<br/>Kong/AWS Gateway"]
        AuthService["Authentication<br/>Service"]
        UserService["User Management<br/>Service"]
        CourseService["Course Management<br/>Service"]
        GradeService["Grading Service"]
        NotificationService["Notification<br/>Service"]
    end
    
    subgraph AI["AI & ML Services"]
        ChatBot["RAG Chatbot<br/>LLM + Embeddings"]
        PredictionModel["Student Performance<br/>Predictor"]
        Recommender["Lesson<br/>Recommender"]
        QuestionGenerator["AI Question<br/>Generator"]
    end
    
    subgraph Data["Data Layer"]
        MainDB["PostgreSQL<br/>Primary Database"]
        Cache["Redis<br/>Cache"]
        FileStore["S3/Cloud Storage<br/>Media Files"]
        VectorDB["Vector DB<br/>Embeddings"]
    end
    
    subgraph Infra["Infrastructure & Monitoring"]
        DockerK8s["Docker & Kubernetes<br/>Orchestration"]
        Monitoring["Monitoring<br/>Prometheus/ELK"]
        Logging["Centralized Logging<br/>ELK Stack"]
        Security["Security<br/>OAuth2/JWT"]
    end
    
    Web -->|HTTPS| Gateway
    Mobile -->|HTTPS| Gateway
    Admin -->|HTTPS| Gateway
    
    Gateway --> AuthService
    Gateway --> UserService
    Gateway --> CourseService
    Gateway --> GradeService
    Gateway --> NotificationService
    
    CourseService --> AI
    GradeService --> AI
    UserService --> AI
    
    AuthService --> MainDB
    UserService --> MainDB
    CourseService --> MainDB
    GradeService --> MainDB
    
    AuthService --> Cache
    CourseService --> Cache
    
    CourseService --> FileStore
    Recommender --> FileStore
    ChatBot --> VectorDB
    
    Gateway --> Security
    AuthService --> Security
    Monitoring --> Infra
    Logging --> Infra
```

Now I'll create the rest of the comprehensive sections. Let me continue with sections 4.0 onwards:
