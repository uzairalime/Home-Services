import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/bindings/dashboard_binding.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/bindings/bookings_binding.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/views/bookings_view.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/about_matadata/bindings/about_matadata_binding.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/about_matadata/views/about_matadata_view.dart';
import 'package:home_brigadier/app/user/dashboard/calender/bindings/calender_binding.dart';
import 'package:home_brigadier/app/user/dashboard/calender/views/calender_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/bindings/all_services_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/bindings/selected_category_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/appliance/bindings/appliance_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/appliance/views/appliance_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/bindings/category_item_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/bindings/booking_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/laundry/bindings/laundry_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/laundry/views/laundry_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/painting/bindings/painting_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/painting/views/painting_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/plumbing/bindings/plumbing_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/plumbing/views/plumbing_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/reparing/bindings/reparing_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/reparing/views/reparing_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/shifting/bindings/shifting_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/shifting/views/shifting_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/tailor/bindings/tailor_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/tailor/views/tailor_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/views/category_item_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/views/selected_category_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/views/all_services_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/bindings/home_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/bookmark/bindings/bookmark_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/bookmark/views/bookmark_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/notification/bindings/notification_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/notification/views/notification_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/popular_services/bindings/popular_services_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/popular_services/views/popular_services_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/special_offers/bindings/special_offers_binding.dart';
import 'package:home_brigadier/app/user/dashboard/home/special_offers/views/special_offers_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/views/home_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/bindings/inbox_binding.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/calls/bindings/calls_binding.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/calls/user_call/bindings/user_call_binding.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/calls/user_call/views/user_call_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/calls/views/calls_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/bindings/chats_binding.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/user_chat/bindings/user_chat_binding.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/user_chat/views/user_chat_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/views/chats_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/views/inbox_view.dart';
import 'package:home_brigadier/app/user/dashboard/views/dashboard_view.dart';

import '../modules/account_setup/bindings/account_setup_binding.dart';
import '../modules/account_setup/views/account_setup_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/email_login/bindings/email_login_binding.dart';
import '../modules/login/email_login/forget_password/bindings/forget_password_binding.dart';
import '../modules/login/email_login/forget_password/views/forget_password_view.dart';
import '../modules/login/email_login/views/email_login_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../seller/dashboard/start_earning/bindings/start_earning_binding.dart';
import '../seller/dashboard/start_earning/views/start_earning_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      transitionDuration: const Duration(seconds: 1),
      transition: Transition.native,
      name: _Paths.DASHBOARD,
      page: () => const UserDashboardView(),
      binding: DashboardBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
          children: [
            GetPage(
              name: _Paths.ABOUT_MATADATA,
              page: () => const AboutMatadataView(),
              binding: AboutMatadataBinding(),
            ),
            GetPage(
              name: _Paths.NOTIFICATION,
              page: () => const NotificationView(),
              binding: NotificationBinding(),
            ),
            GetPage(
              name: _Paths.BOOKMARK,
              page: () => const BookmarkView(),
              binding: BookmarkBinding(),
            ),
            GetPage(
              name: _Paths.SPECIAL_OFFERS,
              page: () => const SpecialOffersView(),
              binding: SpecialOffersBinding(),
            ),
            GetPage(
              name: _Paths.POPULAR_SERVICES,
              page: () => const PopularServicesView(),
              binding: PopularServicesBinding(),
            ),
            GetPage(
              name: _Paths.ALL_SERVICES,
              page: () => const AllServicesView(),
              binding: AllServicesBinding(),
              children: [
                GetPage(
                  name: _Paths.SELECTED_CATEGORY,
                  page: () => const SelectedCategoryView(),
                  binding: SelectedCategoryBinding(),
                  children: [
                    GetPage(
                      name: _Paths.CATEGORY_ITEM,
                      page: () => CategoryItemView(),
                      binding: CategoryItemBinding(),
                      children: [
                        GetPage(
                          name: _Paths.BOOKING,
                          page: () => HouseCleaningBookingView(),
                          binding: BookingBinding(),
                        ),
                        GetPage(
                          name: _Paths.REPARING,
                          page: () => const ReparingView(),
                          binding: ReparingBinding(),
                        ),
                        GetPage(
                          name: _Paths.PAINTING,
                          page: () => const PaintingView(),
                          binding: PaintingBinding(),
                        ),
                        GetPage(
                          name: _Paths.LAUNDRY,
                          page: () => const LaundryView(),
                          binding: LaundryBinding(),
                        ),
                        GetPage(
                          name: _Paths.APPLIANCE,
                          page: () => const ApplianceView(),
                          binding: ApplianceBinding(),
                        ),
                        GetPage(
                          name: _Paths.PLUMBING,
                          page: () => const PlumbingView(),
                          binding: PlumbingBinding(),
                        ),
                        GetPage(
                          name: _Paths.SHIFTING,
                          page: () => const ShiftingView(),
                          binding: ShiftingBinding(),
                        ),
                        GetPage(
                          name: _Paths.TAILOR,
                          page: () => TailorView(),
                          binding: TailorBinding(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GetPage(
          name: _Paths.BOOKINGS,
          page: () => const BookingsView(),
          binding: BookingsBinding(),
        ),
        GetPage(
          name: _Paths.CALENDER,
          page: () => const CalenderView(),
          binding: CalenderBinding(),
        ),
        GetPage(
          name: _Paths.INBOX,
          page: () => const InboxView(),
          binding: InboxBinding(),
          children: [
            GetPage(
              name: _Paths.CHATS,
              page: () => const ChatsView(),
              binding: ChatsBinding(),
              children: [
                GetPage(
                  name: _Paths.USER_CHAT,
                  page: () => const UserChatView(),
                  binding: UserChatBinding(),
                ),
              ],
            ),
            GetPage(
              name: _Paths.CALLS,
              page: () => const CallsView(),
              binding: CallsBinding(),
              children: [
                GetPage(
                  name: _Paths.USER_CALL,
                  page: () => const UserCallView(),
                  binding: UserCallBinding(),
                ),
              ],
            ),
          ],
        ),
        // GetPage(
        //   name: _Paths.PROFILE,
        //   page: () => const ProfileView(),
        //   binding: ProfileBinding(),
        //   children: [
        //     GetPage(
        //       name: _Paths.EDIT_PROFILE_SETTING,
        //       page: () => const EditProfileSettingView(),
        //       binding: EditProfileSettingBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.NOTIFICATION_SETTING,
        //       page: () => const NotificationSettingView(),
        //       binding: NotificationSettingBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.PAYMENT_SETTING,
        //       page: () => const PaymentSettingView(),
        //       binding: PaymentSettingBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.SECURITY_SETTING,
        //       page: () => const SecuritySettingView(),
        //       binding: SecuritySettingBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.LANGUAGE_SETTING,
        //       page: () => const LanguageSettingView(),
        //       binding: LanguageSettingBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.PRIVACY_POLICY,
        //       page: () => const PrivacyPolicyView(),
        //       binding: PrivacyPolicyBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.HELP_CENTER,
        //       page: () => const HelpCenterView(),
        //       binding: HelpCenterBinding(),
        //       children: [
        //         GetPage(
        //           name: _Paths.FAQ,
        //           page: () => const FaqView(),
        //           binding: FaqBinding(),
        //         ),
        //         GetPage(
        //           name: _Paths.CONTACT_US,
        //           page: () => const ContactUsView(),
        //           binding: ContactUsBinding(),
        //         ),
        //       ],
        //     ),
        //     GetPage(
        //       name: _Paths.CUSTOMER_SERVICE,
        //       page: () => const CustomerServiceView(),
        //       binding: CustomerServiceBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.LOGOUT,
        //       page: () => const LogoutView(),
        //       binding: LogoutBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.INVITE_FRIEND,
        //       page: () => const InviteFriendView(),
        //       binding: InviteFriendBinding(),
        //     ),
        //     GetPage(
        //       name: _Paths.USER_PROFILE,
        //       page: () => const UserProfileView(),
        //       binding: UserProfileBinding(),
        //     ),
        //   ],
        // ),
        GetPage(
          name: _Paths.START_EARNING,
          page: () => const StartEarningView(),
          binding: StartEarningBinding(),
        ),
      ],
    ),
    GetPage(
      transitionDuration: const Duration(seconds: 1),
      transition: Transition.native,
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETUP,
      page: () => const AccountSetupView(),
      binding: AccountSetupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transitionDuration: const Duration(milliseconds: 1000),
      transition: Transition.native,
      children: [
        GetPage(
          transitionDuration: const Duration(seconds: 1),
          transition: Transition.native,
          name: _Paths.EMAIL_LOGIN,
          page: () => const EmailLoginView(),
          binding: EmailLoginBinding(),
          children: [
            GetPage(
              name: _Paths.FORGET_PASSWORD,
              page: () => const ForgetPasswordView(),
              binding: ForgetPasswordBinding(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    )
  ];
}
