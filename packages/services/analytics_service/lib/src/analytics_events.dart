/// Centralized class for all analytics event names.
class AnalyticsEvents {
  // Auth
  static const String login = 'login';
  static const String logout = 'logout';
  static const String registrationStarted = 'registration_started';
  static const String registrationStepCompleted = 'registration_step_completed';
  static const String registrationCompleted = 'registration_completed';
  static const String registrationFailed = 'registration_failed';
  static const String forgotPasswordViewed = 'forgot_password_viewed';
  static const String forgotPassword = 'forgot_password';
  static const String resetPasswordViewed = 'reset_password_viewed';
  static const String resetPassword = 'reset_password';
  static const String otpViewed = 'otp_viewed';
  static const String otpSent = 'otp_sent';
  static const String otpVerified = 'otp_verified';
  static const String registration = 'registration';

  // Onboarding
  static const String walkthroughStarted = 'walkthrough_started';
  static const String walkthroughCompleted = 'walkthrough_completed';
  static const String walkthroughSkipped = 'walkthrough_skipped';

  // Course
  static const String courseCatalogViewed = 'course_catalog_viewed';
  static const String myCoursesViewed = 'my_courses_viewed';
  static const String myGradesViewed = 'my_grades_viewed';
  static const String courseViewed = 'course_viewed';
  static const String courseEnrolled = 'course_enrolled';
  static const String courseStarted = 'course_started';
  static const String lessonViewed = 'lesson_viewed';
  static const String videoPlayed = 'video_played';
  static const String pdfViewed = 'pdf_viewed';

  // Quizzes & Assignments
  static const String quizListViewed = 'quiz_list_viewed';
  static const String quizIntroViewed = 'quiz_intro_viewed';
  static const String quizStarted = 'quiz_started';
  static const String quizSubmitted = 'quiz_submitted';
  static const String quizSubmitFailed = 'quiz_submit_failed';
  static const String quizResultViewed = 'quiz_result_viewed';
  static const String quizReviewViewed = 'quiz_review_viewed';
  static const String quizAnswersReviewViewed = 'quiz_answers_review_viewed';
  static const String quizRewardsViewed = 'quiz_rewards_viewed';
  static const String assignmentsListViewed = 'assignments_list_viewed';
  static const String assignmentDetailsViewed = 'assignment_details_viewed';
  static const String assignmentResultViewed = 'assignment_result_viewed';
  static const String assignmentViewed = 'assignment_viewed';
  static const String assignmentSubmitted = 'assignment_submitted';

  // Marketplace
  static const String marketplaceViewed = 'marketplace_viewed';
  static const String ordersViewed = 'orders_viewed';
  static const String cartViewed = 'cart_viewed';
  static const String itemViewed = 'item_viewed';
  static const String marketplaceCategoryViewed = 'marketplace_category_viewed';
  static const String marketplaceSearched = 'marketplace_searched';
  static const String addToCart = 'add_to_cart';
  static const String removeFromCart = 'remove_from_cart';
  static const String couponApplied = 'coupon_applied';
  static const String couponRemoved = 'coupon_removed';
  static const String checkoutStarted = 'checkout_started';
  static const String purchaseCompleted = 'purchase_completed';
  static const String purchaseFailed = 'purchase_failed';

  // Wallet
  static const String walletViewed = 'wallet_viewed';
  static const String addBalanceStarted = 'add_balance_started';
  static const String addBalanceCompleted = 'add_balance_completed';
  static const String addBalanceFailed = 'add_balance_failed';
  static const String redeemCodeStarted = 'redeem_code_started';
  static const String redeemCodeCompleted = 'redeem_code_completed';
  static const String redeemCodeFailed = 'redeem_code_failed';
  static const String transactionHistoryViewed = 'transaction_history_viewed';
  static const String walletOrdersViewed = 'wallet_orders_viewed';
  static const String purchaseConfirmViewed = 'purchase_confirm_viewed';
  static const String purchaseConfirmStarted = 'purchase_confirm_started';
  static const String purchaseConfirmCompleted = 'purchase_confirm_completed';
  static const String purchaseConfirmFailed = 'purchase_confirm_failed';
  static const String paymentSuccessViewed = 'payment_success_viewed';

  // Profile
  static const String profileViewed = 'profile_viewed';
  static const String profileUpdated = 'profile_updated';
  static const String profileEditRequested = 'profile_edit_requested';
  static const String changePasswordViewed = 'change_password_viewed';
  static const String passwordChanged = 'password_changed';

  // Settings
  static const String settingsViewed = 'settings_viewed';
  static const String deviceManagementViewed = 'device_management_viewed';
  static const String deviceRemoved = 'device_removed';
  static const String whatsappGroupsViewed = 'whatsapp_groups_viewed';
  static const String whatsappGroupJoined = 'whatsapp_group_joined';
  static const String aboutViewed = 'about_viewed';

  // AI Chat
  static const String aiMessageSent = 'ai_message_sent';
  static const String aiConversationsViewed = 'ai_conversations_viewed';
  static const String aiConversationViewed = 'ai_conversation_viewed';

  // Engagement
  static const String homeViewed = 'home_viewed';
  static const String childrenViewed = 'children_viewed';
  static const String assessmentsViewed = 'assessments_viewed';
  static const String attendanceViewed = 'attendance_viewed';
  static const String communicationViewed = 'communication_viewed';
  static const String financialViewed = 'financial_viewed';
  static const String coursesViewed = 'courses_viewed';
  static const String splashViewed = 'splash_viewed';
  static const String notificationsViewed = 'notifications_viewed';
  static const String analyticsDashboardViewed = 'analytics_dashboard_viewed';
  static const String leaderboardViewed = 'leaderboard_viewed';
  static const String rewardsCatalogViewed = 'rewards_catalog_viewed';
  static const String rewardsHistoryViewed = 'rewards_history_viewed';
  static const String rewardClaimed = 'reward_claimed';
  static const String attendanceQrScanned = 'attendance_qr_scanned';
  static const String attendanceHistoryViewed = 'attendance_history_viewed';
  static const String studentCardViewed = 'student_card_viewed';
  static const String notificationOpened = 'notification_opened';

  // Account Status
  static const String accountStatusViewed = 'account_status_viewed';
}

/// Centralized class for all analytics parameter names.
class AnalyticsParams {
  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String category = 'category';
  static const String categoryId = 'category_id';
  static const String status = 'status';
  static const String value = 'value';
  static const String currency = 'currency';
  static const String errorMessage = 'error_message';
  static const String method = 'method';
  static const String query = 'query';
  static const String screenName = 'screen_name';
  static const String fieldName = 'field_name';
  static const String itemId = 'item_id';
  static const String itemName = 'item_name';
  static const String courseId = 'course_id';
  static const String quizId = 'quiz_id';
  static const String assignmentId = 'assignment_id';
  static const String conversationId = 'conversation_id';
  static const String score = 'score';
  static const String step = 'step';
  static const String nextStep = 'next_step';
  static const String couponCode = 'coupon_code';
  static const String amount = 'amount';
  static const String paymentMethod = 'payment_method';
  static const String childId = 'child_id';
  static const String childName = 'child_name';
}
