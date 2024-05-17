import 'package:dio/dio.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/logger.dart';

void handleError(dynamic error) {
  if (error is DioException) {
    if (error.response != null) {
      showSnackBar('HTTP Error ${error.response!.statusCode}: ${error.response!.statusMessage}');

      logger.d('HTTP Error ${error.response!.statusCode}: ${error.response!.statusMessage}');
    } else {
      showSnackBar('Network Error: ${error.message}', true);
      logger.d('Network Error: ${error.message}');
    }
  } else {
    showSnackBar('Unexpected Error: $error', true);
    logger.d('Unexpected Error:$error');
  }
}
