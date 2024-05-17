import 'package:dio/dio.dart' as deo;
import 'package:get/get.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../services/apis/api_endpoints.dart';

class MyBookingController extends GetxController {
  deo.Dio dio = deo.Dio();

  // Future<List<MyServicesBookingModel>> fetchData() async {
  //   dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
  //
  //   try {
  //     var response =
  //         await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.USER_BOOKING);
  //     if (response.statusCode == 200) {
  //       // Parse the response data into a list of Booking objects
  //       List<dynamic> jsonData = response.data;
  //       List<MyServicesBookingModel> bookings = jsonData
  //           .map((data) => MyServicesBookingModel.fromJson(data))
  //           .toList();
  //       return bookings;
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

  Future<List<MyServicesBookingModel>> fetchCompletedBookings() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response =
          await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.USER_BOOKING);
      if (response.statusCode == 200) {
        // Parse the response data into a list of Booking objects
        List<dynamic> jsonData = response.data;
        List<MyServicesBookingModel> bookings = jsonData
            .map((data) => MyServicesBookingModel.fromJson(data))
            .toList();
        return bookings
            .where((booking) => booking.status != 'pending')
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<MyServicesBookingModel>> fetchPendingBookings() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response =
          await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.USER_BOOKING);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        List<MyServicesBookingModel> bookings = jsonData
            .map((data) => MyServicesBookingModel.fromJson(data))
            .toList();
        return bookings
            .where((booking) => booking.status == "pending")
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    } finally {}
  }
}
