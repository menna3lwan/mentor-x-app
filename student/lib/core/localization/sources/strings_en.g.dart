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
	/// final t = Translations.of(context);
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
	late final TranslationsAccountstatusEn accountstatus = TranslationsAccountstatusEn.internal(_root);
	late final TranslationsAichatEn aichat = TranslationsAichatEn.internal(_root);
	late final TranslationsAnalyticsEn analytics = TranslationsAnalyticsEn.internal(_root);
	late final TranslationsAssignmentsEn assignments = TranslationsAssignmentsEn.internal(_root);
	late final TranslationsAttendanceEn attendance = TranslationsAttendanceEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCoreEn core = TranslationsCoreEn.internal(_root);
	late final TranslationsCourseEn course = TranslationsCourseEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsMarketplaceEn marketplace = TranslationsMarketplaceEn.internal(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn.internal(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn.internal(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn.internal(_root);
	late final TranslationsQuizzesEn quizzes = TranslationsQuizzesEn.internal(_root);
	late final TranslationsRewardsEn rewards = TranslationsRewardsEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsShellEn shell = TranslationsShellEn.internal(_root);
	late final TranslationsStudentcardEn studentcard = TranslationsStudentcardEn.internal(_root);
	late final TranslationsWalletEn wallet = TranslationsWalletEn.internal(_root);
}

// Path: accountstatus
class TranslationsAccountstatusEn {
	TranslationsAccountstatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Blocked'
	String get blockedTitle => 'Account Blocked';

	/// en: 'Your account has been blocked due to a violation of our terms of service.'
	String get blockedDescription => 'Your account has been blocked due to a violation of our terms of service.';

	/// en: 'If you believe this is a mistake, please contact support.'
	String get blockedSupportInfo => 'If you believe this is a mistake, please contact support.';

	/// en: 'Account Pending'
	String get pendingTitle => 'Account Pending';

	/// en: 'Your account is currently under review.'
	String get pendingDescription => 'Your account is currently under review.';

	/// en: 'We will notify you once your account is approved.'
	String get pendingSupportInfo => 'We will notify you once your account is approved.';

	/// en: 'Refresh Status'
	String get refreshStatus => 'Refresh Status';

	/// en: 'Account Rejected'
	String get rejectedTitle => 'Account Rejected';

	/// en: 'Your account has been rejected.'
	String get rejectedDescription => 'Your account has been rejected.';

	/// en: 'Please check your information and try again.'
	String get rejectedReason => 'Please check your information and try again.';

	/// en: 'Student Code'
	String get studentCodeLabel => 'Student Code';
}

// Path: aichat
class TranslationsAichatEn {
	TranslationsAichatEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AI Tutor History'
	String get aiTutorHistory => 'AI Tutor History';

	/// en: 'New Chat'
	String get newChat => 'New Chat';

	/// en: 'Unable to load conversations.'
	String get unableToLoadConversations => 'Unable to load conversations.';

	/// en: 'No conversations yet'
	String get noConversationsYet => 'No conversations yet';

	/// en: 'Start a conversation with your AI tutor to get help with your studies.'
	String get noConversationsDesc => 'Start a conversation with your AI tutor to get help with your studies.';

	/// en: '${count} messages'
	String messagesCount({required Object count}) => '${count} messages';

	/// en: 'Rename'
	String get rename => 'Rename';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Study Session'
	String get studySession => 'Study Session';

	/// en: 'Rename Chat'
	String get renameChat => 'Rename Chat';

	/// en: 'Enter new title'
	String get enterNewTitle => 'Enter new title';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'AI Assistant'
	String get aiAssistant => 'AI Assistant';

	/// en: 'Processing...'
	String get commonLoading => 'Processing...';

	/// en: 'Always here to help'
	String get aiSubtitle => 'Always here to help';

	/// en: 'Ask me anything...'
	String get typeQuestion => 'Ask me anything...';
}

// Path: analytics
class TranslationsAnalyticsEn {
	TranslationsAnalyticsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Performance Analytics'
	String get title => 'Performance Analytics';

	/// en: 'Performance Dashboard'
	String get performanceDashboard => 'Performance Dashboard';

	/// en: 'Your Academic Journey'
	String get academicJourney => 'Your Academic Journey';

	/// en: 'Grade vs Peers'
	String get gradeVsPeers => 'Grade vs Peers';

	/// en: 'Rank #${rank}'
	String rank({required Object rank}) => 'Rank #${rank}';

	/// en: 'Your Score'
	String get yourScore => 'Your Score';

	/// en: 'Class Average'
	String get classAverage => 'Class Average';

	/// en: '${count} Students'
	String studentsCount({required Object count}) => '${count} Students';

	/// en: 'Above Average'
	String get aboveAverage => 'Above Average';

	/// en: 'Below Average'
	String get belowAverage => 'Below Average';

	/// en: 'Performance Trend'
	String get performanceTrend => 'Performance Trend';

	/// en: 'Study Consistency'
	String get studyConsistency => 'Study Consistency';

	/// en: '${days} Days Streak'
	String daysStreak({required Object days}) => '${days} Days Streak';

	/// en: 'Personal Best: ${count}'
	String personalBestLabel({required Object count}) => 'Personal Best: ${count}';

	/// en: 'New Record!'
	String get newRecord => 'New Record!';

	/// en: 'Unable to load leaderboard'
	String get leaderboardError => 'Unable to load leaderboard';

	/// en: 'Study Peak Hours'
	String get studyPeakHours => 'Study Peak Hours';

	/// en: 'Badges & Achievements'
	String get badgesAndAchievements => 'Badges & Achievements';

	/// en: 'Engagement Streak'
	String get streakTitle => 'Engagement Streak';

	/// en: 'Keep it up! You are making steady progress'
	String get streakEncouragement => 'Keep it up! You are making steady progress';

	/// en: 'Best Streak'
	String get bestStreak => 'Best Streak';

	/// en: 'Quiz Speed Metrics'
	String get quizSpeedMetrics => 'Quiz Speed Metrics';

	/// en: 'sec/question'
	String get secondsPerQuestion => 'sec/question';

	/// en: 'Your Avg'
	String get yourAverage => 'Your Avg';

	/// en: 'Peer Avg'
	String get peerAverage => 'Peer Avg';

	/// en: 'You are 15% faster than peer average! keep up the pace.'
	String get speedEncouragement => 'You are 15% faster than peer average! keep up the pace.';

	/// en: 'All Courses'
	String get allCourses => 'All Courses';

	/// en: 'No rankings available'
	String get noRankingsTitle => 'No rankings available';

	/// en: 'Be the first to join the leaderboard by completing your coursework.'
	String get noRankingsDesc => 'Be the first to join the leaderboard by completing your coursework.';

	/// en: 'Your Standing'
	String get yourStanding => 'Your Standing';

	/// en: 'You'
	String get you => 'You';
}

// Path: assignments
class TranslationsAssignmentsEn {
	TranslationsAssignmentsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Assignment Details'
	String get detail => 'Assignment Details';

	/// en: 'Waves Assignment'
	String get title => 'Waves Assignment';

	/// en: 'Assignments'
	String get featureTitle => 'Assignments';

	/// en: 'Unit 3 - Session 2'
	String get unit => 'Unit 3 - Session 2';

	/// en: 'Deadline'
	String get deadline => 'Deadline';

	/// en: 'Score'
	String get maxScore => 'Score';

	/// en: 'points'
	String get points => 'points';

	/// en: 'Instructions:'
	String get instructionsLabel => 'Instructions:';

	/// en: 'Solve the following problems on mechanical waves. You must solve all problems and show full solution steps.'
	String get instructions => 'Solve the following problems on mechanical waves. You must solve all problems and show full solution steps.';

	/// en: 'Assignment File'
	String get file => 'Assignment File';

	/// en: 'Submit Assignment'
	String get submit => 'Submit Assignment';

	/// en: 'Click to upload file'
	String get uploadFile => 'Click to upload file';

	/// en: 'PDF, images (max 10 MB)'
	String get uploadHint => 'PDF, images (max 10 MB)';

	/// en: 'Notes (optional):'
	String get notesOptional => 'Notes (optional):';

	/// en: 'Add a note for the instructor...'
	String get notesHint => 'Add a note for the instructor...';

	/// en: 'Feedback'
	String get feedbackTitle => 'Feedback';

	/// en: 'Instructor feedback:'
	String get instructorFeedback => 'Instructor feedback:';

	/// en: 'Register Attendance'
	String get registerAttendance => 'Register Attendance';

	/// en: 'Attendance History'
	String get attendanceHistory => 'Attendance History';

	/// en: 'Your Attendance Code'
	String get yourAttendanceCode => 'Your Attendance Code';

	/// en: 'Exit Assignment?'
	String get exitTitle => 'Exit Assignment?';

	/// en: 'Your progress will not be saved. Are you sure you want to exit?'
	String get exitDesc => 'Your progress will not be saved. Are you sure you want to exit?';

	/// en: 'Your Response'
	String get yourResponse => 'Your Response';

	/// en: 'Write your response here...'
	String get writeResponse => 'Write your response here...';

	/// en: 'Start typing...'
	String get responseHint => 'Start typing...';

	/// en: 'Attachments'
	String get attachments => 'Attachments';

	/// en: 'No files attached yet'
	String get noFiles => 'No files attached yet';

	/// en: 'Choose the correct answer:'
	String get chooseCorrect => 'Choose the correct answer:';

	/// en: 'QUESTION'
	String get questionLabel => 'QUESTION';

	/// en: 'Assignment submitted successfully'
	String get submitted => 'Assignment submitted successfully';

	/// en: 'You have already submitted this assignment'
	String get alreadySubmitted => 'You have already submitted this assignment';

	/// en: 'Assignment not found'
	String get notFound => 'Assignment not found';

	/// en: 'No assignments available'
	String get noAssignments => 'No assignments available';

	/// en: 'Check back later for new assignments.'
	String get noAssignmentsDesc => 'Check back later for new assignments.';

	/// en: 'Due: ${date}'
	String dueAt({required Object date}) => 'Due: ${date}';

	/// en: 'No deadline'
	String get noDeadline => 'No deadline';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Exit'
	String get exit => 'Exit';

	/// en: 'Previous'
	String get previous => 'Previous';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Assignment Result'
	String get result => 'Assignment Result';

	/// en: 'Very Good'
	String get veryGood => 'Very Good';

	/// en: 'Back'
	String get commonBack => 'Back';
}

// Path: attendance
class TranslationsAttendanceEn {
	TranslationsAttendanceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No attendance records yet'
	String get noAttendance => 'No attendance records yet';

	/// en: 'Attendance History'
	String get attendanceHistory => 'Attendance History';

	/// en: 'Attendance Rate'
	String get attendanceRate => 'Attendance Rate';

	/// en: 'Present'
	String get present => 'Present';

	/// en: 'Absent'
	String get absent => 'Absent';

	/// en: 'Session'
	String get session => 'Session';

	/// en: 'Your attendance history will appear here'
	String get attendanceHistoryDesc => 'Your attendance history will appear here';

	/// en: 'Register Attendance'
	String get registerAttendance => 'Register Attendance';

	/// en: 'Your Attendance Code'
	String get yourAttendanceCode => 'Your Attendance Code';

	/// en: 'Show this code to the instructor to register your attendance.'
	String get showCodeInstruction => 'Show this code to the instructor to register your attendance.';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome Back'
	String get welcomeBack => 'Welcome Back';

	/// en: 'Sign in to continue your learning journey'
	String get signInToContinue => 'Sign in to continue your learning journey';

	/// en: 'Forgot password?'
	String get forgotPassword => 'Forgot password?';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Login with biometrics'
	String get loginWithBiometrics => 'Login with biometrics';

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Register Now'
	String get registerNow => 'Register Now';

	/// en: 'Welcome'
	String get welcome => 'Welcome';

	/// en: 'Let's get started'
	String get letsGetStarted => 'Let\'s get started';

	/// en: 'Please provide your basic contact information'
	String get basicDetailsDesc => 'Please provide your basic contact information';

	/// en: 'First Name'
	String get firstNameLabel => 'First Name';

	/// en: 'Phone Number'
	String get phoneLabel => 'Phone Number';

	/// en: 'Parent's Phone Number'
	String get parentPhoneLabel => 'Parent\'s Phone Number';

	/// en: 'Phone number is already registered'
	String get phoneAlreadyRegistered => 'Phone number is already registered';

	/// en: 'OTP Verification'
	String get otpVerifyTitle => 'OTP Verification';

	/// en: 'We've sent a verification code to your WhatsApp'
	String get otpSentWhatsapp => 'We\'ve sent a verification code to your WhatsApp';

	/// en: 'Reset Password'
	String get resetTitle => 'Reset Password';

	/// en: 'Forgot Password?'
	String get forgotPasswordTitle => 'Forgot Password?';

	/// en: 'No worries! Enter your phone number below and we will send you a code to reset your password.'
	String get forgotPasswordDesc => 'No worries! Enter your phone number below and we will send you a code to reset your password.';

	/// en: 'Send Reset Code'
	String get sendResetCode => 'Send Reset Code';

	/// en: 'We've sent a verification code to '
	String get resetOtpSentPrefix => 'We\'ve sent a verification code to ';

	/// en: '. Enter it below to reset your password.'
	String get resetOtpSentSuffix => '. Enter it below to reset your password.';

	/// en: 'OTP Code'
	String get resetOtpLabel => 'OTP Code';

	/// en: '000000'
	String get resetOtpHint => '000000';

	/// en: 'Please enter a valid 6-digit code'
	String get resetOtpError => 'Please enter a valid 6-digit code';

	/// en: 'New Password'
	String get newPasswordLabel => 'New Password';

	/// en: 'Enter your new password'
	String get newPasswordHint => 'Enter your new password';

	/// en: 'Password must be at least 8 characters'
	String get passwordRules => 'Password must be at least 8 characters';

	/// en: 'Re-enter your password'
	String get confirmPasswordHint => 'Re-enter your password';

	/// en: 'Verification code sent to your phone.'
	String get otpSentGeneric => 'Verification code sent to your phone.';

	/// en: 'We've sent a code to '
	String get otpSentPrefix => 'We\'ve sent a code to ';

	/// en: 'Didn't receive the code?'
	String get didNotReceiveCode => 'Didn\'t receive the code?';

	/// en: 'Resend Code'
	String get resendCode => 'Resend Code';

	/// en: 'Resend via WhatsApp'
	String get resendWhatsapp => 'Resend via WhatsApp';

	/// en: 'Resend in'
	String get resendIn => 'Resend in';

	/// en: 'Verify OTP'
	String get verifyOtp => 'Verify OTP';

	/// en: 'Edit Number'
	String get editNumber => 'Edit Number';

	/// en: 'Grade'
	String get gradeLabel => 'Grade';

	/// en: 'Governorate'
	String get governorateLabel => 'Governorate';

	/// en: 'Security & Photo'
	String get passwordAndPhotosLabel => 'Security & Photo';

	/// en: 'Enter your password'
	String get passwordHint => 'Enter your password';

	/// en: 'Submit'
	String get submitRegistration => 'Submit';

	/// en: 'Next'
	String get commonNext => 'Next';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Log In'
	String get loginButton => 'Log In';

	/// en: 'Registration submitted'
	String get submissionTitle => 'Registration submitted';

	/// en: 'Your account is now under review. You will receive a WhatsApp message with your details after approval.'
	String get submissionDescription => 'Your account is now under review. You will receive a WhatsApp message with your details after approval.';

	/// en: 'Password reset successfully!'
	String get passwordResetSuccess => 'Password reset successfully!';

	/// en: 'Back to Login'
	String get backToLogin => 'Back to Login';

	/// en: 'Student Code'
	String get codeLabel => 'Student Code';

	/// en: 'Create Account'
	String get registerTitle => 'Create Account';

	/// en: 'Second Name'
	String get secondNameLabel => 'Second Name';

	/// en: 'Third Name'
	String get thirdNameLabel => 'Third Name';

	/// en: 'Fourth Name'
	String get fourthNameLabel => 'Fourth Name';

	/// en: 'Personal Photo'
	String get personalPhotoLabel => 'Personal Photo';

	/// en: 'Please provide your full name as it appears in your official documents.'
	String get personalInfoDesc => 'Please provide your full name as it appears in your official documents.';

	/// en: 'Academic Information'
	String get academicInfoTitle => 'Academic Information';

	/// en: 'Tell us about your study level'
	String get academicInfoDesc => 'Tell us about your study level';

	/// en: 'School Name'
	String get schoolNameLabel => 'School Name';

	/// en: 'Educational Administration'
	String get educationAdminLabel => 'Educational Administration';

	/// en: 'Select your grade'
	String get gradeHint => 'Select your grade';

	/// en: 'Study Type'
	String get studyTypeLabel => 'Study Type';

	/// en: 'Online'
	String get studyTypeOnline => 'Online';

	/// en: 'Center'
	String get studyTypeCenter => 'Center';

	/// en: 'Center Name'
	String get centerNameLabel => 'Center Name';

	/// en: 'Location Details'
	String get locationDetailsTitle => 'Location Details';

	/// en: 'Tell us where you live'
	String get locationDetailsDesc => 'Tell us where you live';

	/// en: 'Select governorate'
	String get governorateHint => 'Select governorate';

	/// en: 'Area'
	String get regionLabel => 'Area';

	/// en: 'Select area'
	String get regionHint => 'Select area';

	/// en: 'Confirm Password'
	String get confirmPasswordLabel => 'Confirm Password';

	/// en: 'Passwords do not match'
	String get passwordMismatch => 'Passwords do not match';

	/// en: 'Security & Identity'
	String get securityIdentityTitle => 'Security & Identity';

	/// en: 'Protect your account and verify your identity'
	String get securityIdentityDesc => 'Protect your account and verify your identity';

	/// en: 'Weak'
	String get passwordWeak => 'Weak';

	/// en: 'Fair'
	String get passwordFair => 'Fair';

	/// en: 'Good'
	String get passwordGood => 'Good';

	/// en: 'Strong'
	String get passwordStrong => 'Strong';

	/// en: 'National ID Photo'
	String get nationalIdPhotoLabel => 'National ID Photo';

	/// en: 'Upload ID Front'
	String get uploadIdFront => 'Upload ID Front';

	/// en: 'Biometric login will be available after your first successful login on this device.'
	String get biometricHint => 'Biometric login will be available after your first successful login on this device.';

	/// en: 'REGISTRATION'
	String get registrationLabel => 'REGISTRATION';

	/// en: 'Gallery'
	String get gallery => 'Gallery';

	/// en: 'Camera'
	String get camera => 'Camera';

	late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn.internal(_root);
	late final TranslationsAuthFormsEn forms = TranslationsAuthFormsEn.internal(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MentorX Student'
	String get appName => 'MentorX Student';

	/// en: 'EGP'
	String get currency => 'EGP';

	/// en: '${amount: num} EGP'
	String price({required num amount}) => '${amount} ${_root.core.currency}';

	Map<String, String> get languages => {
		'en': 'English',
		'ar': 'العربية',
	};
	late final TranslationsCoreInitialLanguageEn initialLanguage = TranslationsCoreInitialLanguageEn.internal(_root);

	/// en: 'Log Out'
	String get logoutSetting => 'Log Out';

	/// en: 'Logout'
	String get logoutConfirmTitle => 'Logout';

	/// en: 'Are you sure you want to logout?'
	String get logoutConfirmDesc => 'Are you sure you want to logout?';

	/// en: 'Preview'
	String get preview => 'Preview';

	/// en: 'Coming Soon'
	String get comingSoon => 'Coming Soon';

	/// en: 'Opening ${url}...'
	String opening({required Object url}) => 'Opening ${url}...';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// en: 'Student Card'
	String get studentCard => 'Student Card';

	/// en: 'Digital ID'
	String get digitalId => 'Digital ID';

	/// en: 'Personal Data'
	String get personalData => 'Personal Data';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Grade'
	String get grade => 'Grade';

	/// en: 'Center'
	String get center => 'Center';

	/// en: 'School'
	String get school => 'School';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Wallet'
	String get wallet => 'Wallet';

	/// en: 'Send Request'
	String get sendRequest => 'Send Request';

	/// en: 'MentorX Edition Pro'
	String get tEditionPro => 'MentorX Edition Pro';

	/// en: 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.'
	String get aboutDesc => 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.';

	/// en: 'Version ${v}'
	String version({required Object v}) => 'Version ${v}';

	/// en: 'Last Update: ${date}'
	String lastUpdate({required Object date}) => 'Last Update: ${date}';

	/// en: 'Build: ${b}'
	String buildLabel({required Object b}) => 'Build: ${b}';

	/// en: 'All Rights Reserved © 2026 MentorX'
	String get allRightsReserved => 'All Rights Reserved © 2026 MentorX';

	/// en: 'Unable to load devices'
	String get unableToLoadDevices => 'Unable to load devices';

	/// en: 'No registered devices found'
	String get noRegisteredDevices => 'No registered devices found';

	/// en: 'Manage your active sessions and devices. You can deactivate any device you no longer use.'
	String get activeSessionsDesc => 'Manage your active sessions and devices. You can deactivate any device you no longer use.';

	/// en: 'Deactivate Device'
	String get deactivateDevice => 'Deactivate Device';

	/// en: 'Deactivated'
	String get deactivatedLabel => 'Deactivated';

	/// en: 'Active'
	String get activeLabel => 'Active';

	/// en: 'Inactive'
	String get inactiveLabel => 'Inactive';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Change Password'
	String get changePasswordSetting => 'Change Password';

	/// en: 'Device Management'
	String get deviceManagement => 'Device Management';

	/// en: 'Communication'
	String get communication => 'Communication';

	/// en: 'Notifications'
	String get notificationsSetting => 'Notifications';

	/// en: 'WhatsApp Groups'
	String get whatsappGroups => 'WhatsApp Groups';

	/// en: 'Help & Info'
	String get helpAndInfo => 'Help & Info';

	/// en: 'About App'
	String get aboutSetting => 'About App';

	/// en: 'Last used at ${date}'
	String lastUsedAt({required Object date}) => 'Last used at ${date}';

	/// en: 'Excellent'
	String get excellent => 'Excellent';

	/// en: 'Very Good'
	String get veryGood => 'Very Good';

	/// en: 'Needs Work'
	String get fail => 'Needs Work';

	/// en: 'of ${count}'
	String of({required Object count}) => 'of ${count}';
}

// Path: course
class TranslationsCourseEn {
	TranslationsCourseEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${completed}/${total} Lessons'
	String lessonProgress({required Object completed, required Object total}) => '${completed}/${total} Lessons';

	/// en: 'MY ACADEMY'
	String get myAcademy => 'MY ACADEMY';

	/// en: 'Course Details'
	String get courseDetail => 'Course Details';

	/// en: 'My Courses'
	String get myCourses => 'My Courses';

	late final TranslationsCourseTabsEn tabs = TranslationsCourseTabsEn.internal(_root);
	late final TranslationsCourseEmptyEn empty = TranslationsCourseEmptyEn.internal(_root);
	late final TranslationsCourseDetailEn detail = TranslationsCourseDetailEn.internal(_root);
	late final TranslationsCourseErrorsEn errors = TranslationsCourseErrorsEn.internal(_root);
	late final TranslationsCoursePlayerEn player = TranslationsCoursePlayerEn.internal(_root);

	/// en: 'Lessons Completed'
	String get lessonsCompleted => 'Lessons Completed';

	/// en: 'Time Spent'
	String get timeSpent => 'Time Spent';

	/// en: 'Quizzes Taken'
	String get quizzesTaken => 'Quizzes Taken';

	late final TranslationsCourseCatalogEn catalog = TranslationsCourseCatalogEn.internal(_root);
	late final TranslationsCourseMyGradesEn myGrades = TranslationsCourseMyGradesEn.internal(_root);

	/// en: 'Mark as Done'
	String get markAsDone => 'Mark as Done';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeDashboardEn dashboard = TranslationsHomeDashboardEn.internal(_root);
}

// Path: marketplace
class TranslationsMarketplaceEn {
	TranslationsMarketplaceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order placed successfully!'
	String get orderPlaced => 'Order placed successfully!';

	/// en: 'Failed to place order'
	String get orderFailed => 'Failed to place order';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Delivery Address'
	String get deliveryAddress => 'Delivery Address';

	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

	/// en: 'Delivery Notes'
	String get deliveryNotes => 'Delivery Notes';

	/// en: 'Wallet Balance'
	String get walletBalance => 'Wallet Balance';

	/// en: 'Subtotal'
	String get subtotal => 'Subtotal';

	/// en: 'Discount'
	String get discount => 'Discount';

	/// en: 'Delivery'
	String get delivery => 'Delivery';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Search products...'
	String get searchProducts => 'Search products...';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Error loading products'
	String get errorLoadingProducts => 'Error loading products';

	/// en: 'No products found'
	String get noProductsFound => 'No products found';

	/// en: 'Marketplace'
	String get store => 'Marketplace';

	/// en: 'EGP'
	String get egp => 'EGP';

	/// en: 'added to cart'
	String get addedToCart => 'added to cart';

	/// en: 'EXPLORE'
	String get explore => 'EXPLORE';

	/// en: 'HOT'
	String get hot => 'HOT';

	/// en: 'Try again later'
	String get tryAgainLater => 'Try again later';

	/// en: 'Error loading product'
	String get errorLoadingProduct => 'Error loading product';

	/// en: 'Add to Cart'
	String get addToCart => 'Add to Cart';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Stock Status'
	String get stockStatus => 'Stock Status';

	/// en: 'In Stock'
	String get inStock => 'In Stock';

	/// en: 'Out of Stock'
	String get outOfStock => 'Out of Stock';

	/// en: 'Only left'
	String get onlyLeft => 'Only left';

	/// en: 'items'
	String get items => 'items';

	late final TranslationsMarketplaceCartEn cart = TranslationsMarketplaceCartEn.internal(_root);
	late final TranslationsMarketplaceOrdersEn orders = TranslationsMarketplaceOrdersEn.internal(_root);
}

// Path: notifications
class TranslationsNotificationsEn {
	TranslationsNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No notifications yet'
	String get noNotifications => 'No notifications yet';

	/// en: 'We'll notify you when something important happens.'
	String get noNotificationsDesc => 'We\'ll notify you when something important happens.';

	/// en: 'Notifications'
	String get notificationsTitle => 'Notifications';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong.'
	String get somethingWentWrong => 'Something went wrong.';

	/// en: 'Retry'
	String get retry => 'Retry';

	late final TranslationsOnboardingStepsEn steps = TranslationsOnboardingStepsEn.internal(_root);
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get title => 'Profile';

	/// en: 'Wallet'
	String get wallet => 'Wallet';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Personal Data'
	String get personalData => 'Personal Data';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Grade'
	String get grade => 'Grade';

	/// en: 'Center'
	String get center => 'Center';

	/// en: 'School'
	String get school => 'School';

	/// en: 'Digital ID'
	String get digitalId => 'Digital ID';

	/// en: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Logout'
	String get logoutSetting => 'Logout';

	/// en: 'Logout Confirmation'
	String get logoutConfirmTitle => 'Logout Confirmation';

	/// en: 'Are you sure you want to logout?'
	String get logoutConfirmDesc => 'Are you sure you want to logout?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Edits need approval from instructor'
	String get editsNeedApproval => 'Edits need approval from instructor';

	/// en: 'Personal Information'
	String get personalInfo => 'Personal Information';

	/// en: 'This field is required'
	String get requiredField => 'This field is required';

	/// en: 'Academic Information'
	String get academicInfo => 'Academic Information';

	/// en: 'Reason for Edit'
	String get reasonForEdit => 'Reason for Edit';

	/// en: 'Please provide a reason'
	String get provideReason => 'Please provide a reason';

	/// en: 'Enter the reason for editing your profile...'
	String get reasonHint => 'Enter the reason for editing your profile...';

	/// en: 'Send Request'
	String get sendRequest => 'Send Request';

	/// en: 'Update your account password'
	String get changePasswordDesc => 'Update your account password';

	/// en: 'Current Password'
	String get currentPassword => 'Current Password';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Confirm New Password'
	String get confirmNewPassword => 'Confirm New Password';

	/// en: 'Password must be at least 6 characters'
	String get passwordTooShort => 'Password must be at least 6 characters';

	/// en: 'Passwords do not match'
	String get passwordsDoNotMatch => 'Passwords do not match';

	/// en: 'Save Changes'
	String get saveChanges => 'Save Changes';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'No changes detected'
	String get noChangesDetected => 'No changes detected';

	/// en: 'Request sent successfully'
	String get requestSentSuccess => 'Request sent successfully';
}

// Path: quizzes
class TranslationsQuizzesEn {
	TranslationsQuizzesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quizzes'
	String get title => 'Quizzes';

	/// en: 'No Quizzes Available'
	String get noQuizzes => 'No Quizzes Available';

	/// en: 'Check back later for new quizzes.'
	String get noQuizzesDesc => 'Check back later for new quizzes.';

	/// en: 'Quiz Result'
	String get quizResult => 'Quiz Result';

	/// en: 'Score'
	String get score => 'Score';

	/// en: 'Time Taken'
	String get timeTaken => 'Time Taken';

	/// en: 'Correct'
	String get correctAnswers => 'Correct';

	/// en: 'Wrong'
	String get wrongAnswers => 'Wrong';

	/// en: 'Review Answers'
	String get reviewAnswers => 'Review Answers';

	/// en: 'Your Answer'
	String get yourAnswer => 'Your Answer';

	/// en: 'Correct Answer'
	String get correctAnswer => 'Correct Answer';

	/// en: 'Leaderboard'
	String get leaderboard => 'Leaderboard';

	/// en: 'Claim Reward'
	String get claimReward => 'Claim Reward';

	/// en: 'ASSESSMENTS'
	String get assessments => 'ASSESSMENTS';

	/// en: 'Quizzes'
	String get navQuizzes => 'Quizzes';

	/// en: 'Questions'
	String get questions => 'Questions';

	/// en: 'mins'
	String get minutesShort => 'mins';

	/// en: 'Quiz not found'
	String get quizNotFound => 'Quiz not found';

	/// en: 'Resume Quiz'
	String get resumeQuiz => 'Resume Quiz';

	/// en: 'Start Quiz'
	String get startQuiz => 'Start Quiz';

	/// en: 'Back'
	String get commonBack => 'Back';

	/// en: 'Unit Quiz'
	String get quizUnitTitle => 'Unit Quiz';

	/// en: 'Test your knowledge of this unit'
	String get quizSubtitle => 'Test your knowledge of this unit';

	/// en: 'Questions'
	String get questionCount => 'Questions';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Pass Grade'
	String get passGrade => 'Pass Grade';

	/// en: 'Attempts'
	String get attempts => 'Attempts';

	/// en: 'Instructions'
	String get instructions => 'Instructions';

	/// en: 'Read the questions carefully before answering.'
	String get instructionRead => 'Read the questions carefully before answering.';

	/// en: 'You can review your answers at the end.'
	String get instructionReview => 'You can review your answers at the end.';

	/// en: 'Once you submit, you cannot change your answers.'
	String get instructionNoReturn => 'Once you submit, you cannot change your answers.';

	/// en: 'Quiz result not found'
	String get resultNotFound => 'Quiz result not found';

	/// en: 'Excellent'
	String get excellent => 'Excellent';

	/// en: 'Very Good'
	String get veryGood => 'Very Good';

	/// en: 'Failed'
	String get fail => 'Failed';

	/// en: 'Great Result!'
	String get greatResult => 'Great Result!';

	/// en: 'No questions available'
	String get noQuestions => 'No questions available';

	/// en: 'Exit Quiz?'
	String get exitQuizTitle => 'Exit Quiz?';

	/// en: 'Your progress is automatically saved. You can resume this quiz later from the intro page.'
	String get exitQuizDesc => 'Your progress is automatically saved. You can resume this quiz later from the intro page.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Exit'
	String get exit => 'Exit';

	/// en: 'QUESTION'
	String get questionLabel => 'QUESTION';

	/// en: 'Choose the correct answer:'
	String get chooseCorrect => 'Choose the correct answer:';

	/// en: 'Type your answer here...'
	String get typeAnswerHere => 'Type your answer here...';

	/// en: 'Previous'
	String get commonPrevious => 'Previous';

	/// en: 'Submit'
	String get commonSubmit => 'Submit';

	/// en: 'Next'
	String get commonNext => 'Next';

	late final TranslationsQuizzesRewardsEn rewards = TranslationsQuizzesRewardsEn.internal(_root);
	late final TranslationsQuizzesReviewEn review = TranslationsQuizzesReviewEn.internal(_root);
}

// Path: rewards
class TranslationsRewardsEn {
	TranslationsRewardsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No rewards available'
	String get noRewards => 'No rewards available';

	/// en: 'Check back later for new items.'
	String get noRewardsDesc => 'Check back later for new items.';

	/// en: 'Rewards Catalog'
	String get rewardsTitle => 'Rewards Catalog';

	/// en: 'Points Balance'
	String get pointsBalance => 'Points Balance';

	/// en: 'Points'
	String get points => 'Points';

	/// en: 'Redeem your points for exclusive rewards.'
	String get redeemPointsDesc => 'Redeem your points for exclusive rewards.';

	/// en: 'Redeem'
	String get redeem => 'Redeem';

	/// en: 'No points history yet'
	String get noHistory => 'No points history yet';

	/// en: 'Earn points by completing tasks and participating in activities.'
	String get noHistoryDesc => 'Earn points by completing tasks and participating in activities.';

	/// en: 'Points History'
	String get rewardsHistoryTitle => 'Points History';

	/// en: 'Balance: ${balance}'
	String balance({required Object balance}) => 'Balance: ${balance}';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Change Password'
	String get changePasswordSetting => 'Change Password';

	/// en: 'Student Card'
	String get studentCard => 'Student Card';

	/// en: 'Device Management'
	String get deviceManagement => 'Device Management';

	/// en: 'Communication'
	String get communication => 'Communication';

	/// en: 'Notifications'
	String get notificationsSetting => 'Notifications';

	/// en: 'WhatsApp Groups'
	String get whatsappGroups => 'WhatsApp Groups';

	/// en: 'Join our official WhatsApp groups to stay updated with the latest news and announcements.'
	String get whatsappGroupsDesc => 'Join our official WhatsApp groups to stay updated with the latest news and announcements.';

	/// en: 'Help & Info'
	String get helpAndInfo => 'Help & Info';

	/// en: 'About App'
	String get aboutSetting => 'About App';

	/// en: 'Log Out'
	String get logoutSetting => 'Log Out';

	/// en: '${count} members active'
	String membersActive({required Object count}) => '${count} members active';

	/// en: 'Link copied to clipboard'
	String get linkCopied => 'Link copied to clipboard';

	/// en: 'Copy invite link'
	String get copyInviteLink => 'Copy invite link';

	/// en: 'Preferences'
	String get preferencesLabel => 'Preferences';

	/// en: 'Log Out'
	String get logoutConfirmTitle => 'Log Out';

	/// en: 'Are you sure you want to log out?'
	String get logoutConfirmDesc => 'Are you sure you want to log out?';

	/// en: 'Community'
	String get communityLabel => 'Community';

	/// en: 'MentorX Pro'
	String get tEditionPro => 'MentorX Pro';

	/// en: 'MentorX is a comprehensive platform designed to streamline student management, track performance, and enhance communication.'
	String get aboutDesc => 'MentorX is a comprehensive platform designed to streamline student management, track performance, and enhance communication.';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Last Update'
	String get lastUpdate => 'Last Update';

	/// en: 'Build'
	String get buildLabel => 'Build';

	/// en: '© 2026 MentorX. All rights reserved.'
	String get allRightsReserved => '© 2026 MentorX. All rights reserved.';

	/// en: 'App Info'
	String get appInfoLabel => 'App Info';

	/// en: 'Unable to load devices'
	String get unableToLoadDevices => 'Unable to load devices';

	/// en: 'Settings'
	String get settingsLabel => 'Settings';

	/// en: 'No registered devices'
	String get noRegisteredDevices => 'No registered devices';

	/// en: 'You can manage your active sessions here.'
	String get activeSessionsDesc => 'You can manage your active sessions here.';

	/// en: 'Last used: ${date}'
	String lastUsedAt({required Object date}) => 'Last used: ${date}';

	/// en: 'Deactivate'
	String get deactivateDevice => 'Deactivate';

	/// en: 'Deactivated'
	String get deactivatedLabel => 'Deactivated';

	/// en: 'Active'
	String get activeLabel => 'Active';

	/// en: 'Inactive'
	String get inactiveLabel => 'Inactive';
}

// Path: shell
class TranslationsShellEn {
	TranslationsShellEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get navHome => 'Home';

	/// en: 'Courses'
	String get navCourses => 'Courses';

	/// en: 'Quizzes'
	String get navQuizzes => 'Quizzes';

	/// en: 'Wallet'
	String get navWallet => 'Wallet';

	/// en: 'Account'
	String get navAccount => 'Account';
}

// Path: studentcard
class TranslationsStudentcardEn {
	TranslationsStudentcardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Student Card'
	String get title => 'Student Card';

	/// en: 'MentorX Platform'
	String get platformName => 'MentorX Platform';

	/// en: 'Student Code'
	String get codeLabel => 'Student Code';

	/// en: 'Scan for attendance'
	String get scanForAttendance => 'Scan for attendance';

	/// en: 'Secure Digital ID'
	String get secureDigitalId => 'Secure Digital ID';

	/// en: 'Grade'
	String get gradeLabel => 'Grade';

	/// en: 'Digital ID'
	String get digitalId => 'Digital ID';

	/// en: 'Error loading card'
	String get errorLoading => 'Error loading card';

	/// en: 'Refresh Status'
	String get refreshStatus => 'Refresh Status';
}

// Path: wallet
class TranslationsWalletEn {
	TranslationsWalletEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Balance'
	String get addBalance => 'Add Balance';

	/// en: 'Redeem Code'
	String get redeemCode => 'Redeem Code';

	/// en: 'Orders'
	String get myOrders => 'Orders';

	/// en: 'Recent Transactions'
	String get recentTransactions => 'Recent Transactions';

	/// en: 'See All'
	String get seeAll => 'See All';

	/// en: 'No transactions yet'
	String get noTransactions => 'No transactions yet';

	/// en: 'Your Wallet'
	String get walletTitle => 'Your Wallet';

	/// en: 'Wallet Balance'
	String get walletBalance => 'Wallet Balance';

	/// en: 'EGP'
	String get egp => 'EGP';

	/// en: 'Points'
	String get points => 'Points';

	/// en: 'Transactions'
	String get transactionsTitle => 'Transactions';

	/// en: 'Vodafone Cash'
	String get vodafoneCash => 'Vodafone Cash';

	/// en: 'Pay using Vodafone Cash wallet'
	String get vodafoneDesc => 'Pay using Vodafone Cash wallet';

	/// en: 'InstaPay'
	String get instaPay => 'InstaPay';

	/// en: 'Pay using InstaPay app'
	String get instaPayDesc => 'Pay using InstaPay app';

	/// en: 'Fawry'
	String get fawry => 'Fawry';

	/// en: 'Pay at any Fawry retail point'
	String get fawryDesc => 'Pay at any Fawry retail point';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Choose Payment Method'
	String get choosePaymentMethod => 'Choose Payment Method';

	/// en: 'Continue'
	String get continueBtn => 'Continue';

	/// en: 'Redeem Your Code'
	String get redeemCodeTitle => 'Redeem Your Code';

	/// en: 'Enter the code you received to add balance to your wallet.'
	String get enterCodeDesc => 'Enter the code you received to add balance to your wallet.';

	/// en: 'Activate Code'
	String get activateCode => 'Activate Code';

	/// en: 'By activating this code, you agree to our terms and conditions.'
	String get redeemPolicy => 'By activating this code, you agree to our terms and conditions.';

	/// en: 'Purchase Confirm'
	String get purchaseConfirm => 'Purchase Confirm';

	/// en: 'Failed to load payment'
	String get failedToLoadPayment => 'Failed to load payment';

	/// en: 'Payment Method'
	String get paymentMethod => 'Payment Method';

	/// en: 'Reference'
	String get reference => 'Reference';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Confirm Payment'
	String get confirmPayment => 'Confirm Payment';

	/// en: 'Payment Success'
	String get paymentSuccess => 'Payment Success';

	/// en: 'Balance Added: %s'
	String get balanceAdded => 'Balance Added: %s';

	/// en: 'New Balance'
	String get newBalance => 'New Balance';

	/// en: 'Back to Wallet'
	String get backToWallet => 'Back to Wallet';
}

// Path: auth.login
class TranslationsAuthLoginEn {
	TranslationsAuthLoginEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Please enter a valid Egyptian phone number'
	String get phoneValidationError => 'Please enter a valid Egyptian phone number';
}

// Path: auth.forms
class TranslationsAuthFormsEn {
	TranslationsAuthFormsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This field is required'
	String get required => 'This field is required';

	/// en: 'Minimum ${length: int} characters required'
	String minLength({required int length}) => 'Minimum ${length} characters required';
}

// Path: core.initialLanguage
class TranslationsCoreInitialLanguageEn {
	TranslationsCoreInitialLanguageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your preferred language'
	String get header => 'Select your preferred language';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: course.tabs
class TranslationsCourseTabsEn {
	TranslationsCourseTabsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'In Progress'
	String get inProgress => 'In Progress';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Expired'
	String get expired => 'Expired';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Sessions'
	String get sessions => 'Sessions';
}

// Path: course.empty
class TranslationsCourseEmptyEn {
	TranslationsCourseEmptyEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Enrolled Courses'
	String get noEnrolledCourses => 'No Enrolled Courses';

	/// en: 'You haven't enrolled in any courses yet.'
	String get noEnrolledCoursesDescription => 'You haven\'t enrolled in any courses yet.';

	/// en: 'Browse Catalog'
	String get browseCatalog => 'Browse Catalog';
}

// Path: course.detail
class TranslationsCourseDetailEn {
	TranslationsCourseDetailEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enrolled successfully!'
	String get enrollSuccess => 'Enrolled successfully!';

	/// en: 'Failed to enroll.'
	String get enrollFailed => 'Failed to enroll.';

	/// en: 'Your Performance'
	String get yourPerformance => 'Your Performance';

	/// en: 'days left'
	String get daysLeft => 'days left';

	/// en: 'Items'
	String get items => 'Items';

	/// en: 'Free'
	String get sessionFree => 'Free';

	/// en: 'About this Course'
	String get aboutCourse => 'About this Course';

	/// en: 'Videos'
	String get videos => 'Videos';

	/// en: 'Minutes'
	String get minutes => 'Minutes';

	/// en: 'Students'
	String get students => 'Students';

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Your Progress'
	String get yourProgress => 'Your Progress';

	/// en: '${percent}% Complete'
	String completePercent({required Object percent}) => '${percent}% Complete';

	/// en: 'Continue Studying'
	String get continueStudying => 'Continue Studying';

	/// en: 'Course Completed'
	String get courseCompleted => 'Course Completed';

	/// en: 'Course Expired'
	String get courseExpired => 'Course Expired';

	/// en: 'Enroll Now'
	String get enrollNow => 'Enroll Now';

	/// en: 'Points Reward'
	String get pointsReward => 'Points Reward';

	/// en: '${mins}m ${secs}s'
	String durationShort({required Object mins, required Object secs}) => '${mins}m ${secs}s';
}

// Path: course.errors
class TranslationsCourseErrorsEn {
	TranslationsCourseErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load course sessions'
	String get failedToLoadSessions => 'Failed to load course sessions';

	/// en: 'Try refreshing the page'
	String get tryRefreshing => 'Try refreshing the page';
}

// Path: course.player
class TranslationsCoursePlayerEn {
	TranslationsCoursePlayerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Watching'
	String get watching => 'Watching';
}

// Path: course.catalog
class TranslationsCourseCatalogEn {
	TranslationsCourseCatalogEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Categories'
	String get allCategories => 'All Categories';

	/// en: 'All Levels'
	String get allLevels => 'All Levels';

	/// en: '${count} courses found'
	String coursesFound({required Object count}) => '${count} courses found';

	/// en: 'No courses found'
	String get noCourses => 'No courses found';

	/// en: 'Try adjusting your filters or search terms'
	String get noCoursesDescription => 'Try adjusting your filters or search terms';

	/// en: 'Search for courses...'
	String get searchHint => 'Search for courses...';

	/// en: 'Sort By'
	String get sortBy => 'Sort By';

	/// en: 'Newest'
	String get sortNewest => 'Newest';

	/// en: 'Price: Low to High'
	String get sortPriceAsc => 'Price: Low to High';

	/// en: 'Price: High to Low'
	String get sortPriceDesc => 'Price: High to Low';

	/// en: 'Most Popular'
	String get sortPopular => 'Most Popular';
}

// Path: course.myGrades
class TranslationsCourseMyGradesEn {
	TranslationsCourseMyGradesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Grades'
	String get title => 'My Grades';

	/// en: 'No grades available yet.'
	String get noGrades => 'No grades available yet.';

	/// en: 'Complete quizzes and assignments to see your grades.'
	String get completeAssessmentsDesc => 'Complete quizzes and assignments to see your grades.';

	/// en: 'Overall Performance'
	String get overallAverage => 'Overall Performance';

	/// en: 'All Courses'
	String get allCourses => 'All Courses';
}

// Path: home.dashboard
class TranslationsHomeDashboardEn {
	TranslationsHomeDashboardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Good morning'
	String get greetingMorning => 'Good morning';

	/// en: 'Good evening'
	String get greetingEvening => 'Good evening';

	/// en: '${greeting}, ${name} 👋'
	String greetingWithName({required Object greeting, required Object name}) => '${greeting}, ${name} 👋';

	/// en: 'Updated ${time: DateFormat('HH:mm')}'
	String updatedAt({required DateTime time}) => 'Updated ${DateFormat('HH:mm', 'en').format(time)}';

	/// en: 'Continue Learning'
	String get continueLearning => 'Continue Learning';

	/// en: 'Featured Courses'
	String get featuredCourses => 'Featured Courses';

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Quick Actions'
	String get quickActions => 'Quick Actions';

	/// en: 'Wallet Balance'
	String get walletBalance => 'Wallet Balance';

	/// en: '${count: int} points'
	String points({required int count}) => '${count} points';

	/// en: 'Start your learning journey! Browse available courses.'
	String get startLearningJourney => 'Start your learning journey! Browse available courses.';

	/// en: 'Continue ${progress: num}%'
	String continueProgress({required num progress}) => 'Continue ${progress}%';

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Loading course'
	String get loadingCourse => 'Loading course';

	/// en: 'Loading featured course'
	String get loadingFeaturedCourse => 'Loading featured course';

	/// en: 'Loading announcement'
	String get loadingAnnouncement => 'Loading announcement';

	/// en: 'Loading announcement details'
	String get loadingAnnouncementDetails => 'Loading announcement details';

	/// en: 'Unable to load. Tap to retry.'
	String get unableToLoadTapRetry => 'Unable to load. Tap to retry.';

	/// en: 'My Courses'
	String get myCourses => 'My Courses';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Grades'
	String get grades => 'Grades';

	/// en: 'AI Assistant'
	String get aiAssistant => 'AI Assistant';

	/// en: 'Assignments'
	String get assignments => 'Assignments';

	/// en: 'Rewards'
	String get rewards => 'Rewards';

	/// en: 'Marketplace'
	String get marketplace => 'Marketplace';

	/// en: 'Performance Analytics'
	String get analytics => 'Performance Analytics';

	/// en: 'Course Catalog'
	String get courseCatalog => 'Course Catalog';

	/// en: 'Leaderboard'
	String get leaderboard => 'Leaderboard';
}

// Path: marketplace.cart
class TranslationsMarketplaceCartEn {
	TranslationsMarketplaceCartEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Cart'
	String get title => 'My Cart';

	/// en: 'Your cart is empty'
	String get empty => 'Your cart is empty';

	/// en: 'Looks like you haven't added anything yet.'
	String get emptyDesc => 'Looks like you haven\'t added anything yet.';

	/// en: 'Start Shopping'
	String get startShopping => 'Start Shopping';

	/// en: 'Checkout'
	String get checkout => 'Checkout';

	/// en: 'Confirm Order'
	String get confirmOrder => 'Confirm Order';

	/// en: 'Delivery Details'
	String get deliveryDetails => 'Delivery Details';

	/// en: 'Insufficient Balance'
	String get insufficientBalance => 'Insufficient Balance';

	/// en: 'Insufficient balance. Top up ${amount} EGP to place order.'
	String insufficientBalanceDesc({required Object amount}) => 'Insufficient balance. Top up ${amount} EGP to place order.';

	/// en: 'Coupon Applied!'
	String get couponApplied => 'Coupon Applied!';

	/// en: 'Have a coupon code?'
	String get haveCoupon => 'Have a coupon code?';

	/// en: 'View Codes'
	String get viewCodes => 'View Codes';
}

// Path: marketplace.orders
class TranslationsMarketplaceOrdersEn {
	TranslationsMarketplaceOrdersEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order History'
	String get title => 'Order History';

	/// en: 'You haven't placed any orders yet.'
	String get noOrders => 'You haven\'t placed any orders yet.';

	/// en: 'Explore our marketplace and place your first order!'
	String get startShoppingDesc => 'Explore our marketplace and place your first order!';

	/// en: 'Order #${number}'
	String orderNumber({required Object number}) => 'Order #${number}';

	/// en: '${count} items'
	String itemsCount({required Object count}) => '${count} items';

	late final TranslationsMarketplaceOrdersStatusEn status = TranslationsMarketplaceOrdersStatusEn.internal(_root);
}

// Path: onboarding.steps
class TranslationsOnboardingStepsEn {
	TranslationsOnboardingStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingStepsLearnEn learn = TranslationsOnboardingStepsLearnEn.internal(_root);
	late final TranslationsOnboardingStepsTrackProgressEn trackProgress = TranslationsOnboardingStepsTrackProgressEn.internal(_root);
	late final TranslationsOnboardingStepsQuizzesEn quizzes = TranslationsOnboardingStepsQuizzesEn.internal(_root);
}

// Path: quizzes.rewards
class TranslationsQuizzesRewardsEn {
	TranslationsQuizzesRewardsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Gamification'
	String get title => 'Gamification';

	/// en: 'GOLD'
	String get goldLevel => 'GOLD';

	/// en: 'to next level'
	String get toNextLevel => 'to next level';

	/// en: 'XP Points'
	String get xpPoints => 'XP Points';

	/// en: 'Quizzes'
	String get quizCompleted => 'Quizzes';

	/// en: 'Badges'
	String get badge => 'Badges';

	/// en: 'Daily Streak'
	String get dailyStreak => 'Daily Streak';

	/// en: 'You have a ${days}-day streak!'
	String streakDaysMsg({required Object days}) => 'You have a ${days}-day streak!';

	/// en: 'Badges'
	String get earnedBadges => 'Badges';

	/// en: 'Leaderboard'
	String get leaderboard => 'Leaderboard';

	late final TranslationsQuizzesRewardsDaysEn days = TranslationsQuizzesRewardsDaysEn.internal(_root);
	late final TranslationsQuizzesRewardsBadgesEn badges = TranslationsQuizzesRewardsBadgesEn.internal(_root);
}

// Path: quizzes.review
class TranslationsQuizzesReviewEn {
	TranslationsQuizzesReviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Review Answers'
	String get title => 'Review Answers';

	/// en: 'Jump to Question'
	String get jumpToQuestion => 'Jump to Question';

	/// en: 'Submit Quiz'
	String get submitQuiz => 'Submit Quiz';

	/// en: 'Back to Questions'
	String get backToQuestions => 'Back to Questions';

	/// en: 'Answered Questions'
	String get answeredCount => 'Answered Questions';

	/// en: '${count} questions left'
	String unansweredNote({required Object count}) => '${count} questions left';
}

// Path: marketplace.orders.status
class TranslationsMarketplaceOrdersStatusEn {
	TranslationsMarketplaceOrdersStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Shipped'
	String get shipped => 'Shipped';

	/// en: 'Delivered'
	String get delivered => 'Delivered';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';
}

// Path: onboarding.steps.learn
class TranslationsOnboardingStepsLearnEn {
	TranslationsOnboardingStepsLearnEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Learn Anytime, Anywhere'
	String get title => 'Learn Anytime, Anywhere';

	/// en: 'Access your courses and materials on the go. Learn at your own pace.'
	String get description => 'Access your courses and materials on the go. Learn at your own pace.';
}

// Path: onboarding.steps.trackProgress
class TranslationsOnboardingStepsTrackProgressEn {
	TranslationsOnboardingStepsTrackProgressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Track Your Progress'
	String get title => 'Track Your Progress';

	/// en: 'Keep track of your grades, attendance, and performance in one place.'
	String get description => 'Keep track of your grades, attendance, and performance in one place.';
}

// Path: onboarding.steps.quizzes
class TranslationsOnboardingStepsQuizzesEn {
	TranslationsOnboardingStepsQuizzesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interactive Quizzes'
	String get title => 'Interactive Quizzes';

	/// en: 'Test your knowledge with interactive quizzes and get instant feedback.'
	String get description => 'Test your knowledge with interactive quizzes and get instant feedback.';
}

// Path: quizzes.rewards.days
class TranslationsQuizzesRewardsDaysEn {
	TranslationsQuizzesRewardsDaysEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SAT'
	String get sat => 'SAT';

	/// en: 'SUN'
	String get sun => 'SUN';

	/// en: 'MON'
	String get mon => 'MON';

	/// en: 'TUE'
	String get tue => 'TUE';

	/// en: 'WED'
	String get wed => 'WED';

	/// en: 'THU'
	String get thu => 'THU';

	/// en: 'FRI'
	String get fri => 'FRI';
}

// Path: quizzes.rewards.badges
class TranslationsQuizzesRewardsBadgesEn {
	TranslationsQuizzesRewardsBadgesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lightning Speed'
	String get lightningSpeed => 'Lightning Speed';

	/// en: 'Perfect Score'
	String get perfectScore => 'Perfect Score';

	/// en: '5 Day Streak'
	String get fiveDayStreak => '5 Day Streak';

	/// en: '10 Quizzes'
	String get tenQuizzes => '10 Quizzes';

	/// en: 'Physics Lion'
	String get physicsLion => 'Physics Lion';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accountstatus.blockedTitle' => 'Account Blocked',
			'accountstatus.blockedDescription' => 'Your account has been blocked due to a violation of our terms of service.',
			'accountstatus.blockedSupportInfo' => 'If you believe this is a mistake, please contact support.',
			'accountstatus.pendingTitle' => 'Account Pending',
			'accountstatus.pendingDescription' => 'Your account is currently under review.',
			'accountstatus.pendingSupportInfo' => 'We will notify you once your account is approved.',
			'accountstatus.refreshStatus' => 'Refresh Status',
			'accountstatus.rejectedTitle' => 'Account Rejected',
			'accountstatus.rejectedDescription' => 'Your account has been rejected.',
			'accountstatus.rejectedReason' => 'Please check your information and try again.',
			'accountstatus.studentCodeLabel' => 'Student Code',
			'aichat.aiTutorHistory' => 'AI Tutor History',
			'aichat.newChat' => 'New Chat',
			'aichat.unableToLoadConversations' => 'Unable to load conversations.',
			'aichat.noConversationsYet' => 'No conversations yet',
			'aichat.noConversationsDesc' => 'Start a conversation with your AI tutor to get help with your studies.',
			'aichat.messagesCount' => ({required Object count}) => '${count} messages',
			'aichat.rename' => 'Rename',
			'aichat.delete' => 'Delete',
			'aichat.studySession' => 'Study Session',
			'aichat.renameChat' => 'Rename Chat',
			'aichat.enterNewTitle' => 'Enter new title',
			'aichat.cancel' => 'Cancel',
			'aichat.save' => 'Save',
			'aichat.aiAssistant' => 'AI Assistant',
			'aichat.commonLoading' => 'Processing...',
			'aichat.aiSubtitle' => 'Always here to help',
			'aichat.typeQuestion' => 'Ask me anything...',
			'analytics.title' => 'Performance Analytics',
			'analytics.performanceDashboard' => 'Performance Dashboard',
			'analytics.academicJourney' => 'Your Academic Journey',
			'analytics.gradeVsPeers' => 'Grade vs Peers',
			'analytics.rank' => ({required Object rank}) => 'Rank #${rank}',
			'analytics.yourScore' => 'Your Score',
			'analytics.classAverage' => 'Class Average',
			'analytics.studentsCount' => ({required Object count}) => '${count} Students',
			'analytics.aboveAverage' => 'Above Average',
			'analytics.belowAverage' => 'Below Average',
			'analytics.performanceTrend' => 'Performance Trend',
			'analytics.studyConsistency' => 'Study Consistency',
			'analytics.daysStreak' => ({required Object days}) => '${days} Days Streak',
			'analytics.personalBestLabel' => ({required Object count}) => 'Personal Best: ${count}',
			'analytics.newRecord' => 'New Record!',
			'analytics.leaderboardError' => 'Unable to load leaderboard',
			'analytics.studyPeakHours' => 'Study Peak Hours',
			'analytics.badgesAndAchievements' => 'Badges & Achievements',
			'analytics.streakTitle' => 'Engagement Streak',
			'analytics.streakEncouragement' => 'Keep it up! You are making steady progress',
			'analytics.bestStreak' => 'Best Streak',
			'analytics.quizSpeedMetrics' => 'Quiz Speed Metrics',
			'analytics.secondsPerQuestion' => 'sec/question',
			'analytics.yourAverage' => 'Your Avg',
			'analytics.peerAverage' => 'Peer Avg',
			'analytics.speedEncouragement' => 'You are 15% faster than peer average! keep up the pace.',
			'analytics.allCourses' => 'All Courses',
			'analytics.noRankingsTitle' => 'No rankings available',
			'analytics.noRankingsDesc' => 'Be the first to join the leaderboard by completing your coursework.',
			'analytics.yourStanding' => 'Your Standing',
			'analytics.you' => 'You',
			'assignments.detail' => 'Assignment Details',
			'assignments.title' => 'Waves Assignment',
			'assignments.featureTitle' => 'Assignments',
			'assignments.unit' => 'Unit 3 - Session 2',
			'assignments.deadline' => 'Deadline',
			'assignments.maxScore' => 'Score',
			'assignments.points' => 'points',
			'assignments.instructionsLabel' => 'Instructions:',
			'assignments.instructions' => 'Solve the following problems on mechanical waves. You must solve all problems and show full solution steps.',
			'assignments.file' => 'Assignment File',
			'assignments.submit' => 'Submit Assignment',
			'assignments.uploadFile' => 'Click to upload file',
			'assignments.uploadHint' => 'PDF, images (max 10 MB)',
			'assignments.notesOptional' => 'Notes (optional):',
			'assignments.notesHint' => 'Add a note for the instructor...',
			'assignments.feedbackTitle' => 'Feedback',
			'assignments.instructorFeedback' => 'Instructor feedback:',
			'assignments.registerAttendance' => 'Register Attendance',
			'assignments.attendanceHistory' => 'Attendance History',
			'assignments.yourAttendanceCode' => 'Your Attendance Code',
			'assignments.exitTitle' => 'Exit Assignment?',
			'assignments.exitDesc' => 'Your progress will not be saved. Are you sure you want to exit?',
			'assignments.yourResponse' => 'Your Response',
			'assignments.writeResponse' => 'Write your response here...',
			'assignments.responseHint' => 'Start typing...',
			'assignments.attachments' => 'Attachments',
			'assignments.noFiles' => 'No files attached yet',
			'assignments.chooseCorrect' => 'Choose the correct answer:',
			'assignments.questionLabel' => 'QUESTION',
			'assignments.submitted' => 'Assignment submitted successfully',
			'assignments.alreadySubmitted' => 'You have already submitted this assignment',
			'assignments.notFound' => 'Assignment not found',
			'assignments.noAssignments' => 'No assignments available',
			'assignments.noAssignmentsDesc' => 'Check back later for new assignments.',
			'assignments.dueAt' => ({required Object date}) => 'Due: ${date}',
			'assignments.noDeadline' => 'No deadline',
			'assignments.cancel' => 'Cancel',
			'assignments.exit' => 'Exit',
			'assignments.previous' => 'Previous',
			'assignments.next' => 'Next',
			'assignments.result' => 'Assignment Result',
			'assignments.veryGood' => 'Very Good',
			'assignments.commonBack' => 'Back',
			'attendance.noAttendance' => 'No attendance records yet',
			'attendance.attendanceHistory' => 'Attendance History',
			'attendance.attendanceRate' => 'Attendance Rate',
			'attendance.present' => 'Present',
			'attendance.absent' => 'Absent',
			'attendance.session' => 'Session',
			'attendance.attendanceHistoryDesc' => 'Your attendance history will appear here',
			'attendance.registerAttendance' => 'Register Attendance',
			'attendance.yourAttendanceCode' => 'Your Attendance Code',
			'attendance.showCodeInstruction' => 'Show this code to the instructor to register your attendance.',
			'auth.welcomeBack' => 'Welcome Back',
			'auth.signInToContinue' => 'Sign in to continue your learning journey',
			'auth.forgotPassword' => 'Forgot password?',
			'auth.signIn' => 'Sign In',
			'auth.loginWithBiometrics' => 'Login with biometrics',
			'auth.dontHaveAccount' => 'Don\'t have an account?',
			'auth.registerNow' => 'Register Now',
			'auth.welcome' => 'Welcome',
			'auth.letsGetStarted' => 'Let\'s get started',
			'auth.basicDetailsDesc' => 'Please provide your basic contact information',
			'auth.firstNameLabel' => 'First Name',
			'auth.phoneLabel' => 'Phone Number',
			'auth.parentPhoneLabel' => 'Parent\'s Phone Number',
			'auth.phoneAlreadyRegistered' => 'Phone number is already registered',
			'auth.otpVerifyTitle' => 'OTP Verification',
			'auth.otpSentWhatsapp' => 'We\'ve sent a verification code to your WhatsApp',
			'auth.resetTitle' => 'Reset Password',
			'auth.forgotPasswordTitle' => 'Forgot Password?',
			'auth.forgotPasswordDesc' => 'No worries! Enter your phone number below and we will send you a code to reset your password.',
			'auth.sendResetCode' => 'Send Reset Code',
			'auth.resetOtpSentPrefix' => 'We\'ve sent a verification code to ',
			'auth.resetOtpSentSuffix' => '. Enter it below to reset your password.',
			'auth.resetOtpLabel' => 'OTP Code',
			'auth.resetOtpHint' => '000000',
			'auth.resetOtpError' => 'Please enter a valid 6-digit code',
			'auth.newPasswordLabel' => 'New Password',
			'auth.newPasswordHint' => 'Enter your new password',
			'auth.passwordRules' => 'Password must be at least 8 characters',
			'auth.confirmPasswordHint' => 'Re-enter your password',
			'auth.otpSentGeneric' => 'Verification code sent to your phone.',
			'auth.otpSentPrefix' => 'We\'ve sent a code to ',
			'auth.didNotReceiveCode' => 'Didn\'t receive the code?',
			'auth.resendCode' => 'Resend Code',
			'auth.resendWhatsapp' => 'Resend via WhatsApp',
			'auth.resendIn' => 'Resend in',
			'auth.verifyOtp' => 'Verify OTP',
			'auth.editNumber' => 'Edit Number',
			'auth.gradeLabel' => 'Grade',
			'auth.governorateLabel' => 'Governorate',
			'auth.passwordAndPhotosLabel' => 'Security & Photo',
			'auth.passwordHint' => 'Enter your password',
			'auth.submitRegistration' => 'Submit',
			'auth.commonNext' => 'Next',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.loginButton' => 'Log In',
			'auth.submissionTitle' => 'Registration submitted',
			'auth.submissionDescription' => 'Your account is now under review. You will receive a WhatsApp message with your details after approval.',
			'auth.passwordResetSuccess' => 'Password reset successfully!',
			'auth.backToLogin' => 'Back to Login',
			'auth.codeLabel' => 'Student Code',
			'auth.registerTitle' => 'Create Account',
			'auth.secondNameLabel' => 'Second Name',
			'auth.thirdNameLabel' => 'Third Name',
			'auth.fourthNameLabel' => 'Fourth Name',
			'auth.personalPhotoLabel' => 'Personal Photo',
			'auth.personalInfoDesc' => 'Please provide your full name as it appears in your official documents.',
			'auth.academicInfoTitle' => 'Academic Information',
			'auth.academicInfoDesc' => 'Tell us about your study level',
			'auth.schoolNameLabel' => 'School Name',
			'auth.educationAdminLabel' => 'Educational Administration',
			'auth.gradeHint' => 'Select your grade',
			'auth.studyTypeLabel' => 'Study Type',
			'auth.studyTypeOnline' => 'Online',
			'auth.studyTypeCenter' => 'Center',
			'auth.centerNameLabel' => 'Center Name',
			'auth.locationDetailsTitle' => 'Location Details',
			'auth.locationDetailsDesc' => 'Tell us where you live',
			'auth.governorateHint' => 'Select governorate',
			'auth.regionLabel' => 'Area',
			'auth.regionHint' => 'Select area',
			'auth.confirmPasswordLabel' => 'Confirm Password',
			'auth.passwordMismatch' => 'Passwords do not match',
			'auth.securityIdentityTitle' => 'Security & Identity',
			'auth.securityIdentityDesc' => 'Protect your account and verify your identity',
			'auth.passwordWeak' => 'Weak',
			'auth.passwordFair' => 'Fair',
			'auth.passwordGood' => 'Good',
			'auth.passwordStrong' => 'Strong',
			'auth.nationalIdPhotoLabel' => 'National ID Photo',
			'auth.uploadIdFront' => 'Upload ID Front',
			'auth.biometricHint' => 'Biometric login will be available after your first successful login on this device.',
			'auth.registrationLabel' => 'REGISTRATION',
			'auth.gallery' => 'Gallery',
			'auth.camera' => 'Camera',
			'auth.login.phoneNumber' => 'Phone Number',
			'auth.login.password' => 'Password',
			'auth.login.signIn' => 'Sign In',
			'auth.login.phoneValidationError' => 'Please enter a valid Egyptian phone number',
			'auth.forms.required' => 'This field is required',
			'auth.forms.minLength' => ({required int length}) => 'Minimum ${length} characters required',
			'core.appName' => 'MentorX Student',
			'core.currency' => 'EGP',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'core.initialLanguage.header' => 'Select your preferred language',
			'core.initialLanguage.kContinue' => 'Continue',
			'core.logoutSetting' => 'Log Out',
			'core.logoutConfirmTitle' => 'Logout',
			'core.logoutConfirmDesc' => 'Are you sure you want to logout?',
			'core.preview' => 'Preview',
			'core.comingSoon' => 'Coming Soon',
			'core.opening' => ({required Object url}) => 'Opening ${url}...',
			'core.search' => 'Search',
			'core.viewAll' => 'View All',
			'core.skip' => 'Skip',
			'core.next' => 'Next',
			'core.getStarted' => 'Get Started',
			'core.retry' => 'Retry',
			'core.cancel' => 'Cancel',
			'core.settingsTitle' => 'Settings',
			'core.editProfile' => 'Edit Profile',
			'core.studentCard' => 'Student Card',
			'core.digitalId' => 'Digital ID',
			'core.personalData' => 'Personal Data',
			'core.name' => 'Name',
			'core.phone' => 'Phone',
			'core.grade' => 'Grade',
			'core.center' => 'Center',
			'core.school' => 'School',
			'core.attendance' => 'Attendance',
			'core.wallet' => 'Wallet',
			'core.sendRequest' => 'Send Request',
			'core.tEditionPro' => 'MentorX Edition Pro',
			'core.aboutDesc' => 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.',
			'core.version' => ({required Object v}) => 'Version ${v}',
			'core.lastUpdate' => ({required Object date}) => 'Last Update: ${date}',
			'core.buildLabel' => ({required Object b}) => 'Build: ${b}',
			'core.allRightsReserved' => 'All Rights Reserved © 2026 MentorX',
			'core.unableToLoadDevices' => 'Unable to load devices',
			'core.noRegisteredDevices' => 'No registered devices found',
			'core.activeSessionsDesc' => 'Manage your active sessions and devices. You can deactivate any device you no longer use.',
			'core.deactivateDevice' => 'Deactivate Device',
			'core.deactivatedLabel' => 'Deactivated',
			'core.activeLabel' => 'Active',
			'core.inactiveLabel' => 'Inactive',
			'core.language' => 'Language',
			'core.account' => 'Account',
			'core.changePasswordSetting' => 'Change Password',
			'core.deviceManagement' => 'Device Management',
			'core.communication' => 'Communication',
			'core.notificationsSetting' => 'Notifications',
			'core.whatsappGroups' => 'WhatsApp Groups',
			'core.helpAndInfo' => 'Help & Info',
			'core.aboutSetting' => 'About App',
			'core.lastUsedAt' => ({required Object date}) => 'Last used at ${date}',
			'core.excellent' => 'Excellent',
			'core.veryGood' => 'Very Good',
			'core.fail' => 'Needs Work',
			'core.of' => ({required Object count}) => 'of ${count}',
			'course.lessonProgress' => ({required Object completed, required Object total}) => '${completed}/${total} Lessons',
			'course.myAcademy' => 'MY ACADEMY',
			'course.courseDetail' => 'Course Details',
			'course.myCourses' => 'My Courses',
			'course.tabs.inProgress' => 'In Progress',
			'course.tabs.completed' => 'Completed',
			'course.tabs.expired' => 'Expired',
			'course.tabs.description' => 'Description',
			'course.tabs.sessions' => 'Sessions',
			'course.empty.noEnrolledCourses' => 'No Enrolled Courses',
			'course.empty.noEnrolledCoursesDescription' => 'You haven\'t enrolled in any courses yet.',
			'course.empty.browseCatalog' => 'Browse Catalog',
			'course.detail.enrollSuccess' => 'Enrolled successfully!',
			'course.detail.enrollFailed' => 'Failed to enroll.',
			'course.detail.yourPerformance' => 'Your Performance',
			'course.detail.daysLeft' => 'days left',
			'course.detail.items' => 'Items',
			'course.detail.sessionFree' => 'Free',
			'course.detail.aboutCourse' => 'About this Course',
			'course.detail.videos' => 'Videos',
			'course.detail.minutes' => 'Minutes',
			'course.detail.students' => 'Students',
			'course.detail.sessions' => 'Sessions',
			'course.detail.free' => 'Free',
			'course.detail.yourProgress' => 'Your Progress',
			'course.detail.completePercent' => ({required Object percent}) => '${percent}% Complete',
			'course.detail.continueStudying' => 'Continue Studying',
			'course.detail.courseCompleted' => 'Course Completed',
			'course.detail.courseExpired' => 'Course Expired',
			'course.detail.enrollNow' => 'Enroll Now',
			'course.detail.pointsReward' => 'Points Reward',
			'course.detail.durationShort' => ({required Object mins, required Object secs}) => '${mins}m ${secs}s',
			'course.errors.failedToLoadSessions' => 'Failed to load course sessions',
			'course.errors.tryRefreshing' => 'Try refreshing the page',
			'course.player.completed' => 'Completed',
			'course.player.duration' => 'Duration',
			'course.player.status' => 'Status',
			'course.player.watching' => 'Watching',
			'course.lessonsCompleted' => 'Lessons Completed',
			'course.timeSpent' => 'Time Spent',
			'course.quizzesTaken' => 'Quizzes Taken',
			'course.catalog.allCategories' => 'All Categories',
			'course.catalog.allLevels' => 'All Levels',
			'course.catalog.coursesFound' => ({required Object count}) => '${count} courses found',
			'course.catalog.noCourses' => 'No courses found',
			'course.catalog.noCoursesDescription' => 'Try adjusting your filters or search terms',
			'course.catalog.searchHint' => 'Search for courses...',
			'course.catalog.sortBy' => 'Sort By',
			'course.catalog.sortNewest' => 'Newest',
			'course.catalog.sortPriceAsc' => 'Price: Low to High',
			'course.catalog.sortPriceDesc' => 'Price: High to Low',
			'course.catalog.sortPopular' => 'Most Popular',
			'course.myGrades.title' => 'My Grades',
			'course.myGrades.noGrades' => 'No grades available yet.',
			'course.myGrades.completeAssessmentsDesc' => 'Complete quizzes and assignments to see your grades.',
			'course.myGrades.overallAverage' => 'Overall Performance',
			'course.myGrades.allCourses' => 'All Courses',
			'course.markAsDone' => 'Mark as Done',
			'home.dashboard.greetingMorning' => 'Good morning',
			'home.dashboard.greetingEvening' => 'Good evening',
			'home.dashboard.greetingWithName' => ({required Object greeting, required Object name}) => '${greeting}, ${name} 👋',
			'home.dashboard.updatedAt' => ({required DateTime time}) => 'Updated ${DateFormat('HH:mm', 'en').format(time)}',
			'home.dashboard.continueLearning' => 'Continue Learning',
			'home.dashboard.featuredCourses' => 'Featured Courses',
			'home.dashboard.announcements' => 'Announcements',
			'home.dashboard.quickActions' => 'Quick Actions',
			'home.dashboard.walletBalance' => 'Wallet Balance',
			'home.dashboard.points' => ({required int count}) => '${count} points',
			'home.dashboard.startLearningJourney' => 'Start your learning journey! Browse available courses.',
			'home.dashboard.continueProgress' => ({required num progress}) => 'Continue ${progress}%',
			'home.dashboard.free' => 'Free',
			'home.dashboard.loadingCourse' => 'Loading course',
			'home.dashboard.loadingFeaturedCourse' => 'Loading featured course',
			'home.dashboard.loadingAnnouncement' => 'Loading announcement',
			'home.dashboard.loadingAnnouncementDetails' => 'Loading announcement details',
			'home.dashboard.unableToLoadTapRetry' => 'Unable to load. Tap to retry.',
			'home.dashboard.myCourses' => 'My Courses',
			'home.dashboard.attendance' => 'Attendance',
			'home.dashboard.grades' => 'Grades',
			'home.dashboard.aiAssistant' => 'AI Assistant',
			'home.dashboard.assignments' => 'Assignments',
			'home.dashboard.rewards' => 'Rewards',
			'home.dashboard.marketplace' => 'Marketplace',
			'home.dashboard.analytics' => 'Performance Analytics',
			'home.dashboard.courseCatalog' => 'Course Catalog',
			'home.dashboard.leaderboard' => 'Leaderboard',
			'marketplace.orderPlaced' => 'Order placed successfully!',
			'marketplace.orderFailed' => 'Failed to place order',
			'marketplace.apply' => 'Apply',
			'marketplace.deliveryAddress' => 'Delivery Address',
			'marketplace.phoneNumber' => 'Phone Number',
			'marketplace.deliveryNotes' => 'Delivery Notes',
			'marketplace.walletBalance' => 'Wallet Balance',
			'marketplace.subtotal' => 'Subtotal',
			'marketplace.discount' => 'Discount',
			'marketplace.delivery' => 'Delivery',
			'marketplace.search' => 'Search',
			'marketplace.searchProducts' => 'Search products...',
			'marketplace.all' => 'All',
			'marketplace.errorLoadingProducts' => 'Error loading products',
			'marketplace.noProductsFound' => 'No products found',
			'marketplace.store' => 'Marketplace',
			'marketplace.egp' => 'EGP',
			'marketplace.addedToCart' => 'added to cart',
			'marketplace.explore' => 'EXPLORE',
			'marketplace.hot' => 'HOT',
			'marketplace.tryAgainLater' => 'Try again later',
			'marketplace.errorLoadingProduct' => 'Error loading product',
			'marketplace.addToCart' => 'Add to Cart',
			'marketplace.description' => 'Description',
			'marketplace.stockStatus' => 'Stock Status',
			'marketplace.inStock' => 'In Stock',
			'marketplace.outOfStock' => 'Out of Stock',
			'marketplace.onlyLeft' => 'Only left',
			'marketplace.items' => 'items',
			'marketplace.cart.title' => 'My Cart',
			'marketplace.cart.empty' => 'Your cart is empty',
			'marketplace.cart.emptyDesc' => 'Looks like you haven\'t added anything yet.',
			'marketplace.cart.startShopping' => 'Start Shopping',
			'marketplace.cart.checkout' => 'Checkout',
			'marketplace.cart.confirmOrder' => 'Confirm Order',
			'marketplace.cart.deliveryDetails' => 'Delivery Details',
			'marketplace.cart.insufficientBalance' => 'Insufficient Balance',
			'marketplace.cart.insufficientBalanceDesc' => ({required Object amount}) => 'Insufficient balance. Top up ${amount} EGP to place order.',
			'marketplace.cart.couponApplied' => 'Coupon Applied!',
			'marketplace.cart.haveCoupon' => 'Have a coupon code?',
			'marketplace.cart.viewCodes' => 'View Codes',
			'marketplace.orders.title' => 'Order History',
			'marketplace.orders.noOrders' => 'You haven\'t placed any orders yet.',
			'marketplace.orders.startShoppingDesc' => 'Explore our marketplace and place your first order!',
			'marketplace.orders.orderNumber' => ({required Object number}) => 'Order #${number}',
			'marketplace.orders.itemsCount' => ({required Object count}) => '${count} items',
			'marketplace.orders.status.pending' => 'Pending',
			'marketplace.orders.status.confirmed' => 'Confirmed',
			'marketplace.orders.status.processing' => 'Processing',
			'marketplace.orders.status.shipped' => 'Shipped',
			'marketplace.orders.status.delivered' => 'Delivered',
			'marketplace.orders.status.cancelled' => 'Cancelled',
			'notifications.noNotifications' => 'No notifications yet',
			'notifications.noNotificationsDesc' => 'We\'ll notify you when something important happens.',
			'notifications.notificationsTitle' => 'Notifications',
			'onboarding.somethingWentWrong' => 'Something went wrong.',
			'onboarding.retry' => 'Retry',
			'onboarding.steps.learn.title' => 'Learn Anytime, Anywhere',
			'onboarding.steps.learn.description' => 'Access your courses and materials on the go. Learn at your own pace.',
			'onboarding.steps.trackProgress.title' => 'Track Your Progress',
			'onboarding.steps.trackProgress.description' => 'Keep track of your grades, attendance, and performance in one place.',
			'onboarding.steps.quizzes.title' => 'Interactive Quizzes',
			'onboarding.steps.quizzes.description' => 'Test your knowledge with interactive quizzes and get instant feedback.',
			'profile.title' => 'Profile',
			'profile.wallet' => 'Wallet',
			'profile.attendance' => 'Attendance',
			'profile.personalData' => 'Personal Data',
			'profile.name' => 'Name',
			'profile.phone' => 'Phone',
			'profile.grade' => 'Grade',
			'profile.center' => 'Center',
			'profile.school' => 'School',
			'profile.digitalId' => 'Digital ID',
			'profile.editProfile' => 'Edit Profile',
			'profile.settingsTitle' => 'Settings',
			'profile.logoutSetting' => 'Logout',
			'profile.logoutConfirmTitle' => 'Logout Confirmation',
			'profile.logoutConfirmDesc' => 'Are you sure you want to logout?',
			'profile.cancel' => 'Cancel',
			'profile.editsNeedApproval' => 'Edits need approval from instructor',
			'profile.personalInfo' => 'Personal Information',
			'profile.requiredField' => 'This field is required',
			'profile.academicInfo' => 'Academic Information',
			'profile.reasonForEdit' => 'Reason for Edit',
			'profile.provideReason' => 'Please provide a reason',
			'profile.reasonHint' => 'Enter the reason for editing your profile...',
			'profile.sendRequest' => 'Send Request',
			'profile.changePasswordDesc' => 'Update your account password',
			'profile.currentPassword' => 'Current Password',
			'profile.newPassword' => 'New Password',
			'profile.confirmNewPassword' => 'Confirm New Password',
			'profile.passwordTooShort' => 'Password must be at least 6 characters',
			'profile.passwordsDoNotMatch' => 'Passwords do not match',
			'profile.saveChanges' => 'Save Changes',
			'profile.changePassword' => 'Change Password',
			'profile.noChangesDetected' => 'No changes detected',
			'profile.requestSentSuccess' => 'Request sent successfully',
			'quizzes.title' => 'Quizzes',
			'quizzes.noQuizzes' => 'No Quizzes Available',
			'quizzes.noQuizzesDesc' => 'Check back later for new quizzes.',
			'quizzes.quizResult' => 'Quiz Result',
			'quizzes.score' => 'Score',
			'quizzes.timeTaken' => 'Time Taken',
			'quizzes.correctAnswers' => 'Correct',
			'quizzes.wrongAnswers' => 'Wrong',
			'quizzes.reviewAnswers' => 'Review Answers',
			'quizzes.yourAnswer' => 'Your Answer',
			'quizzes.correctAnswer' => 'Correct Answer',
			'quizzes.leaderboard' => 'Leaderboard',
			'quizzes.claimReward' => 'Claim Reward',
			'quizzes.assessments' => 'ASSESSMENTS',
			'quizzes.navQuizzes' => 'Quizzes',
			'quizzes.questions' => 'Questions',
			'quizzes.minutesShort' => 'mins',
			'quizzes.quizNotFound' => 'Quiz not found',
			'quizzes.resumeQuiz' => 'Resume Quiz',
			'quizzes.startQuiz' => 'Start Quiz',
			'quizzes.commonBack' => 'Back',
			'quizzes.quizUnitTitle' => 'Unit Quiz',
			'quizzes.quizSubtitle' => 'Test your knowledge of this unit',
			'quizzes.questionCount' => 'Questions',
			'quizzes.duration' => 'Duration',
			'quizzes.passGrade' => 'Pass Grade',
			'quizzes.attempts' => 'Attempts',
			'quizzes.instructions' => 'Instructions',
			'quizzes.instructionRead' => 'Read the questions carefully before answering.',
			'quizzes.instructionReview' => 'You can review your answers at the end.',
			'quizzes.instructionNoReturn' => 'Once you submit, you cannot change your answers.',
			'quizzes.resultNotFound' => 'Quiz result not found',
			'quizzes.excellent' => 'Excellent',
			'quizzes.veryGood' => 'Very Good',
			'quizzes.fail' => 'Failed',
			'quizzes.greatResult' => 'Great Result!',
			'quizzes.noQuestions' => 'No questions available',
			'quizzes.exitQuizTitle' => 'Exit Quiz?',
			'quizzes.exitQuizDesc' => 'Your progress is automatically saved. You can resume this quiz later from the intro page.',
			'quizzes.cancel' => 'Cancel',
			'quizzes.exit' => 'Exit',
			'quizzes.questionLabel' => 'QUESTION',
			'quizzes.chooseCorrect' => 'Choose the correct answer:',
			'quizzes.typeAnswerHere' => 'Type your answer here...',
			'quizzes.commonPrevious' => 'Previous',
			'quizzes.commonSubmit' => 'Submit',
			'quizzes.commonNext' => 'Next',
			'quizzes.rewards.title' => 'Gamification',
			'quizzes.rewards.goldLevel' => 'GOLD',
			'quizzes.rewards.toNextLevel' => 'to next level',
			'quizzes.rewards.xpPoints' => 'XP Points',
			'quizzes.rewards.quizCompleted' => 'Quizzes',
			'quizzes.rewards.badge' => 'Badges',
			'quizzes.rewards.dailyStreak' => 'Daily Streak',
			'quizzes.rewards.streakDaysMsg' => ({required Object days}) => 'You have a ${days}-day streak!',
			'quizzes.rewards.earnedBadges' => 'Badges',
			'quizzes.rewards.leaderboard' => 'Leaderboard',
			'quizzes.rewards.days.sat' => 'SAT',
			'quizzes.rewards.days.sun' => 'SUN',
			'quizzes.rewards.days.mon' => 'MON',
			'quizzes.rewards.days.tue' => 'TUE',
			'quizzes.rewards.days.wed' => 'WED',
			'quizzes.rewards.days.thu' => 'THU',
			'quizzes.rewards.days.fri' => 'FRI',
			'quizzes.rewards.badges.lightningSpeed' => 'Lightning Speed',
			'quizzes.rewards.badges.perfectScore' => 'Perfect Score',
			'quizzes.rewards.badges.fiveDayStreak' => '5 Day Streak',
			_ => null,
		} ?? switch (path) {
			'quizzes.rewards.badges.tenQuizzes' => '10 Quizzes',
			'quizzes.rewards.badges.physicsLion' => 'Physics Lion',
			'quizzes.review.title' => 'Review Answers',
			'quizzes.review.jumpToQuestion' => 'Jump to Question',
			'quizzes.review.submitQuiz' => 'Submit Quiz',
			'quizzes.review.backToQuestions' => 'Back to Questions',
			'quizzes.review.answeredCount' => 'Answered Questions',
			'quizzes.review.unansweredNote' => ({required Object count}) => '${count} questions left',
			'rewards.noRewards' => 'No rewards available',
			'rewards.noRewardsDesc' => 'Check back later for new items.',
			'rewards.rewardsTitle' => 'Rewards Catalog',
			'rewards.pointsBalance' => 'Points Balance',
			'rewards.points' => 'Points',
			'rewards.redeemPointsDesc' => 'Redeem your points for exclusive rewards.',
			'rewards.redeem' => 'Redeem',
			'rewards.noHistory' => 'No points history yet',
			'rewards.noHistoryDesc' => 'Earn points by completing tasks and participating in activities.',
			'rewards.rewardsHistoryTitle' => 'Points History',
			'rewards.balance' => ({required Object balance}) => 'Balance: ${balance}',
			'settings.title' => 'Settings',
			'settings.language' => 'Language',
			'settings.account' => 'Account',
			'settings.changePasswordSetting' => 'Change Password',
			'settings.studentCard' => 'Student Card',
			'settings.deviceManagement' => 'Device Management',
			'settings.communication' => 'Communication',
			'settings.notificationsSetting' => 'Notifications',
			'settings.whatsappGroups' => 'WhatsApp Groups',
			'settings.whatsappGroupsDesc' => 'Join our official WhatsApp groups to stay updated with the latest news and announcements.',
			'settings.helpAndInfo' => 'Help & Info',
			'settings.aboutSetting' => 'About App',
			'settings.logoutSetting' => 'Log Out',
			'settings.membersActive' => ({required Object count}) => '${count} members active',
			'settings.linkCopied' => 'Link copied to clipboard',
			'settings.copyInviteLink' => 'Copy invite link',
			'settings.preferencesLabel' => 'Preferences',
			'settings.logoutConfirmTitle' => 'Log Out',
			'settings.logoutConfirmDesc' => 'Are you sure you want to log out?',
			'settings.communityLabel' => 'Community',
			'settings.tEditionPro' => 'MentorX Pro',
			'settings.aboutDesc' => 'MentorX is a comprehensive platform designed to streamline student management, track performance, and enhance communication.',
			'settings.version' => 'Version',
			'settings.lastUpdate' => 'Last Update',
			'settings.buildLabel' => 'Build',
			'settings.allRightsReserved' => '© 2026 MentorX. All rights reserved.',
			'settings.appInfoLabel' => 'App Info',
			'settings.unableToLoadDevices' => 'Unable to load devices',
			'settings.settingsLabel' => 'Settings',
			'settings.noRegisteredDevices' => 'No registered devices',
			'settings.activeSessionsDesc' => 'You can manage your active sessions here.',
			'settings.lastUsedAt' => ({required Object date}) => 'Last used: ${date}',
			'settings.deactivateDevice' => 'Deactivate',
			'settings.deactivatedLabel' => 'Deactivated',
			'settings.activeLabel' => 'Active',
			'settings.inactiveLabel' => 'Inactive',
			'shell.navHome' => 'Home',
			'shell.navCourses' => 'Courses',
			'shell.navQuizzes' => 'Quizzes',
			'shell.navWallet' => 'Wallet',
			'shell.navAccount' => 'Account',
			'studentcard.title' => 'Student Card',
			'studentcard.platformName' => 'MentorX Platform',
			'studentcard.codeLabel' => 'Student Code',
			'studentcard.scanForAttendance' => 'Scan for attendance',
			'studentcard.secureDigitalId' => 'Secure Digital ID',
			'studentcard.gradeLabel' => 'Grade',
			'studentcard.digitalId' => 'Digital ID',
			'studentcard.errorLoading' => 'Error loading card',
			'studentcard.refreshStatus' => 'Refresh Status',
			'wallet.addBalance' => 'Add Balance',
			'wallet.redeemCode' => 'Redeem Code',
			'wallet.myOrders' => 'Orders',
			'wallet.recentTransactions' => 'Recent Transactions',
			'wallet.seeAll' => 'See All',
			'wallet.noTransactions' => 'No transactions yet',
			'wallet.walletTitle' => 'Your Wallet',
			'wallet.walletBalance' => 'Wallet Balance',
			'wallet.egp' => 'EGP',
			'wallet.points' => 'Points',
			'wallet.transactionsTitle' => 'Transactions',
			'wallet.vodafoneCash' => 'Vodafone Cash',
			'wallet.vodafoneDesc' => 'Pay using Vodafone Cash wallet',
			'wallet.instaPay' => 'InstaPay',
			'wallet.instaPayDesc' => 'Pay using InstaPay app',
			'wallet.fawry' => 'Fawry',
			'wallet.fawryDesc' => 'Pay at any Fawry retail point',
			'wallet.amount' => 'Amount',
			'wallet.choosePaymentMethod' => 'Choose Payment Method',
			'wallet.continueBtn' => 'Continue',
			'wallet.redeemCodeTitle' => 'Redeem Your Code',
			'wallet.enterCodeDesc' => 'Enter the code you received to add balance to your wallet.',
			'wallet.activateCode' => 'Activate Code',
			'wallet.redeemPolicy' => 'By activating this code, you agree to our terms and conditions.',
			'wallet.purchaseConfirm' => 'Purchase Confirm',
			'wallet.failedToLoadPayment' => 'Failed to load payment',
			'wallet.paymentMethod' => 'Payment Method',
			'wallet.reference' => 'Reference',
			'wallet.total' => 'Total',
			'wallet.confirmPayment' => 'Confirm Payment',
			'wallet.paymentSuccess' => 'Payment Success',
			'wallet.balanceAdded' => 'Balance Added: %s',
			'wallet.newBalance' => 'New Balance',
			'wallet.backToWallet' => 'Back to Wallet',
			_ => null,
		};
	}
}
