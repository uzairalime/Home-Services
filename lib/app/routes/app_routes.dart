// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const DASHBOARD = _Paths.DASHBOARD;
  static const WELCOME = _Paths.WELCOME;
  static const HOME = _Paths.DASHBOARD + _Paths.HOME;
  static const BOOKINGS = _Paths.DASHBOARD + _Paths.BOOKINGS;
  static const CALENDER = _Paths.DASHBOARD + _Paths.CALENDER;
  static const INBOX = _Paths.DASHBOARD + _Paths.INBOX;
  static const PROFILE = _Paths.DASHBOARD + _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const EMAIL_LOGIN = _Paths.LOGIN + _Paths.EMAIL_LOGIN;
  static const ACCOUNT_SETUP = _Paths.ACCOUNT_SETUP;
  static const NOTIFICATION =
      _Paths.DASHBOARD + _Paths.HOME + _Paths.NOTIFICATION;
  static const BOOKMARK = _Paths.DASHBOARD + _Paths.HOME + _Paths.BOOKMARK;
  static const SPECIAL_OFFERS =
      _Paths.DASHBOARD + _Paths.HOME + _Paths.SPECIAL_OFFERS;
  static const POPULAR_SERVICES =
      _Paths.DASHBOARD + _Paths.HOME + _Paths.POPULAR_SERVICES;
  static const ALL_SERVICES =
      _Paths.DASHBOARD + _Paths.HOME + _Paths.ALL_SERVICES;
  static const SELECTED_CATEGORY = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY;
  static const CATEGORY_ITEM = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM;
  static const BOOKING = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.BOOKING;

  // static const DASHBOARD = _Paths.DASHBOARD;
  // static const WELCOME = _Paths.WELCOME;
  // static const HOME = _Paths.DASHBOARD + _Paths.HOME;
  // static const BOOKINGS = _Paths.DASHBOARD + _Paths.BOOKINGS;
  // static const CALENDER = _Paths.DASHBOARD + _Paths.CALENDER;
  // static const INBOX = _Paths.DASHBOARD + _Paths.INBOX;
  // static const PROFILE = _Paths.DASHBOARD + _Paths.PROFILE;
  // static const LOGIN = _Paths.LOGIN;
  // static const SIGNUP = _Paths.SIGNUP;
  // static const EMAIL_LOGIN = _Paths.LOGIN + _Paths.EMAIL_LOGIN;
  // static const ACCOUNT_SETUP = _Paths.ACCOUNT_SETUP;
  static const FORGET_PASSWORD =
      _Paths.LOGIN + _Paths.EMAIL_LOGIN + _Paths.FORGET_PASSWORD;
  static const UPCOMING = _Paths.DASHBOARD + _Paths.BOOKINGS + _Paths.UPCOMING;
  static const CANCELLED =
      _Paths.DASHBOARD + _Paths.BOOKINGS + _Paths.CANCELLED;
  static const COMPLETED =
      _Paths.DASHBOARD + _Paths.BOOKINGS + _Paths.COMPLETED;
  static const CHATS = _Paths.DASHBOARD + _Paths.INBOX + _Paths.CHATS;
  static const CALLS = _Paths.DASHBOARD + _Paths.INBOX + _Paths.CALLS;
  static const USER_CHAT =
      _Paths.DASHBOARD + _Paths.INBOX + _Paths.CHATS + _Paths.USER_CHAT;
  static const USER_CALL =
      _Paths.DASHBOARD + _Paths.INBOX + _Paths.CALLS + _Paths.USER_CALL;
  static const EDIT_PROFILE_SETTING =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.EDIT_PROFILE_SETTING;
  static const NOTIFICATION_SETTING =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.NOTIFICATION_SETTING;
  static const PAYMENT_SETTING =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.PAYMENT_SETTING;
  static const SECURITY_SETTING =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.SECURITY_SETTING;
  static const LANGUAGE_SETTING =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.LANGUAGE_SETTING;
  static const PRIVACY_POLICY =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.PRIVACY_POLICY;
  static const HELP_CENTER =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.HELP_CENTER;
  static const CUSTOMER_SERVICE =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.CUSTOMER_SERVICE;
  static const LOGOUT = _Paths.DASHBOARD + _Paths.PROFILE + _Paths.LOGOUT;
  static const INVITE_FRIEND =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.INVITE_FRIEND;
  static const FAQ =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.HELP_CENTER + _Paths.FAQ;
  static const CONTACT_US = _Paths.DASHBOARD +
      _Paths.PROFILE +
      _Paths.HELP_CENTER +
      _Paths.CONTACT_US;
  static const REPARING = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.REPARING;
  static const PAINTING = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.PAINTING;
  static const LAUNDRY = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.LAUNDRY;
  static const APPLIANCE = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.APPLIANCE;
  static const PLUMBING = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.PLUMBING;
  static const SHIFTING = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.SHIFTING;
  static const START_EARNING = _Paths.DASHBOARD + _Paths.START_EARNING;

  static const ABOUT_MATADATA =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.ABOUT_MATADATA;

  static const USER_PROFILE =
      _Paths.DASHBOARD + _Paths.PROFILE + _Paths.USER_PROFILE;
  static const TAILOR = _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.TAILOR;
  static const MEN_SALON = _Paths.USER +
      _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.MEN_SALON;
  static const PEST_CONTROL = _Paths.USER +
      _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.PEST_CONTROL;
  static const HANDYMAN = _Paths.USER +
      _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.HANDYMAN;
  static const SPA = _Paths.USER +
      _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.SPA;
  static const WOMEN_SALON = _Paths.USER +
      _Paths.DASHBOARD +
      _Paths.HOME +
      _Paths.ALL_SERVICES +
      _Paths.SELECTED_CATEGORY +
      _Paths.CATEGORY_ITEM +
      _Paths.WOMEN_SALON;
}

abstract class _Paths {
  _Paths._();

  static const USER = '/user';
  static const DASHBOARD = '/dashboard';
  static const WELCOME = '/welcome';
  static const HOME = '/home';
  static const BOOKINGS = '/bookings';
  static const CALENDER = '/calender';
  static const INBOX = '/inbox';
  static const PROFILE = '/profile';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const EMAIL_LOGIN = '/email-login';
  static const ACCOUNT_SETUP = '/account-setup';
  static const NOTIFICATION = '/notification';
  static const BOOKMARK = '/bookmark';
  static const SPECIAL_OFFERS = '/special-offers';
  static const POPULAR_SERVICES = '/popular-services';
  static const ALL_SERVICES = '/all-services';
  static const SELECTED_CATEGORY = '/selected-category';
  static const CATEGORY_ITEM = '/category-item';
  static const BOOKING = '/booking';
  static const FORGET_PASSWORD = '/forget-password';
  static const UPCOMING = '/upcoming';
  static const CANCELLED = '/cancelled';
  static const COMPLETED = '/completed';
  static const CHATS = '/chats';
  static const CALLS = '/calls';
  static const USER_CHAT = '/user-chat';
  static const USER_CALL = '/user-call';
  static const EDIT_PROFILE_SETTING = '/edit-profile-setting';
  static const NOTIFICATION_SETTING = '/notification-setting';
  static const PAYMENT_SETTING = '/payment-setting';
  static const SECURITY_SETTING = '/security-setting';
  static const LANGUAGE_SETTING = '/language-setting';
  static const PRIVACY_POLICY = '/privacy-policy';
  static const HELP_CENTER = '/help-center';
  static const CUSTOMER_SERVICE = '/customer-service';
  static const LOGOUT = '/logout';
  static const INVITE_FRIEND = '/invite-friend';
  static const FAQ = '/faq';
  static const CONTACT_US = '/contact-us';
  static const REPARING = '/reparing';
  static const PAINTING = '/painting';
  static const LAUNDRY = '/laundry';
  static const APPLIANCE = '/appliance';
  static const PLUMBING = '/plumbing';
  static const SHIFTING = '/shifting';
  static const START_EARNING = '/start-earning';
  static const ABOUT_MATADATA = '/about-matadata';
  static const USER_PROFILE = '/user-profile';
  static const TAILOR = '/tailor';
  static const MEN_SALON = '/men-salon';
  static const PEST_CONTROL = '/pest-control';
  static const HANDYMAN = '/handyman';
  static const SPA = '/spa';
  static const WOMEN_SALON = '/women-salon';
}
