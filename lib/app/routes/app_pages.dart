import 'package:get/get.dart';

import '../modules/seller/dashboard/bindings/dashboard_binding.dart';
import '../modules/seller/dashboard/start_earning/bindings/start_earning_binding.dart';
import '../modules/seller/dashboard/start_earning/views/start_earning_view.dart';
import '../modules/user/dashboard/home/all_services/bindings/all_services_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/bindings/selected_category_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/appliance/bindings/appliance_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/appliance/views/appliance_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/bindings/category_item_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/handyman/bindings/handyman_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/handyman/views/handyman_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/bindings/booking_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/booking_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/laundry/bindings/laundry_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/laundry/views/laundry_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/men_salon/bindings/men_salon_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/men_salon/views/men_salon_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/painting/bindings/painting_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/painting/views/painting_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/pest_control/bindings/pest_control_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/pest_control/views/pest_control_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/plumbing/bindings/plumbing_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/plumbing/views/plumbing_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/reparing/bindings/reparing_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/reparing/views/reparing_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/shifting/bindings/shifting_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/shifting/views/shifting_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/spa/bindings/spa_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/spa/views/spa_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/tailor/bindings/tailor_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/tailor/views/tailor_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/views/category_item_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/women_salon/bindings/women_salon_binding.dart';
import '../modules/user/dashboard/home/all_services/selected_category/category_item/women_salon/views/women_salon_view.dart';
import '../modules/user/dashboard/home/all_services/selected_category/views/selected_category_view.dart';
import '../modules/user/dashboard/home/all_services/views/all_services_view.dart';
import '../modules/user/dashboard/home/bindings/home_binding.dart';
import '../modules/user/dashboard/home/popular_services/bindings/popular_services_binding.dart';
import '../modules/user/dashboard/home/popular_services/views/popular_services_view.dart';
import '../modules/user/dashboard/home/special_offers/bindings/special_offers_binding.dart';
import '../modules/user/dashboard/home/special_offers/views/special_offers_view.dart';
import '../modules/user/dashboard/home/views/home_view.dart';
import '../modules/user/dashboard/my_bookings/bindings/my_bookings_binding.dart';
import '../modules/user/dashboard/my_bookings/views/my_bookings_view.dart';
import '../modules/user/dashboard/views/dashboard_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

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
                      page: () => const CategoryItemView(),
                      binding: CategoryItemBinding(),
                      children: [
                        GetPage(
                          name: _Paths.BOOKING,
                          page: () => const HouseCleaningBookingView(),
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
                        GetPage(
                          name: _Paths.MEN_SALON,
                          page: () => const MenSalonView(),
                          binding: MenSalonBinding(),
                        ),
                        GetPage(
                          name: _Paths.PEST_CONTROL,
                          page: () => const PestControlBookingView(),
                          binding: PestControlBinding(),
                        ),
                        GetPage(
                          name: _Paths.HANDYMAN,
                          page: () => const HandymanView(),
                          binding: HandymanBinding(),
                        ),
                        GetPage(
                          name: _Paths.SPA,
                          page: () => const SpaView(),
                          binding: SpaBinding(),
                        ),
                        GetPage(
                          name: _Paths.WOMEN_SALON,
                          page: () => WomenSalonView(),
                          binding: WomenSalonBinding(),
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
          page: () => const MyBookingsView(),
          binding: MyBookingsBinding(),
        ),
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
  ];
}
