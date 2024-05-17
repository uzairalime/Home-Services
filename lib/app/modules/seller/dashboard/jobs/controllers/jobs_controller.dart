import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:intl/intl.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../services/apis/api_endpoints.dart';

class JobsController extends GetxController {
  static JobsController get to => Get.find<JobsController>();
  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  final isAtStart = true.obs;
  final isAtEnd = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    isAtStart.value = scrollController.position.pixels ==
        scrollController.position.minScrollExtent;
    isAtEnd.value = scrollController.position.pixels ==
        scrollController.position.maxScrollExtent;
  }

  void scrollBack() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollForward() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  ///////
  deo.Dio dio = deo.Dio();
  List<String> status = [
    "Pending",
    "Accepted",
    "Started",
    "Canceled",
    "Rejected",
  ];
  List<String> dialogStatus = [
    "Pending",
    "Accepted",
    "Started",
    "Canceled",
    "Rejected",
    "Completed"
  ];

  var selectedStatus = 'Pending'.obs;

  void toggleSelection(String status) {
    if (selectedStatus.value != status) {
      selectedStatus.value = status;
      update();
    }
  }

  /////////////
  Future<List<MyServicesBookingModel>> fetchCompletedJobs() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response = await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.JOBS);
      if (response.statusCode == 200) {
        // Parse the response data into a list of Booking objects
        List<dynamic> jsonData = response.data;
        List<MyServicesBookingModel> bookings = jsonData
            .map((data) => MyServicesBookingModel.fromJson(data))
            .toList();
        return bookings
            .where((booking) => booking.status == 'completed')
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<MyServicesBookingModel>> fetchFilteredJobs() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response = await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.JOBS);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<MyServicesBookingModel> bookings = jsonData
            .map((data) => MyServicesBookingModel.fromJson(data))
            .toList();
        return bookings
            .where((booking) => booking.status == selectedStatus.toLowerCase())
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    } finally {}
  }

  Future<void> updateBookingStatus(
      {required String status, required int jobId, cancel = false}) async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    print(status);
    try {
      var response = await dio.patch(
          "${ApiEndpoints.BASEURL + ApiEndpoints.JOBS}$jobId/",
          data: {"status": status.toString().toLowerCase(), "cancel": true});
      if (response.statusCode == 200) {
        await fetchFilteredJobs();
        showSnackBar("Booking $status");
      } else {
        showSnackBar("unable to change status", true);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      showSnackBar("Something went wrong", true);

      throw Exception('Error fetching data: $e');
    }
  }
}

List<MyServicesBookingModel> sortBookingsByStartAt(
    List<MyServicesBookingModel> bookings) {
  bookings.sort((a, b) {
    // Put large IDs at the top
    if (a.id > b.id) {
      return -1;
    } else if (a.id < b.id) {
      return 1;
    } else {
      return 0;
    }
  });

  return bookings;
}

String formatTime(String time24Hour) {
  // Split the time string by ":"
  List<String> parts = time24Hour.split(":");

  // Get the hour part
  int hour = int.parse(parts[0]);

  // Determine AM/PM
  String period = hour < 12 ? 'AM' : 'PM';

  // Convert hour to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  return "$hour$period";
}

String formatDate(String dateString) {
  // Parse the date string to DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Convert the DateTime to the desired format
  String formattedDate = DateFormat('EEEE, MMM dd').format(dateTime);

  return formattedDate;
}

// Future<List<MyServicesBookingModel>> fetchUpcomingJobs() async {
//   dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
//
//   try {
//     var response = await dio.get("https://homebrigadier.fly.dev/api/jobs/");
//     if (response.statusCode == 200) {
//       // Parse the response data into a list of Booking objects
//       List<dynamic> jsonData = response.data;
//       List<MyServicesBookingModel> bookings =
//           jsonData.map((data) => MyServicesBookingModel.fromJson(data)).toList();
//       return bookings.where((booking) => booking.status == 'pending').toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     throw Exception('Error fetching data: $e');
//   }
// }
