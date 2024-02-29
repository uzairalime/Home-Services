import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/consts/const.dart';
import 'package:home_brigadier/model/booking_response_model.dart';
import 'package:home_brigadier/model/post_booking_model.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/services/apis/api_helper.dart';
import 'package:home_brigadier/utils/animation_dialog.dart';
import 'package:home_brigadier/utils/dialog_helper.dart';

import '../../../../../../../../../utils/logger.dart';
import '../../../../../../../../routes/app_pages.dart';

class BookingController extends GetxController {
  static BookingController get to => Get.find();

  // cleaning services values=======================================
  var hours = 1.obs;
  var cleaner = 1.obs;
  RxString selectedweekplan = 'Once'.obs;
  TextEditingController instruction = TextEditingController();
  RxString selectedmaterial = 'Yes'.obs;

  //========

  TextEditingController addressController = TextEditingController();

  // Set<Marker> mapmarker = {};

  @override
  void onInit() {
    // mapmarker.add(
    //   const Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(25.168282, 55.250286),
    //   ),
    // );
    // moveCameraToLocation(const LatLng(25.168282, 55.250286));

    super.onInit();
  }

  Position? currentPosition;
  var currentAddress = "Dubai Airport Terminal 2 Departures".obs;

  DateTime selectedtime = DateTime.now();
  var s = "";
    DateTime start = DateTime.now();


  DateTime lastday = DateTime.now().add(const Duration(days: 365));
  ServicesModel? servicemodel;

  final ApiHelper _apiHelper = ApiHelper();

  // ====== google map show
  // GoogleMapController? mapController;
  // LatLng? latLng;
  // addlatlong(LatLng val) {
  //   latLng = val;
  // }

  void setServicesModel(ServicesModel model) {
    servicemodel = model;
    logger.d("service controller is ${model.name}");
  }

  var bedroom = 0.obs;
  var bathroom = 0.obs;
  var kitchen = 0.obs;
  var diningRoom = 0.obs;
  var garage = 0.obs;
  RxInt selectedRadio = 0.obs;
  var total = 0.obs;

  //======================

  DateTime selectedDate = DateTime.now();
  DateTime stardatetime = DateTime.now();
  DateTime enddatetime = DateTime.now();
  setStartdatetime(val) {
    stardatetime = val;
    logger.d("start datetime  is $stardatetime ");
  }

  setEnddatetime(val) {
    enddatetime = val;
    logger.d("end datetime  is $enddatetime");
  }

  //=======================

  // ==== booking response model

  ResponseBookingModel? responseBookingModel;

  void setSelectedRadio(int index) {
    selectedRadio.value = index;
  }

  var workingHour = 0.obs;

  hours_decrese() {
    if (hours > 0) {
      hours.value--;
    }
  }

  cleaner_decrese() {
    if (cleaner > 0) {
      cleaner.value--;
    }
  }

  void selectMaterials(String material) {
    selectedmaterial.value = material;
  }

  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }

  workinH_decr() {
    if (workingHour > 0) {
      workingHour.value--;
    }
  }

  selectdate(DateTime day, DateTime focusedDay) {
    selectedDate = day;

    logger.d("selected date $selectedDate");
    update();
  }

  onClanederControllerClear() {
    selectedDate = DateTime.now();

    
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      cPosition = "${currentPosition?.latitude}, ${currentPosition?.longitude}";
      currentPosition = position;
      logger.d("${position.latitude} ${position.longitude}");
      _getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });

    update();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    print("location call");
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress.value =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

      GetStorage storage = GetStorage();
      storage.write("address", currentAddress.value);

      logger.d("location is $currentAddress");
    }).catchError((e) {
      debugPrint(e);
    });
    update();
  }

  claculateBill() {
    // update();

    String? stringValue = servicemodel!.rate;
    double doubleValue = double.parse(stringValue!);
    int rate = doubleValue.toInt();

    final hour = hours.value;
    final cleaers = cleaner.value;
    final material = selectedmaterial.value;
    final bill =
        ((rate * hour) * cleaers) + (material == "Yes" ? (hour * 4) : 0);

    total.value = bill;
  }

  postbooking(PostBookingModel model, BuildContext context) async {
    DialogHelper.showLoading();

    await _apiHelper.post("user/booking/", model.toJson()).then((response) {
      DialogHelper.hideLoading();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AnimationDialog(
                text: 'Successfully Booking !',
              )).then((value) {
        Get.offNamed(Routes.DASHBOARD);
        instruction.clear();
      });
    });
  }

  // show googel map

  // void pickLocation(LatLng location) {
  //   mapmarker.clear();

  //   mapmarker.add(
  //     Marker(
  //       markerId: const MarkerId("1"),
  //       position: location,
  //     ),
  //   );

  //   latLng = location;
  //   moveCameraToLocation(location);
  //   update();
  // }

  // void moveCameraToLocation(LatLng location) {
  //   mapController?.animateCamera(CameraUpdate.newLatLng(location));
  //   // searchAddress(location);
  //   update();
  // }

  // Future<void> searchAddress(LatLng location) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       location.latitude,
  //       location.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;

  //       currentAddress.value =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

  //       addressController.text = currentAddress.value;
  //       logger.d("location is ${place.country}");
  //       update();
  //     } else {
  //       // Handle case where no placemarks are found
  //       print('No placemarks found for the given coordinates');
  //       update();
  //     }
  //   } catch (e) {
  //     // Handle any errors that might occur
  //     print('Error during reverse geocoding: $e');
  //     update();
  //   }
  // }

  clearONCleaningPageRemove() {
    hours.value = 1;
    cleaner.value = 1;
    total.value = 0;
    selectedweekplan.value = "Once";
    selectedmaterial.value = "Yes";
    instruction.clear();
  }
}
