///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t_ui = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsWidgetsEn widgets = TranslationsWidgetsEn._(_root);
	late final TranslationsCoreEn core = TranslationsCoreEn._(_root);
	late final TranslationsParentEn parent = TranslationsParentEn._(_root);
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	Map<String, dynamic> get exceptions => {
		'unknown': 'Unknown error',
		'AuthenticationRepositoryExceptionCode': TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(_root),
	};
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Optional'
	String get optional => 'Optional';

	/// en: 'Customization'
	String get customization => 'Customization';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Back to Login'
	String get backToLogin => 'Back to Login';

	/// en: 'No results found'
	String get noResults => 'No results found';

	/// en: 'Opening: ${url}'
	String opening({required Object url}) => 'Opening: ${url}';

	/// en: 'Coming soon'
	String get comingSoon => 'Coming soon';

	/// en: 'Something went wrong'
	String get somethingWentWrong => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Read More'
	String get readMore => 'Read More';

	/// en: 'Read Less'
	String get readLess => 'Read Less';
}

// Path: widgets
class TranslationsWidgetsEn {
	TranslationsWidgetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsWidgetsAnnouncementEn announcement = TranslationsWidgetsAnnouncementEn._(_root);
	late final TranslationsWidgetsAttendanceEn attendance = TranslationsWidgetsAttendanceEn._(_root);
	late final TranslationsWidgetsErrorEn error = TranslationsWidgetsErrorEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'EGP'
	String get currency => 'EGP';
}

// Path: parent
class TranslationsParentEn {
	TranslationsParentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unable to load'
	String get unableToLoad => 'Unable to load';

	/// en: 'Child Wallet Balance'
	String get childWalletBalance => 'Child Wallet Balance';

	/// en: 'Transaction History'
	String get transactionHistory => 'Transaction History';

	/// en: 'Financial Monitor'
	String get financialMonitor => 'Financial Monitor';

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Overall Average'
	String get overallAverage => 'Overall Average';

	/// en: 'No Data'
	String get noData => 'No Data';

	/// en: 'Enrolled Courses'
	String get enrolledCourses => 'Enrolled Courses';

	/// en: 'Academic Monitor'
	String get academicMonitor => 'Academic Monitor';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Recent Activity'
	String get recentActivity => 'Recent Activity';

	/// en: 'Welcome Back'
	String get welcomeBack => 'Welcome Back';

	/// en: 'Account Info'
	String get accountInfo => 'Account Info';

	/// en: 'App Settings'
	String get appSettings => 'App Settings';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Sign Out'
	String get signOut => 'Sign Out';

	/// en: 'My Profile'
	String get myProfile => 'My Profile';

	/// en: 'View All'
	String get viewAll => 'View All';

	late final TranslationsParentAuthEn auth = TranslationsParentAuthEn._(_root);
	late final TranslationsParentChildrenEn children = TranslationsParentChildrenEn._(_root);
	late final TranslationsParentNotificationCenterEn notificationCenter = TranslationsParentNotificationCenterEn._(_root);
	late final TranslationsParentOnboardingEn onboarding = TranslationsParentOnboardingEn._(_root);
	late final TranslationsParentPushNotificationsEn pushNotifications = TranslationsParentPushNotificationsEn._(_root);
	late final TranslationsParentSplashEn splash = TranslationsParentSplashEn._(_root);
	late final TranslationsParentHomeEn home = TranslationsParentHomeEn._(_root);
	late final TranslationsParentAcademicEn academic = TranslationsParentAcademicEn._(_root);
	late final TranslationsParentAssessmentsEn assessments = TranslationsParentAssessmentsEn._(_root);
	late final TranslationsParentGradeDetailEn gradeDetail = TranslationsParentGradeDetailEn._(_root);
	late final TranslationsParentAttendanceTrackingEn attendanceTracking = TranslationsParentAttendanceTrackingEn._(_root);
	late final TranslationsParentFinancialEn financial = TranslationsParentFinancialEn._(_root);
	late final TranslationsParentCourseDetailEn courseDetail = TranslationsParentCourseDetailEn._(_root);
	late final TranslationsParentCommunicationEn communication = TranslationsParentCommunicationEn._(_root);
	late final TranslationsParentAnalyticsEn analytics = TranslationsParentAnalyticsEn._(_root);
	late final TranslationsParentQuickActionsEn quickActions = TranslationsParentQuickActionsEn._(_root);
	late final TranslationsParentProfileEn profile = TranslationsParentProfileEn._(_root);
	late final TranslationsParentDevicesEn devices = TranslationsParentDevicesEn._(_root);
	late final TranslationsParentDeleteAccountEn deleteAccount = TranslationsParentDeleteAccountEn._(_root);
	late final TranslationsParentPendingAccountEn pendingAccount = TranslationsParentPendingAccountEn._(_root);
}

// Path: forms
class TranslationsFormsEn {
	TranslationsFormsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This field is required'
	String get required => 'This field is required';

	/// en: 'It must be ${length: int} letters long at least'
	String minLength({required int length}) => 'It must be ${length} letters long at least';

	/// en: 'The maximum limit is ${length: int} letters'
	String maxLength({required int length}) => 'The maximum limit is ${length} letters';

	/// en: 'It must be ${length: int} digits long at least'
	String minDigitsLength({required int length}) => 'It must be ${length} digits long at least';

	/// en: 'The maximum limit is ${length: int} digits'
	String maxDigitsLength({required int length}) => 'The maximum limit is ${length} digits';

	/// en: 'You must enter a valid email'
	String get youMustEnterAValidEmail => 'You must enter a valid email';
}

// Path: exceptions.AuthenticationRepositoryExceptionCode
class TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn {
	TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unknown error'
	String get unknown => 'Unknown error';

	/// en: 'Invalid phone number'
	String get invalidPhoneNumber => 'Invalid phone number';

	/// en: 'Invalid OTP'
	String get invalidOTP => 'Invalid OTP';

	/// en: 'Failed to initialize'
	String get failedToInitialize => 'Failed to initialize';

	/// en: 'Failed to send OTP'
	String get failedToSendOtp => 'Failed to send OTP';

	/// en: 'Failed to verify OTP'
	String get failedToVerifyOtp => 'Failed to verify OTP';
}

// Path: widgets.announcement
class TranslationsWidgetsAnnouncementEn {
	TranslationsWidgetsAnnouncementEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PINNED'
	String get pinned => 'PINNED';

	/// en: 'UPDATE'
	String get update => 'UPDATE';
}

// Path: widgets.attendance
class TranslationsWidgetsAttendanceEn {
	TranslationsWidgetsAttendanceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Attendance Rate'
	String get rate => 'Attendance Rate';
}

// Path: widgets.error
class TranslationsWidgetsErrorEn {
	TranslationsWidgetsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong'
	String get title => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: parent.auth
class TranslationsParentAuthEn {
	TranslationsParentAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appName => 'MentorX';
	String get loginTagline => 'Stay connected with your child\'s education';
	String get signInToDashboard => 'Sign in to your dashboard';
	String get phoneNumberLabel => 'Phone Number';
	String get phoneNumberHint => 'Enter your phone number';
	String get phoneRequired => 'Phone number is required';
	String get passwordLabel => 'Password';
	String get passwordPlaceholder => 'Enter your password';
	String get passwordRequired => 'Password is required';
	String get confirmPasswordLabel => 'Confirm Password';
	String get newPasswordLabel => 'New Password';
	String get loginFailed => 'Login failed. Please try again';
	String get forgotPassword => 'Forgot Password?';
	String get forgotPasswordTitle => 'Forgot Password';
	String get forgotPasswordSubtitle => 'Enter your phone number to reset your password';
	String get resetPasswordTitle => 'Reset Password';
	String get resetPasswordSubtitle => 'Create a new password for your account';
	String get passwordResetSuccess => 'Password reset successfully';
	String get newToMentorX => 'New to MentorX?';
	String get createAccount => 'Create Account';
	String get backToLogin => 'Back to Login';
	String get otpTitle => 'Verify Your Number';
	String get otpSubtitle => 'Enter the code sent to your phone';
	String get otpFieldLabel => 'Verification Code';
	String get otpFieldHint => 'Enter verification code';
	String get otpCodeLabel => 'OTP Code';
	String get verifyAndContinue => 'Verify & Continue';
	String get verificationFailed => 'Verification failed. Please try again';
	String get sendVerificationCode => 'Send Verification Code';
	String get sendCodeFailed => 'Failed to send verification code';
	String get resendCode => 'Resend Code';
	String resendInSeconds({required int seconds}) => 'Resend in ${seconds}s';
	String get resending => 'Resending...';
	String get updatePasswordNow => 'Update Password Now';
	String get passwordRecoveryHeading => 'Password Recovery';
	String get validationCheckInputs => 'Please check your inputs';
	String get regDefaultTitle => 'Parent Registration';
	String get regLookupPhoneTab => 'By Phone';
	String get regLookupCodeTab => 'By Code';
	String get regStudentCodeLabel => 'Student Code';
	String get regStudentCodeHint => 'Enter student code';
	String get regChildPhoneLabel => 'Child\'s Phone Number';
	String get regChildPhoneHint => 'Enter child\'s phone number';
	String get regFindStudent => 'Find Student';
	String get regStep1Title => 'Find Student';
	String get regStep2Title => 'Confirm Student';
	String get regStep3Title => 'Create Account';
	String get regConfirmIsYourChild => 'Is this your child?';
	String get regChildConfirmed => 'Yes, this is my child';
	String get regConfirmChild => 'Confirm';
	String get regFirstNameLabel => 'First Name';
	String get regFirstNameHint => 'Enter your first name';
	String get regLastNameLabel => 'Last Name';
	String get regLastNameHint => 'Enter your last name';
	String get regEmailLabel => 'Email';
	String get regEmailHint => 'Enter your email';
	String get regRelationshipLabel => 'Relationship';
	String get regYourPhoneHint => 'Enter your phone number';
	String get regSecurityHint => 'Your information is kept private and secure';
	String get regCreateAccount => 'Create Account';
	String get regContinue => 'Continue';
	String get regPleaseWait => 'Please wait...';
	String get regAlreadyHaveAccount => 'Already have an account?';
	String get regErrorLookupEmpty => 'No student found with that information';
	String get regErrorStudentNotFound => 'Student not found';
	String get regErrorFindFailed => 'Failed to find student';
	String get regErrorFindChildFirst => 'Please find the student first';
	String get regErrorConfirmChild => 'Please confirm the student';
	String get regErrorFirstNameShort => 'First name is too short';
	String get regErrorLastNameShort => 'Last name is too short';
	String get regErrorInvalidPhone => 'Invalid phone number';
	String get regErrorInvalidEmail => 'Invalid email address';
	String get regErrorRelationshipRequired => 'Relationship is required';
	String get regErrorPasswordWeak => 'Password is too weak';
	String get regErrorPasswordMismatch => 'Passwords do not match';
	String get regErrorPhoneAlreadyExists => 'This phone number is already registered';
	String get regErrorRegistrationFailed => 'Registration failed. Please try again';
}

// Path: parent.children
class TranslationsParentChildrenEn {
	TranslationsParentChildrenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get lookupEmpty => 'No children found';
}

// Path: parent.notificationCenter
class TranslationsParentNotificationCenterEn {
	TranslationsParentNotificationCenterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Notifications';
	String get read => 'Read';
	String get unread => 'Unread';
	String get markAllRead => 'Mark All as Read';
	String get markAllReadSuccess => 'All notifications marked as read';
	String get markRead => 'Mark as Read';
	String get markReadSuccess => 'Notification marked as read';
	String get loadFailed => 'Failed to load notifications';
	String get noNotificationsTitle => 'No Notifications';
	String get noNotificationsHint => 'You\'re all caught up! Check back later.';
	String get openLink => 'Open Link';
	String get detailsTitle => 'Notification Details';
	String get receivedAt => 'Received At';
	String get student => 'Student';
}

// Path: parent.onboarding
class TranslationsParentOnboardingEn {
	TranslationsParentOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get slide1Title => 'Track Your Child\'s Progress';
	String get slide1Description => 'Get real-time updates on your child\'s academic performance, attendance, and activities';
	String get slide2Title => 'Stay in Touch';
	String get slide2Description => 'Communicate with teachers and receive important announcements directly';
	String get slide3Title => 'Manage Finances Easily';
	String get slide3Description => 'Monitor wallet balance, transactions, and financial activity from one place';
	String get getStarted => 'Get Started';
	String get skip => 'Skip';
}

// Path: parent.pushNotifications
class TranslationsParentPushNotificationsEn {
	TranslationsParentPushNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get bannerOpen => 'Open';
	String get bannerDismiss => 'Dismiss';
}

// Path: parent.splash
class TranslationsParentSplashEn {
	TranslationsParentSplashEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get appName => 'MentorX';
	String get tagline => 'Empowering Every Learner';
}

// Path: parent.home
class TranslationsParentHomeEn {
	TranslationsParentHomeEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get academicStanding => 'Academic Standing';
	String get addChild => 'Add Child';
	String get attendance => 'Attendance';
	String get avgGrade => 'Avg. Grade';
	String get linkChild => 'Link Child';
	String get noChildrenHint => 'Link a student account to get started';
	String get noChildrenTitle => 'No Children Yet';
	String get noRecentActivity => 'No Recent Activity';
	String get noRecentActivityHint => 'Activity from your child\'s learning will appear here';
	String get noRecentGrades => 'No recent grades';
	String get noUpcomingSessions => 'No upcoming sessions';
	String get parentAccount => 'Parent Account';
	String get recentGrades => 'Recent Grades';
	String get unpaidFees => 'Unpaid Fees';
	String get upcomingSessions => 'Upcoming Sessions';
	String updatedAt({required Object time}) => 'Updated at ${time}';
}

// Path: parent.academic
class TranslationsParentAcademicEn {
	TranslationsParentAcademicEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get averageLabel => 'Average';
	String get gradedLabel => 'Graded';
	String get noCoursesHint => 'No enrolled courses found for this child';
	String get noCoursesTitle => 'No Courses';
	String get overallAverageHeading => 'Overall Average';
	String get pageTitle => 'Academic Monitor';
	String get pendingLabel => 'Pending';
	String sessionsCount({required int count}) => '${count} sessions';
}

// Path: parent.assessments
class TranslationsParentAssessmentsEn {
	TranslationsParentAssessmentsEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get assessmentHistory => 'Assessment History';
	String get average => 'Average';
	String get graded => 'Graded';
	String get noAssessmentsHint => 'No assessments have been completed yet';
	String get noAssessmentsTitle => 'No Assessments';
	String get overallPerformance => 'Overall Performance';
	String get pageTitle => 'Grade Monitor';
	String get pending => 'Pending';
	String get quizPrefix => 'Quiz:';
	String scoreLabel({required Object score, required Object total}) => '${score}/${total}';
}

// Path: parent.gradeDetail
class TranslationsParentGradeDetailEn {
	TranslationsParentGradeDetailEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get additionalDetails => 'Additional Details';
	String get assessmentInfo => 'Assessment Info';
	String get correctAnswer => 'Correct Answer';
	String get fail => 'Fail';
	String get incorrectAnswer => 'Incorrect Answer';
	String get notFound => 'Assessment not found';
	String get pageTitle => 'Grade Detail';
	String get pass => 'Pass';
	String get passCriteria => 'Pass Criteria';
	String get percentage => 'Percentage';
	String get questionBreakdown => 'Question Breakdown';
	String questionLabel({required Object number}) => 'Question ${number}';
	String get quizDetail => 'Quiz Detail';
	String get quizId => 'Quiz ID';
	String get quizScore => 'Quiz Score';
	String get result => 'Result';
	String get score => 'Score';
	String get submittedAt => 'Submitted At';
}

// Path: parent.attendanceTracking
class TranslationsParentAttendanceTrackingEn {
	TranslationsParentAttendanceTrackingEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get absent => 'Absent';
	String get attendanceLog => 'Attendance Log';
	String checkInTimeLabel({required Object time}) => 'Check-in: ${time}';
	String get dayFriday => 'Friday';
	String get dayMonday => 'Monday';
	String get daySaturday => 'Saturday';
	String get daySunday => 'Sunday';
	String get dayThursday => 'Thursday';
	String get dayTuesday => 'Tuesday';
	String get dayWednesday => 'Wednesday';
	String get excused => 'Excused';
	String get generalAcademic => 'General Academic';
	String get groupActiveBadge => 'Active';
	String get groupAttendanceRatioLabel => 'Attendance Rate';
	String get groupAttendanceTitle => 'Attendance Summary';
	String groupAttendedSessions({required int count}) => '${count} attended';
	String get groupCourseLabel => 'Course';
	String get groupDescriptionLabel => 'Description';
	String get groupDetailTitle => 'Group Details';
	String groupEndDateLabel({required Object date}) => 'End: ${date}';
	String groupEnrolledLabel({required int count}) => '${count} enrolled';
	String get groupFailureTitle => 'Failed to load group';
	String get groupInactiveBadge => 'Inactive';
	String groupLateSessions({required int count}) => '${count} late';
	String get groupLocationLabel => 'Location';
	String groupMissedSessions({required int count}) => '${count} missed';
	String get groupNoSchedule => 'No schedule available';
	String get groupNotFoundHint => 'The attendance group could not be found';
	String get groupNotFoundTitle => 'Group Not Found';
	String get groupRecentSessionsTitle => 'Recent Sessions';
	String get groupScheduleTitle => 'Schedule';
	String groupSessionRoomLabel({required Object room}) => 'Room: ${room}';
	String groupStartDateLabel({required Object date}) => 'Start: ${date}';
	String get groupTeacherLabel => 'Teacher';
	String groupTotalSessions({required int count}) => '${count} sessions total';
	String get groupsAction => 'Groups';
	String get groupsEmptyHint => 'No attendance groups found';
	String get groupsEmptyTitle => 'No Groups';
	String get groupsHint => 'View your child\'s attendance groups';
	String get groupsTitle => 'Attendance Groups';
	String get late => 'Late';
	String get noRecordsHint => 'No attendance records found for this period';
	String get noRecordsTitle => 'No Records';
	String get onlineSession => 'Online';
	String get pageTitle => 'Attendance Monitor';
	String get present => 'Present';
	String get regularSession => 'Regular Session';
}

// Path: parent.financial
class TranslationsParentFinancialEn {
	TranslationsParentFinancialEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get balance => 'Balance';
	String get creditsThisMonth => 'Credits This Month';
	String get currencySymbol => 'EGP';
	String get myWalletBalanceLabel => 'Wallet Balance';
	String get myWalletTitle => 'My Wallet';
	String get noTransactionsHint => 'No transactions have been made yet';
	String get noTransactionsTitle => 'No Transactions';
	String get points => 'Points';
	String get spent => 'Spent';
	String get topUpAction => 'Top Up';
	String get topUpAmountHint => 'Enter amount';
	String get topUpAmountLabel => 'Amount';
	String get topUpBelowMinimum => 'Amount is below the minimum';
	String get topUpFailed => 'Top up failed. Please try again';
	String get topUpHint => 'Add funds to your child\'s wallet';
	String get topUpInsufficientFunds => 'Insufficient funds';
	String get topUpInvalidAmount => 'Invalid amount';
	String get topUpSuccess => 'Wallet topped up successfully';
	String get topUpTitle => 'Top Up Wallet';
	String get transactionsTitle => 'Transaction History';
}

// Path: parent.courseDetail
class TranslationsParentCourseDetailEn {
	TranslationsParentCourseDetailEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get courseBreakdown => 'Course Breakdown';
	String get courseId => 'Course ID';
	String get descriptionLabel => 'Description';
	String get emptyHint => 'No course data available';
	String get emptyTitle => 'No Courses';
	String enrolledCount({required int count}) => '${count} enrolled';
	String get failureTitle => 'Failed to load course';
	String get fullTitle => 'Full Course';
	String get pageTitle => 'Course Detail';
	String get progress => 'Progress';
	String get status => 'Status';
	String get statusActive => 'Active';
	String get statusCompleted => 'Completed';
	String get statusInProgress => 'In Progress';
	String get statusLabel => 'Course Status';
}

// Path: parent.communication
class TranslationsParentCommunicationEn {
	TranslationsParentCommunicationEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get announcementsTitle => 'Announcements';
	String get groupSubtitle => 'Join your child\'s WhatsApp group';
	String get joinGroup => 'Join Group';
	String get noAnnouncementsHint => 'No announcements at this time';
	String get noAnnouncementsTitle => 'No Announcements';
	String get noGroupsHint => 'No WhatsApp groups available';
	String get noGroupsTitle => 'No Groups';
	String get readMore => 'Read More';
	String get whatsAppTitle => 'WhatsApp Groups';
}

// Path: parent.analytics
class TranslationsParentAnalyticsEn {
	TranslationsParentAnalyticsEn._(this._root);
	final Translations _root; // ignore: unused_field
	String averagePerDay({required Object minutes}) => '${minutes} min/day';
	String averageQuizSpeed({required Object seconds}) => '${seconds}s avg';
	String get childAverageLabel => 'Child\'s Average';
	String get classAverageLabel => 'Class Average';
	String completedSessionsLabel({required int completed, required int total}) => '${completed}/${total} sessions';
	String get currentStreak => 'Current Streak';
	String get emptySectionHint => 'No data available for this section';
	String get emptySectionTitle => 'No Data';
	String get errorRetry => 'Retry';
	String lastActive({required Object time}) => 'Last active: ${time}';
	String get loadFailed => 'Failed to load analytics';
	String get longestStreak => 'Longest Streak';
	String get pageTitle => 'Analytics';
	String quizCountLabel({required int count}) => '${count} quizzes';
	String rankLabel({required int rank, required int total}) => '#${rank} of ${total}';
	String get sectionAchievements => 'Achievements';
	String get sectionActiveHours => 'Active Hours';
	String get sectionCourseProgress => 'Course Progress';
	String get sectionGradeComparison => 'Grade Comparison';
	String get sectionQuizSpeed => 'Quiz Speed';
	String get sectionStreak => 'Streak';
	String streakDays({required int days}) => '${days} days';
	String totalMinutes({required int minutes}) => '${minutes} min total';
	String get unauthorized => 'You are not authorized to view this';
	String unlockedCount({required int unlocked}) => '${unlocked} unlocked';
}

// Path: parent.quickActions
class TranslationsParentQuickActionsEn {
	TranslationsParentQuickActionsEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get announcements => 'Announcements';
	String get attendance => 'Attendance';
	String get courses => 'Courses';
	String get fees => 'Fees';
	String get grades => 'Grades';
	String get messages => 'Messages';
}

// Path: parent.profile
class TranslationsParentProfileEn {
	TranslationsParentProfileEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get aboutTitle => 'About';
	String aboutVersion({required Object version}) => 'v${version}';
	String get appConfigurationSection => 'App Configuration';
	String get appLanguage => 'Language';
	String get avatarChangeAction => 'Change Photo';
	String get avatarInvalidImage => 'Invalid image format';
	String get avatarPickFromGallery => 'Choose from Gallery';
	String get avatarTakePhoto => 'Take Photo';
	String get avatarUploadFailed => 'Failed to upload photo';
	String get avatarUploading => 'Uploading...';
	String get changePasswordAction => 'Change Password';
	String get changePasswordConfirmLabel => 'Confirm New Password';
	String get changePasswordCurrentLabel => 'Current Password';
	String get changePasswordCurrentRequired => 'Current password is required';
	String get changePasswordFailed => 'Failed to change password';
	String get changePasswordHint => 'Choose a strong password to keep your account secure';
	String get changePasswordMismatch => 'New passwords do not match';
	String get changePasswordNewLabel => 'New Password';
	String get changePasswordSuccess => 'Password changed successfully';
	String get changePasswordTitle => 'Change Password';
	String get changePasswordTooWeak => 'Password is too weak';
	String get changePasswordWrongCurrent => 'Current password is incorrect';
	String get editFullNameHint => 'Enter your full name';
	String get editFullNameLabel => 'Full Name';
	String get editFullNameTooShort => 'Name is too short';
	String get editLoadFailed => 'Failed to load profile';
	String get editNetworkError => 'Network error. Please try again';
	String get editSaveAction => 'Save';
	String get editSaveFailed => 'Failed to save changes';
	String get editSaveSuccess => 'Profile updated successfully';
	String get editTitle => 'Edit Profile';
	String get editUnauthorized => 'You are not authorized to edit this profile';
	String get emailLabel => 'Email';
	String get fallbackName => 'Parent';
	String get fullNameLabel => 'Full Name';
	String get helpCenter => 'Help Center';
	String get helpCenterValue => 'Visit support page';
	String get languageArabic => 'Arabic';
	String get languageEnglish => 'English';
	String get notificationsEnabled => 'Push Notifications';
	String get phoneNumberLabel => 'Phone Number';
	String get preferencesSection => 'Preferences';
	String get pushNotifications => 'Push Notifications';
	String get securityChangePassword => 'Change Password';
	String get securityValue => 'Password & Security';
	String settingsAboutBody({required Object version}) => 'MentorX Parent App v${version}\n\nMonitor your child\'s academic journey in real time.';
	String get settingsAboutTitle => 'About MentorX';
	String get settingsHelpUrl => 'https://mentorx.app/support';
	String get settingsTitle => 'Settings';
	String get signOutAction => 'Sign Out';
	String get signOutCancel => 'Cancel';
	String get signOutConfirmMessage => 'Are you sure you want to sign out?';
	String get signOutConfirmTitle => 'Sign Out';
	String get supportSection => 'Support';
	String get themeDark => 'Dark';
	String get themeLight => 'Light';
	String get themeMode => 'Theme';
	String get themeSystem => 'System';
	String get verifiedAccount => 'Verified Account';
}

// Path: parent.devices
class TranslationsParentDevicesEn {
	TranslationsParentDevicesEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get activeBadge => 'Active';
	String get cancel => 'Cancel';
	String get currentBadge => 'This Device';
	String get emptyHint => 'No devices have been linked to your account';
	String get emptyTitle => 'No Devices';
	String get forceLogoutAction => 'Force Logout All';
	String get forceLogoutConfirmMessage => 'This will log out all other devices. Continue?';
	String get forceLogoutConfirmTitle => 'Force Logout';
	String get forceLogoutHint => 'Log out all other active devices';
	String get forceLogoutSuccess => 'All other devices have been logged out';
	String get forceLogoutTitle => 'Force Logout';
	String get inactiveBadge => 'Inactive';
	String lastUsedLabel({required Object time}) => 'Last used: ${time}';
	String get pageSubtitle => 'Manage devices with access to your account';
	String get pageTitle => 'Trusted Devices';
	String get revokeAction => 'Revoke';
	String get revokeConfirmMessage => 'Remove access for this device?';
	String get revokeConfirmTitle => 'Revoke Device';
	String get revokeSuccess => 'Device access revoked';
	String get settingsSubtitle => 'Manage trusted devices';
}

// Path: parent.deleteAccount
class TranslationsParentDeleteAccountEn {
	TranslationsParentDeleteAccountEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get acknowledgementLabel => 'I understand this action is permanent';
	String get cancel => 'Cancel';
	String get confirmAction => 'Delete My Account';
	String get confirmationPhrase => 'DELETE';
	String confirmationPrompt({required Object phrase}) => 'Type "${phrase}" to confirm';
	String get consequence => 'All your data including profile, history, and linked accounts will be permanently deleted';
	String get consequencesTitle => 'What will be deleted';
	String get dataExportHint => 'You can request a copy of your data before deleting';
	String get dataExportLabel => 'Export My Data';
	String get finalConfirmMessage => 'Your account will be permanently deleted within 24 hours. This cannot be undone.';
	String get finalConfirmTitle => 'Final Confirmation';
	String get networkError => 'Network error. Please try again';
	String get pageTitle => 'Delete Account';
	String get reasonHint => 'Tell us why you\'re leaving (optional)';
	String get reasonLabel => 'Reason for Deletion';
	String get settingsTileLabel => 'Delete Account';
	String get settingsTileSubtitle => 'Permanently remove your account';
	String get submitting => 'Processing your request...';
	String get successMessage => 'Your account deletion request has been submitted';
	String get unauthorizedError => 'You are not authorized to perform this action';
	String get unknownError => 'An unknown error occurred';
	String get validationError => 'Please complete all required fields';
	String get warningSubtitle => 'This action is permanent and cannot be undone';
	String get warningTitle => 'Warning';
}

// Path: parent.pendingAccount
class TranslationsParentPendingAccountEn {
	TranslationsParentPendingAccountEn._(this._root);
	final Translations _root; // ignore: unused_field
	String get approvedToastMessage => 'Your account has been approved!';
	String get cancel => 'Cancel';
	String get checkAgain => 'Check Status';
	String get checking => 'Checking...';
	String get contactSupport => 'Contact Support';
	String get contactSupportHint => 'If you have questions, reach out to our support team';
	String estimatedReviewBy({required Object date}) => 'Estimated review by: ${date}';
	String get headlinePending => 'Account Under Review';
	String get headlineRejected => 'Account Not Approved';
	String get loadErrorMessage => 'Failed to load account status';
	String get loadErrorTitle => 'Error';
	String get pageTitle => 'Account Status';
	String get rejectionReasonTitle => 'Reason';
	String get signOut => 'Sign Out';
	String get signOutConfirmMessage => 'Are you sure you want to sign out?';
	String get signOutConfirmTitle => 'Sign Out';
	String get statusBadgePending => 'Pending';
	String get statusBadgeRejected => 'Rejected';
	String get stepApproved => 'Approved';
	String get stepApprovedHint => 'Your account is active';
	String get stepReceived => 'Application Received';
	String get stepReceivedHint => 'We have received your registration';
	String get stepUnderReview => 'Under Review';
	String get stepUnderReviewHint => 'Our team is reviewing your application';
	String submittedOn({required Object date}) => 'Submitted on: ${date}';
	String get subtitlePending => 'Our team is reviewing your registration. You\'ll be notified once approved.';
	String get subtitleRejected => 'Your registration was not approved. Please contact support for assistance.';
	String get supportLabel => 'Support';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.cancel' => 'Cancel',
			'common.ok' => 'OK',
			'common.viewAll' => 'View All',
			'common.required' => 'Required',
			'common.optional' => 'Optional',
			'common.customization' => 'Customization',
			'common.skip' => 'Skip',
			'common.next' => 'Next',
			'common.getStarted' => 'Get Started',
			'common.backToLogin' => 'Back to Login',
			'common.noResults' => 'No results found',
			'common.opening' => ({required Object url}) => 'Opening: ${url}',
			'common.comingSoon' => 'Coming soon',
			'common.somethingWentWrong' => 'Something went wrong',
			'common.retry' => 'Retry',
			'common.readMore' => 'Read More',
			'common.readLess' => 'Read Less',
			'widgets.announcement.pinned' => 'PINNED',
			'widgets.announcement.update' => 'UPDATE',
			'widgets.attendance.rate' => 'Attendance Rate',
			'widgets.error.title' => 'Something went wrong',
			'widgets.error.retry' => 'Retry',
			'core.currency' => 'EGP',
			'parent.unableToLoad' => 'Unable to load',
			'parent.childWalletBalance' => 'Child Wallet Balance',
			'parent.transactionHistory' => 'Transaction History',
			'parent.financialMonitor' => 'Financial Monitor',
			'parent.announcements' => 'Announcements',
			'parent.overallAverage' => 'Overall Average',
			'parent.noData' => 'No Data',
			'parent.enrolledCourses' => 'Enrolled Courses',
			'parent.academicMonitor' => 'Academic Monitor',
			'parent.services' => 'Services',
			'parent.recentActivity' => 'Recent Activity',
			'parent.welcomeBack' => 'Welcome Back',
			'parent.accountInfo' => 'Account Info',
			'parent.appSettings' => 'App Settings',
			'parent.notifications' => 'Notifications',
			'parent.security' => 'Security',
			'parent.signOut' => 'Sign Out',
			'parent.myProfile' => 'My Profile',
			'parent.viewAll' => 'View All',
			'parent.auth.appName' => 'MentorX',
			'parent.auth.loginTagline' => 'Stay connected with your child\'s education',
			'parent.auth.signInToDashboard' => 'Sign in to your dashboard',
			'parent.auth.phoneNumberLabel' => 'Phone Number',
			'parent.auth.phoneNumberHint' => 'Enter your phone number',
			'parent.auth.phoneRequired' => 'Phone number is required',
			'parent.auth.passwordLabel' => 'Password',
			'parent.auth.passwordPlaceholder' => 'Enter your password',
			'parent.auth.passwordRequired' => 'Password is required',
			'parent.auth.confirmPasswordLabel' => 'Confirm Password',
			'parent.auth.newPasswordLabel' => 'New Password',
			'parent.auth.loginFailed' => 'Login failed. Please try again',
			'parent.auth.forgotPassword' => 'Forgot Password?',
			'parent.auth.forgotPasswordTitle' => 'Forgot Password',
			'parent.auth.forgotPasswordSubtitle' => 'Enter your phone number to reset your password',
			'parent.auth.resetPasswordTitle' => 'Reset Password',
			'parent.auth.resetPasswordSubtitle' => 'Create a new password for your account',
			'parent.auth.passwordResetSuccess' => 'Password reset successfully',
			'parent.auth.newToMentorX' => 'New to MentorX?',
			'parent.auth.createAccount' => 'Create Account',
			'parent.auth.backToLogin' => 'Back to Login',
			'parent.auth.otpTitle' => 'Verify Your Number',
			'parent.auth.otpSubtitle' => 'Enter the code sent to your phone',
			'parent.auth.otpFieldLabel' => 'Verification Code',
			'parent.auth.otpFieldHint' => 'Enter verification code',
			'parent.auth.otpCodeLabel' => 'OTP Code',
			'parent.auth.verifyAndContinue' => 'Verify & Continue',
			'parent.auth.verificationFailed' => 'Verification failed. Please try again',
			'parent.auth.sendVerificationCode' => 'Send Verification Code',
			'parent.auth.sendCodeFailed' => 'Failed to send verification code',
			'parent.auth.resendCode' => 'Resend Code',
			'parent.auth.resendInSeconds' => ({required int seconds}) => 'Resend in ${seconds}s',
			'parent.auth.resending' => 'Resending...',
			'parent.auth.updatePasswordNow' => 'Update Password Now',
			'parent.auth.passwordRecoveryHeading' => 'Password Recovery',
			'parent.auth.validationCheckInputs' => 'Please check your inputs',
			'parent.auth.regDefaultTitle' => 'Parent Registration',
			'parent.auth.regLookupPhoneTab' => 'By Phone',
			'parent.auth.regLookupCodeTab' => 'By Code',
			'parent.auth.regStudentCodeLabel' => 'Student Code',
			'parent.auth.regStudentCodeHint' => 'Enter student code',
			'parent.auth.regChildPhoneLabel' => 'Child\'s Phone Number',
			'parent.auth.regChildPhoneHint' => 'Enter child\'s phone number',
			'parent.auth.regFindStudent' => 'Find Student',
			'parent.auth.regStep1Title' => 'Find Student',
			'parent.auth.regStep2Title' => 'Confirm Student',
			'parent.auth.regStep3Title' => 'Create Account',
			'parent.auth.regConfirmIsYourChild' => 'Is this your child?',
			'parent.auth.regChildConfirmed' => 'Yes, this is my child',
			'parent.auth.regConfirmChild' => 'Confirm',
			'parent.auth.regFirstNameLabel' => 'First Name',
			'parent.auth.regFirstNameHint' => 'Enter your first name',
			'parent.auth.regLastNameLabel' => 'Last Name',
			'parent.auth.regLastNameHint' => 'Enter your last name',
			'parent.auth.regEmailLabel' => 'Email',
			'parent.auth.regEmailHint' => 'Enter your email',
			'parent.auth.regRelationshipLabel' => 'Relationship',
			'parent.auth.regYourPhoneHint' => 'Enter your phone number',
			'parent.auth.regSecurityHint' => 'Your information is kept private and secure',
			'parent.auth.regCreateAccount' => 'Create Account',
			'parent.auth.regContinue' => 'Continue',
			'parent.auth.regPleaseWait' => 'Please wait...',
			'parent.auth.regAlreadyHaveAccount' => 'Already have an account?',
			'parent.auth.regErrorLookupEmpty' => 'No student found with that information',
			'parent.auth.regErrorStudentNotFound' => 'Student not found',
			'parent.auth.regErrorFindFailed' => 'Failed to find student',
			'parent.auth.regErrorFindChildFirst' => 'Please find the student first',
			'parent.auth.regErrorConfirmChild' => 'Please confirm the student',
			'parent.auth.regErrorFirstNameShort' => 'First name is too short',
			'parent.auth.regErrorLastNameShort' => 'Last name is too short',
			'parent.auth.regErrorInvalidPhone' => 'Invalid phone number',
			'parent.auth.regErrorInvalidEmail' => 'Invalid email address',
			'parent.auth.regErrorRelationshipRequired' => 'Relationship is required',
			'parent.auth.regErrorPasswordWeak' => 'Password is too weak',
			'parent.auth.regErrorPasswordMismatch' => 'Passwords do not match',
			'parent.auth.regErrorPhoneAlreadyExists' => 'This phone number is already registered',
			'parent.auth.regErrorRegistrationFailed' => 'Registration failed. Please try again',
			'parent.children.lookupEmpty' => 'No children found',
			'parent.notificationCenter.title' => 'Notifications',
			'parent.notificationCenter.read' => 'Read',
			'parent.notificationCenter.unread' => 'Unread',
			'parent.notificationCenter.markAllRead' => 'Mark All as Read',
			'parent.notificationCenter.markAllReadSuccess' => 'All notifications marked as read',
			'parent.notificationCenter.markRead' => 'Mark as Read',
			'parent.notificationCenter.markReadSuccess' => 'Notification marked as read',
			'parent.notificationCenter.loadFailed' => 'Failed to load notifications',
			'parent.notificationCenter.noNotificationsTitle' => 'No Notifications',
			'parent.notificationCenter.noNotificationsHint' => 'You\'re all caught up! Check back later.',
			'parent.notificationCenter.openLink' => 'Open Link',
			'parent.notificationCenter.detailsTitle' => 'Notification Details',
			'parent.notificationCenter.receivedAt' => 'Received At',
			'parent.notificationCenter.student' => 'Student',
			'parent.onboarding.slide1Title' => 'Track Your Child\'s Progress',
			'parent.onboarding.slide1Description' => 'Get real-time updates on your child\'s academic performance, attendance, and activities',
			'parent.onboarding.slide2Title' => 'Stay in Touch',
			'parent.onboarding.slide2Description' => 'Communicate with teachers and receive important announcements directly',
			'parent.onboarding.slide3Title' => 'Manage Finances Easily',
			'parent.onboarding.slide3Description' => 'Monitor wallet balance, transactions, and financial activity from one place',
			'parent.onboarding.getStarted' => 'Get Started',
			'parent.onboarding.skip' => 'Skip',
			'parent.pushNotifications.bannerOpen' => 'Open',
			'parent.pushNotifications.bannerDismiss' => 'Dismiss',
			'forms.required' => 'This field is required',
			'forms.minLength' => ({required int length}) => 'It must be ${length} letters long at least',
			'forms.maxLength' => ({required int length}) => 'The maximum limit is ${length} letters',
			'forms.minDigitsLength' => ({required int length}) => 'It must be ${length} digits long at least',
			'forms.maxDigitsLength' => ({required int length}) => 'The maximum limit is ${length} digits',
			'forms.youMustEnterAValidEmail' => 'You must enter a valid email',
			'exceptions.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'Invalid phone number',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'Invalid OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'Failed to initialize',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'Failed to send OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'Failed to verify OTP',
			'parent.splash.appName' => 'MentorX',
			'parent.splash.tagline' => 'Empowering Every Learner',
			'parent.home.academicStanding' => 'Academic Standing',
			'parent.home.addChild' => 'Add Child',
			'parent.home.attendance' => 'Attendance',
			'parent.home.avgGrade' => 'Avg. Grade',
			'parent.home.linkChild' => 'Link Child',
			'parent.home.noChildrenHint' => 'Link a student account to get started',
			'parent.home.noChildrenTitle' => 'No Children Yet',
			'parent.home.noRecentActivity' => 'No Recent Activity',
			'parent.home.noRecentActivityHint' => 'Activity from your child\'s learning will appear here',
			'parent.home.noRecentGrades' => 'No recent grades',
			'parent.home.noUpcomingSessions' => 'No upcoming sessions',
			'parent.home.parentAccount' => 'Parent Account',
			'parent.home.recentGrades' => 'Recent Grades',
			'parent.home.unpaidFees' => 'Unpaid Fees',
			'parent.home.upcomingSessions' => 'Upcoming Sessions',
			'parent.home.updatedAt' => ({required Object time}) => 'Updated at ${time}',
			'parent.academic.averageLabel' => 'Average',
			'parent.academic.gradedLabel' => 'Graded',
			'parent.academic.noCoursesHint' => 'No enrolled courses found for this child',
			'parent.academic.noCoursesTitle' => 'No Courses',
			'parent.academic.overallAverageHeading' => 'Overall Average',
			'parent.academic.pageTitle' => 'Academic Monitor',
			'parent.academic.pendingLabel' => 'Pending',
			'parent.academic.sessionsCount' => ({required int count}) => '${count} sessions',
			'parent.assessments.assessmentHistory' => 'Assessment History',
			'parent.assessments.average' => 'Average',
			'parent.assessments.graded' => 'Graded',
			'parent.assessments.noAssessmentsHint' => 'No assessments have been completed yet',
			'parent.assessments.noAssessmentsTitle' => 'No Assessments',
			'parent.assessments.overallPerformance' => 'Overall Performance',
			'parent.assessments.pageTitle' => 'Grade Monitor',
			'parent.assessments.pending' => 'Pending',
			'parent.assessments.quizPrefix' => 'Quiz:',
			'parent.assessments.scoreLabel' => ({required Object score, required Object total}) => '${score}/${total}',
			'parent.gradeDetail.additionalDetails' => 'Additional Details',
			'parent.gradeDetail.assessmentInfo' => 'Assessment Info',
			'parent.gradeDetail.correctAnswer' => 'Correct Answer',
			'parent.gradeDetail.fail' => 'Fail',
			'parent.gradeDetail.incorrectAnswer' => 'Incorrect Answer',
			'parent.gradeDetail.notFound' => 'Assessment not found',
			'parent.gradeDetail.pageTitle' => 'Grade Detail',
			'parent.gradeDetail.pass' => 'Pass',
			'parent.gradeDetail.passCriteria' => 'Pass Criteria',
			'parent.gradeDetail.percentage' => 'Percentage',
			'parent.gradeDetail.questionBreakdown' => 'Question Breakdown',
			'parent.gradeDetail.questionLabel' => ({required Object number}) => 'Question ${number}',
			'parent.gradeDetail.quizDetail' => 'Quiz Detail',
			'parent.gradeDetail.quizId' => 'Quiz ID',
			'parent.gradeDetail.quizScore' => 'Quiz Score',
			'parent.gradeDetail.result' => 'Result',
			'parent.gradeDetail.score' => 'Score',
			'parent.gradeDetail.submittedAt' => 'Submitted At',
			'parent.attendanceTracking.absent' => 'Absent',
			'parent.attendanceTracking.attendanceLog' => 'Attendance Log',
			'parent.attendanceTracking.checkInTimeLabel' => ({required Object time}) => 'Check-in: ${time}',
			'parent.attendanceTracking.dayFriday' => 'Friday',
			'parent.attendanceTracking.dayMonday' => 'Monday',
			'parent.attendanceTracking.daySaturday' => 'Saturday',
			'parent.attendanceTracking.daySunday' => 'Sunday',
			'parent.attendanceTracking.dayThursday' => 'Thursday',
			'parent.attendanceTracking.dayTuesday' => 'Tuesday',
			'parent.attendanceTracking.dayWednesday' => 'Wednesday',
			'parent.attendanceTracking.excused' => 'Excused',
			'parent.attendanceTracking.generalAcademic' => 'General Academic',
			'parent.attendanceTracking.groupActiveBadge' => 'Active',
			'parent.attendanceTracking.groupAttendanceRatioLabel' => 'Attendance Rate',
			'parent.attendanceTracking.groupAttendanceTitle' => 'Attendance Summary',
			'parent.attendanceTracking.groupAttendedSessions' => ({required int count}) => '${count} attended',
			'parent.attendanceTracking.groupCourseLabel' => 'Course',
			'parent.attendanceTracking.groupDescriptionLabel' => 'Description',
			'parent.attendanceTracking.groupDetailTitle' => 'Group Details',
			'parent.attendanceTracking.groupEndDateLabel' => ({required Object date}) => 'End: ${date}',
			'parent.attendanceTracking.groupEnrolledLabel' => ({required int count}) => '${count} enrolled',
			'parent.attendanceTracking.groupFailureTitle' => 'Failed to load group',
			'parent.attendanceTracking.groupInactiveBadge' => 'Inactive',
			'parent.attendanceTracking.groupLateSessions' => ({required int count}) => '${count} late',
			'parent.attendanceTracking.groupLocationLabel' => 'Location',
			'parent.attendanceTracking.groupMissedSessions' => ({required int count}) => '${count} missed',
			'parent.attendanceTracking.groupNoSchedule' => 'No schedule available',
			'parent.attendanceTracking.groupNotFoundHint' => 'The attendance group could not be found',
			'parent.attendanceTracking.groupNotFoundTitle' => 'Group Not Found',
			'parent.attendanceTracking.groupRecentSessionsTitle' => 'Recent Sessions',
			'parent.attendanceTracking.groupScheduleTitle' => 'Schedule',
			'parent.attendanceTracking.groupSessionRoomLabel' => ({required Object room}) => 'Room: ${room}',
			'parent.attendanceTracking.groupStartDateLabel' => ({required Object date}) => 'Start: ${date}',
			'parent.attendanceTracking.groupTeacherLabel' => 'Teacher',
			'parent.attendanceTracking.groupTotalSessions' => ({required int count}) => '${count} sessions total',
			'parent.attendanceTracking.groupsAction' => 'Groups',
			'parent.attendanceTracking.groupsEmptyHint' => 'No attendance groups found',
			'parent.attendanceTracking.groupsEmptyTitle' => 'No Groups',
			'parent.attendanceTracking.groupsHint' => 'View your child\'s attendance groups',
			'parent.attendanceTracking.groupsTitle' => 'Attendance Groups',
			'parent.attendanceTracking.late' => 'Late',
			'parent.attendanceTracking.noRecordsHint' => 'No attendance records found for this period',
			'parent.attendanceTracking.noRecordsTitle' => 'No Records',
			'parent.attendanceTracking.onlineSession' => 'Online',
			'parent.attendanceTracking.pageTitle' => 'Attendance Monitor',
			'parent.attendanceTracking.present' => 'Present',
			'parent.attendanceTracking.regularSession' => 'Regular Session',
			'parent.financial.balance' => 'Balance',
			'parent.financial.creditsThisMonth' => 'Credits This Month',
			'parent.financial.currencySymbol' => 'EGP',
			'parent.financial.myWalletBalanceLabel' => 'Wallet Balance',
			'parent.financial.myWalletTitle' => 'My Wallet',
			'parent.financial.noTransactionsHint' => 'No transactions have been made yet',
			'parent.financial.noTransactionsTitle' => 'No Transactions',
			'parent.financial.points' => 'Points',
			'parent.financial.spent' => 'Spent',
			'parent.financial.topUpAction' => 'Top Up',
			'parent.financial.topUpAmountHint' => 'Enter amount',
			'parent.financial.topUpAmountLabel' => 'Amount',
			'parent.financial.topUpBelowMinimum' => 'Amount is below the minimum',
			'parent.financial.topUpFailed' => 'Top up failed. Please try again',
			'parent.financial.topUpHint' => 'Add funds to your child\'s wallet',
			'parent.financial.topUpInsufficientFunds' => 'Insufficient funds',
			'parent.financial.topUpInvalidAmount' => 'Invalid amount',
			'parent.financial.topUpSuccess' => 'Wallet topped up successfully',
			'parent.financial.topUpTitle' => 'Top Up Wallet',
			'parent.financial.transactionsTitle' => 'Transaction History',
			'parent.courseDetail.courseBreakdown' => 'Course Breakdown',
			'parent.courseDetail.courseId' => 'Course ID',
			'parent.courseDetail.descriptionLabel' => 'Description',
			'parent.courseDetail.emptyHint' => 'No course data available',
			'parent.courseDetail.emptyTitle' => 'No Courses',
			'parent.courseDetail.enrolledCount' => ({required int count}) => '${count} enrolled',
			'parent.courseDetail.failureTitle' => 'Failed to load course',
			'parent.courseDetail.fullTitle' => 'Full Course',
			'parent.courseDetail.pageTitle' => 'Course Detail',
			'parent.courseDetail.progress' => 'Progress',
			'parent.courseDetail.status' => 'Status',
			'parent.courseDetail.statusActive' => 'Active',
			'parent.courseDetail.statusCompleted' => 'Completed',
			'parent.courseDetail.statusInProgress' => 'In Progress',
			'parent.courseDetail.statusLabel' => 'Course Status',
			'parent.communication.announcementsTitle' => 'Announcements',
			'parent.communication.groupSubtitle' => 'Join your child\'s WhatsApp group',
			'parent.communication.joinGroup' => 'Join Group',
			'parent.communication.noAnnouncementsHint' => 'No announcements at this time',
			'parent.communication.noAnnouncementsTitle' => 'No Announcements',
			'parent.communication.noGroupsHint' => 'No WhatsApp groups available',
			'parent.communication.noGroupsTitle' => 'No Groups',
			'parent.communication.readMore' => 'Read More',
			'parent.communication.whatsAppTitle' => 'WhatsApp Groups',
			'parent.analytics.averagePerDay' => ({required Object minutes}) => '${minutes} min/day',
			'parent.analytics.averageQuizSpeed' => ({required Object seconds}) => '${seconds}s avg',
			'parent.analytics.childAverageLabel' => 'Child\'s Average',
			'parent.analytics.classAverageLabel' => 'Class Average',
			'parent.analytics.completedSessionsLabel' => ({required int completed, required int total}) => '${completed}/${total} sessions',
			'parent.analytics.currentStreak' => 'Current Streak',
			'parent.analytics.emptySectionHint' => 'No data available for this section',
			'parent.analytics.emptySectionTitle' => 'No Data',
			'parent.analytics.errorRetry' => 'Retry',
			'parent.analytics.lastActive' => ({required Object time}) => 'Last active: ${time}',
			'parent.analytics.loadFailed' => 'Failed to load analytics',
			'parent.analytics.longestStreak' => 'Longest Streak',
			'parent.analytics.pageTitle' => 'Analytics',
			'parent.analytics.quizCountLabel' => ({required int count}) => '${count} quizzes',
			'parent.analytics.rankLabel' => ({required int rank, required int total}) => '#${rank} of ${total}',
			'parent.analytics.sectionAchievements' => 'Achievements',
			'parent.analytics.sectionActiveHours' => 'Active Hours',
			'parent.analytics.sectionCourseProgress' => 'Course Progress',
			'parent.analytics.sectionGradeComparison' => 'Grade Comparison',
			'parent.analytics.sectionQuizSpeed' => 'Quiz Speed',
			'parent.analytics.sectionStreak' => 'Streak',
			'parent.analytics.streakDays' => ({required int days}) => '${days} days',
			'parent.analytics.totalMinutes' => ({required int minutes}) => '${minutes} min total',
			'parent.analytics.unauthorized' => 'You are not authorized to view this',
			'parent.analytics.unlockedCount' => ({required int unlocked}) => '${unlocked} unlocked',
			'parent.quickActions.announcements' => 'Announcements',
			'parent.quickActions.attendance' => 'Attendance',
			'parent.quickActions.courses' => 'Courses',
			'parent.quickActions.fees' => 'Fees',
			'parent.quickActions.grades' => 'Grades',
			'parent.quickActions.messages' => 'Messages',
			'parent.profile.aboutTitle' => 'About',
			'parent.profile.aboutVersion' => ({required Object version}) => 'v${version}',
			'parent.profile.appConfigurationSection' => 'App Configuration',
			'parent.profile.appLanguage' => 'Language',
			'parent.profile.avatarChangeAction' => 'Change Photo',
			'parent.profile.avatarInvalidImage' => 'Invalid image format',
			'parent.profile.avatarPickFromGallery' => 'Choose from Gallery',
			'parent.profile.avatarTakePhoto' => 'Take Photo',
			'parent.profile.avatarUploadFailed' => 'Failed to upload photo',
			'parent.profile.avatarUploading' => 'Uploading...',
			'parent.profile.changePasswordAction' => 'Change Password',
			'parent.profile.changePasswordConfirmLabel' => 'Confirm New Password',
			'parent.profile.changePasswordCurrentLabel' => 'Current Password',
			'parent.profile.changePasswordCurrentRequired' => 'Current password is required',
			'parent.profile.changePasswordFailed' => 'Failed to change password',
			'parent.profile.changePasswordHint' => 'Choose a strong password to keep your account secure',
			'parent.profile.changePasswordMismatch' => 'New passwords do not match',
			'parent.profile.changePasswordNewLabel' => 'New Password',
			'parent.profile.changePasswordSuccess' => 'Password changed successfully',
			'parent.profile.changePasswordTitle' => 'Change Password',
			'parent.profile.changePasswordTooWeak' => 'Password is too weak',
			'parent.profile.changePasswordWrongCurrent' => 'Current password is incorrect',
			'parent.profile.editFullNameHint' => 'Enter your full name',
			'parent.profile.editFullNameLabel' => 'Full Name',
			'parent.profile.editFullNameTooShort' => 'Name is too short',
			'parent.profile.editLoadFailed' => 'Failed to load profile',
			'parent.profile.editNetworkError' => 'Network error. Please try again',
			'parent.profile.editSaveAction' => 'Save',
			'parent.profile.editSaveFailed' => 'Failed to save changes',
			'parent.profile.editSaveSuccess' => 'Profile updated successfully',
			'parent.profile.editTitle' => 'Edit Profile',
			'parent.profile.editUnauthorized' => 'You are not authorized to edit this profile',
			'parent.profile.emailLabel' => 'Email',
			'parent.profile.fallbackName' => 'Parent',
			'parent.profile.fullNameLabel' => 'Full Name',
			'parent.profile.helpCenter' => 'Help Center',
			'parent.profile.helpCenterValue' => 'Visit support page',
			'parent.profile.languageArabic' => 'Arabic',
			'parent.profile.languageEnglish' => 'English',
			'parent.profile.notificationsEnabled' => 'Push Notifications',
			'parent.profile.phoneNumberLabel' => 'Phone Number',
			'parent.profile.preferencesSection' => 'Preferences',
			'parent.profile.pushNotifications' => 'Push Notifications',
			'parent.profile.securityChangePassword' => 'Change Password',
			'parent.profile.securityValue' => 'Password & Security',
			'parent.profile.settingsAboutBody' => ({required Object version}) => 'MentorX Parent App v${version}\n\nMonitor your child\'s academic journey in real time.',
			'parent.profile.settingsAboutTitle' => 'About MentorX',
			'parent.profile.settingsHelpUrl' => 'https://mentorx.app/support',
			'parent.profile.settingsTitle' => 'Settings',
			'parent.profile.signOutAction' => 'Sign Out',
			'parent.profile.signOutCancel' => 'Cancel',
			'parent.profile.signOutConfirmMessage' => 'Are you sure you want to sign out?',
			'parent.profile.signOutConfirmTitle' => 'Sign Out',
			'parent.profile.supportSection' => 'Support',
			'parent.profile.themeDark' => 'Dark',
			'parent.profile.themeLight' => 'Light',
			'parent.profile.themeMode' => 'Theme',
			'parent.profile.themeSystem' => 'System',
			'parent.profile.verifiedAccount' => 'Verified Account',
			'parent.devices.activeBadge' => 'Active',
			'parent.devices.cancel' => 'Cancel',
			'parent.devices.currentBadge' => 'This Device',
			'parent.devices.emptyHint' => 'No devices have been linked to your account',
			'parent.devices.emptyTitle' => 'No Devices',
			'parent.devices.forceLogoutAction' => 'Force Logout All',
			'parent.devices.forceLogoutConfirmMessage' => 'This will log out all other devices. Continue?',
			'parent.devices.forceLogoutConfirmTitle' => 'Force Logout',
			'parent.devices.forceLogoutHint' => 'Log out all other active devices',
			'parent.devices.forceLogoutSuccess' => 'All other devices have been logged out',
			'parent.devices.forceLogoutTitle' => 'Force Logout',
			'parent.devices.inactiveBadge' => 'Inactive',
			'parent.devices.lastUsedLabel' => ({required Object time}) => 'Last used: ${time}',
			'parent.devices.pageSubtitle' => 'Manage devices with access to your account',
			'parent.devices.pageTitle' => 'Trusted Devices',
			'parent.devices.revokeAction' => 'Revoke',
			'parent.devices.revokeConfirmMessage' => 'Remove access for this device?',
			'parent.devices.revokeConfirmTitle' => 'Revoke Device',
			'parent.devices.revokeSuccess' => 'Device access revoked',
			'parent.devices.settingsSubtitle' => 'Manage trusted devices',
			'parent.deleteAccount.acknowledgementLabel' => 'I understand this action is permanent',
			'parent.deleteAccount.cancel' => 'Cancel',
			'parent.deleteAccount.confirmAction' => 'Delete My Account',
			'parent.deleteAccount.confirmationPhrase' => 'DELETE',
			'parent.deleteAccount.confirmationPrompt' => ({required Object phrase}) => 'Type "${phrase}" to confirm',
			'parent.deleteAccount.consequence' => 'All your data including profile, history, and linked accounts will be permanently deleted',
			'parent.deleteAccount.consequencesTitle' => 'What will be deleted',
			'parent.deleteAccount.dataExportHint' => 'You can request a copy of your data before deleting',
			'parent.deleteAccount.dataExportLabel' => 'Export My Data',
			'parent.deleteAccount.finalConfirmMessage' => 'Your account will be permanently deleted within 24 hours. This cannot be undone.',
			'parent.deleteAccount.finalConfirmTitle' => 'Final Confirmation',
			'parent.deleteAccount.networkError' => 'Network error. Please try again',
			'parent.deleteAccount.pageTitle' => 'Delete Account',
			'parent.deleteAccount.reasonHint' => 'Tell us why you\'re leaving (optional)',
			'parent.deleteAccount.reasonLabel' => 'Reason for Deletion',
			'parent.deleteAccount.settingsTileLabel' => 'Delete Account',
			'parent.deleteAccount.settingsTileSubtitle' => 'Permanently remove your account',
			'parent.deleteAccount.submitting' => 'Processing your request...',
			'parent.deleteAccount.successMessage' => 'Your account deletion request has been submitted',
			'parent.deleteAccount.unauthorizedError' => 'You are not authorized to perform this action',
			'parent.deleteAccount.unknownError' => 'An unknown error occurred',
			'parent.deleteAccount.validationError' => 'Please complete all required fields',
			'parent.deleteAccount.warningSubtitle' => 'This action is permanent and cannot be undone',
			'parent.deleteAccount.warningTitle' => 'Warning',
			'parent.pendingAccount.approvedToastMessage' => 'Your account has been approved!',
			'parent.pendingAccount.cancel' => 'Cancel',
			'parent.pendingAccount.checkAgain' => 'Check Status',
			'parent.pendingAccount.checking' => 'Checking...',
			'parent.pendingAccount.contactSupport' => 'Contact Support',
			'parent.pendingAccount.contactSupportHint' => 'If you have questions, reach out to our support team',
			'parent.pendingAccount.estimatedReviewBy' => ({required Object date}) => 'Estimated review by: ${date}',
			'parent.pendingAccount.headlinePending' => 'Account Under Review',
			'parent.pendingAccount.headlineRejected' => 'Account Not Approved',
			'parent.pendingAccount.loadErrorMessage' => 'Failed to load account status',
			'parent.pendingAccount.loadErrorTitle' => 'Error',
			'parent.pendingAccount.pageTitle' => 'Account Status',
			'parent.pendingAccount.rejectionReasonTitle' => 'Reason',
			'parent.pendingAccount.signOut' => 'Sign Out',
			'parent.pendingAccount.signOutConfirmMessage' => 'Are you sure you want to sign out?',
			'parent.pendingAccount.signOutConfirmTitle' => 'Sign Out',
			'parent.pendingAccount.statusBadgePending' => 'Pending',
			'parent.pendingAccount.statusBadgeRejected' => 'Rejected',
			'parent.pendingAccount.stepApproved' => 'Approved',
			'parent.pendingAccount.stepApprovedHint' => 'Your account is active',
			'parent.pendingAccount.stepReceived' => 'Application Received',
			'parent.pendingAccount.stepReceivedHint' => 'We have received your registration',
			'parent.pendingAccount.stepUnderReview' => 'Under Review',
			'parent.pendingAccount.stepUnderReviewHint' => 'Our team is reviewing your application',
			'parent.pendingAccount.submittedOn' => ({required Object date}) => 'Submitted on: ${date}',
			'parent.pendingAccount.subtitlePending' => 'Our team is reviewing your registration. You\'ll be notified once approved.',
			'parent.pendingAccount.subtitleRejected' => 'Your registration was not approved. Please contact support for assistance.',
			'parent.pendingAccount.supportLabel' => 'Support',
			_ => null,
		};
	}
}
