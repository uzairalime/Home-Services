import 'package:dio/dio.dart' as deo;
import 'package:get/get.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';

class MyJobsController extends GetxController {
  deo.Dio dio = deo.Dio();

  Future<List<MyServicesBookingModel>> fetchJobs() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      var response = await dio.get("https://homebrigadier.fly.dev/api/jobs/");
      if (response.statusCode == 200) {
        // Parse the response data into a list of Booking objects
        List<dynamic> jsonData = response.data;
        List<MyServicesBookingModel> bookings =
            jsonData.map((data) => MyServicesBookingModel.fromJson(data)).toList();
        return bookings;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
