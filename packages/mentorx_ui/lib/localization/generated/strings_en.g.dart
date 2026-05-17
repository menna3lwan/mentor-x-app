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
	late final TranslationsUiEn ui = TranslationsUiEn._(_root);
	late final TranslationsCoreEn core = TranslationsCoreEn._(_root);
	late final TranslationsInitialLanguageEn initialLanguage = TranslationsInitialLanguageEn._(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	Map<String, dynamic> get exceptions => {
		'unknown': 'Unknown error',
		'AuthenticationRepositoryExceptionCode': TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(_root),
		'promocodeExceptions': TranslationsExceptionsPromocodeExceptionsEn._(_root),
	};
	Map<String, String> get countries => {
		'afghanistan': 'Afghanistan',
		'albania': 'Albania',
		'algeria': 'Algeria',
		'andorra': 'Andorra',
		'angola': 'Angola',
		'antiguaAndBarbuda': 'Antigua and Barbuda',
		'argentina': 'Argentina',
		'armenia': 'Armenia',
		'australia': 'Australia',
		'austria': 'Austria',
		'azerbaijan': 'Azerbaijan',
		'bahamas': 'Bahamas',
		'bahrain': 'Bahrain',
		'bangladesh': 'Bangladesh',
		'barbados': 'Barbados',
		'belarus': 'Belarus',
		'belgium': 'Belgium',
		'belize': 'Belize',
		'benin': 'Benin',
		'bhutan': 'Bhutan',
		'bolivia': 'Bolivia',
		'bosniaAndHerzegovina': 'Bosnia and Herzegovina',
		'botswana': 'Botswana',
		'brazil': 'Brazil',
		'brunei': 'Brunei',
		'bulgaria': 'Bulgaria',
		'burkinaFaso': 'Burkina Faso',
		'burundi': 'Burundi',
		'cambodia': 'Cambodia',
		'cameroon': 'Cameroon',
		'canada': 'Canada',
		'capeVerde': 'Cape Verde',
		'centralAfricanRepublic': 'Central African Republic',
		'chad': 'Chad',
		'chile': 'Chile',
		'china': 'China',
		'colombia': 'Colombia',
		'comoros': 'Comoros',
		'congo': 'Congo',
		'democraticRepublicOfCongo': 'Democratic Republic of the Congo',
		'costaRica': 'Costa Rica',
		'croatia': 'Croatia',
		'cuba': 'Cuba',
		'cyprus': 'Cyprus',
		'czechRepublic': 'Czech Republic',
		'denmark': 'Denmark',
		'djibouti': 'Djibouti',
		'dominica': 'Dominica',
		'dominicanRepublic': 'Dominican Republic',
		'ecuador': 'Ecuador',
		'egypt': 'Egypt',
		'elSalvador': 'El Salvador',
		'equatorialGuinea': 'Equatorial Guinea',
		'eritrea': 'Eritrea',
		'estonia': 'Estonia',
		'eswatini': 'Eswatini',
		'ethiopia': 'Ethiopia',
		'fiji': 'Fiji',
		'finland': 'Finland',
		'france': 'France',
		'gabon': 'Gabon',
		'gambia': 'Gambia',
		'georgia': 'Georgia',
		'germany': 'Germany',
		'ghana': 'Ghana',
		'greece': 'Greece',
		'grenada': 'Grenada',
		'guatemala': 'Guatemala',
		'guinea': 'Guinea',
		'guineaBissau': 'Guinea-Bissau',
		'guyana': 'Guyana',
		'haiti': 'Haiti',
		'honduras': 'Honduras',
		'hungary': 'Hungary',
		'iceland': 'Iceland',
		'india': 'India',
		'indonesia': 'Indonesia',
		'iran': 'Iran',
		'iraq': 'Iraq',
		'ireland': 'Ireland',
		'israel': 'Israel',
		'italy': 'Italy',
		'ivoryCoast': 'Ivory Coast',
		'jamaica': 'Jamaica',
		'japan': 'Japan',
		'jordan': 'Jordan',
		'kazakhstan': 'Kazakhstan',
		'kenya': 'Kenya',
		'kiribati': 'Kiribati',
		'kuwait': 'Kuwait',
		'kyrgyzstan': 'Kyrgyzstan',
		'laos': 'Laos',
		'latvia': 'Latvia',
		'lebanon': 'Lebanon',
		'lesotho': 'Lesotho',
		'liberia': 'Liberia',
		'libya': 'Libya',
		'liechtenstein': 'Liechtenstein',
		'lithuania': 'Lithuania',
		'luxembourg': 'Luxembourg',
		'madagascar': 'Madagascar',
		'malawi': 'Malawi',
		'malaysia': 'Malaysia',
		'maldives': 'Maldives',
		'mali': 'Mali',
		'malta': 'Malta',
		'marshallIslands': 'Marshall Islands',
		'mauritania': 'Mauritania',
		'mauritius': 'Mauritius',
		'mexico': 'Mexico',
		'micronesia': 'Micronesia',
		'moldova': 'Moldova',
		'monaco': 'Monaco',
		'mongolia': 'Mongolia',
		'montenegro': 'Montenegro',
		'morocco': 'Morocco',
		'mozambique': 'Mozambique',
		'myanmar': 'Myanmar',
		'namibia': 'Namibia',
		'nauru': 'Nauru',
		'nepal': 'Nepal',
		'netherlands': 'Netherlands',
		'newZealand': 'New Zealand',
		'nicaragua': 'Nicaragua',
		'niger': 'Niger',
		'nigeria': 'Nigeria',
		'northKorea': 'North Korea',
		'northMacedonia': 'North Macedonia',
		'norway': 'Norway',
		'oman': 'Oman',
		'pakistan': 'Pakistan',
		'palau': 'Palau',
		'palestine': 'Palestine',
		'panama': 'Panama',
		'papuaNewGuinea': 'Papua New Guinea',
		'paraguay': 'Paraguay',
		'peru': 'Peru',
		'philippines': 'Philippines',
		'poland': 'Poland',
		'portugal': 'Portugal',
		'qatar': 'Qatar',
		'romania': 'Romania',
		'russia': 'Russia',
		'rwanda': 'Rwanda',
		'saintKittsAndNevis': 'Saint Kitts and Nevis',
		'saintLucia': 'Saint Lucia',
		'saintVincentAndTheGrenadines': 'Saint Vincent and the Grenadines',
		'samoa': 'Samoa',
		'sanMarino': 'San Marino',
		'saoTomeAndPrincipe': 'Sao Tome and Principe',
		'saudiArabia': 'Saudi Arabia',
		'senegal': 'Senegal',
		'serbia': 'Serbia',
		'seychelles': 'Seychelles',
		'sierraLeone': 'Sierra Leone',
		'singapore': 'Singapore',
		'slovakia': 'Slovakia',
		'slovenia': 'Slovenia',
		'solomonIslands': 'Solomon Islands',
		'somalia': 'Somalia',
		'southAfrica': 'South Africa',
		'southKorea': 'South Korea',
		'southSudan': 'South Sudan',
		'spain': 'Spain',
		'sriLanka': 'Sri Lanka',
		'sudan': 'Sudan',
		'suriname': 'Suriname',
		'sweden': 'Sweden',
		'switzerland': 'Switzerland',
		'syria': 'Syria',
		'taiwan': 'Taiwan',
		'tajikistan': 'Tajikistan',
		'tanzania': 'Tanzania',
		'thailand': 'Thailand',
		'timor': 'Timor-Leste',
		'togo': 'Togo',
		'tonga': 'Tonga',
		'trinidadAndTobago': 'Trinidad and Tobago',
		'tunisia': 'Tunisia',
		'turkey': 'Turkey',
		'turkmenistan': 'Turkmenistan',
		'tuvalu': 'Tuvalu',
		'uganda': 'Uganda',
		'ukraine': 'Ukraine',
		'unitedArabEmirates': 'United Arab Emirates',
		'unitedKingdom': 'United Kingdom',
		'unitedStates': 'United States',
		'uruguay': 'Uruguay',
		'uzbekistan': 'Uzbekistan',
		'vanuatu': 'Vanuatu',
		'vaticanCity': 'Vatican City',
		'venezuela': 'Venezuela',
		'vietnam': 'Vietnam',
		'yemen': 'Yemen',
		'zambia': 'Zambia',
		'zimbabwe': 'Zimbabwe',
	};
	late final TranslationsAccountStatusEn accountStatus = TranslationsAccountStatusEn._(_root);
	late final TranslationsCartEn cart = TranslationsCartEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsCourseEn course = TranslationsCourseEn._(_root);
	Map<String, dynamic> get student => {
		'aiAssistant': 'AI Assistant',
		'aiSubtitle': 'AI Physics Assistant',
		'aiWelcome': 'Hello! I am the AI Physics assistant. Ask me any question!',
		'typeQuestion': 'Type your question here...',
		'analytics': TranslationsStudentAnalyticsEn._(_root),
		'assignmentDetail': 'Assignment Details',
		'assignmentTitle': 'Waves Assignment',
		'assignmentUnit': 'Unit 3 - Session 2',
		'deadline': 'Deadline',
		'maxScore': 'Score',
		'points': 'points',
		'instructionsLabel': 'Instructions:',
		'assignmentInstructions': 'Solve the following problems on mechanical waves. You must solve all problems and show full solution steps.',
		'assignmentFile': 'Assignment File',
		'submitAssignment': 'Submit Assignment',
		'uploadFile': 'Click to upload file',
		'uploadHint': 'PDF, images (max 10 MB)',
		'notesOptional': 'Notes (optional):',
		'notesHint': 'Add a note for the instructor...',
		'feedbackTitle': 'Feedback',
		'instructorFeedback': 'Instructor feedback:',
		'registerAttendance': 'Register Attendance',
		'attendanceHistory': 'Attendance History',
		'yourAttendanceCode': 'Your Attendance Code',
		'exitQuizTitle': 'Exit Assignment?',
		'exitQuizDesc': 'Your progress will not be saved. Are you sure you want to exit?',
		'cancel': 'Cancel',
		'exit': 'Exit',
		'yourResponse': 'Your Response',
		'writeResponse': 'Write your response here...',
		'responseHint': 'Start typing...',
		'attachments': 'Attachments',
		'noFiles': 'No files attached yet',
		'chooseCorrect': 'Choose the correct answer:',
		'questionLabel': 'QUESTION',
		'assignmentSubmitted': 'Assignment submitted successfully',
		'alreadySubmitted': 'You have already submitted this assignment',
		'assignmentNotFound': 'Assignment not found',
		'commonBack': 'Back',
		'commonNext': 'Next',
		'commonPrevious': 'Previous',
		'commonSubmit': 'Submit',
		'review': 'Review',
		'quizNotFound': 'Quiz not found',
		'noQuestions': 'No questions available',
		'yourAnswer': 'Your answer:',
		'typeAnswerHere': 'Type your answer here...',
		'showCodeInstruction': 'Show the code to the instructor or assistant to register your attendance',
		'codeValidFor': 'Code valid for 5 minutes',
		'viewAttendance': 'Attendance Record',
		'totalAttendance': 'Total attendance rate',
		'present': 'Present',
		'absent': 'Absent',
		'presentCount': '%s present',
		'absentCount': '%s absent',
		'loginWelcome': 'Welcome! Log in to continue',
		'phoneLabel': 'Mobile Number',
		'phoneHint': '01xxxxxxxxx',
		'passwordLabel': 'Password',
		'passwordHintLogin': '••••••••',
		'forgotPassword': 'Forgot password?',
		'loginButton': 'Log In',
		'newStudentPrompt': 'New student?',
		'registerHere': 'Register here',
		'phoneNotRegisteredLogin': 'This number is not registered. If you are a new student, register below.',
		'wrongPasswordLogin': 'Wrong number or password. Check your data or reset your password.',
		'registerHintFromLogin': 'If you are a new student, register here',
		'registerTitle': 'Create New Account',
		'stepLabel1': 'Step 1 of 6 - Personal Data',
		'stepLabel2': 'Step 2 of 6 - Contact Info',
		'stepLabel3': 'Step 3 of 6 - Academic Data',
		'stepLabel4': 'Step 4 of 6 - Study Type',
		'stepLabel5': 'Step 5 of 6 - Password & Photos',
		'stepLabel6': 'Step 6 of 6 - Phone Verification',
		'studentPhoneLabel': 'Student Mobile Number',
		'phoneValidationError': 'Phone must be 11 digits and start with 01.',
		'otpVerifyTitle': 'Verify Mobile Number',
		'otpSentWhatsapp': 'Verification code sent via WhatsApp to',
		'resendCode': 'Resend Code',
		'resendIn': 'Resend in',
		'editNumber': 'Edit number',
		'verifyOtp': 'Verify code',
		'fullNameLabel': 'Full Name (4 parts)',
		'firstNameLabel': 'First Name',
		'secondNameLabel': 'Second Name',
		'thirdNameLabel': 'Third Name',
		'fourthNameLabel': 'Fourth Name',
		'birthDateLabel': 'Date of Birth',
		'birthDateHint': 'Select date',
		'genderLabel': 'Gender',
		'genderMale': 'Male',
		'genderFemale': 'Female',
		'parentNameLabel': 'Parent Name',
		'parentPhoneLabel': 'Parent Mobile Number',
		'parentVerified': 'Parent number verified',
		'verifyParentPhone': 'Verify parent number',
		'parentOtpSent': 'OTP sent to parent via WhatsApp',
		'parentOtpRequired': 'Please verify parent number first.',
		'passwordHintRegister': 'Enter password (min 8 characters)',
		'confirmPasswordLabel': 'Confirm Password',
		'confirmPasswordHintRegister': 'Re-enter your password',
		'passwordRules': 'Password must be at least 8 letters or numbers.',
		'passwordRulesHint': 'Minimum 8 characters, letters or numbers only.',
		'uploadPhotosLabel': 'Upload Required Images',
		'personalPhotoLabel': 'Personal Photo',
		'nationalIdPhotoLabel': 'Student ID Photo',
		'studyTypeLabel': 'Select Study Type',
		'studyTypeCenter': 'Center Student (Offline)',
		'studyTypeOnline': 'Online Student',
		'scheduleLabel': 'Select Schedule',
		'onlineConfirmation': 'You will receive online class details after approval.',
		'dayFriday': 'Friday',
		'daySaturday': 'Saturday',
		'daySunday': 'Sunday',
		'centerSmartMaadi': 'Smart Center - Maadi',
		'centerNoorNasr': 'Al-Noor Center - Nasr City',
		'centerElmHaram': 'Al-Elm Center - Haram',
		'timeSlot1': '6:00 PM - 8:00 PM',
		'timeSlot2': '4:00 PM - 6:00 PM',
		'timeSlot3': '5:00 PM - 7:00 PM',
		'governorateLabel': 'Governorate',
		'governorateHint': 'Select governorate',
		'governorateCairo': 'Cairo',
		'governorateGiza': 'Giza',
		'governorateAlex': 'Alexandria',
		'governorateMansura': 'Mansura',
		'regionLabel': 'Area',
		'regionHint': 'Select area',
		'regionNasrCity': 'Nasr City',
		'regionMaadi': 'Maadi',
		'regionHaram': 'Haram',
		'regionShorouk': 'El Shorouk',
		'regionDokki': 'Dokki',
		'regionSheikhZayed': 'Sheikh Zayed',
		'regionSmouha': 'Smouha',
		'regionGleem': 'Gleem',
		'gradeLabel': 'Grade',
		'gradeHint': 'Select grade',
		'gradeFirstSecondary': 'First Secondary',
		'gradeSecondSecondary': 'Second Secondary',
		'gradeThirdSecondary': 'Third Secondary',
		'schoolNameLabel': 'School Name',
		'schoolNameHint': 'Enter school name',
		'educationAdminLabel': 'Educational Administration',
		'educationAdminHint': 'Enter administration',
		'contactInfoLabel': 'Contact Info',
		'passwordAndPhotosLabel': 'Password & Photos',
		'confirmAndCreateAccount': 'Confirm & Create Account',
		'submissionTitle': 'Registration submitted',
		'submissionDescription': 'Your account is now under review. You will receive a WhatsApp message with your details after approval.',
		'whatsappDetailsTitle': 'WhatsApp will include:',
		'studentCodeLabel': 'Student code',
		'firstClassLabel': 'First class date',
		'firstClassDate': 'Friday 10:00 AM',
		'centerLocationLabel': 'Center location',
		'groupLinkLabel': 'WhatsApp group',
		'groupLinkValue': 'whatsapp.com/invite/MentorX',
		'socialLinksLabel': 'Social links',
		'socialLinksValue': 'facebook.com/MentorX | instagram.com/MentorX',
		'submitRegistration': 'Submit Registration',
		'pendingTitle': 'Account Under Review',
		'pendingDescription': 'Your account is currently under review. For any inquiries, contact support.',
		'whatsappSupport': 'WhatsApp Support',
		'supportPhoneLabel': 'Support number',
		'supportPhoneValue': '0100 000 0000',
		'backToLogin': 'Back to Login',
		'rejectedTitle': 'Your request was rejected',
		'rejectedDescription': 'Sorry, your registration request was rejected. You can edit your data and resubmit.',
		'rejectedReason': 'Reason: ID photo is unclear. Please upload a clearer photo and resubmit.',
		'editAndResubmit': 'Edit data and resubmit',
		'blockedTitle': 'Account Blocked',
		'blockedDescription': 'Your account was blocked. For any inquiries, contact support.',
		'deviceLimitTitle': 'Logged in on another device',
		'deviceLimitDescription': 'Your account is signed in on another device. Please log out from the other device first, or contact support.',
		'deviceRegisteredLabel': 'Registered device',
		'deviceRegisteredValue': 'Samsung Galaxy A54',
		'contactTechSupport': 'Contact Technical Support',
		'forgotTitle': 'Forgot Password',
		'forgotHeading': 'Recover Password',
		'forgotDescription': 'Enter your registered phone and we will send a WhatsApp code.',
		'sendCode': 'Send Verification Code',
		'resetTitle': 'Reset Password',
		'resetHeading': 'New Password',
		'resetDescription': 'Enter your new password',
		'newPasswordLabel': 'New Password',
		'newPasswordHint': 'Enter new password',
		'savePassword': 'Save Password',
		'requiredField': 'This field is required.',
		'incorrectCredentials': 'Incorrect phone or password.',
		'deviceMismatch': 'You are logged in on another device. Please log out from that device first.',
		'phoneAlreadyRegistered': 'Your number is already registered. Please login.',
		'phoneNotRegistered': 'This number is not registered.',
		'passwordMismatch': 'Passwords do not match.',
		'idMissing': 'Please upload required images.',
		'otpError': 'Please enter the full code.',
		'appName': 'MentorX',
		'platformTagline': 'Egyptian Education Platform',
		'splashTagline': 'TEACH • MANAGE • REACH',
		'commonSkip': 'Skip',
		'commonStartNow': 'Start Now',
		'commonOr': 'Or',
		'commonSave': 'Save',
		'commonCancel': 'Cancel',
		'commonConfirm': 'Confirm',
		'commonDone': 'Done',
		'commonClose': 'Close',
		'commonSearch': 'Search',
		'commonSeeAll': 'See All',
		'commonLoading': 'Loading...',
		'commonError': 'An error occurred',
		'commonRetry': 'Retry',
		'commonYes': 'Yes',
		'commonNo': 'No',
		'commonDelete': 'Delete',
		'commonEdit': 'Edit',
		'egp': 'EGP',
		'coursesTitle': 'Courses',
		'coursePhysics': 'Physics - Third Secondary',
		'unitPrefix': 'Unit',
		'sessions': 'sessions',
		'completed': 'completed',
		'locked': 'locked',
		'inProgress': 'in progress',
		'sessionsTab': 'Sessions',
		'quizzesTab': 'Quizzes',
		'assignmentsTab': 'Assignments',
		'filesTab': 'Files',
		'minutes': 'min',
		'video': 'Video',
		'pdf': 'PDF',
		'quiz': 'quiz',
		'assignment': 'Assignment',
		'free': 'Free',
		'open': 'Open',
		'premium': 'Premium',
		'lessonExplanation': 'Lesson Explanation',
		'part1': 'Part 1',
		'part2': 'Part 2',
		'lessonSummary': 'Lesson Summary',
		'quickQuiz': 'Quick Quiz',
		'lessonAssignment': 'Lesson Assignment',
		'submissionRequired': 'Submission required',
		'pages': 'pages',
		'questions': 'questions',
		'videoViews': 'Views',
		'videoDuration': 'Duration',
		'pdfPageOf': 'of',
		'lockedContentTitle': 'This content is locked',
		'lockedContentDesc': 'You can unlock this content by purchasing from wallet or entering a session code',
		'buyFor': 'Buy for',
		'enterCode': 'Enter Code',
		'unitMechanics': 'Unit 1: Mechanics',
		'unitElectricity': 'Unit 2: Electricity',
		'unitWaves': 'Unit 3: Waves',
		'unitDynamics': 'Unit 4: Dynamics',
		'unitHeat': 'Unit 5: Heat',
		'introToWaves': 'Introduction to Waves',
		'typesOfWaves': 'Types of Waves',
		'waveProperties': 'Wave Properties',
		'soundWaves': 'Sound Waves',
		'reviewAndPractice': 'Review & Practice',
		'dashboardTitle': 'Student Dashboard',
		'welcome': 'Welcome',
		'homeGreeting': 'Hello',
		'homeTitle': 'Student Home',
		'myLessons': 'My Lessons',
		'myExams': 'My Exams',
		'myGrades': 'My Grades',
		'wallet': 'Wallet',
		'notifications': 'Notifications',
		'settings': 'Settings',
		'noLessonsToday': 'No lessons today',
		'upcomingLessons': 'Upcoming Lessons',
		'attendance': 'Attendance',
		'profile': 'Profile',
		'logout': 'Logout',
		'myCourses': 'My Courses',
		'aiChat': 'AI Assistant',
		'attendanceRate': 'Attendance Rate',
		'averageScore': 'Average Score',
		'pendingAssignments': 'Pending Assignments',
		'walletBalance': 'Wallet Balance',
		'quickActions': 'Quick Actions',
		'navHome': 'Home',
		'navCourses': 'Courses',
		'navQuizzes': 'Quizzes',
		'navWallet': 'Wallet',
		'navAccount': 'My Account',
		'welcomeBack': 'Welcome back,',
		'welcomeSubtitle': 'Ready to continue learning?',
		'goToDashboard': 'Go to Dashboard',
		'notificationsTitle': 'Notifications',
		'markAllRead': 'Mark all read',
		'minutesAgo': '%s minutes ago',
		'hoursAgo': '%s hours ago',
		'daysAgo': '%s days ago',
		'quizCorrected': 'Quiz Corrected',
		'newAssignment': 'New Assignment',
		'sessionReminder': 'Session Reminder',
		'walletCharged': 'Wallet Charged',
		'absenceAlert': 'Absence Alert',
		'store': 'Store',
		'addToCart': 'Add to Cart',
		'shoppingCart': 'Shopping Cart',
		'products': 'Products',
		'checkout': 'Checkout',
		'pagesCount': 'Pages',
		'availability': 'Availability',
		'available': 'Available',
		'physicsBook': 'Physics Notebook',
		'practiceWorkbook': 'Practice Workbook',
		'mentorxTshirt': 'MentorX T-Shirt',
		'studentBag': 'Student Bag',
		'orderSummary': 'Order Summary',
		'profileTitle': 'My Profile',
		'personalData': 'Personal Data',
		'name': 'Name',
		'phone': 'Phone',
		'grade': 'Grade',
		'center': 'Center',
		'editRequest': 'Edit Request',
		'editProfile': 'Edit Profile',
		'editsNeedApproval': 'Edits need admin approval',
		'school': 'School',
		'reasonForEdit': 'Reason for edit',
		'sendRequest': 'Send Request',
		'changePassword': 'Change Password',
		'currentPassword': 'Current Password',
		'newPassword': 'New Password',
		'confirmNewPassword': 'Confirm New Password',
		'saveChanges': 'Save Changes',
		'quizIntroTitle': 'Quiz Info',
		'quizUnitTitle': 'Unit 3 Quiz',
		'quizTitle': 'Waves Quiz',
		'quizSubtitle': 'Test your knowledge about waves',
		'questionCount': 'Questions',
		'duration': 'Duration',
		'passGrade': 'Pass Grade',
		'attempts': 'Attempts',
		'instructions': 'Instructions:',
		'instructionRead': 'Read each question carefully before answering',
		'instructionReview': 'You can review your answers before submitting',
		'instructionNoReturn': 'You cannot return after submitting the quiz',
		'startQuiz': 'Start Quiz',
		'questionOf': 'Question %s of %s',
		'submitQuiz': 'Submit Quiz',
		'backToQuestions': 'Back to Questions',
		'answeredCount': 'Answered',
		'jumpToQuestion': 'Jump to a question:',
		'unansweredNote': '%s unanswered questions',
		'quizResult': 'Quiz Result',
		'excellent': 'Excellent!',
		'veryGood': 'Very Good',
		'good': 'Good',
		'fail': 'Try Again',
		'greatResult': 'Great job! Amazing result',
		'correctAnswers': 'Correct answers',
		'wrongAnswers': 'Wrong answers',
		'timeTaken': 'Time taken',
		'reviewAnswers': 'Review Answers',
		'correctAnswer': 'Correct answer:',
		'minutesShort': 'min',
		'claimReward': 'Claim Your Reward',
		'quizRewardsTitle': 'Quiz Rewards',
		'congratulations': 'Congratulations!',
		'rewardEarnedMsg': 'You achieved an excellent score and earned a special reward!',
		'yourScore': 'Your Score',
		'pointsEarned': 'Points Earned',
		'excellentBadge': 'Excellence Badge',
		'badgeUnlocked': 'Badge unlocked - added to your profile',
		'backToQuizzes': 'Back to Dashboard',
		'quizListTitle': 'Quizzes',
		'gamificationTitle': 'Gamification',
		'goldLevel': 'Gold Level',
		'xpPoints': 'XP Points',
		'quizCompleted': 'Completed Quiz',
		'badge': 'Badge',
		'toNextLevel': 'to next level',
		'dailyStreak': 'Daily Streak',
		'streakDaysMsg': '%s consecutive days - keep going for a reward!',
		'earnedBadges': 'Earned Badges',
		'leaderboard': 'Top Performers',
		'sat': 'Sat',
		'sun': 'Sun',
		'mon': 'Mon',
		'tue': 'Tue',
		'wed': 'Wed',
		'thu': 'Thu',
		'fri': 'Fri',
		'lightningSpeed': 'Lightning Speed',
		'perfectScore': 'Perfect Score',
		'fiveDayStreak': '5 Day Streak',
		'tenQuizzes': '10 Quizzes',
		'physicsLion': 'Physics Lion',
		'settingsTitle': 'Settings',
		'changePasswordSetting': 'Change Password',
		'notificationsSetting': 'Notifications',
		'supportSetting': 'Technical Support',
		'aboutSetting': 'About App',
		'logoutSetting': 'Logout',
		'supportTitle': 'Contact Us',
		'supportDesc': 'We are here to help! Contact us through any of the following channels',
		'whatsapp': 'WhatsApp',
		'phoneCall': 'Phone',
		'email': 'Email',
		'aboutTitle': 'About App',
		'aboutDesc': 'An integrated educational platform connecting instructors and students',
		'version': 'Version',
		'lastUpdate': 'Last Update',
		'walletTitle': 'Wallet',
		'currentBalance': 'Current Balance',
		'charge': 'Charge',
		'code': 'Code',
		'history': 'History',
		'recentTransactions': 'Recent Transactions',
		'addBalance': 'Add Balance',
		'amount': 'Amount',
		'choosePaymentMethod': 'Choose Payment Method',
		'vodafoneCash': 'Vodafone Cash',
		'vodafoneDesc': 'Pay from Vodafone wallet',
		'instaPay': 'InstaPay',
		'instaPayDesc': 'Transfer via InstaPay',
		'fawry': 'Fawry',
		'fawryDesc': 'Pay through Fawry',
		'continueBtn': 'Continue',
		'redeemCode': 'Redeem Code',
		'enterCodeDesc': 'Enter discount or session code',
		'activateCode': 'Activate Code',
		'purchaseConfirm': 'Purchase Confirmation',
		'paymentMethod': 'Payment Method',
		'total': 'Total',
		'confirmPayment': 'Confirm Payment',
		'paymentSuccess': 'Payment Successful!',
		'balanceAdded': '%s EGP added to your balance',
		'newBalance': 'New Balance',
		'backToWallet': 'Back to Wallet',
		'transactionsTitle': 'Transactions',
		'chargeBalance': 'Charge - Balance',
		'purchaseCourse': 'Purchase - Course',
		'discountCode': 'Discount Code',
		'purchaseBook': 'Purchase - Book',
		'today': 'Today',
		'yesterday': 'Yesterday',
	};
	late final TranslationsParentEn parent = TranslationsParentEn._(_root);
	late final TranslationsAssignmentsEn assignments = TranslationsAssignmentsEn._(_root);
}

// Path: ui
class TranslationsUiEn {
	TranslationsUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsUiCommonEn common = TranslationsUiCommonEn._(_root);
	late final TranslationsUiErrorsEn errors = TranslationsUiErrorsEn._(_root);
	late final TranslationsUiDateTimeEn dateTime = TranslationsUiDateTimeEn._(_root);
	late final TranslationsUiMentorXReadMoreEn mentorXReadMore = TranslationsUiMentorXReadMoreEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

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
}

// Path: initialLanguage
class TranslationsInitialLanguageEn {
	TranslationsInitialLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your preferred language'
	String get header => 'Select your preferred language';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingStepsEn steps = TranslationsOnboardingStepsEn._(_root);
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter your phone number to sign in'
	String get header => 'Enter your phone number to sign in';

	/// en: 'We will send you a verification code'
	String get subtitle => 'We will send you a verification code';

	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

	/// en: '01XXXXXXXXX'
	String get phoneHint => '01XXXXXXXXX';

	/// en: 'Please enter a valid phone number'
	String get phoneValidationError => 'Please enter a valid phone number';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	late final TranslationsLoginOtpEn otp = TranslationsLoginOtpEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeMainEn main = TranslationsHomeMainEn._(_root);
	late final TranslationsHomeDashboardEn dashboard = TranslationsHomeDashboardEn._(_root);
	late final TranslationsHomeErrorsEn errors = TranslationsHomeErrorsEn._(_root);
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

	late final TranslationsFormsCardEn card = TranslationsFormsCardEn._(_root);
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

// Path: exceptions.promocodeExceptions
class TranslationsExceptionsPromocodeExceptionsEn {
	TranslationsExceptionsPromocodeExceptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Promocode cannot be applied to your cart'
	String get cantBeApplied => 'Promocode cannot be applied to your cart';
}

// Path: accountStatus
class TranslationsAccountStatusEn {
	TranslationsAccountStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Under Review'
	String get pendingTitle => 'Account Under Review';

	/// en: 'Your account is currently being reviewed. We will notify you once approved.'
	String get pendingDescription => 'Your account is currently being reviewed. We will notify you once approved.';

	/// en: 'If you have questions, please contact support.'
	String get pendingSupportInfo => 'If you have questions, please contact support.';

	/// en: 'Account Rejected'
	String get rejectedTitle => 'Account Rejected';

	/// en: 'Unfortunately, your account application has been rejected.'
	String get rejectedDescription => 'Unfortunately, your account application has been rejected.';

	/// en: 'Please contact support for more information about the reason.'
	String get rejectedReason => 'Please contact support for more information about the reason.';

	/// en: 'Account Blocked'
	String get blockedTitle => 'Account Blocked';

	/// en: 'Your account has been blocked. Please contact support for assistance.'
	String get blockedDescription => 'Your account has been blocked. Please contact support for assistance.';

	/// en: 'If you believe this is an error, please reach out to our support team.'
	String get blockedSupportInfo => 'If you believe this is an error, please reach out to our support team.';
}

// Path: cart
class TranslationsCartEn {
	TranslationsCartEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Cart'
	String get yourCart => 'Your Cart';

	/// en: 'Cart is Empty'
	String get emptyCart => 'Cart is Empty';

	/// en: 'Browse Services'
	String get browseServices => 'Browse Services';

	/// en: 'Browse our offerings to add items to your cart'
	String get browseOfferings => 'Browse our offerings \nto add items to your cart';

	/// en: 'We recommend'
	String get weRecommend => 'We recommend';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Add to Cart'
	String get addToCart => 'Add to Cart';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Don't forget to add'
	String get dontForgetToAdd => 'Don\'t forget to add';

	/// en: '${date: DateFormat('MMM dd, hh:mm')}'
	String itemDateTime({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'en').format(date)}';

	/// en: '(one) {service} (other) {services}'
	String services({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'service',
		other: 'services',
	);

	/// en: 'Total'
	String get total => 'Total';

	/// en: '(zero) {hour} (one) {hour} (other) {hours}'
	String hour({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'hour',
		one: 'hour',
		other: 'hours',
	);

	late final TranslationsCartPromocodeEn promocode = TranslationsCartPromocodeEn._(_root);

	/// en: 'Update in Cart'
	String get updateInCart => 'Update in Cart';

	/// en: 'cart'
	String get cart => 'cart';

	/// en: 'Checkout'
	String get checkout => 'Checkout';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Apply Promocode'
	String get applyPromocode => 'Apply Promocode';

	/// en: 'Enter promocode'
	String get enterPromocode => 'Enter promocode';

	/// en: 'Promocode is required'
	String get promocodeRequired => 'Promocode is required';

	/// en: 'Applied Promocodes'
	String get appliedPromocodes => 'Applied Promocodes';

	/// en: 'Recommendations'
	String get recommendations => 'Recommendations';

	/// en: 'Subtotal'
	String get subtotal => 'Subtotal';

	/// en: 'Discount'
	String get discount => 'Discount';

	/// en: 'Min order'
	String get minOrder => 'Min order';

	/// en: 'Min time'
	String get minTime => 'Min time';

	/// en: 'Space required'
	String get spaceRequired => 'Space required';

	/// en: 'Hours'
	String get hours => 'Hours';

	/// en: 'Special requests'
	String get specialRequests => 'Special requests';

	/// en: 'Enter special requests...'
	String get enterSpecialRequests => 'Enter special requests...';

	/// en: 'Error loading cart'
	String get errorLoadingCart => 'Error loading cart';

	/// en: 'Cart cleared successfully'
	String get cartCleared => 'Cart cleared successfully';

	/// en: 'Failed to load service'
	String get failedToLoadService => 'Failed to load service';

	/// en: 'Please select a ${sectionName}'
	String pleaseSelectOption({required Object sectionName}) => 'Please select a ${sectionName}';

	/// en: 'Please select at least one ${sectionName} option'
	String pleaseSelectAtLeastOne({required Object sectionName}) => 'Please select at least one ${sectionName} option';

	/// en: 'Please select more ${sectionName} options'
	String pleaseSelectMore({required Object sectionName}) => 'Please select more ${sectionName} options';

	/// en: 'Too many ${sectionName} options selected'
	String tooManyOptionsSelected({required Object sectionName}) => 'Too many ${sectionName} options selected';

	/// en: 'Please add at least one ${sectionName} item'
	String pleaseAddAtLeastOne({required Object sectionName}) => 'Please add at least one ${sectionName} item';

	/// en: 'Please select a date and time'
	String get pleaseSelectDateTime => 'Please select a date and time';

	/// en: 'Canapé Options'
	String get canapeOptions => 'Canapé Options';

	/// en: 'Options'
	String get options => 'Options';

	/// en: 'Start date and time'
	String get startDateAndTime => 'Start date and time';

	/// en: 'per extra hour'
	String get perExtraHour => 'per extra hour';

	/// en: 'Go to ${vendorName} profile'
	String goToVendorProfile({required Object vendorName}) => 'Go to ${vendorName} profile';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Settings'
	String get title => 'App Settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	late final TranslationsSettingsNotificationSettingsEn notificationSettings = TranslationsSettingsNotificationSettingsEn._(_root);
}

// Path: course
class TranslationsCourseEn {
	TranslationsCourseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Courses'
	String get myCourses => 'My Courses';

	/// en: 'Course Catalog'
	String get courseCatalog => 'Course Catalog';

	/// en: 'Course Detail'
	String get courseDetail => 'Course Detail';

	/// en: 'Video Player'
	String get videoPlayer => 'Video Player';

	/// en: 'PDF Viewer'
	String get pdfViewer => 'PDF Viewer';

	late final TranslationsCourseTabsEn tabs = TranslationsCourseTabsEn._(_root);
	late final TranslationsCourseCatalogEn catalog = TranslationsCourseCatalogEn._(_root);
	late final TranslationsCourseDetailEn detail = TranslationsCourseDetailEn._(_root);
	late final TranslationsCoursePlayerEn player = TranslationsCoursePlayerEn._(_root);
	late final TranslationsCoursePdfEn pdf = TranslationsCoursePdfEn._(_root);
	late final TranslationsCourseEmptyEn empty = TranslationsCourseEmptyEn._(_root);
	late final TranslationsCourseErrorsEn errors = TranslationsCourseErrorsEn._(_root);
}

// Path: student.analytics
class TranslationsStudentAnalyticsEn {
	TranslationsStudentAnalyticsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Performance Analytics'
	String get title => 'Performance Analytics';

	/// en: 'Grade vs Peers'
	String get gradeVsPeers => 'Grade vs Peers';

	/// en: 'Rank: #${rank}'
	String rank({required Object rank}) => 'Rank: #${rank}';

	/// en: 'Your Score'
	String get yourScore => 'Your Score';

	/// en: 'Class Average'
	String get classAverage => 'Class Average';

	/// en: 'out of ${count} students'
	String studentsCount({required Object count}) => 'out of ${count} students';

	/// en: 'Above Average'
	String get aboveAverage => 'Above Average';

	/// en: 'Below Average'
	String get belowAverage => 'Below Average';

	/// en: 'Performance Trend'
	String get performanceTrend => 'Performance Trend';

	/// en: 'Study Peak Hours'
	String get studyPeakHours => 'Study Peak Hours';

	/// en: 'Badges & Achievements'
	String get badgesAndAchievements => 'Badges & Achievements';

	/// en: 'Engagement Streak'
	String get streakTitle => 'Engagement Streak';

	/// en: '${count} Days Streak'
	String streakDays({required Object count}) => '${count} Days Streak';

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
}

// Path: parent
class TranslationsParentEn {
	TranslationsParentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Parent Portal'
	String get dashboardTitle => 'Parent Portal';

	/// en: 'Welcome back,'
	String get welcomeBack => 'Welcome back,';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Recent Activity'
	String get recentActivity => 'Recent Activity';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Unable to load dashboard'
	String get unableToLoad => 'Unable to load dashboard';

	/// en: 'My Profile'
	String get myProfile => 'My Profile';

	/// en: 'Sign Out'
	String get signOut => 'Sign Out';

	/// en: 'Account Information'
	String get accountInfo => 'Account Information';

	/// en: 'App Settings'
	String get appSettings => 'App Settings';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Child Switcher'
	String get childSwitcher => 'Child Switcher';

	/// en: 'No data found'
	String get noData => 'No data found';

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Academic Monitor'
	String get academicMonitor => 'Academic Monitor';

	/// en: 'Financial Monitor'
	String get financialMonitor => 'Financial Monitor';

	/// en: 'Attendance Monitor'
	String get attendanceMonitor => 'Attendance Monitor';

	/// en: 'Overall Average'
	String get overallAverage => 'Overall Average';

	/// en: 'Enrolled Courses'
	String get enrolledCourses => 'Enrolled Courses';

	/// en: 'Child Wallet Balance'
	String get childWalletBalance => 'Child Wallet Balance';

	/// en: 'Spent This Month'
	String get spentThisMonth => 'Spent This Month';

	/// en: 'Transaction History'
	String get transactionHistory => 'Transaction History';

	/// en: 'Points Earned'
	String get pointsEarned => 'Points Earned';

	late final TranslationsParentHomeEn home = TranslationsParentHomeEn._(_root);

	late final TranslationsParentQuickActionsEn quickActions =
			TranslationsParentQuickActionsEn._(_root);

	late final TranslationsParentChildrenEn children =
			TranslationsParentChildrenEn._(_root);

	late final TranslationsParentAssessmentsEn assessments =
			TranslationsParentAssessmentsEn._(_root);

	late final TranslationsParentAttendanceTrackingEn attendanceTracking =
			TranslationsParentAttendanceTrackingEn._(_root);

	late final TranslationsParentFinancialEn financial =
			TranslationsParentFinancialEn._(_root);

	late final TranslationsParentAcademicEn academic =
			TranslationsParentAcademicEn._(_root);

	late final TranslationsParentCommunicationEn communication =
			TranslationsParentCommunicationEn._(_root);

	late final TranslationsParentProfileEn profile =
			TranslationsParentProfileEn._(_root);

	late final TranslationsParentAuthEn auth =
			TranslationsParentAuthEn._(_root);
}

// Path: parent.auth
class TranslationsParentAuthEn {
	TranslationsParentAuthEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get otpTitle => 'Verify Your Number';
	String otpSubtitle({required Object phone}) =>
			'Enter the 6-digit code sent to\n${phone}';
	String get otpFieldLabel => 'Verification Code';
	String get otpFieldHint => '000000';
	String get verifyAndContinue => 'Verify & Continue';
	String get resending => 'Resending…';
	String get resendCode => 'Resend Code';
	String resendInSeconds({required Object seconds}) =>
			'Resend in ${seconds}s';
	String get verificationFailed => 'Verification failed';
}

// Path: parent.profile
class TranslationsParentProfileEn {
	TranslationsParentProfileEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get verifiedAccount => 'Verified Account';
	String get fullNameLabel => 'Full Name';
	String get phoneNumberLabel => 'Phone Number';
	String get emailLabel => 'Email Address';
	String get notificationsEnabled => 'Enabled';
	String get notificationsDisabled => 'Disabled';
	String get securityValue => 'Password & Biometrics';
	String get signOutConfirmTitle => 'Sign Out?';
	String get signOutConfirmMessage =>
			'You will be signed out and returned to the login screen.';
	String get signOutAction => 'Sign Out';
	String get signOutCancel => 'Cancel';
	String get fallbackName => 'Parent User';
	String get settingsTitle => 'Settings';
	String get appConfigurationSection => 'App Configuration';
	String get preferencesSection => 'Preferences';
	String get supportSection => 'Support';
	String get pushNotifications => 'Push Notifications';
	String get themeMode => 'Theme Mode';
	String get themeSystem => 'System';
	String get themeLight => 'Light';
	String get themeDark => 'Dark';
	String get appLanguage => 'App Language';
	String get languageEnglish => 'English';
	String get languageArabic => 'العربية';
	String get helpCenter => 'Help Center';
	String get helpCenterValue => 'FAQs & Support';
	String get aboutTitle => 'About MentorX';
	String aboutVersion({required Object version}) => 'Version ${version}';
}

// Path: parent.communication
class TranslationsParentCommunicationEn {
	TranslationsParentCommunicationEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get notificationsTitle => 'Notifications';
	String get announcementsTitle => 'Announcements';
	String get whatsAppTitle => 'WhatsApp Groups';
	String get noNotificationsTitle => 'No Notifications';
	String get noNotificationsHint =>
			"You're all caught up — new updates will appear here.";
	String get noAnnouncementsTitle => 'No Announcements';
	String get noAnnouncementsHint =>
			'Stay tuned! School announcements will appear here.';
	String get noGroupsTitle => 'No Groups';
	String get noGroupsHint =>
			'No WhatsApp groups are available for this child yet.';
	String get readMore => 'Read More';
	String get joinGroup => 'Join';
	String get groupSubtitle => 'Tap to join for the latest updates';
}

// Path: parent.academic
class TranslationsParentAcademicEn {
	TranslationsParentAcademicEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get pageTitle => 'Academic Monitor';
	String get overallAverageHeading => 'Overall Average';
	String get averageLabel => 'Average';
	String get gradedLabel => 'Graded';
	String get pendingLabel => 'Pending';
	String get noCoursesTitle => 'No Courses';
	String get noCoursesHint => 'Academic data will appear here once available.';
	String sessionsCount({required Object count}) => '${count} sessions';
	String completedSessionsLabel({
		required Object completed,
		required Object total,
	}) => '${completed} / ${total} sessions';
	String get courseDetailsTitle => 'Course Progress';
}

// Path: parent.financial
class TranslationsParentFinancialEn {
	TranslationsParentFinancialEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get balance => 'Balance';
	String get spent => 'Spent';
	String get points => 'Points';
	String get noDataTitle => 'No Data';
	String get noDataHint => 'Financial data will appear here once available.';
	String get noTransactionsTitle => 'No Transactions';
	String get noTransactionsHint =>
			'No transaction history found for this child.';
	String get credit => 'Credit';
	String get debit => 'Debit';
	String get deposit => 'Top Up';
	String get withdrawal => 'Withdrawal';
	String get payment => 'Payment';
	String get refund => 'Refund';
	String get reward => 'Reward';
	String get statusPending => 'Pending';
	String get statusSuccess => 'Success';
	String get statusFailed => 'Failed';
}

// Path: parent.attendanceTracking
class TranslationsParentAttendanceTrackingEn {
	TranslationsParentAttendanceTrackingEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get pageTitle => 'Attendance Monitor';
	String get attendanceLog => 'Attendance Log';
	String get present => 'Present';
	String get absent => 'Absent';
	String get late => 'Late';
	String get excused => 'Excused';
	String get noRecordsTitle => 'No Records';
	String get noRecordsHint =>
			'No attendance records found for this student.';
	String get regularSession => 'Regular Session';
	String get generalAcademic => 'General Academic';
	String get onlineSession => 'Online';
	String checkInTimeLabel({required Object time}) => 'Checked in at ${time}';
}

// Path: parent.assessments
class TranslationsParentAssessmentsEn {
	TranslationsParentAssessmentsEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get pageTitle => 'Academic Performance';
	String get overallPerformance => 'Overall Performance';
	String get average => 'Average';
	String get graded => 'Graded';
	String get pending => 'Pending';
	String get passed => 'Passed';
	String get failed => 'Failed';
	String get assessmentHistory => 'Assessment History';
	String get noAssessmentsTitle => 'No Assessments';
	String get noAssessmentsHint =>
			'Academic evaluation data will appear here once submitted.';
	String get passLabel => 'Passed';
	String get failLabel => 'Failed';
	String scoreLabel({required Object score, required Object total}) =>
			'Score: ${score}/${total}';
	String get quizPrefix => 'Quiz';
	String get assignmentPrefix => 'Assignment';
	String get examPrefix => 'Exam';
	String get trendUp => 'Trending up';
	String get trendDown => 'Trending down';
	String get trendStable => 'Stable';
}

// Path: parent.home
class TranslationsParentHomeEn {
	TranslationsParentHomeEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get parentAccount => 'Parent Account';
	String get addChild => 'Add Child';
	String get academicStanding => 'Academic Standing';
	String get avgGrade => 'Avg Grade';
	String get attendance => 'Attendance';
	String get unpaidFees => 'Unpaid Fees';
	String get noRecentActivity => 'No Recent Activity';
	String get noRecentActivityHint =>
			'Activities will appear here once your child starts their learning journey.';
	String get noChildrenTitle => 'No Children Linked';
	String get noChildrenHint =>
			'Link your first child to start tracking their progress.';
	String get linkChild => 'Link a Child';
	String updatedAt({required Object time}) => 'Updated ${time}';
	String get upcomingSessions => 'Upcoming Sessions';
	String get noUpcomingSessions => 'No upcoming sessions';
	String get recentGrades => 'Recent Grades';
	String get noRecentGrades => 'No grades yet';
	String get viewDetails => 'View details';
}

// Path: parent.quickActions
class TranslationsParentQuickActionsEn {
	TranslationsParentQuickActionsEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get attendance => 'Attendance';
	String get courses => 'Courses';
	String get fees => 'Fees';
	String get messages => 'Messages';
	String get grades => 'Grades';
	String get announcements => 'News';
	String get schedule => 'Schedule';
	String get support => 'Support';
}

// Path: parent.children
class TranslationsParentChildrenEn {
	TranslationsParentChildrenEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get title => 'Linked Children';
	String get linkNewChild => 'Link New Child';
	String get linkChildTitle => 'Link Your Child';
	String get linkChildHint =>
			"Enter your child's admission number or registered phone number to link their account.";
	String get searchLabel => 'Search Child';
	String get searchHint => 'Admission Number / Phone';
	String get confirmLink => 'Confirm & Link Child';
	String get specifyRelationship => 'Specify Relationship';
	String get linkSuccess => 'Child linked successfully';
	String get unlinkConfirmTitle => 'Remove Child?';
	String unlinkConfirmMessage({required Object name}) =>
			'${name} will be unlinked from your account. You can re-link them at any time.';
	String get unlink => 'Unlink';
	String get unlinkSuccess => 'Child unlinked';
	String studentIdLabel({required Object id}) => 'Student ID: ${id}';
	String studentCodeLabel({required Object code}) => 'Code: ${code}';
	String gradeLabel({required Object grade}) => 'Grade: ${grade}';
	String centerLabel({required Object center}) => 'Center: ${center}';
	String get cancel => 'Cancel';

	late final TranslationsParentChildrenRelationshipEn relationship =
			TranslationsParentChildrenRelationshipEn._(_root);
}

// Path: parent.children.relationship
class TranslationsParentChildrenRelationshipEn {
	TranslationsParentChildrenRelationshipEn._(this._root);
	final Translations _root; // ignore: unused_field

	String get father => 'Father';
	String get mother => 'Mother';
	String get guardian => 'Guardian';
	String get other => 'Other';
}

// Path: assignments
class TranslationsAssignmentsEn {
	TranslationsAssignmentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Assignments'
	String get listTitle => 'Assignments';

	/// en: 'Due: ${date}'
	String dueAt({required Object date}) => 'Due: ${date}';

	/// en: 'No deadline'
	String get noDeadline => 'No deadline';

	/// en: 'Submit Assignment'
	String get submitAssignment => 'Submit Assignment';

	/// en: 'View Feedback'
	String get viewFeedback => 'View Feedback';

	/// en: 'Submitted'
	String get submitted => 'Submitted';

	/// en: 'Not submitted'
	String get notSubmitted => 'Not submitted';

	/// en: 'Grading'
	String get grading => 'Grading';

	/// en: 'Graded'
	String get graded => 'Graded';
}

// Path: ui.common
class TranslationsUiCommonEn {
	TranslationsUiCommonEn._(this._root);

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
}

// Path: ui.errors
class TranslationsUiErrorsEn {
	TranslationsUiErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong'
	String get somethingWentWrong => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: ui.dateTime
class TranslationsUiDateTimeEn {
	TranslationsUiDateTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Now'
	String get now => 'Now';

	/// en: 'Tomorrow'
	String get tomorrow => 'Tomorrow';

	/// en: '${time: DateFormat('HH:mm')}'
	String time({required DateTime time}) => '${DateFormat('HH:mm', 'en').format(time)}';

	/// en: '${time: DateFormat('HH:mm')}, ${day}'
	String timeWithDay({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'en').format(time)}, ${day}';

	/// en: '${date: DateFormat('MMM d')}'
	String dateWithMonth({required DateTime date}) => '${DateFormat('MMM d', 'en').format(date)}';

	Map<String, String> get weekdays => {
		'monday': 'Mon',
		'tuesday': 'Tue',
		'wednesday': 'Wed',
		'thursday': 'Thu',
		'friday': 'Fri',
		'saturday': 'Sat',
		'sunday': 'Sun',
	};
}

// Path: ui.mentorXReadMore
class TranslationsUiMentorXReadMoreEn {
	TranslationsUiMentorXReadMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More'
	String get more => 'More';

	/// en: 'Less'
	String get less => 'Less';
}

// Path: onboarding.steps
class TranslationsOnboardingStepsEn {
	TranslationsOnboardingStepsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingStepsLearnEn learn = TranslationsOnboardingStepsLearnEn._(_root);
	late final TranslationsOnboardingStepsTrackProgressEn trackProgress = TranslationsOnboardingStepsTrackProgressEn._(_root);
	late final TranslationsOnboardingStepsQuizzesEn quizzes = TranslationsOnboardingStepsQuizzesEn._(_root);
}

// Path: login.otp
class TranslationsLoginOtpEn {
	TranslationsLoginOtpEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirmation code'
	String get header => 'Confirmation code';

	/// en: 'We sent a code to your device. Enter it here to continue.'
	String get description => 'We sent a code to your device. Enter it here to continue.';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'OTP was verified successfully'
	String get otpWasVerifiedSuccessfully => 'OTP was verified successfully';

	/// en: 'Resend'
	String get resend => 'Resend';

	/// en: 'Resend in'
	String get resendIn => 'Resend in';

	/// en: 'Edit Number'
	String get editNumber => 'Edit Number';

	/// en: 'OTP was resent successfully'
	String get otpWasResentSuccessfully => 'OTP was resent successfully';
}

// Path: home.main
class TranslationsHomeMainEn {
	TranslationsHomeMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Assistance'
	String get assistance => 'Assistance';

	/// en: 'Cart'
	String get cart => 'Cart';

	/// en: 'Me'
	String get me => 'Me';
}

// Path: home.dashboard
class TranslationsHomeDashboardEn {
	TranslationsHomeDashboardEn._(this._root);

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

	late final TranslationsHomeDashboardActionsEn actions = TranslationsHomeDashboardActionsEn._(_root);
}

// Path: home.errors
class TranslationsHomeErrorsEn {
	TranslationsHomeErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load upcoming events'
	String get failedToLoadUpcomingEvents => 'Failed to load upcoming events';

	/// en: 'Failed to load service providers'
	String get failedToLoadVendors => 'Failed to load service providers';

	/// en: 'Failed to load occasions'
	String get failedToLoadOccasions => 'Failed to load occasions';

	/// en: 'Failed to load categories'
	String get failedToLoadCategories => 'Failed to load categories';
}

// Path: forms.card
class TranslationsFormsCardEn {
	TranslationsFormsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid format. Use MM/YY'
	String get expiryInvalidFormat => 'Invalid format. Use MM/YY';

	/// en: 'Invalid month (01-12)'
	String get expiryInvalidMonth => 'Invalid month (01-12)';

	/// en: 'Card has expired'
	String get expiryCardExpired => 'Card has expired';

	/// en: 'CVV must be 3-4 digits'
	String get cvvInvalid => 'CVV must be 3-4 digits';
}

// Path: cart.promocode
class TranslationsCartPromocodeEn {
	TranslationsCartPromocodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Promocode'
	String get header => 'Promocode';

	/// en: 'Enter a Promocode'
	String get hint => 'Enter a Promocode';

	/// en: 'Promocode applied'
	String get promocodeApplied => 'Promocode applied';

	/// en: 'Promocode cannot be applied to your cart'
	String get promocodeCannotBeApplied => 'Promocode cannot be applied to your cart';
}

// Path: settings.notificationSettings
class TranslationsSettingsNotificationSettingsEn {
	TranslationsSettingsNotificationSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Common'
	String get common => 'Common';

	/// en: 'General Notification'
	String get generalNotification => 'General Notification';

	/// en: 'Sound'
	String get sound => 'Sound';

	/// en: 'Vibrate'
	String get vibrate => 'Vibrate';

	/// en: 'System & Services Update'
	String get systemAndServicesUpdate => 'System & Services Update';

	/// en: 'App Updates'
	String get appUpdates => 'App Updates';

	/// en: 'Bill Reminder'
	String get billReminder => 'Bill Reminder';

	/// en: 'Promotion'
	String get promotion => 'Promotion';

	/// en: 'Discount Available'
	String get discountAvailable => 'Discount Available';

	/// en: 'Payment Request'
	String get paymentRequest => 'Payment Request';
}

// Path: course.tabs
class TranslationsCourseTabsEn {
	TranslationsCourseTabsEn._(this._root);

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

// Path: course.catalog
class TranslationsCourseCatalogEn {
	TranslationsCourseCatalogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search courses...'
	String get searchHint => 'Search courses...';

	/// en: 'All'
	String get allCategories => 'All';

	/// en: 'All Levels'
	String get allLevels => 'All Levels';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Newest'
	String get sortNewest => 'Newest';

	/// en: 'Price: Low to High'
	String get sortPriceAsc => 'Price: Low to High';

	/// en: 'Price: High to Low'
	String get sortPriceDesc => 'Price: High to Low';

	/// en: 'Most Popular'
	String get sortPopular => 'Most Popular';

	/// en: 'No courses found'
	String get noCourses => 'No courses found';

	/// en: 'Try adjusting your search or filters.'
	String get noCoursesDescription => 'Try adjusting your search or filters.';

	/// en: '${count} Courses Found'
	String coursesFound({required Object count}) => '${count} Courses Found';
}

// Path: course.detail
class TranslationsCourseDetailEn {
	TranslationsCourseDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About this Course'
	String get aboutCourse => 'About this Course';

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'items'
	String get items => 'items';

	/// en: 'Enroll Now'
	String get enrollNow => 'Enroll Now';

	/// en: 'Enrolled'
	String get enrolled => 'Enrolled';

	/// en: 'Continue Studying'
	String get continueStudying => 'Continue Studying';

	/// en: 'Course Expired'
	String get courseExpired => 'Course Expired';

	/// en: 'Course Completed'
	String get courseCompleted => 'Course Completed';

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'students'
	String get students => 'students';

	/// en: 'videos'
	String get videos => 'videos';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'min'
	String get minutes => 'min';

	/// en: 'hours'
	String get hours => 'hours';

	/// en: 'Free'
	String get sessionFree => 'Free';

	/// en: '${mins}m ${secs}s'
	String durationShort({required Object mins, required Object secs}) => '${mins}m ${secs}s';

	/// en: '${count} pages'
	String pagesCount({required Object count}) => '${count} pages';

	/// en: 'YOUR PROGRESS'
	String get yourProgress => 'YOUR PROGRESS';

	/// en: '${percent}% Complete'
	String completePercent({required Object percent}) => '${percent}% Complete';

	/// en: 'Enrolling...'
	String get enrolling => 'Enrolling...';

	/// en: 'Successfully enrolled!'
	String get enrollSuccess => 'Successfully enrolled!';

	/// en: 'Failed to enroll. Please try again.'
	String get enrollFailed => 'Failed to enroll. Please try again.';
}

// Path: course.player
class TranslationsCoursePlayerEn {
	TranslationsCoursePlayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Video Player'
	String get title => 'Video Player';

	/// en: 'Loading video...'
	String get loading => 'Loading video...';

	/// en: 'Failed to load video'
	String get error => 'Failed to load video';

	/// en: 'Mark as Complete'
	String get complete => 'Mark as Complete';

	/// en: 'Completed'
	String get completed => 'Completed';
}

// Path: course.pdf
class TranslationsCoursePdfEn {
	TranslationsCoursePdfEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PDF Viewer'
	String get title => 'PDF Viewer';

	/// en: 'Loading document...'
	String get loading => 'Loading document...';

	/// en: 'Failed to load document'
	String get error => 'Failed to load document';

	/// en: 'Page ${current} of ${total}'
	String page({required Object current, required Object total}) => 'Page ${current} of ${total}';

	/// en: 'Mark Complete'
	String get markComplete => 'Mark Complete';

	/// en: 'Completed'
	String get completed => 'Completed';
}

// Path: course.empty
class TranslationsCourseEmptyEn {
	TranslationsCourseEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No enrolled courses'
	String get noEnrolledCourses => 'No enrolled courses';

	/// en: 'Start learning by browsing our course catalog.'
	String get noEnrolledCoursesDescription => 'Start learning by browsing our course catalog.';

	/// en: 'Browse Catalog'
	String get browseCatalog => 'Browse Catalog';
}

// Path: course.errors
class TranslationsCourseErrorsEn {
	TranslationsCourseErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load. Tap to retry.'
	String get failedToLoad => 'Failed to load. Tap to retry.';

	/// en: 'Failed to load courses'
	String get failedToLoadCourses => 'Failed to load courses';

	/// en: 'Failed to load course details'
	String get failedToLoadDetail => 'Failed to load course details';

	/// en: 'Failed to load sessions'
	String get failedToLoadSessions => 'Failed to load sessions';
}

// Path: onboarding.steps.learn
class TranslationsOnboardingStepsLearnEn {
	TranslationsOnboardingStepsLearnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Learn'
	String get title => 'Learn';

	/// en: 'Access your lessons, courses, and educational materials all in one place.'
	String get description => 'Access your lessons, courses, and educational materials all in one place.';
}

// Path: onboarding.steps.trackProgress
class TranslationsOnboardingStepsTrackProgressEn {
	TranslationsOnboardingStepsTrackProgressEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Track Progress'
	String get title => 'Track Progress';

	/// en: 'Monitor your academic performance and track your growth over time.'
	String get description => 'Monitor your academic performance and track your growth over time.';
}

// Path: onboarding.steps.quizzes
class TranslationsOnboardingStepsQuizzesEn {
	TranslationsOnboardingStepsQuizzesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quizzes'
	String get title => 'Quizzes';

	/// en: 'Test your knowledge with interactive quizzes and get instant feedback.'
	String get description => 'Test your knowledge with interactive quizzes and get instant feedback.';
}

// Path: home.dashboard.actions
class TranslationsHomeDashboardActionsEn {
	TranslationsHomeDashboardActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

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
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui.common.cancel' => 'Cancel',
			'ui.common.ok' => 'OK',
			'ui.common.viewAll' => 'View All',
			'ui.common.required' => 'Required',
			'ui.common.optional' => 'Optional',
			'ui.common.customization' => 'Customization',
			'ui.common.skip' => 'Skip',
			'ui.common.next' => 'Next',
			'ui.common.getStarted' => 'Get Started',
			'ui.common.backToLogin' => 'Back to Login',
			'ui.common.noResults' => 'No results found',
			'ui.common.opening' => ({required Object url}) => 'Opening: ${url}',
			'ui.common.comingSoon' => 'Coming soon',
			'ui.errors.somethingWentWrong' => 'Something went wrong',
			'ui.errors.retry' => 'Retry',
			'ui.dateTime.yesterday' => 'Yesterday',
			'ui.dateTime.today' => 'Today',
			'ui.dateTime.now' => 'Now',
			'ui.dateTime.tomorrow' => 'Tomorrow',
			'ui.dateTime.time' => ({required DateTime time}) => '${DateFormat('HH:mm', 'en').format(time)}',
			'ui.dateTime.timeWithDay' => ({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'en').format(time)}, ${day}',
			'ui.dateTime.dateWithMonth' => ({required DateTime date}) => '${DateFormat('MMM d', 'en').format(date)}',
			'ui.dateTime.weekdays.monday' => 'Mon',
			'ui.dateTime.weekdays.tuesday' => 'Tue',
			'ui.dateTime.weekdays.wednesday' => 'Wed',
			'ui.dateTime.weekdays.thursday' => 'Thu',
			'ui.dateTime.weekdays.friday' => 'Fri',
			'ui.dateTime.weekdays.saturday' => 'Sat',
			'ui.dateTime.weekdays.sunday' => 'Sun',
			'ui.mentorXReadMore.more' => 'More',
			'ui.mentorXReadMore.less' => 'Less',
			'core.appName' => 'MentorX Student',
			'core.currency' => 'EGP',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'initialLanguage.header' => 'Select your preferred language',
			'initialLanguage.kContinue' => 'Continue',
			'onboarding.steps.learn.title' => 'Learn',
			'onboarding.steps.learn.description' => 'Access your lessons, courses, and educational materials all in one place.',
			'onboarding.steps.trackProgress.title' => 'Track Progress',
			'onboarding.steps.trackProgress.description' => 'Monitor your academic performance and track your growth over time.',
			'onboarding.steps.quizzes.title' => 'Quizzes',
			'onboarding.steps.quizzes.description' => 'Test your knowledge with interactive quizzes and get instant feedback.',
			'login.header' => 'Enter your phone number to sign in',
			'login.subtitle' => 'We will send you a verification code',
			'login.phoneNumber' => 'Phone Number',
			'login.phoneHint' => '01XXXXXXXXX',
			'login.phoneValidationError' => 'Please enter a valid phone number',
			'login.signIn' => 'Sign In',
			'login.otp.header' => 'Confirmation code',
			'login.otp.description' => 'We sent a code to your device. Enter it here to continue.',
			'login.otp.confirm' => 'Confirm',
			'login.otp.otpWasVerifiedSuccessfully' => 'OTP was verified successfully',
			'login.otp.resend' => 'Resend',
			'login.otp.resendIn' => 'Resend in',
			'login.otp.editNumber' => 'Edit Number',
			'login.otp.otpWasResentSuccessfully' => 'OTP was resent successfully',
			'home.main.home' => 'Home',
			'home.main.favorites' => 'Favorites',
			'home.main.assistance' => 'Assistance',
			'home.main.cart' => 'Cart',
			'home.main.me' => 'Me',
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
			'home.dashboard.actions.myCourses' => 'My Courses',
			'home.dashboard.actions.attendance' => 'Attendance',
			'home.dashboard.actions.grades' => 'Grades',
			'home.dashboard.actions.aiAssistant' => 'AI Assistant',
			'home.dashboard.actions.assignments' => 'Assignments',
			'home.dashboard.actions.rewards' => 'Rewards',
			'home.dashboard.actions.marketplace' => 'Marketplace',
			'home.dashboard.actions.analytics' => 'Performance Analytics',
			'home.errors.failedToLoadUpcomingEvents' => 'Failed to load upcoming events',
			'home.errors.failedToLoadVendors' => 'Failed to load service providers',
			'home.errors.failedToLoadOccasions' => 'Failed to load occasions',
			'home.errors.failedToLoadCategories' => 'Failed to load categories',
			'forms.required' => 'This field is required',
			'forms.minLength' => ({required int length}) => 'It must be ${length} letters long at least',
			'forms.maxLength' => ({required int length}) => 'The maximum limit is ${length} letters',
			'forms.minDigitsLength' => ({required int length}) => 'It must be ${length} digits long at least',
			'forms.maxDigitsLength' => ({required int length}) => 'The maximum limit is ${length} digits',
			'forms.youMustEnterAValidEmail' => 'You must enter a valid email',
			'forms.card.expiryInvalidFormat' => 'Invalid format. Use MM/YY',
			'forms.card.expiryInvalidMonth' => 'Invalid month (01-12)',
			'forms.card.expiryCardExpired' => 'Card has expired',
			'forms.card.cvvInvalid' => 'CVV must be 3-4 digits',
			'exceptions.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'Invalid phone number',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'Invalid OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'Failed to initialize',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'Failed to send OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'Failed to verify OTP',
			'exceptions.promocodeExceptions.cantBeApplied' => 'Promocode cannot be applied to your cart',
			'countries.afghanistan' => 'Afghanistan',
			'countries.albania' => 'Albania',
			'countries.algeria' => 'Algeria',
			'countries.andorra' => 'Andorra',
			'countries.angola' => 'Angola',
			'countries.antiguaAndBarbuda' => 'Antigua and Barbuda',
			'countries.argentina' => 'Argentina',
			'countries.armenia' => 'Armenia',
			'countries.australia' => 'Australia',
			'countries.austria' => 'Austria',
			'countries.azerbaijan' => 'Azerbaijan',
			'countries.bahamas' => 'Bahamas',
			'countries.bahrain' => 'Bahrain',
			'countries.bangladesh' => 'Bangladesh',
			'countries.barbados' => 'Barbados',
			'countries.belarus' => 'Belarus',
			'countries.belgium' => 'Belgium',
			'countries.belize' => 'Belize',
			'countries.benin' => 'Benin',
			'countries.bhutan' => 'Bhutan',
			'countries.bolivia' => 'Bolivia',
			'countries.bosniaAndHerzegovina' => 'Bosnia and Herzegovina',
			'countries.botswana' => 'Botswana',
			'countries.brazil' => 'Brazil',
			'countries.brunei' => 'Brunei',
			'countries.bulgaria' => 'Bulgaria',
			'countries.burkinaFaso' => 'Burkina Faso',
			'countries.burundi' => 'Burundi',
			'countries.cambodia' => 'Cambodia',
			'countries.cameroon' => 'Cameroon',
			'countries.canada' => 'Canada',
			'countries.capeVerde' => 'Cape Verde',
			'countries.centralAfricanRepublic' => 'Central African Republic',
			'countries.chad' => 'Chad',
			'countries.chile' => 'Chile',
			'countries.china' => 'China',
			'countries.colombia' => 'Colombia',
			'countries.comoros' => 'Comoros',
			'countries.congo' => 'Congo',
			'countries.democraticRepublicOfCongo' => 'Democratic Republic of the Congo',
			'countries.costaRica' => 'Costa Rica',
			'countries.croatia' => 'Croatia',
			'countries.cuba' => 'Cuba',
			'countries.cyprus' => 'Cyprus',
			'countries.czechRepublic' => 'Czech Republic',
			'countries.denmark' => 'Denmark',
			'countries.djibouti' => 'Djibouti',
			'countries.dominica' => 'Dominica',
			'countries.dominicanRepublic' => 'Dominican Republic',
			'countries.ecuador' => 'Ecuador',
			'countries.egypt' => 'Egypt',
			'countries.elSalvador' => 'El Salvador',
			'countries.equatorialGuinea' => 'Equatorial Guinea',
			'countries.eritrea' => 'Eritrea',
			'countries.estonia' => 'Estonia',
			'countries.eswatini' => 'Eswatini',
			'countries.ethiopia' => 'Ethiopia',
			'countries.fiji' => 'Fiji',
			'countries.finland' => 'Finland',
			'countries.france' => 'France',
			'countries.gabon' => 'Gabon',
			'countries.gambia' => 'Gambia',
			'countries.georgia' => 'Georgia',
			'countries.germany' => 'Germany',
			'countries.ghana' => 'Ghana',
			'countries.greece' => 'Greece',
			'countries.grenada' => 'Grenada',
			'countries.guatemala' => 'Guatemala',
			'countries.guinea' => 'Guinea',
			'countries.guineaBissau' => 'Guinea-Bissau',
			'countries.guyana' => 'Guyana',
			'countries.haiti' => 'Haiti',
			'countries.honduras' => 'Honduras',
			'countries.hungary' => 'Hungary',
			'countries.iceland' => 'Iceland',
			'countries.india' => 'India',
			'countries.indonesia' => 'Indonesia',
			'countries.iran' => 'Iran',
			'countries.iraq' => 'Iraq',
			'countries.ireland' => 'Ireland',
			'countries.israel' => 'Israel',
			'countries.italy' => 'Italy',
			'countries.ivoryCoast' => 'Ivory Coast',
			'countries.jamaica' => 'Jamaica',
			'countries.japan' => 'Japan',
			'countries.jordan' => 'Jordan',
			'countries.kazakhstan' => 'Kazakhstan',
			'countries.kenya' => 'Kenya',
			'countries.kiribati' => 'Kiribati',
			'countries.kuwait' => 'Kuwait',
			'countries.kyrgyzstan' => 'Kyrgyzstan',
			'countries.laos' => 'Laos',
			'countries.latvia' => 'Latvia',
			'countries.lebanon' => 'Lebanon',
			'countries.lesotho' => 'Lesotho',
			'countries.liberia' => 'Liberia',
			'countries.libya' => 'Libya',
			'countries.liechtenstein' => 'Liechtenstein',
			'countries.lithuania' => 'Lithuania',
			'countries.luxembourg' => 'Luxembourg',
			'countries.madagascar' => 'Madagascar',
			'countries.malawi' => 'Malawi',
			'countries.malaysia' => 'Malaysia',
			'countries.maldives' => 'Maldives',
			'countries.mali' => 'Mali',
			'countries.malta' => 'Malta',
			'countries.marshallIslands' => 'Marshall Islands',
			'countries.mauritania' => 'Mauritania',
			'countries.mauritius' => 'Mauritius',
			'countries.mexico' => 'Mexico',
			'countries.micronesia' => 'Micronesia',
			'countries.moldova' => 'Moldova',
			'countries.monaco' => 'Monaco',
			'countries.mongolia' => 'Mongolia',
			'countries.montenegro' => 'Montenegro',
			'countries.morocco' => 'Morocco',
			'countries.mozambique' => 'Mozambique',
			'countries.myanmar' => 'Myanmar',
			'countries.namibia' => 'Namibia',
			'countries.nauru' => 'Nauru',
			'countries.nepal' => 'Nepal',
			'countries.netherlands' => 'Netherlands',
			'countries.newZealand' => 'New Zealand',
			'countries.nicaragua' => 'Nicaragua',
			'countries.niger' => 'Niger',
			'countries.nigeria' => 'Nigeria',
			'countries.northKorea' => 'North Korea',
			'countries.northMacedonia' => 'North Macedonia',
			'countries.norway' => 'Norway',
			'countries.oman' => 'Oman',
			'countries.pakistan' => 'Pakistan',
			'countries.palau' => 'Palau',
			'countries.palestine' => 'Palestine',
			'countries.panama' => 'Panama',
			'countries.papuaNewGuinea' => 'Papua New Guinea',
			'countries.paraguay' => 'Paraguay',
			'countries.peru' => 'Peru',
			'countries.philippines' => 'Philippines',
			'countries.poland' => 'Poland',
			'countries.portugal' => 'Portugal',
			'countries.qatar' => 'Qatar',
			'countries.romania' => 'Romania',
			'countries.russia' => 'Russia',
			'countries.rwanda' => 'Rwanda',
			'countries.saintKittsAndNevis' => 'Saint Kitts and Nevis',
			'countries.saintLucia' => 'Saint Lucia',
			'countries.saintVincentAndTheGrenadines' => 'Saint Vincent and the Grenadines',
			'countries.samoa' => 'Samoa',
			'countries.sanMarino' => 'San Marino',
			'countries.saoTomeAndPrincipe' => 'Sao Tome and Principe',
			'countries.saudiArabia' => 'Saudi Arabia',
			'countries.senegal' => 'Senegal',
			'countries.serbia' => 'Serbia',
			'countries.seychelles' => 'Seychelles',
			'countries.sierraLeone' => 'Sierra Leone',
			'countries.singapore' => 'Singapore',
			'countries.slovakia' => 'Slovakia',
			'countries.slovenia' => 'Slovenia',
			'countries.solomonIslands' => 'Solomon Islands',
			'countries.somalia' => 'Somalia',
			'countries.southAfrica' => 'South Africa',
			'countries.southKorea' => 'South Korea',
			'countries.southSudan' => 'South Sudan',
			'countries.spain' => 'Spain',
			'countries.sriLanka' => 'Sri Lanka',
			'countries.sudan' => 'Sudan',
			'countries.suriname' => 'Suriname',
			'countries.sweden' => 'Sweden',
			'countries.switzerland' => 'Switzerland',
			'countries.syria' => 'Syria',
			'countries.taiwan' => 'Taiwan',
			'countries.tajikistan' => 'Tajikistan',
			'countries.tanzania' => 'Tanzania',
			'countries.thailand' => 'Thailand',
			'countries.timor' => 'Timor-Leste',
			'countries.togo' => 'Togo',
			'countries.tonga' => 'Tonga',
			'countries.trinidadAndTobago' => 'Trinidad and Tobago',
			'countries.tunisia' => 'Tunisia',
			'countries.turkey' => 'Turkey',
			'countries.turkmenistan' => 'Turkmenistan',
			'countries.tuvalu' => 'Tuvalu',
			'countries.uganda' => 'Uganda',
			'countries.ukraine' => 'Ukraine',
			'countries.unitedArabEmirates' => 'United Arab Emirates',
			'countries.unitedKingdom' => 'United Kingdom',
			'countries.unitedStates' => 'United States',
			'countries.uruguay' => 'Uruguay',
			'countries.uzbekistan' => 'Uzbekistan',
			'countries.vanuatu' => 'Vanuatu',
			'countries.vaticanCity' => 'Vatican City',
			'countries.venezuela' => 'Venezuela',
			'countries.vietnam' => 'Vietnam',
			'countries.yemen' => 'Yemen',
			'countries.zambia' => 'Zambia',
			'countries.zimbabwe' => 'Zimbabwe',
			'accountStatus.pendingTitle' => 'Account Under Review',
			'accountStatus.pendingDescription' => 'Your account is currently being reviewed. We will notify you once approved.',
			'accountStatus.pendingSupportInfo' => 'If you have questions, please contact support.',
			'accountStatus.rejectedTitle' => 'Account Rejected',
			'accountStatus.rejectedDescription' => 'Unfortunately, your account application has been rejected.',
			'accountStatus.rejectedReason' => 'Please contact support for more information about the reason.',
			'accountStatus.blockedTitle' => 'Account Blocked',
			'accountStatus.blockedDescription' => 'Your account has been blocked. Please contact support for assistance.',
			'accountStatus.blockedSupportInfo' => 'If you believe this is an error, please reach out to our support team.',
			'cart.yourCart' => 'Your Cart',
			'cart.emptyCart' => 'Cart is Empty',
			'cart.browseServices' => 'Browse Services',
			'cart.browseOfferings' => 'Browse our offerings \nto add items to your cart',
			'cart.weRecommend' => 'We recommend',
			'cart.edit' => 'Edit',
			'cart.remove' => 'Remove',
			'cart.addToCart' => 'Add to Cart',
			'cart.close' => 'Close',
			'cart.dontForgetToAdd' => 'Don\'t forget to add',
			'cart.itemDateTime' => ({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'en').format(date)}',
			'cart.services' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'service', other: 'services', ), 
			'cart.total' => 'Total',
			'cart.hour' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'hour', one: 'hour', other: 'hours', ), 
			'cart.promocode.header' => 'Promocode',
			'cart.promocode.hint' => 'Enter a Promocode',
			'cart.promocode.promocodeApplied' => 'Promocode applied',
			'cart.promocode.promocodeCannotBeApplied' => 'Promocode cannot be applied to your cart',
			'cart.updateInCart' => 'Update in Cart',
			'cart.cart' => 'cart',
			'cart.checkout' => 'Checkout',
			'cart.apply' => 'Apply',
			'cart.applyPromocode' => 'Apply Promocode',
			'cart.enterPromocode' => 'Enter promocode',
			'cart.promocodeRequired' => 'Promocode is required',
			'cart.appliedPromocodes' => 'Applied Promocodes',
			'cart.recommendations' => 'Recommendations',
			'cart.subtotal' => 'Subtotal',
			'cart.discount' => 'Discount',
			'cart.minOrder' => 'Min order',
			'cart.minTime' => 'Min time',
			'cart.spaceRequired' => 'Space required',
			'cart.hours' => 'Hours',
			'cart.specialRequests' => 'Special requests',
			'cart.enterSpecialRequests' => 'Enter special requests...',
			'cart.errorLoadingCart' => 'Error loading cart',
			'cart.cartCleared' => 'Cart cleared successfully',
			'cart.failedToLoadService' => 'Failed to load service',
			'cart.pleaseSelectOption' => ({required Object sectionName}) => 'Please select a ${sectionName}',
			'cart.pleaseSelectAtLeastOne' => ({required Object sectionName}) => 'Please select at least one ${sectionName} option',
			'cart.pleaseSelectMore' => ({required Object sectionName}) => 'Please select more ${sectionName} options',
			'cart.tooManyOptionsSelected' => ({required Object sectionName}) => 'Too many ${sectionName} options selected',
			'cart.pleaseAddAtLeastOne' => ({required Object sectionName}) => 'Please add at least one ${sectionName} item',
			'cart.pleaseSelectDateTime' => 'Please select a date and time',
			'cart.canapeOptions' => 'Canapé Options',
			'cart.options' => 'Options',
			'cart.startDateAndTime' => 'Start date and time',
			'cart.perExtraHour' => 'per extra hour',
			'cart.goToVendorProfile' => ({required Object vendorName}) => 'Go to ${vendorName} profile',
			'settings.title' => 'App Settings',
			'settings.language' => 'Language',
			'settings.notifications' => 'Notifications',
			'settings.notificationSettings.title' => 'Notifications',
			'settings.notificationSettings.common' => 'Common',
			'settings.notificationSettings.generalNotification' => 'General Notification',
			'settings.notificationSettings.sound' => 'Sound',
			'settings.notificationSettings.vibrate' => 'Vibrate',
			'settings.notificationSettings.systemAndServicesUpdate' => 'System & Services Update',
			'settings.notificationSettings.appUpdates' => 'App Updates',
			'settings.notificationSettings.billReminder' => 'Bill Reminder',
			'settings.notificationSettings.promotion' => 'Promotion',
			'settings.notificationSettings.discountAvailable' => 'Discount Available',
			'settings.notificationSettings.paymentRequest' => 'Payment Request',
			'course.myCourses' => 'My Courses',
			'course.courseCatalog' => 'Course Catalog',
			'course.courseDetail' => 'Course Detail',
			'course.videoPlayer' => 'Video Player',
			'course.pdfViewer' => 'PDF Viewer',
			'course.tabs.inProgress' => 'In Progress',
			'course.tabs.completed' => 'Completed',
			'course.tabs.expired' => 'Expired',
			'course.tabs.description' => 'Description',
			'course.tabs.sessions' => 'Sessions',
			'course.catalog.searchHint' => 'Search courses...',
			'course.catalog.allCategories' => 'All',
			'course.catalog.allLevels' => 'All Levels',
			'course.catalog.sortBy' => 'Sort by',
			'course.catalog.sortNewest' => 'Newest',
			'course.catalog.sortPriceAsc' => 'Price: Low to High',
			'course.catalog.sortPriceDesc' => 'Price: High to Low',
			'course.catalog.sortPopular' => 'Most Popular',
			'course.catalog.noCourses' => 'No courses found',
			'course.catalog.noCoursesDescription' => 'Try adjusting your search or filters.',
			'course.catalog.coursesFound' => ({required Object count}) => '${count} Courses Found',
			'course.detail.aboutCourse' => 'About this Course',
			'course.detail.sessions' => 'Sessions',
			'course.detail.items' => 'items',
			'course.detail.enrollNow' => 'Enroll Now',
			'course.detail.enrolled' => 'Enrolled',
			'course.detail.continueStudying' => 'Continue Studying',
			'course.detail.courseExpired' => 'Course Expired',
			'course.detail.courseCompleted' => 'Course Completed',
			'course.detail.free' => 'Free',
			'course.detail.students' => 'students',
			'course.detail.videos' => 'videos',
			'course.detail.duration' => 'Duration',
			'course.detail.minutes' => 'min',
			'course.detail.hours' => 'hours',
			'course.detail.sessionFree' => 'Free',
			'course.detail.durationShort' => ({required Object mins, required Object secs}) => '${mins}m ${secs}s',
			'course.detail.pagesCount' => ({required Object count}) => '${count} pages',
			'course.detail.yourProgress' => 'YOUR PROGRESS',
			'course.detail.completePercent' => ({required Object percent}) => '${percent}% Complete',
			'course.detail.enrolling' => 'Enrolling...',
			'course.detail.enrollSuccess' => 'Successfully enrolled!',
			'course.detail.enrollFailed' => 'Failed to enroll. Please try again.',
			'course.player.title' => 'Video Player',
			'course.player.loading' => 'Loading video...',
			'course.player.error' => 'Failed to load video',
			'course.player.complete' => 'Mark as Complete',
			'course.player.completed' => 'Completed',
			'course.pdf.title' => 'PDF Viewer',
			'course.pdf.loading' => 'Loading document...',
			'course.pdf.error' => 'Failed to load document',
			'course.pdf.page' => ({required Object current, required Object total}) => 'Page ${current} of ${total}',
			'course.pdf.markComplete' => 'Mark Complete',
			'course.pdf.completed' => 'Completed',
			'course.empty.noEnrolledCourses' => 'No enrolled courses',
			'course.empty.noEnrolledCoursesDescription' => 'Start learning by browsing our course catalog.',
			'course.empty.browseCatalog' => 'Browse Catalog',
			'course.errors.failedToLoad' => 'Failed to load. Tap to retry.',
			'course.errors.failedToLoadCourses' => 'Failed to load courses',
			'course.errors.failedToLoadDetail' => 'Failed to load course details',
			'course.errors.failedToLoadSessions' => 'Failed to load sessions',
			'student.aiAssistant' => 'AI Assistant',
			'student.aiSubtitle' => 'AI Physics Assistant',
			'student.aiWelcome' => 'Hello! I am the AI Physics assistant. Ask me any question!',
			'student.typeQuestion' => 'Type your question here...',
			'student.analytics.title' => 'Performance Analytics',
			'student.analytics.gradeVsPeers' => 'Grade vs Peers',
			'student.analytics.rank' => ({required Object rank}) => 'Rank: #${rank}',
			'student.analytics.yourScore' => 'Your Score',
			'student.analytics.classAverage' => 'Class Average',
			'student.analytics.studentsCount' => ({required Object count}) => 'out of ${count} students',
			'student.analytics.aboveAverage' => 'Above Average',
			'student.analytics.belowAverage' => 'Below Average',
			'student.analytics.performanceTrend' => 'Performance Trend',
			'student.analytics.studyPeakHours' => 'Study Peak Hours',
			'student.analytics.badgesAndAchievements' => 'Badges & Achievements',
			'student.analytics.streakTitle' => 'Engagement Streak',
			'student.analytics.streakDays' => ({required Object count}) => '${count} Days Streak',
			'student.analytics.streakEncouragement' => 'Keep it up! You are making steady progress',
			'student.analytics.bestStreak' => 'Best Streak',
			'student.analytics.quizSpeedMetrics' => 'Quiz Speed Metrics',
			'student.analytics.secondsPerQuestion' => 'sec/question',
			'student.analytics.yourAverage' => 'Your Avg',
			'student.analytics.peerAverage' => 'Peer Avg',
			'student.analytics.speedEncouragement' => 'You are 15% faster than peer average! keep up the pace.',
			'student.analytics.allCourses' => 'All Courses',
			'student.assignmentDetail' => 'Assignment Details',
			'student.assignmentTitle' => 'Waves Assignment',
			'student.assignmentUnit' => 'Unit 3 - Session 2',
			'student.deadline' => 'Deadline',
			'student.maxScore' => 'Score',
			'student.points' => 'points',
			'student.instructionsLabel' => 'Instructions:',
			'student.assignmentInstructions' => 'Solve the following problems on mechanical waves. You must solve all problems and show full solution steps.',
			'student.assignmentFile' => 'Assignment File',
			'student.submitAssignment' => 'Submit Assignment',
			'student.uploadFile' => 'Click to upload file',
			'student.uploadHint' => 'PDF, images (max 10 MB)',
			'student.notesOptional' => 'Notes (optional):',
			'student.notesHint' => 'Add a note for the instructor...',
			'student.feedbackTitle' => 'Feedback',
			'student.instructorFeedback' => 'Instructor feedback:',
			'student.registerAttendance' => 'Register Attendance',
			'student.attendanceHistory' => 'Attendance History',
			'student.yourAttendanceCode' => 'Your Attendance Code',
			'student.exitQuizTitle' => 'Exit Assignment?',
			'student.exitQuizDesc' => 'Your progress will not be saved. Are you sure you want to exit?',
			'student.cancel' => 'Cancel',
			'student.exit' => 'Exit',
			'student.yourResponse' => 'Your Response',
			'student.writeResponse' => 'Write your response here...',
			'student.responseHint' => 'Start typing...',
			'student.attachments' => 'Attachments',
			'student.noFiles' => 'No files attached yet',
			'student.chooseCorrect' => 'Choose the correct answer:',
			'student.questionLabel' => 'QUESTION',
			'student.assignmentSubmitted' => 'Assignment submitted successfully',
			'student.alreadySubmitted' => 'You have already submitted this assignment',
			'student.assignmentNotFound' => 'Assignment not found',
			'student.commonBack' => 'Back',
			'student.commonNext' => 'Next',
			'student.commonPrevious' => 'Previous',
			'student.commonSubmit' => 'Submit',
			'student.review' => 'Review',
			'student.quizNotFound' => 'Quiz not found',
			'student.noQuestions' => 'No questions available',
			'student.yourAnswer' => 'Your answer:',
			'student.typeAnswerHere' => 'Type your answer here...',
			'student.showCodeInstruction' => 'Show the code to the instructor or assistant to register your attendance',
			'student.codeValidFor' => 'Code valid for 5 minutes',
			'student.viewAttendance' => 'Attendance Record',
			'student.totalAttendance' => 'Total attendance rate',
			'student.present' => 'Present',
			_ => null,
		} ?? switch (path) {
			'student.absent' => 'Absent',
			'student.presentCount' => '%s present',
			'student.absentCount' => '%s absent',
			'student.loginWelcome' => 'Welcome! Log in to continue',
			'student.phoneLabel' => 'Mobile Number',
			'student.phoneHint' => '01xxxxxxxxx',
			'student.passwordLabel' => 'Password',
			'student.passwordHintLogin' => '••••••••',
			'student.forgotPassword' => 'Forgot password?',
			'student.loginButton' => 'Log In',
			'student.newStudentPrompt' => 'New student?',
			'student.registerHere' => 'Register here',
			'student.phoneNotRegisteredLogin' => 'This number is not registered. If you are a new student, register below.',
			'student.wrongPasswordLogin' => 'Wrong number or password. Check your data or reset your password.',
			'student.registerHintFromLogin' => 'If you are a new student, register here',
			'student.registerTitle' => 'Create New Account',
			'student.stepLabel1' => 'Step 1 of 6 - Personal Data',
			'student.stepLabel2' => 'Step 2 of 6 - Contact Info',
			'student.stepLabel3' => 'Step 3 of 6 - Academic Data',
			'student.stepLabel4' => 'Step 4 of 6 - Study Type',
			'student.stepLabel5' => 'Step 5 of 6 - Password & Photos',
			'student.stepLabel6' => 'Step 6 of 6 - Phone Verification',
			'student.studentPhoneLabel' => 'Student Mobile Number',
			'student.phoneValidationError' => 'Phone must be 11 digits and start with 01.',
			'student.otpVerifyTitle' => 'Verify Mobile Number',
			'student.otpSentWhatsapp' => 'Verification code sent via WhatsApp to',
			'student.resendCode' => 'Resend Code',
			'student.resendIn' => 'Resend in',
			'student.editNumber' => 'Edit number',
			'student.verifyOtp' => 'Verify code',
			'student.fullNameLabel' => 'Full Name (4 parts)',
			'student.firstNameLabel' => 'First Name',
			'student.secondNameLabel' => 'Second Name',
			'student.thirdNameLabel' => 'Third Name',
			'student.fourthNameLabel' => 'Fourth Name',
			'student.birthDateLabel' => 'Date of Birth',
			'student.birthDateHint' => 'Select date',
			'student.genderLabel' => 'Gender',
			'student.genderMale' => 'Male',
			'student.genderFemale' => 'Female',
			'student.parentNameLabel' => 'Parent Name',
			'student.parentPhoneLabel' => 'Parent Mobile Number',
			'student.parentVerified' => 'Parent number verified',
			'student.verifyParentPhone' => 'Verify parent number',
			'student.parentOtpSent' => 'OTP sent to parent via WhatsApp',
			'student.parentOtpRequired' => 'Please verify parent number first.',
			'student.passwordHintRegister' => 'Enter password (min 8 characters)',
			'student.confirmPasswordLabel' => 'Confirm Password',
			'student.confirmPasswordHintRegister' => 'Re-enter your password',
			'student.passwordRules' => 'Password must be at least 8 letters or numbers.',
			'student.passwordRulesHint' => 'Minimum 8 characters, letters or numbers only.',
			'student.uploadPhotosLabel' => 'Upload Required Images',
			'student.personalPhotoLabel' => 'Personal Photo',
			'student.nationalIdPhotoLabel' => 'Student ID Photo',
			'student.studyTypeLabel' => 'Select Study Type',
			'student.studyTypeCenter' => 'Center Student (Offline)',
			'student.studyTypeOnline' => 'Online Student',
			'student.scheduleLabel' => 'Select Schedule',
			'student.onlineConfirmation' => 'You will receive online class details after approval.',
			'student.dayFriday' => 'Friday',
			'student.daySaturday' => 'Saturday',
			'student.daySunday' => 'Sunday',
			'student.centerSmartMaadi' => 'Smart Center - Maadi',
			'student.centerNoorNasr' => 'Al-Noor Center - Nasr City',
			'student.centerElmHaram' => 'Al-Elm Center - Haram',
			'student.timeSlot1' => '6:00 PM - 8:00 PM',
			'student.timeSlot2' => '4:00 PM - 6:00 PM',
			'student.timeSlot3' => '5:00 PM - 7:00 PM',
			'student.governorateLabel' => 'Governorate',
			'student.governorateHint' => 'Select governorate',
			'student.governorateCairo' => 'Cairo',
			'student.governorateGiza' => 'Giza',
			'student.governorateAlex' => 'Alexandria',
			'student.governorateMansura' => 'Mansura',
			'student.regionLabel' => 'Area',
			'student.regionHint' => 'Select area',
			'student.regionNasrCity' => 'Nasr City',
			'student.regionMaadi' => 'Maadi',
			'student.regionHaram' => 'Haram',
			'student.regionShorouk' => 'El Shorouk',
			'student.regionDokki' => 'Dokki',
			'student.regionSheikhZayed' => 'Sheikh Zayed',
			'student.regionSmouha' => 'Smouha',
			'student.regionGleem' => 'Gleem',
			'student.gradeLabel' => 'Grade',
			'student.gradeHint' => 'Select grade',
			'student.gradeFirstSecondary' => 'First Secondary',
			'student.gradeSecondSecondary' => 'Second Secondary',
			'student.gradeThirdSecondary' => 'Third Secondary',
			'student.schoolNameLabel' => 'School Name',
			'student.schoolNameHint' => 'Enter school name',
			'student.educationAdminLabel' => 'Educational Administration',
			'student.educationAdminHint' => 'Enter administration',
			'student.contactInfoLabel' => 'Contact Info',
			'student.passwordAndPhotosLabel' => 'Password & Photos',
			'student.confirmAndCreateAccount' => 'Confirm & Create Account',
			'student.submissionTitle' => 'Registration submitted',
			'student.submissionDescription' => 'Your account is now under review. You will receive a WhatsApp message with your details after approval.',
			'student.whatsappDetailsTitle' => 'WhatsApp will include:',
			'student.studentCodeLabel' => 'Student code',
			'student.firstClassLabel' => 'First class date',
			'student.firstClassDate' => 'Friday 10:00 AM',
			'student.centerLocationLabel' => 'Center location',
			'student.groupLinkLabel' => 'WhatsApp group',
			'student.groupLinkValue' => 'whatsapp.com/invite/MentorX',
			'student.socialLinksLabel' => 'Social links',
			'student.socialLinksValue' => 'facebook.com/MentorX | instagram.com/MentorX',
			'student.submitRegistration' => 'Submit Registration',
			'student.pendingTitle' => 'Account Under Review',
			'student.pendingDescription' => 'Your account is currently under review. For any inquiries, contact support.',
			'student.whatsappSupport' => 'WhatsApp Support',
			'student.supportPhoneLabel' => 'Support number',
			'student.supportPhoneValue' => '0100 000 0000',
			'student.backToLogin' => 'Back to Login',
			'student.rejectedTitle' => 'Your request was rejected',
			'student.rejectedDescription' => 'Sorry, your registration request was rejected. You can edit your data and resubmit.',
			'student.rejectedReason' => 'Reason: ID photo is unclear. Please upload a clearer photo and resubmit.',
			'student.editAndResubmit' => 'Edit data and resubmit',
			'student.blockedTitle' => 'Account Blocked',
			'student.blockedDescription' => 'Your account was blocked. For any inquiries, contact support.',
			'student.deviceLimitTitle' => 'Logged in on another device',
			'student.deviceLimitDescription' => 'Your account is signed in on another device. Please log out from the other device first, or contact support.',
			'student.deviceRegisteredLabel' => 'Registered device',
			'student.deviceRegisteredValue' => 'Samsung Galaxy A54',
			'student.contactTechSupport' => 'Contact Technical Support',
			'student.forgotTitle' => 'Forgot Password',
			'student.forgotHeading' => 'Recover Password',
			'student.forgotDescription' => 'Enter your registered phone and we will send a WhatsApp code.',
			'student.sendCode' => 'Send Verification Code',
			'student.resetTitle' => 'Reset Password',
			'student.resetHeading' => 'New Password',
			'student.resetDescription' => 'Enter your new password',
			'student.newPasswordLabel' => 'New Password',
			'student.newPasswordHint' => 'Enter new password',
			'student.savePassword' => 'Save Password',
			'student.requiredField' => 'This field is required.',
			'student.incorrectCredentials' => 'Incorrect phone or password.',
			'student.deviceMismatch' => 'You are logged in on another device. Please log out from that device first.',
			'student.phoneAlreadyRegistered' => 'Your number is already registered. Please login.',
			'student.phoneNotRegistered' => 'This number is not registered.',
			'student.passwordMismatch' => 'Passwords do not match.',
			'student.idMissing' => 'Please upload required images.',
			'student.otpError' => 'Please enter the full code.',
			'student.appName' => 'MentorX',
			'student.platformTagline' => 'Egyptian Education Platform',
			'student.splashTagline' => 'TEACH • MANAGE • REACH',
			'student.commonSkip' => 'Skip',
			'student.commonStartNow' => 'Start Now',
			'student.commonOr' => 'Or',
			'student.commonSave' => 'Save',
			'student.commonCancel' => 'Cancel',
			'student.commonConfirm' => 'Confirm',
			'student.commonDone' => 'Done',
			'student.commonClose' => 'Close',
			'student.commonSearch' => 'Search',
			'student.commonSeeAll' => 'See All',
			'student.commonLoading' => 'Loading...',
			'student.commonError' => 'An error occurred',
			'student.commonRetry' => 'Retry',
			'student.commonYes' => 'Yes',
			'student.commonNo' => 'No',
			'student.commonDelete' => 'Delete',
			'student.commonEdit' => 'Edit',
			'student.egp' => 'EGP',
			'student.coursesTitle' => 'Courses',
			'student.coursePhysics' => 'Physics - Third Secondary',
			'student.unitPrefix' => 'Unit',
			'student.sessions' => 'sessions',
			'student.completed' => 'completed',
			'student.locked' => 'locked',
			'student.inProgress' => 'in progress',
			'student.sessionsTab' => 'Sessions',
			'student.quizzesTab' => 'Quizzes',
			'student.assignmentsTab' => 'Assignments',
			'student.filesTab' => 'Files',
			'student.minutes' => 'min',
			'student.video' => 'Video',
			'student.pdf' => 'PDF',
			'student.quiz' => 'quiz',
			'student.assignment' => 'Assignment',
			'student.free' => 'Free',
			'student.open' => 'Open',
			'student.premium' => 'Premium',
			'student.lessonExplanation' => 'Lesson Explanation',
			'student.part1' => 'Part 1',
			'student.part2' => 'Part 2',
			'student.lessonSummary' => 'Lesson Summary',
			'student.quickQuiz' => 'Quick Quiz',
			'student.lessonAssignment' => 'Lesson Assignment',
			'student.submissionRequired' => 'Submission required',
			'student.pages' => 'pages',
			'student.questions' => 'questions',
			'student.videoViews' => 'Views',
			'student.videoDuration' => 'Duration',
			'student.pdfPageOf' => 'of',
			'student.lockedContentTitle' => 'This content is locked',
			'student.lockedContentDesc' => 'You can unlock this content by purchasing from wallet or entering a session code',
			'student.buyFor' => 'Buy for',
			'student.enterCode' => 'Enter Code',
			'student.unitMechanics' => 'Unit 1: Mechanics',
			'student.unitElectricity' => 'Unit 2: Electricity',
			'student.unitWaves' => 'Unit 3: Waves',
			'student.unitDynamics' => 'Unit 4: Dynamics',
			'student.unitHeat' => 'Unit 5: Heat',
			'student.introToWaves' => 'Introduction to Waves',
			'student.typesOfWaves' => 'Types of Waves',
			'student.waveProperties' => 'Wave Properties',
			'student.soundWaves' => 'Sound Waves',
			'student.reviewAndPractice' => 'Review & Practice',
			'student.dashboardTitle' => 'Student Dashboard',
			'student.welcome' => 'Welcome',
			'student.homeGreeting' => 'Hello',
			'student.homeTitle' => 'Student Home',
			'student.myLessons' => 'My Lessons',
			'student.myExams' => 'My Exams',
			'student.myGrades' => 'My Grades',
			'student.wallet' => 'Wallet',
			'student.notifications' => 'Notifications',
			'student.settings' => 'Settings',
			'student.noLessonsToday' => 'No lessons today',
			'student.upcomingLessons' => 'Upcoming Lessons',
			'student.attendance' => 'Attendance',
			'student.profile' => 'Profile',
			'student.logout' => 'Logout',
			'student.myCourses' => 'My Courses',
			'student.aiChat' => 'AI Assistant',
			'student.attendanceRate' => 'Attendance Rate',
			'student.averageScore' => 'Average Score',
			'student.pendingAssignments' => 'Pending Assignments',
			'student.walletBalance' => 'Wallet Balance',
			'student.quickActions' => 'Quick Actions',
			'student.navHome' => 'Home',
			'student.navCourses' => 'Courses',
			'student.navQuizzes' => 'Quizzes',
			'student.navWallet' => 'Wallet',
			'student.navAccount' => 'My Account',
			'student.welcomeBack' => 'Welcome back,',
			'student.welcomeSubtitle' => 'Ready to continue learning?',
			'student.goToDashboard' => 'Go to Dashboard',
			'student.notificationsTitle' => 'Notifications',
			'student.markAllRead' => 'Mark all read',
			'student.minutesAgo' => '%s minutes ago',
			'student.hoursAgo' => '%s hours ago',
			'student.daysAgo' => '%s days ago',
			'student.quizCorrected' => 'Quiz Corrected',
			'student.newAssignment' => 'New Assignment',
			'student.sessionReminder' => 'Session Reminder',
			'student.walletCharged' => 'Wallet Charged',
			'student.absenceAlert' => 'Absence Alert',
			'student.store' => 'Store',
			'student.addToCart' => 'Add to Cart',
			'student.shoppingCart' => 'Shopping Cart',
			'student.products' => 'Products',
			'student.checkout' => 'Checkout',
			'student.pagesCount' => 'Pages',
			'student.availability' => 'Availability',
			'student.available' => 'Available',
			'student.physicsBook' => 'Physics Notebook',
			'student.practiceWorkbook' => 'Practice Workbook',
			'student.mentorxTshirt' => 'MentorX T-Shirt',
			'student.studentBag' => 'Student Bag',
			'student.orderSummary' => 'Order Summary',
			'student.profileTitle' => 'My Profile',
			'student.personalData' => 'Personal Data',
			'student.name' => 'Name',
			'student.phone' => 'Phone',
			'student.grade' => 'Grade',
			'student.center' => 'Center',
			'student.editRequest' => 'Edit Request',
			'student.editProfile' => 'Edit Profile',
			'student.editsNeedApproval' => 'Edits need admin approval',
			'student.school' => 'School',
			'student.reasonForEdit' => 'Reason for edit',
			'student.sendRequest' => 'Send Request',
			'student.changePassword' => 'Change Password',
			'student.currentPassword' => 'Current Password',
			'student.newPassword' => 'New Password',
			'student.confirmNewPassword' => 'Confirm New Password',
			'student.saveChanges' => 'Save Changes',
			'student.quizIntroTitle' => 'Quiz Info',
			'student.quizUnitTitle' => 'Unit 3 Quiz',
			'student.quizTitle' => 'Waves Quiz',
			'student.quizSubtitle' => 'Test your knowledge about waves',
			'student.questionCount' => 'Questions',
			'student.duration' => 'Duration',
			'student.passGrade' => 'Pass Grade',
			'student.attempts' => 'Attempts',
			'student.instructions' => 'Instructions:',
			'student.instructionRead' => 'Read each question carefully before answering',
			'student.instructionReview' => 'You can review your answers before submitting',
			'student.instructionNoReturn' => 'You cannot return after submitting the quiz',
			'student.startQuiz' => 'Start Quiz',
			'student.questionOf' => 'Question %s of %s',
			'student.submitQuiz' => 'Submit Quiz',
			'student.backToQuestions' => 'Back to Questions',
			'student.answeredCount' => 'Answered',
			'student.jumpToQuestion' => 'Jump to a question:',
			'student.unansweredNote' => '%s unanswered questions',
			'student.quizResult' => 'Quiz Result',
			'student.excellent' => 'Excellent!',
			'student.veryGood' => 'Very Good',
			'student.good' => 'Good',
			'student.fail' => 'Try Again',
			'student.greatResult' => 'Great job! Amazing result',
			'student.correctAnswers' => 'Correct answers',
			'student.wrongAnswers' => 'Wrong answers',
			'student.timeTaken' => 'Time taken',
			'student.reviewAnswers' => 'Review Answers',
			'student.correctAnswer' => 'Correct answer:',
			'student.minutesShort' => 'min',
			'student.claimReward' => 'Claim Your Reward',
			'student.quizRewardsTitle' => 'Quiz Rewards',
			'student.congratulations' => 'Congratulations!',
			'student.rewardEarnedMsg' => 'You achieved an excellent score and earned a special reward!',
			'student.yourScore' => 'Your Score',
			'student.pointsEarned' => 'Points Earned',
			'student.excellentBadge' => 'Excellence Badge',
			'student.badgeUnlocked' => 'Badge unlocked - added to your profile',
			'student.backToQuizzes' => 'Back to Dashboard',
			'student.quizListTitle' => 'Quizzes',
			'student.gamificationTitle' => 'Gamification',
			'student.goldLevel' => 'Gold Level',
			'student.xpPoints' => 'XP Points',
			'student.quizCompleted' => 'Completed Quiz',
			'student.badge' => 'Badge',
			'student.toNextLevel' => 'to next level',
			'student.dailyStreak' => 'Daily Streak',
			'student.streakDaysMsg' => '%s consecutive days - keep going for a reward!',
			'student.earnedBadges' => 'Earned Badges',
			'student.leaderboard' => 'Top Performers',
			'student.sat' => 'Sat',
			'student.sun' => 'Sun',
			'student.mon' => 'Mon',
			'student.tue' => 'Tue',
			'student.wed' => 'Wed',
			'student.thu' => 'Thu',
			'student.fri' => 'Fri',
			'student.lightningSpeed' => 'Lightning Speed',
			'student.perfectScore' => 'Perfect Score',
			'student.fiveDayStreak' => '5 Day Streak',
			'student.tenQuizzes' => '10 Quizzes',
			'student.physicsLion' => 'Physics Lion',
			'student.settingsTitle' => 'Settings',
			'student.changePasswordSetting' => 'Change Password',
			'student.notificationsSetting' => 'Notifications',
			'student.supportSetting' => 'Technical Support',
			'student.aboutSetting' => 'About App',
			'student.logoutSetting' => 'Logout',
			'student.supportTitle' => 'Contact Us',
			'student.supportDesc' => 'We are here to help! Contact us through any of the following channels',
			'student.whatsapp' => 'WhatsApp',
			'student.phoneCall' => 'Phone',
			'student.email' => 'Email',
			'student.aboutTitle' => 'About App',
			'student.aboutDesc' => 'An integrated educational platform connecting instructors and students',
			'student.version' => 'Version',
			'student.lastUpdate' => 'Last Update',
			'student.walletTitle' => 'Wallet',
			'student.currentBalance' => 'Current Balance',
			'student.charge' => 'Charge',
			'student.code' => 'Code',
			'student.history' => 'History',
			'student.recentTransactions' => 'Recent Transactions',
			'student.addBalance' => 'Add Balance',
			'student.amount' => 'Amount',
			'student.choosePaymentMethod' => 'Choose Payment Method',
			'student.vodafoneCash' => 'Vodafone Cash',
			'student.vodafoneDesc' => 'Pay from Vodafone wallet',
			'student.instaPay' => 'InstaPay',
			'student.instaPayDesc' => 'Transfer via InstaPay',
			'student.fawry' => 'Fawry',
			'student.fawryDesc' => 'Pay through Fawry',
			'student.continueBtn' => 'Continue',
			'student.redeemCode' => 'Redeem Code',
			'student.enterCodeDesc' => 'Enter discount or session code',
			'student.activateCode' => 'Activate Code',
			'student.purchaseConfirm' => 'Purchase Confirmation',
			'student.paymentMethod' => 'Payment Method',
			'student.total' => 'Total',
			'student.confirmPayment' => 'Confirm Payment',
			'student.paymentSuccess' => 'Payment Successful!',
			'student.balanceAdded' => '%s EGP added to your balance',
			'student.newBalance' => 'New Balance',
			'student.backToWallet' => 'Back to Wallet',
			'student.transactionsTitle' => 'Transactions',
			'student.chargeBalance' => 'Charge - Balance',
			'student.purchaseCourse' => 'Purchase - Course',
			'student.discountCode' => 'Discount Code',
			'student.purchaseBook' => 'Purchase - Book',
			'student.today' => 'Today',
			'student.yesterday' => 'Yesterday',
			'parent.dashboardTitle' => 'Parent Portal',
			'parent.welcomeBack' => 'Welcome back,',
			'parent.services' => 'Services',
			'parent.recentActivity' => 'Recent Activity',
			'parent.viewAll' => 'View All',
			'parent.retry' => 'Retry',
			'parent.unableToLoad' => 'Unable to load dashboard',
			'parent.myProfile' => 'My Profile',
			'parent.signOut' => 'Sign Out',
			'parent.accountInfo' => 'Account Information',
			'parent.appSettings' => 'App Settings',
			'parent.notifications' => 'Notifications',
			'parent.security' => 'Security',
			'parent.childSwitcher' => 'Child Switcher',
			'parent.noData' => 'No data found',
			'parent.announcements' => 'Announcements',
			'parent.academicMonitor' => 'Academic Monitor',
			'parent.financialMonitor' => 'Financial Monitor',
			'parent.attendanceMonitor' => 'Attendance Monitor',
			'parent.overallAverage' => 'Overall Average',
			'parent.enrolledCourses' => 'Enrolled Courses',
			'parent.childWalletBalance' => 'Child Wallet Balance',
			'parent.spentThisMonth' => 'Spent This Month',
			'parent.transactionHistory' => 'Transaction History',
			'parent.pointsEarned' => 'Points Earned',
			'assignments.listTitle' => 'Assignments',
			'assignments.dueAt' => ({required Object date}) => 'Due: ${date}',
			'assignments.noDeadline' => 'No deadline',
			'assignments.submitAssignment' => 'Submit Assignment',
			'assignments.viewFeedback' => 'View Feedback',
			'assignments.submitted' => 'Submitted',
			'assignments.notSubmitted' => 'Not submitted',
			'assignments.grading' => 'Grading',
			'assignments.graded' => 'Graded',
			_ => null,
		};
	}
}
