// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static const String BASEURL = kReleaseMode
      ? "https://prod-gotalented.fly.dev/api/"
      : "https://homebrigadier.fly.dev/api/";

  static const String IMGBASE = kReleaseMode
      ? "https://prod-gotalented.fly.dev"
      : "https://homebrigadier.fly.dev";
  static const String SERVICE = "service/";
  static const String CATEGORY = "service/category/";

  static const String GENERATE_OTP = "generate-otp/";
  static const String IM = "iam/";
  static const String JOBS = "jobs/";
  static const String METADATA = "metadata/";

  static const String FILE = "file/";
  static const String SERVICE_FILE = "service/file/";

  static const String SINGLE_SERVICE = "service/";

  static const String STRIPE = "stripe/webhook/";
  static const String TOKEN = "token/";
  static const String RERESH_TOKEN = "token/refresh/";
  static const String UPDATE_MODILE = "update-mobile/";

  static const String USER_BOOKING = "user/booking/";

  static const String USER_SINGLE_BOOKING = "user/booking/";
  static const String PATCH_USER_SINGLE_BOOKING = "user/booking/";

  // SEE SWAGGER
  static const String POST_USER_SINGLE_BOOKING =
      "user/booking/ID/payment-sheet/";

  static const String USER_OFFER = "user/offer/";
  static const String USER_SERVICE = "user/service/";
  static const String SINGLE_USER_SERVICE = "user/service/";

  static const String VARIFY_UPDATE_MOBILE = "user/service/";
}
