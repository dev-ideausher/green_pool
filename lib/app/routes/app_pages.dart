import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/chat_page/bindings/chat_page_binding.dart';
import '../modules/chat_page/views/chat_page_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/driver_details/bindings/driver_details_binding.dart';
import '../modules/driver_details/views/driver_details_view.dart';
import '../modules/emergency_contacts/bindings/emergency_contacts_binding.dart';
import '../modules/emergency_contacts/views/emergency_contacts_view.dart';
import '../modules/file_dispute/bindings/file_dispute_binding.dart';
import '../modules/file_dispute/views/file_dispute_view.dart';
import '../modules/find_ride/bindings/find_ride_binding.dart';
import '../modules/find_ride/views/find_ride_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_password_otp/bindings/forgot_password_otp_binding.dart';
import '../modules/forgot_password_otp/views/forgot_password_otp_view.dart';
import '../modules/help_support/bindings/help_support_binding.dart';
import '../modules/help_support/views/help_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/bottom_navigation_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/my_rides_details/bindings/my_rides_details_binding.dart';
import '../modules/my_rides_details/views/my_rides_details_view.dart';
import '../modules/my_rides_one_time/bindings/my_rides_binding.dart';
import '../modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import '../modules/my_rides_page/bindings/my_rides_page_binding.dart';
import '../modules/my_rides_page/views/my_rides_page_view.dart';
import '../modules/my_rides_recurring/bindings/my_rides_recurring_binding.dart';
import '../modules/my_rides_recurring/views/my_rides_recurring_view.dart';
import '../modules/my_rides_recurring_details/bindings/my_rides_recurring_details_binding.dart';
import '../modules/my_rides_recurring_details/views/my_rides_recurring_details_view.dart';
import '../modules/my_rides_request/bindings/my_rides_request_binding.dart';
import '../modules/my_rides_request/views/my_rides_request.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/origin/bindings/origin_binding.dart';
import '../modules/origin/views/origin_view.dart';
import '../modules/password_changed/bindings/password_changed_binding.dart';
import '../modules/password_changed/views/password_changed_view.dart';
import '../modules/post_ride/bindings/post_ride_binding.dart';
import '../modules/post_ride/views/carpool_schedule_view.dart';
import '../modules/post_ride/views/guidelines_view.dart';
import '../modules/post_ride/views/post_ride_view.dart';
import '../modules/post_ride/views/pricing_view.dart';
import '../modules/post_ride_step_one/bindings/post_ride_step_one_binding.dart';
import '../modules/post_ride_step_one/views/post_ride_step_one_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_settings/bindings/profile_settings_binding.dart';
import '../modules/profile_settings/views/profile_settings_view.dart';
import '../modules/profile_setup/bindings/profile_setup_binding.dart';
import '../modules/profile_setup/views/profile_setup_view.dart';
import '../modules/push_notifications/bindings/push_notifications_binding.dart';
import '../modules/push_notifications/views/push_notifications_view.dart';
import '../modules/rating_driver_side/bindings/rating_driver_side_binding.dart';
import '../modules/rating_driver_side/views/rating_driver_side_view.dart';
import '../modules/rating_rider_side/bindings/rating_rider_side_binding.dart';
import '../modules/rating_rider_side/views/rating_rider_side_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/ride_details/bindings/ride_details_binding.dart';
import '../modules/ride_details/views/ride_details_view.dart';
import '../modules/ride_history/bindings/ride_history_binding.dart';
import '../modules/ride_history/views/ride_history_view.dart';
import '../modules/rider_confirmed_ride_details/bindings/rider_confirmed_ride_details_binding.dart';
import '../modules/rider_confirmed_ride_details/views/rider_confirmed_ride_details_view.dart';
import '../modules/rider_filter/bindings/rider_filter_binding.dart';
import '../modules/rider_filter/views/rider_filter_view.dart';
import '../modules/rider_matching_rides/bindings/matching_rides_binding.dart';
import '../modules/rider_matching_rides/views/matching_rides_view.dart';
import '../modules/rider_my_ride_request/bindings/rider_ride_request_binding.dart';
import '../modules/rider_my_ride_request/views/rider_my_ride_request_view.dart';
import '../modules/rider_my_rides/bindings/rider_my_rides_binding.dart';
import '../modules/rider_my_rides/views/rider_my_rides_view.dart';
import '../modules/rider_my_rides_confirm_details/bindings/rider_my_rides_confirm_details_binding.dart';
import '../modules/rider_my_rides_confirm_details/views/rider_my_rides_confirm_details_view.dart';
import '../modules/rider_my_rides_send_details/bindings/rider_my_rides_send_details_binding.dart';
import '../modules/rider_my_rides_send_details/views/rider_my_rides_send_details_view.dart';
import '../modules/rider_post_ride/bindings/rider_post_ride_binding.dart';
import '../modules/rider_post_ride/views/rider_post_ride_view.dart';
import '../modules/rider_profile_setup/bindings/rider_profile_setup_binding.dart';
import '../modules/rider_profile_setup/views/rider_profile_setup_view.dart';
import '../modules/rider_start_ride_map/bindings/rider_start_ride_map_binding.dart';
import '../modules/rider_start_ride_map/views/rider_start_ride_map_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/start_ride/bindings/start_ride_binding.dart';
import '../modules/start_ride/views/start_ride_view.dart';
import '../modules/student_discounts/bindings/student_discounts_binding.dart';
import '../modules/student_discounts/views/student_discounts_view.dart';
import '../modules/terms_conditions/bindings/terms_conditions_binding.dart';
import '../modules/terms_conditions/views/terms_conditions_view.dart';
import '../modules/user_details/bindings/user_details_binding.dart';
import '../modules/user_details/views/user_details_view.dart';
import '../modules/vehicle_details/bindings/vehicle_details_binding.dart';
import '../modules/vehicle_details/views/vehicle_details_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => const BottomNavigationView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES,
      page: () => const MyRidesOneTimeView(),
      binding: MyRidesOneTimeBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_REQUEST,
      page: () => const MyRideRequestsView(),
      binding: MyRidesRequestBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE,
      page: () => const PostRideView(),
      binding: PostRideBinding(),
    ),
    GetPage(
      name: _Paths.CARPOOL_SCHEDULE,
      page: () => const CarpoolScheduleView(),
      binding: PostRideBinding(),
    ),
    GetPage(
      name: _Paths.PRICING_VIEW,
      page: () => const PricingView(),
      binding: PostRideBinding(),
    ),
    GetPage(
      name: _Paths.GUIDELINES_VIEW,
      page: () => const GuidelinesView(),
      binding: PostRideBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.ORIGIN,
      page: () => const OriginView(),
      binding: OriginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => const ChatPageView(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => const CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => const VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsConditionsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETUP,
      page: () => const ProfileSetupView(),
      binding: ProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS,
      page: () => const ProfileSettingsView(),
      binding: ProfileSettingsBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAILS,
      page: () => const UserDetailsView(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_DETAILS,
      page: () => const VehicleDetailsView(),
      binding: VehicleDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EMERGENCY_CONTACTS,
      page: () => const EmergencyContactsView(),
      binding: EmergencyContactsBinding(),
    ),
    GetPage(
      name: _Paths.PUSH_NOTIFICATIONS,
      page: () => const PushNotificationsView(),
      binding: PushNotificationsBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_DISCOUNTS,
      page: () => const StudentDiscountsView(),
      binding: StudentDiscountsBinding(),
    ),
    GetPage(
      name: _Paths.FILE_DISPUTE,
      page: () => const FileDisputeView(),
      binding: FileDisputeBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_HISTORY,
      page: () => const RideHistoryView(),
      binding: RideHistoryBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_DETAILS,
      page: () => const RideDetailsView(),
      binding: RideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.FIND_RIDE,
      page: () => const FindRideView(),
      binding: FindRideBinding(),
    ),
    GetPage(
      name: _Paths.MATCHING_RIDES,
      page: () => const MatchingRidesView(),
      binding: MatchingRidesBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_DETAILS,
      page: () => const DriverDetailsView(),
      binding: DriverDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_PROFILE_SETUP,
      page: () => const RiderProfileSetupView(),
      binding: RiderProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_POST_RIDE,
      page: () => const RiderPostRideView(),
      binding: RiderPostRideBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDE_REQUEST,
      page: () => const RiderMyRideRequestView(),
      binding: RiderMyRideRequestBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_FILTER,
      page: () => const RiderFilterView(),
      binding: RiderFilterBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDES,
      page: () => const RiderMyRidesView(),
      binding: RiderMyRidesBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_RECURRING,
      page: () => const MyRidesRecurringView(),
      binding: MyRidesRecurringBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_OTP,
      page: () => const ForgotPasswordOtpView(),
      binding: ForgotPasswordOtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_CHANGED,
      page: () => const PasswordChanged(),
      binding: PasswordChangedBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_DETAILS,
      page: () => const MyRidesDetailsView(),
      binding: MyRidesDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_PAGE,
      page: () => const MyRidesPageView(),
      binding: MyRidesPageBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDES_SEND_DETAILS,
      page: () => const RiderMyRidesSendDetailsView(),
      binding: RiderMyRidesSendDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDES_CONFIRM_DETAILS,
      page: () => const RiderMyRidesConfirmDetailsView(),
      binding: RiderMyRidesConfirmDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_CONFIRMED_RIDE_DETAILS,
      page: () => const RiderConfirmedRideDetailsView(),
      binding: RiderConfirmedRideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.START_RIDE,
      page: () => const StartRideView(),
      binding: StartRideBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE_STEP_ONE,
      page: () => const PostRideStepOneView(),
      binding: PostRideStepOneBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_RECURRING_DETAILS,
      page: () => const MyRidesRecurringDetailsView(),
      binding: MyRidesRecurringDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RATING_DRIVER_SIDE,
      page: () => const RatingDriverSideView(),
      binding: RatingDriverSideBinding(),
    ),
    GetPage(
      name: _Paths.RATING_RIDER_SIDE,
      page: () => const RatingRiderSideView(),
      binding: RatingRiderSideBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_START_RIDE_MAP,
      page: () => const RiderStartRideMapView(),
      binding: RiderStartRideMapBinding(),
    ),
  ];
}
