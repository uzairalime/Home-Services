// class MyBookingController extends GetxController {
//   deo.Dio dio = deo.Dio();
//
//   Future<List<MyServicesBookingModel>> fetchData() async {
//     dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
//
//     try {
//       var response =
//           await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.USER_BOOKING);
//       if (response.statusCode == 200) {
//         // Parse the response data into a list of Booking objects
//         List<dynamic> jsonData = response.data;
//         List<MyServicesBookingModel> bookings = jsonData
//             .map((data) => MyServicesBookingModel.fromJson(data))
//             .toList();
//         return bookings;
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }
// }
