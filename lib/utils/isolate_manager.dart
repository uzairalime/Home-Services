import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';

import '../model/refresh_token_model.dart';

class IsolateManager {
  static final Dio _dio = Dio();
  static late Timer _timer;

  static Future<int> refreshToken() async {
    if (kDebugMode) {
      print("before refresh Token is ${StaticData.refreshToken}");
      print("token is being refreshed");
    }

    try {
      Map<String, dynamic> postData = {"refresh": StaticData.refreshToken};
      var response = await _dio.post(
        "https://homebrigadier.fly.dev/api/token/refresh/",
        data: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var data = RefreshTokenModel.fromJson(response.data);
        if (data.refresh != null || data.refresh != '') {
          print("Dio refresh response : ${data.refresh}");
          await SharedPreference.storeToken(
            access: data.access,
            refresh: data.refresh,
          );
        }
        print("Now refreshed token is ${StaticData.refreshToken}");
        return 200;
      }
    } on SocketException {
      showSnackBar("Failed to Sign in: Check Internet Connection", true);
    } catch (e) {
      print("error :${e.toString()}");
    }
    return 401;
  }

  void isolateEntryPoint() {
    print("Isolate Entry Point");

    _timer = Timer.periodic(const Duration(minutes: 4), (_) async {
      await refreshToken();
    });
  }

  void terminateIsolate() {
    _timer.cancel();
  }
}
