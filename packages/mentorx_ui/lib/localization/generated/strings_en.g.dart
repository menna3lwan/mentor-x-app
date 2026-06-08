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

	/// en: 'Dashboard'
	String get dashboardTitle => 'Dashboard';

	/// en: 'Retry'
	String get retry => 'Retry';

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

	/// en: 'MentorX'
	String get appName => 'MentorX';

	/// en: 'Stay connected with your child's education'
	String get loginTagline => 'Stay connected with your child\'s education';

	/// en: 'Sign in to your dashboard'
	String get signInToDashboard => 'Sign in to your dashboard';

	/// en: 'Phone Number'
	String get phoneNumberLabel => 'Phone Number';

	/// en: 'Enter your phone number'
	String get phoneNumberHint => 'Enter your phone number';

	/// en: 'Phone number is required'
	String get phoneRequired => 'Phone number is required';

	/// en: 'Password'
	String get passwordLabel => 'Password';

	/// en: 'Enter your password'
	String get passwordPlaceholder => 'Enter your password';

	/// en: 'Password is required'
	String get passwordRequired => 'Password is required';

	/// en: 'Confirm Password'
	String get confirmPasswordLabel => 'Confirm Password';

	/// en: 'New Password'
	String get newPasswordLabel => 'New Password';

	/// en: 'Login failed. Please try again'
	String get loginFailed => 'Login failed. Please try again';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'Forgot Password'
	String get forgotPasswordTitle => 'Forgot Password';

	/// en: 'Enter your phone number to reset your password'
	String get forgotPasswordSubtitle => 'Enter your phone number to reset your password';

	/// en: 'Reset Password'
	String get resetPasswordTitle => 'Reset Password';

	/// en: 'Create a new password for ${phone}'
	String resetPasswordSubtitle({required Object phone}) => 'Create a new password for ${phone}';

	/// en: 'Password reset successfully'
	String get passwordResetSuccess => 'Password reset successfully';

	/// en: 'New to MentorX?'
	String get newToMentorX => 'New to MentorX?';

	/// en: 'Create Account'
	String get createAccount => 'Create Account';

	/// en: 'Back to Login'
	String get backToLogin => 'Back to Login';

	/// en: 'Verify Your Number'
	String get otpTitle => 'Verify Your Number';

	/// en: 'Enter the code sent to ${phone}'
	String otpSubtitle({required Object phone}) => 'Enter the code sent to ${phone}';

	/// en: 'Verification Code'
	String get otpFieldLabel => 'Verification Code';

	/// en: 'Enter verification code'
	String get otpFieldHint => 'Enter verification code';

	/// en: 'OTP Code'
	String get otpCodeLabel => 'OTP Code';

	/// en: 'Verify & Continue'
	String get verifyAndContinue => 'Verify & Continue';

	/// en: 'Verification failed. Please try again'
	String get verificationFailed => 'Verification failed. Please try again';

	/// en: 'Send Verification Code'
	String get sendVerificationCode => 'Send Verification Code';

	/// en: 'Failed to send verification code'
	String get sendCodeFailed => 'Failed to send verification code';

	/// en: 'Resend Code'
	String get resendCode => 'Resend Code';

	/// en: 'Resend in ${seconds: int}s'
	String resendInSeconds({required int seconds}) => 'Resend in ${seconds}s';

	/// en: 'Resending...'
	String get resending => 'Resending...';

	/// en: 'Update Password Now'
	String get updatePasswordNow => 'Update Password Now';

	/// en: 'Password Recovery'
	String get passwordRecoveryHeading => 'Password Recovery';

	/// en: 'Please check your inputs'
	String get validationCheckInputs => 'Please check your inputs';

	/// en: 'Parent Registration'
	String get regDefaultTitle => 'Parent Registration';

	/// en: 'By Phone'
	String get regLookupPhoneTab => 'By Phone';

	/// en: 'By Code'
	String get regLookupCodeTab => 'By Code';

	/// en: 'Student Code'
	String get regStudentCodeLabel => 'Student Code';

	/// en: 'Enter student code'
	String get regStudentCodeHint => 'Enter student code';

	/// en: 'Child's Phone Number'
	String get regChildPhoneLabel => 'Child\'s Phone Number';

	/// en: 'Enter child's phone number'
	String get regChildPhoneHint => 'Enter child\'s phone number';

	/// en: 'Find Student'
	String get regFindStudent => 'Find Student';

	/// en: 'Find Student'
	String get regStep1Title => 'Find Student';

	/// en: 'Confirm Student'
	String get regStep2Title => 'Confirm Student';

	/// en: 'Create Account'
	String get regStep3Title => 'Create Account';

	/// en: 'Is this your child?'
	String get regConfirmIsYourChild => 'Is this your child?';

	/// en: 'Yes, this is my child'
	String get regChildConfirmed => 'Yes, this is my child';

	/// en: 'Confirm'
	String get regConfirmChild => 'Confirm';

	/// en: 'First Name'
	String get regFirstNameLabel => 'First Name';

	/// en: 'Enter your first name'
	String get regFirstNameHint => 'Enter your first name';

	/// en: 'Last Name'
	String get regLastNameLabel => 'Last Name';

	/// en: 'Enter your last name'
	String get regLastNameHint => 'Enter your last name';

	/// en: 'Email'
	String get regEmailLabel => 'Email';

	/// en: 'Enter your email'
	String get regEmailHint => 'Enter your email';

	/// en: 'Relationship'
	String get regRelationshipLabel => 'Relationship';

	/// en: 'Enter your phone number'
	String get regYourPhoneHint => 'Enter your phone number';

	/// en: 'Your information is kept private and secure'
	String get regSecurityHint => 'Your information is kept private and secure';

	/// en: 'Create Account'
	String get regCreateAccount => 'Create Account';

	/// en: 'Continue'
	String get regContinue => 'Continue';

	/// en: 'Please wait...'
	String get regPleaseWait => 'Please wait...';

	/// en: 'Already have an account?'
	String get regAlreadyHaveAccount => 'Already have an account?';

	/// en: 'No student found with that information'
	String get regErrorLookupEmpty => 'No student found with that information';

	/// en: 'Student not found'
	String get regErrorStudentNotFound => 'Student not found';

	/// en: 'Failed to find student'
	String get regErrorFindFailed => 'Failed to find student';

	/// en: 'Please find the student first'
	String get regErrorFindChildFirst => 'Please find the student first';

	/// en: 'Please confirm the student'
	String get regErrorConfirmChild => 'Please confirm the student';

	/// en: 'First name is too short'
	String get regErrorFirstNameShort => 'First name is too short';

	/// en: 'Last name is too short'
	String get regErrorLastNameShort => 'Last name is too short';

	/// en: 'Invalid phone number'
	String get regErrorInvalidPhone => 'Invalid phone number';

	/// en: 'Invalid email address'
	String get regErrorInvalidEmail => 'Invalid email address';

	/// en: 'Relationship is required'
	String get regErrorRelationshipRequired => 'Relationship is required';

	/// en: 'Password is too weak'
	String get regErrorPasswordWeak => 'Password is too weak';

	/// en: 'Passwords do not match'
	String get regErrorPasswordMismatch => 'Passwords do not match';

	/// en: 'This phone number is already registered'
	String get regErrorPhoneAlreadyExists => 'This phone number is already registered';

	/// en: 'Registration failed. Please try again'
	String get regErrorRegistrationFailed => 'Registration failed. Please try again';
}

// Path: parent.children
class TranslationsParentChildrenEn {
	TranslationsParentChildrenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No children found'
	String get lookupEmpty => 'No children found';

	/// en: 'Linked Children'
	String get title => 'Linked Children';

	/// en: 'Child linked successfully'
	String get linkSuccess => 'Child linked successfully';

	/// en: 'Child unlinked successfully'
	String get unlinkSuccess => 'Child unlinked successfully';

	/// en: 'Link a Child'
	String get linkChildTitle => 'Link a Child';

	/// en: 'Search for your child using their phone number or student code'
	String get linkChildHint => 'Search for your child using their phone number or student code';

	/// en: 'Search'
	String get searchLabel => 'Search';

	/// en: 'Phone number or student code'
	String get searchHint => 'Phone number or student code';

	/// en: 'Specify your relationship to this student'
	String get specifyRelationship => 'Specify your relationship to this student';

	/// en: 'Grade: ${grade}'
	String gradeLabel({required Object grade}) => 'Grade: ${grade}';

	/// en: 'Confirm Link'
	String get confirmLink => 'Confirm Link';

	/// en: 'This child is already linked to your account'
	String get errorAlreadyLinked => 'This child is already linked to your account';

	/// en: 'Student not found'
	String get errorStudentNotFound => 'Student not found';

	/// en: 'Network error. Please try again'
	String get errorNetwork => 'Network error. Please try again';

	/// en: 'An error occurred. Please try again'
	String get errorGeneric => 'An error occurred. Please try again';

	/// en: 'Link New Child'
	String get linkNewChild => 'Link New Child';

	/// en: 'Unlink'
	String get unlink => 'Unlink';

	/// en: 'Unlink Child'
	String get unlinkConfirmTitle => 'Unlink Child';

	/// en: 'Remove ${name} from your account?'
	String unlinkConfirmMessage({required Object name}) => 'Remove ${name} from your account?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'ID: ${id}'
	String studentIdLabel({required Object id}) => 'ID: ${id}';

	/// en: '${center}'
	String centerLabel({required Object center}) => '${center}';

	late final TranslationsParentChildrenRelationshipEn relationship = TranslationsParentChildrenRelationshipEn._(_root);
}

// Path: parent.notificationCenter
class TranslationsParentNotificationCenterEn {
	TranslationsParentNotificationCenterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Read'
	String get read => 'Read';

	/// en: 'Unread'
	String get unread => 'Unread';

	/// en: 'Mark All as Read'
	String get markAllRead => 'Mark All as Read';

	/// en: 'All notifications marked as read'
	String get markAllReadSuccess => 'All notifications marked as read';

	/// en: 'Mark as Read'
	String get markRead => 'Mark as Read';

	/// en: 'Notification marked as read'
	String get markReadSuccess => 'Notification marked as read';

	/// en: 'Failed to load notifications'
	String get loadFailed => 'Failed to load notifications';

	/// en: 'No Notifications'
	String get noNotificationsTitle => 'No Notifications';

	/// en: 'You're all caught up! Check back later.'
	String get noNotificationsHint => 'You\'re all caught up! Check back later.';

	/// en: 'Open Link'
	String get openLink => 'Open Link';

	/// en: 'Notification Details'
	String get detailsTitle => 'Notification Details';

	/// en: 'Received At'
	String get receivedAt => 'Received At';

	/// en: 'Student'
	String get student => 'Student';
}

// Path: parent.onboarding
class TranslationsParentOnboardingEn {
	TranslationsParentOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Track Your Child's Progress'
	String get slide1Title => 'Track Your Child\'s Progress';

	/// en: 'Get real-time updates on your child's academic performance, attendance, and activities'
	String get slide1Description => 'Get real-time updates on your child\'s academic performance, attendance, and activities';

	/// en: 'Stay in Touch'
	String get slide2Title => 'Stay in Touch';

	/// en: 'Communicate with teachers and receive important announcements directly'
	String get slide2Description => 'Communicate with teachers and receive important announcements directly';

	/// en: 'Manage Finances Easily'
	String get slide3Title => 'Manage Finances Easily';

	/// en: 'Monitor wallet balance, transactions, and financial activity from one place'
	String get slide3Description => 'Monitor wallet balance, transactions, and financial activity from one place';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Skip'
	String get skip => 'Skip';
}

// Path: parent.pushNotifications
class TranslationsParentPushNotificationsEn {
	TranslationsParentPushNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open'
	String get bannerOpen => 'Open';

	/// en: 'Dismiss'
	String get bannerDismiss => 'Dismiss';

	/// en: 'Push notification permission was denied. Enable it in your device settings.'
	String get permissionDeniedMessage => 'Push notification permission was denied. Enable it in your device settings.';
}

// Path: parent.splash
class TranslationsParentSplashEn {
	TranslationsParentSplashEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MentorX'
	String get appName => 'MentorX';

	/// en: 'Empowering Every Learner'
	String get tagline => 'Empowering Every Learner';
}

// Path: parent.home
class TranslationsParentHomeEn {
	TranslationsParentHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Academic Standing'
	String get academicStanding => 'Academic Standing';

	/// en: 'Add Child'
	String get addChild => 'Add Child';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Avg. Grade'
	String get avgGrade => 'Avg. Grade';

	/// en: 'Link Child'
	String get linkChild => 'Link Child';

	/// en: 'Link a student account to get started'
	String get noChildrenHint => 'Link a student account to get started';

	/// en: 'No Children Yet'
	String get noChildrenTitle => 'No Children Yet';

	/// en: 'No Recent Activity'
	String get noRecentActivity => 'No Recent Activity';

	/// en: 'Activity from your child's learning will appear here'
	String get noRecentActivityHint => 'Activity from your child\'s learning will appear here';

	/// en: 'No recent grades'
	String get noRecentGrades => 'No recent grades';

	/// en: 'No upcoming sessions'
	String get noUpcomingSessions => 'No upcoming sessions';

	/// en: 'Parent Account'
	String get parentAccount => 'Parent Account';

	/// en: 'Recent Grades'
	String get recentGrades => 'Recent Grades';

	/// en: 'Unpaid Fees'
	String get unpaidFees => 'Unpaid Fees';

	/// en: 'Upcoming Sessions'
	String get upcomingSessions => 'Upcoming Sessions';

	/// en: 'Updated at ${time}'
	String updatedAt({required Object time}) => 'Updated at ${time}';
}

// Path: parent.academic
class TranslationsParentAcademicEn {
	TranslationsParentAcademicEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Average'
	String get averageLabel => 'Average';

	/// en: 'Graded'
	String get gradedLabel => 'Graded';

	/// en: 'No enrolled courses found for this child'
	String get noCoursesHint => 'No enrolled courses found for this child';

	/// en: 'No Courses'
	String get noCoursesTitle => 'No Courses';

	/// en: 'Overall Average'
	String get overallAverageHeading => 'Overall Average';

	/// en: 'Academic Monitor'
	String get pageTitle => 'Academic Monitor';

	/// en: 'Pending'
	String get pendingLabel => 'Pending';

	/// en: '${count: int} sessions'
	String sessionsCount({required int count}) => '${count} sessions';
}

// Path: parent.assessments
class TranslationsParentAssessmentsEn {
	TranslationsParentAssessmentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Assessment History'
	String get assessmentHistory => 'Assessment History';

	/// en: 'Average'
	String get average => 'Average';

	/// en: 'Graded'
	String get graded => 'Graded';

	/// en: 'No assessments have been completed yet'
	String get noAssessmentsHint => 'No assessments have been completed yet';

	/// en: 'No Assessments'
	String get noAssessmentsTitle => 'No Assessments';

	/// en: 'Overall Performance'
	String get overallPerformance => 'Overall Performance';

	/// en: 'Grade Monitor'
	String get pageTitle => 'Grade Monitor';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Quiz:'
	String get quizPrefix => 'Quiz:';

	/// en: '${score}/${total}'
	String scoreLabel({required Object score, required Object total}) => '${score}/${total}';
}

// Path: parent.gradeDetail
class TranslationsParentGradeDetailEn {
	TranslationsParentGradeDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Additional Details'
	String get additionalDetails => 'Additional Details';

	/// en: 'Assessment Info'
	String get assessmentInfo => 'Assessment Info';

	/// en: 'Correct Answer'
	String get correctAnswer => 'Correct Answer';

	/// en: 'Fail'
	String get fail => 'Fail';

	/// en: 'Incorrect Answer'
	String get incorrectAnswer => 'Incorrect Answer';

	/// en: 'Assessment not found'
	String get notFound => 'Assessment not found';

	/// en: 'Grade Detail'
	String get pageTitle => 'Grade Detail';

	/// en: 'Pass'
	String get pass => 'Pass';

	/// en: 'Pass Criteria'
	String get passCriteria => 'Pass Criteria';

	/// en: 'Percentage'
	String get percentage => 'Percentage';

	/// en: 'Question Breakdown'
	String get questionBreakdown => 'Question Breakdown';

	/// en: 'Question ${number}'
	String questionLabel({required Object number}) => 'Question ${number}';

	/// en: 'Quiz Detail'
	String get quizDetail => 'Quiz Detail';

	/// en: 'Quiz ID'
	String get quizId => 'Quiz ID';

	/// en: 'Quiz Score'
	String get quizScore => 'Quiz Score';

	/// en: 'Result'
	String get result => 'Result';

	/// en: 'Score'
	String get score => 'Score';

	/// en: 'Submitted At'
	String get submittedAt => 'Submitted At';
}

// Path: parent.attendanceTracking
class TranslationsParentAttendanceTrackingEn {
	TranslationsParentAttendanceTrackingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Absent'
	String get absent => 'Absent';

	/// en: 'Attendance Log'
	String get attendanceLog => 'Attendance Log';

	/// en: 'Check-in: ${time}'
	String checkInTimeLabel({required Object time}) => 'Check-in: ${time}';

	/// en: 'Friday'
	String get dayFriday => 'Friday';

	/// en: 'Monday'
	String get dayMonday => 'Monday';

	/// en: 'Saturday'
	String get daySaturday => 'Saturday';

	/// en: 'Sunday'
	String get daySunday => 'Sunday';

	/// en: 'Thursday'
	String get dayThursday => 'Thursday';

	/// en: 'Tuesday'
	String get dayTuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get dayWednesday => 'Wednesday';

	/// en: 'Excused'
	String get excused => 'Excused';

	/// en: 'General Academic'
	String get generalAcademic => 'General Academic';

	/// en: 'Active'
	String get groupActiveBadge => 'Active';

	/// en: 'Attendance Rate'
	String get groupAttendanceRatioLabel => 'Attendance Rate';

	/// en: 'Attendance Summary'
	String get groupAttendanceTitle => 'Attendance Summary';

	/// en: '${count: int} attended'
	String groupAttendedSessions({required int count}) => '${count} attended';

	/// en: 'Course'
	String get groupCourseLabel => 'Course';

	/// en: 'Description'
	String get groupDescriptionLabel => 'Description';

	/// en: 'Group Details'
	String get groupDetailTitle => 'Group Details';

	/// en: 'End: ${date}'
	String groupEndDateLabel({required Object date}) => 'End: ${date}';

	/// en: '${count: int} enrolled'
	String groupEnrolledLabel({required int count}) => '${count} enrolled';

	/// en: 'Failed to load group'
	String get groupFailureTitle => 'Failed to load group';

	/// en: 'Inactive'
	String get groupInactiveBadge => 'Inactive';

	/// en: '${count: int} late'
	String groupLateSessions({required int count}) => '${count} late';

	/// en: 'Location'
	String get groupLocationLabel => 'Location';

	/// en: '${count: int} missed'
	String groupMissedSessions({required int count}) => '${count} missed';

	/// en: 'No schedule available'
	String get groupNoSchedule => 'No schedule available';

	/// en: 'The attendance group could not be found'
	String get groupNotFoundHint => 'The attendance group could not be found';

	/// en: 'Group Not Found'
	String get groupNotFoundTitle => 'Group Not Found';

	/// en: 'Recent Sessions'
	String get groupRecentSessionsTitle => 'Recent Sessions';

	/// en: 'Schedule'
	String get groupScheduleTitle => 'Schedule';

	/// en: 'Room: ${room}'
	String groupSessionRoomLabel({required Object room}) => 'Room: ${room}';

	/// en: 'Start: ${date}'
	String groupStartDateLabel({required Object date}) => 'Start: ${date}';

	/// en: 'Teacher'
	String get groupTeacherLabel => 'Teacher';

	/// en: '${count: int} sessions total'
	String groupTotalSessions({required int count}) => '${count} sessions total';

	/// en: 'Groups'
	String get groupsAction => 'Groups';

	/// en: 'No attendance groups found'
	String get groupsEmptyHint => 'No attendance groups found';

	/// en: 'No Groups'
	String get groupsEmptyTitle => 'No Groups';

	/// en: 'View your child's attendance groups'
	String get groupsHint => 'View your child\'s attendance groups';

	/// en: 'Attendance Groups'
	String get groupsTitle => 'Attendance Groups';

	/// en: 'Late'
	String get late => 'Late';

	/// en: 'No attendance records found for this period'
	String get noRecordsHint => 'No attendance records found for this period';

	/// en: 'No Records'
	String get noRecordsTitle => 'No Records';

	/// en: 'Online'
	String get onlineSession => 'Online';

	/// en: 'Attendance Monitor'
	String get pageTitle => 'Attendance Monitor';

	/// en: 'Present'
	String get present => 'Present';

	/// en: 'Regular Session'
	String get regularSession => 'Regular Session';
}

// Path: parent.financial
class TranslationsParentFinancialEn {
	TranslationsParentFinancialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Balance'
	String get balance => 'Balance';

	/// en: 'Credits This Month'
	String get creditsThisMonth => 'Credits This Month';

	/// en: 'EGP'
	String get currencySymbol => 'EGP';

	/// en: 'Wallet Balance'
	String get myWalletBalanceLabel => 'Wallet Balance';

	/// en: 'My Wallet'
	String get myWalletTitle => 'My Wallet';

	/// en: 'No transactions have been made yet'
	String get noTransactionsHint => 'No transactions have been made yet';

	/// en: 'No Transactions'
	String get noTransactionsTitle => 'No Transactions';

	/// en: 'Points'
	String get points => 'Points';

	/// en: 'Spent'
	String get spent => 'Spent';

	/// en: 'Top Up'
	String get topUpAction => 'Top Up';

	/// en: 'Enter amount'
	String get topUpAmountHint => 'Enter amount';

	/// en: 'Amount'
	String get topUpAmountLabel => 'Amount';

	/// en: 'Amount is below the minimum'
	String get topUpBelowMinimum => 'Amount is below the minimum';

	/// en: 'Top up failed. Please try again'
	String get topUpFailed => 'Top up failed. Please try again';

	/// en: 'Add funds to your child's wallet'
	String get topUpHint => 'Add funds to your child\'s wallet';

	/// en: 'Insufficient funds'
	String get topUpInsufficientFunds => 'Insufficient funds';

	/// en: 'Invalid amount'
	String get topUpInvalidAmount => 'Invalid amount';

	/// en: 'Wallet topped up successfully'
	String get topUpSuccess => 'Wallet topped up successfully';

	/// en: 'Top Up Wallet'
	String get topUpTitle => 'Top Up Wallet';

	/// en: 'Transaction History'
	String get transactionsTitle => 'Transaction History';
}

// Path: parent.courseDetail
class TranslationsParentCourseDetailEn {
	TranslationsParentCourseDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Course Breakdown'
	String get courseBreakdown => 'Course Breakdown';

	/// en: 'Course ID'
	String get courseId => 'Course ID';

	/// en: 'Description'
	String get descriptionLabel => 'Description';

	/// en: 'No course data available'
	String get emptyHint => 'No course data available';

	/// en: 'No Courses'
	String get emptyTitle => 'No Courses';

	/// en: '${count: int} enrolled'
	String enrolledCount({required int count}) => '${count} enrolled';

	/// en: 'Failed to load course'
	String get failureTitle => 'Failed to load course';

	/// en: 'Full Course'
	String get fullTitle => 'Full Course';

	/// en: 'Course Detail'
	String get pageTitle => 'Course Detail';

	/// en: 'Progress'
	String get progress => 'Progress';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Active'
	String get statusActive => 'Active';

	/// en: 'Completed'
	String get statusCompleted => 'Completed';

	/// en: 'In Progress'
	String get statusInProgress => 'In Progress';

	/// en: 'Course Status'
	String get statusLabel => 'Course Status';
}

// Path: parent.communication
class TranslationsParentCommunicationEn {
	TranslationsParentCommunicationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Announcements'
	String get announcementsTitle => 'Announcements';

	/// en: 'Join your child's WhatsApp group'
	String get groupSubtitle => 'Join your child\'s WhatsApp group';

	/// en: 'Join Group'
	String get joinGroup => 'Join Group';

	/// en: 'No announcements at this time'
	String get noAnnouncementsHint => 'No announcements at this time';

	/// en: 'No Announcements'
	String get noAnnouncementsTitle => 'No Announcements';

	/// en: 'No WhatsApp groups available'
	String get noGroupsHint => 'No WhatsApp groups available';

	/// en: 'No Groups'
	String get noGroupsTitle => 'No Groups';

	/// en: 'Read More'
	String get readMore => 'Read More';

	/// en: 'WhatsApp Groups'
	String get whatsAppTitle => 'WhatsApp Groups';
}

// Path: parent.analytics
class TranslationsParentAnalyticsEn {
	TranslationsParentAnalyticsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${minutes} min/day'
	String averagePerDay({required Object minutes}) => '${minutes} min/day';

	/// en: '${seconds}s avg'
	String averageQuizSpeed({required Object seconds}) => '${seconds}s avg';

	/// en: 'Child's Average'
	String get childAverageLabel => 'Child\'s Average';

	/// en: 'Class Average'
	String get classAverageLabel => 'Class Average';

	/// en: '${completed: int}/${total: int} sessions'
	String completedSessionsLabel({required int completed, required int total}) => '${completed}/${total} sessions';

	/// en: 'Current Streak'
	String get currentStreak => 'Current Streak';

	/// en: 'No data available for this section'
	String get emptySectionHint => 'No data available for this section';

	/// en: 'No Data'
	String get emptySectionTitle => 'No Data';

	/// en: 'Retry'
	String get errorRetry => 'Retry';

	/// en: 'Last active: ${time}'
	String lastActive({required Object time}) => 'Last active: ${time}';

	/// en: 'Failed to load analytics'
	String get loadFailed => 'Failed to load analytics';

	/// en: 'Longest Streak'
	String get longestStreak => 'Longest Streak';

	/// en: 'Analytics'
	String get pageTitle => 'Analytics';

	/// en: '${count: int} quizzes'
	String quizCountLabel({required int count}) => '${count} quizzes';

	/// en: '#${rank: int} of ${total: int}'
	String rankLabel({required int rank, required int total}) => '#${rank} of ${total}';

	/// en: 'Achievements'
	String get sectionAchievements => 'Achievements';

	/// en: 'Active Hours'
	String get sectionActiveHours => 'Active Hours';

	/// en: 'Course Progress'
	String get sectionCourseProgress => 'Course Progress';

	/// en: 'Grade Comparison'
	String get sectionGradeComparison => 'Grade Comparison';

	/// en: 'Quiz Speed'
	String get sectionQuizSpeed => 'Quiz Speed';

	/// en: 'Streak'
	String get sectionStreak => 'Streak';

	/// en: '${days: int} days'
	String streakDays({required int days}) => '${days} days';

	/// en: '${minutes: int} min total'
	String totalMinutes({required int minutes}) => '${minutes} min total';

	/// en: 'You are not authorized to view this'
	String get unauthorized => 'You are not authorized to view this';

	/// en: '${unlocked: int} unlocked'
	String unlockedCount({required int unlocked}) => '${unlocked} unlocked';
}

// Path: parent.quickActions
class TranslationsParentQuickActionsEn {
	TranslationsParentQuickActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Courses'
	String get courses => 'Courses';

	/// en: 'Fees'
	String get fees => 'Fees';

	/// en: 'Grades'
	String get grades => 'Grades';

	/// en: 'Messages'
	String get messages => 'Messages';
}

// Path: parent.profile
class TranslationsParentProfileEn {
	TranslationsParentProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get aboutTitle => 'About';

	/// en: 'v${version}'
	String aboutVersion({required Object version}) => 'v${version}';

	/// en: 'App Configuration'
	String get appConfigurationSection => 'App Configuration';

	/// en: 'Language'
	String get appLanguage => 'Language';

	/// en: 'Change Photo'
	String get avatarChangeAction => 'Change Photo';

	/// en: 'Invalid image format'
	String get avatarInvalidImage => 'Invalid image format';

	/// en: 'Choose from Gallery'
	String get avatarPickFromGallery => 'Choose from Gallery';

	/// en: 'Take Photo'
	String get avatarTakePhoto => 'Take Photo';

	/// en: 'Failed to upload photo'
	String get avatarUploadFailed => 'Failed to upload photo';

	/// en: 'Uploading...'
	String get avatarUploading => 'Uploading...';

	/// en: 'Change Password'
	String get changePasswordAction => 'Change Password';

	/// en: 'Confirm New Password'
	String get changePasswordConfirmLabel => 'Confirm New Password';

	/// en: 'Current Password'
	String get changePasswordCurrentLabel => 'Current Password';

	/// en: 'Current password is required'
	String get changePasswordCurrentRequired => 'Current password is required';

	/// en: 'Failed to change password'
	String get changePasswordFailed => 'Failed to change password';

	/// en: 'Choose a strong password to keep your account secure'
	String get changePasswordHint => 'Choose a strong password to keep your account secure';

	/// en: 'New passwords do not match'
	String get changePasswordMismatch => 'New passwords do not match';

	/// en: 'New Password'
	String get changePasswordNewLabel => 'New Password';

	/// en: 'Password changed successfully'
	String get changePasswordSuccess => 'Password changed successfully';

	/// en: 'Change Password'
	String get changePasswordTitle => 'Change Password';

	/// en: 'Password is too weak'
	String get changePasswordTooWeak => 'Password is too weak';

	/// en: 'Current password is incorrect'
	String get changePasswordWrongCurrent => 'Current password is incorrect';

	/// en: 'Enter your full name'
	String get editFullNameHint => 'Enter your full name';

	/// en: 'Full Name'
	String get editFullNameLabel => 'Full Name';

	/// en: 'Name is too short'
	String get editFullNameTooShort => 'Name is too short';

	/// en: 'Failed to load profile'
	String get editLoadFailed => 'Failed to load profile';

	/// en: 'Network error. Please try again'
	String get editNetworkError => 'Network error. Please try again';

	/// en: 'Save'
	String get editSaveAction => 'Save';

	/// en: 'Failed to save changes'
	String get editSaveFailed => 'Failed to save changes';

	/// en: 'Profile updated successfully'
	String get editSaveSuccess => 'Profile updated successfully';

	/// en: 'Edit Profile'
	String get editTitle => 'Edit Profile';

	/// en: 'You are not authorized to edit this profile'
	String get editUnauthorized => 'You are not authorized to edit this profile';

	/// en: 'Email'
	String get emailLabel => 'Email';

	/// en: 'Parent'
	String get fallbackName => 'Parent';

	/// en: 'Full Name'
	String get fullNameLabel => 'Full Name';

	/// en: 'Help Center'
	String get helpCenter => 'Help Center';

	/// en: 'Visit support page'
	String get helpCenterValue => 'Visit support page';

	/// en: 'Arabic'
	String get languageArabic => 'Arabic';

	/// en: 'English'
	String get languageEnglish => 'English';

	/// en: 'Push Notifications'
	String get notificationsEnabled => 'Push Notifications';

	/// en: 'Phone Number'
	String get phoneNumberLabel => 'Phone Number';

	/// en: 'Preferences'
	String get preferencesSection => 'Preferences';

	/// en: 'Push Notifications'
	String get pushNotifications => 'Push Notifications';

	/// en: 'Change Password'
	String get securityChangePassword => 'Change Password';

	/// en: 'Password & Security'
	String get securityValue => 'Password & Security';

	/// en: 'MentorX Parent App v${version} Monitor your child's academic journey in real time.'
	String settingsAboutBody({required Object version}) => 'MentorX Parent App v${version}\n\nMonitor your child\'s academic journey in real time.';

	/// en: 'About MentorX'
	String get settingsAboutTitle => 'About MentorX';

	/// en: 'https://mentorx.app/support'
	String get settingsHelpUrl => 'https://mentorx.app/support';

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Sign Out'
	String get signOutAction => 'Sign Out';

	/// en: 'Cancel'
	String get signOutCancel => 'Cancel';

	/// en: 'Are you sure you want to sign out?'
	String get signOutConfirmMessage => 'Are you sure you want to sign out?';

	/// en: 'Sign Out'
	String get signOutConfirmTitle => 'Sign Out';

	/// en: 'Support'
	String get supportSection => 'Support';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Theme'
	String get themeMode => 'Theme';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Verified Account'
	String get verifiedAccount => 'Verified Account';
}

// Path: parent.devices
class TranslationsParentDevicesEn {
	TranslationsParentDevicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active'
	String get activeBadge => 'Active';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'This Device'
	String get currentBadge => 'This Device';

	/// en: 'No devices have been linked to your account'
	String get emptyHint => 'No devices have been linked to your account';

	/// en: 'No Devices'
	String get emptyTitle => 'No Devices';

	/// en: 'Force Logout All'
	String get forceLogoutAction => 'Force Logout All';

	/// en: 'This will log out all other devices. Continue?'
	String get forceLogoutConfirmMessage => 'This will log out all other devices. Continue?';

	/// en: 'Force Logout'
	String get forceLogoutConfirmTitle => 'Force Logout';

	/// en: 'Log out all other active devices'
	String get forceLogoutHint => 'Log out all other active devices';

	/// en: 'All other devices have been logged out'
	String get forceLogoutSuccess => 'All other devices have been logged out';

	/// en: 'Force Logout'
	String get forceLogoutTitle => 'Force Logout';

	/// en: 'Inactive'
	String get inactiveBadge => 'Inactive';

	/// en: 'Last used: ${time}'
	String lastUsedLabel({required Object time}) => 'Last used: ${time}';

	/// en: 'Manage devices with access to your account'
	String get pageSubtitle => 'Manage devices with access to your account';

	/// en: 'Trusted Devices'
	String get pageTitle => 'Trusted Devices';

	/// en: 'Revoke'
	String get revokeAction => 'Revoke';

	/// en: 'Remove access for ${device}?'
	String revokeConfirmMessage({required Object device}) => 'Remove access for ${device}?';

	/// en: 'Revoke Device'
	String get revokeConfirmTitle => 'Revoke Device';

	/// en: 'Device access revoked'
	String get revokeSuccess => 'Device access revoked';

	/// en: 'Manage trusted devices'
	String get settingsSubtitle => 'Manage trusted devices';
}

// Path: parent.deleteAccount
class TranslationsParentDeleteAccountEn {
	TranslationsParentDeleteAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'I understand this action is permanent'
	String get acknowledgementLabel => 'I understand this action is permanent';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete My Account'
	String get confirmAction => 'Delete My Account';

	/// en: 'DELETE'
	String get confirmationPhrase => 'DELETE';

	/// en: 'Type "${phrase}" to confirm'
	String confirmationPrompt({required Object phrase}) => 'Type "${phrase}" to confirm';

	/// en: 'All your data including profile, history, and linked accounts will be permanently deleted'
	String get consequence => 'All your data including profile, history, and linked accounts will be permanently deleted';

	/// en: 'Your profile and personal information will be deleted'
	String get consequence1 => 'Your profile and personal information will be deleted';

	/// en: 'All linked children and their data will be unlinked'
	String get consequence2 => 'All linked children and their data will be unlinked';

	/// en: 'Transaction history and wallet balance will be lost'
	String get consequence3 => 'Transaction history and wallet balance will be lost';

	/// en: 'This action cannot be undone'
	String get consequence4 => 'This action cannot be undone';

	/// en: 'What will be deleted'
	String get consequencesTitle => 'What will be deleted';

	/// en: 'You can request a copy of your data before deleting'
	String get dataExportHint => 'You can request a copy of your data before deleting';

	/// en: 'Export My Data'
	String get dataExportLabel => 'Export My Data';

	/// en: 'Your account will be permanently deleted within 24 hours. This cannot be undone.'
	String get finalConfirmMessage => 'Your account will be permanently deleted within 24 hours. This cannot be undone.';

	/// en: 'Final Confirmation'
	String get finalConfirmTitle => 'Final Confirmation';

	/// en: 'Network error. Please try again'
	String get networkError => 'Network error. Please try again';

	/// en: 'Delete Account'
	String get pageTitle => 'Delete Account';

	/// en: 'Tell us why you're leaving (optional)'
	String get reasonHint => 'Tell us why you\'re leaving (optional)';

	/// en: 'Reason for Deletion'
	String get reasonLabel => 'Reason for Deletion';

	/// en: 'Delete Account'
	String get settingsTileLabel => 'Delete Account';

	/// en: 'Permanently remove your account'
	String get settingsTileSubtitle => 'Permanently remove your account';

	/// en: 'Processing your request...'
	String get submitting => 'Processing your request...';

	/// en: 'Your account deletion request has been submitted'
	String get successMessage => 'Your account deletion request has been submitted';

	/// en: 'You are not authorized to perform this action'
	String get unauthorizedError => 'You are not authorized to perform this action';

	/// en: 'An unknown error occurred'
	String get unknownError => 'An unknown error occurred';

	/// en: 'Please complete all required fields'
	String get validationError => 'Please complete all required fields';

	/// en: 'This action is permanent and cannot be undone'
	String get warningSubtitle => 'This action is permanent and cannot be undone';

	/// en: 'Warning'
	String get warningTitle => 'Warning';
}

// Path: parent.pendingAccount
class TranslationsParentPendingAccountEn {
	TranslationsParentPendingAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your account has been approved!'
	String get approvedToastMessage => 'Your account has been approved!';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Check Status'
	String get checkAgain => 'Check Status';

	/// en: 'Checking...'
	String get checking => 'Checking...';

	/// en: 'Contact Support'
	String get contactSupport => 'Contact Support';

	/// en: 'If you have questions, reach out to our support team'
	String get contactSupportHint => 'If you have questions, reach out to our support team';

	/// en: 'Estimated review by: ${date}'
	String estimatedReviewBy({required Object date}) => 'Estimated review by: ${date}';

	/// en: 'Account Under Review'
	String get headlinePending => 'Account Under Review';

	/// en: 'Account Not Approved'
	String get headlineRejected => 'Account Not Approved';

	/// en: 'Failed to load account status'
	String get loadErrorMessage => 'Failed to load account status';

	/// en: 'Error'
	String get loadErrorTitle => 'Error';

	/// en: 'Account Status'
	String get pageTitle => 'Account Status';

	/// en: 'Reason'
	String get rejectionReasonTitle => 'Reason';

	/// en: 'Sign Out'
	String get signOut => 'Sign Out';

	/// en: 'Are you sure you want to sign out?'
	String get signOutConfirmMessage => 'Are you sure you want to sign out?';

	/// en: 'Sign Out'
	String get signOutConfirmTitle => 'Sign Out';

	/// en: 'Pending'
	String get statusBadgePending => 'Pending';

	/// en: 'Rejected'
	String get statusBadgeRejected => 'Rejected';

	/// en: 'Approved'
	String get stepApproved => 'Approved';

	/// en: 'Your account is active'
	String get stepApprovedHint => 'Your account is active';

	/// en: 'Application Received'
	String get stepReceived => 'Application Received';

	/// en: 'We have received your registration'
	String get stepReceivedHint => 'We have received your registration';

	/// en: 'Under Review'
	String get stepUnderReview => 'Under Review';

	/// en: 'Our team is reviewing your application'
	String get stepUnderReviewHint => 'Our team is reviewing your application';

	/// en: 'Submitted on: ${date}'
	String submittedOn({required Object date}) => 'Submitted on: ${date}';

	/// en: 'Our team is reviewing your registration. You'll be notified once approved.'
	String get subtitlePending => 'Our team is reviewing your registration. You\'ll be notified once approved.';

	/// en: 'Your registration was not approved. Please contact support for assistance.'
	String get subtitleRejected => 'Your registration was not approved. Please contact support for assistance.';

	/// en: 'Support'
	String get supportLabel => 'Support';
}

// Path: parent.children.relationship
class TranslationsParentChildrenRelationshipEn {
	TranslationsParentChildrenRelationshipEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Father'
	String get father => 'Father';

	/// en: 'Mother'
	String get mother => 'Mother';

	/// en: 'Guardian'
	String get guardian => 'Guardian';

	/// en: 'Other'
	String get other => 'Other';
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
			'parent.dashboardTitle' => 'Dashboard',
			'parent.retry' => 'Retry',
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
			'parent.auth.resetPasswordSubtitle' => ({required Object phone}) => 'Create a new password for ${phone}',
			'parent.auth.passwordResetSuccess' => 'Password reset successfully',
			'parent.auth.newToMentorX' => 'New to MentorX?',
			'parent.auth.createAccount' => 'Create Account',
			'parent.auth.backToLogin' => 'Back to Login',
			'parent.auth.otpTitle' => 'Verify Your Number',
			'parent.auth.otpSubtitle' => ({required Object phone}) => 'Enter the code sent to ${phone}',
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
			'parent.children.title' => 'Linked Children',
			'parent.children.linkSuccess' => 'Child linked successfully',
			'parent.children.unlinkSuccess' => 'Child unlinked successfully',
			'parent.children.linkChildTitle' => 'Link a Child',
			'parent.children.linkChildHint' => 'Search for your child using their phone number or student code',
			'parent.children.searchLabel' => 'Search',
			'parent.children.searchHint' => 'Phone number or student code',
			'parent.children.specifyRelationship' => 'Specify your relationship to this student',
			'parent.children.gradeLabel' => ({required Object grade}) => 'Grade: ${grade}',
			'parent.children.confirmLink' => 'Confirm Link',
			'parent.children.errorAlreadyLinked' => 'This child is already linked to your account',
			'parent.children.errorStudentNotFound' => 'Student not found',
			'parent.children.errorNetwork' => 'Network error. Please try again',
			'parent.children.errorGeneric' => 'An error occurred. Please try again',
			'parent.children.linkNewChild' => 'Link New Child',
			'parent.children.unlink' => 'Unlink',
			'parent.children.unlinkConfirmTitle' => 'Unlink Child',
			'parent.children.unlinkConfirmMessage' => ({required Object name}) => 'Remove ${name} from your account?',
			'parent.children.cancel' => 'Cancel',
			'parent.children.studentIdLabel' => ({required Object id}) => 'ID: ${id}',
			'parent.children.centerLabel' => ({required Object center}) => '${center}',
			'parent.children.relationship.father' => 'Father',
			'parent.children.relationship.mother' => 'Mother',
			'parent.children.relationship.guardian' => 'Guardian',
			'parent.children.relationship.other' => 'Other',
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
			'parent.pushNotifications.permissionDeniedMessage' => 'Push notification permission was denied. Enable it in your device settings.',
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
			'parent.devices.revokeConfirmMessage' => ({required Object device}) => 'Remove access for ${device}?',
			'parent.devices.revokeConfirmTitle' => 'Revoke Device',
			'parent.devices.revokeSuccess' => 'Device access revoked',
			'parent.devices.settingsSubtitle' => 'Manage trusted devices',
			'parent.deleteAccount.acknowledgementLabel' => 'I understand this action is permanent',
			'parent.deleteAccount.cancel' => 'Cancel',
			'parent.deleteAccount.confirmAction' => 'Delete My Account',
			'parent.deleteAccount.confirmationPhrase' => 'DELETE',
			'parent.deleteAccount.confirmationPrompt' => ({required Object phrase}) => 'Type "${phrase}" to confirm',
			'parent.deleteAccount.consequence' => 'All your data including profile, history, and linked accounts will be permanently deleted',
			'parent.deleteAccount.consequence1' => 'Your profile and personal information will be deleted',
			'parent.deleteAccount.consequence2' => 'All linked children and their data will be unlinked',
			'parent.deleteAccount.consequence3' => 'Transaction history and wallet balance will be lost',
			'parent.deleteAccount.consequence4' => 'This action cannot be undone',
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
			_ => null,
		};
	}
}
