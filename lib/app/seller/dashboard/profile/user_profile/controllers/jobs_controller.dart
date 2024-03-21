import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as deo;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';

class MyJobsController extends GetxController {
  deo.Dio dio = deo.Dio();

  Future<List<MyServicesBookingModel>> fetchCompletedJobs() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response = await dio.get("https://homebrigadier.fly.dev/api/jobs/");
      if (response.statusCode == 200) {
        // Parse the response data into a list of Booking objects
        List<dynamic> jsonData = response.data;
        log("Jobs ${jsonEncode(jsonData)}");
        List<MyServicesBookingModel> bookings =
            jsonData.map((data) => MyServicesBookingModel.fromJson(data)).toList();
        return bookings.where((booking) => booking.status == 'completed').toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<MyServicesBookingModel>> fetchUpcomingJobs() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response = await dio.get("https://homebrigadier.fly.dev/api/jobs/");
      if (response.statusCode == 200) {
        // Parse the response data into a list of Booking objects
        List<dynamic> jsonData = response.data;
        log("Jobs ${jsonEncode(jsonData)}");
        List<MyServicesBookingModel> bookings =
            jsonData.map((data) => MyServicesBookingModel.fromJson(data)).toList();
        return bookings.where((booking) => booking.status == 'pending').toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

List<MyServicesBookingModel> sortBookingsByStartAt(List<MyServicesBookingModel> bookings) {
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
