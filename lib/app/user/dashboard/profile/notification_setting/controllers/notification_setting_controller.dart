import 'package:get/get.dart';

class NotificationSettingController extends GetxController {
  //TODO: Implement NotificationSettingController

  RxBool notification = false.obs;
  RxBool soundSwitch = false.obs;
  RxBool vibrationSwitch = false.obs;
  RxBool specialOfferSwitch = false.obs;
  RxBool promoDiscountSwitch = false.obs;
  RxBool paymentsSwitch = false.obs;
  RxBool cashbackSwitch = false.obs;
  RxBool appUpdatesSwitch = false.obs;
  RxBool newServicesSwitch = false.obs;
  RxBool newTipsSwitch = false.obs;

  void notifiSwitch({required String title, required bool value}) {
    switch (title) {
      case "General Notification":
        notification.value = value;
        break;
      case "Sound":
        soundSwitch.value = value;
        break;
      case "Vibration":
        vibrationSwitch.value = value;
        break;
      case "Special Offer":
        specialOfferSwitch.value = value;
        break;
      case "Promo % Discount":
        promoDiscountSwitch.value = value;
        break;
      case "Payments":
        paymentsSwitch.value = value;
        break;
      case "Cashback":
        cashbackSwitch.value = value;
        break;
      case "App Updates":
        appUpdatesSwitch.value = value;
        break;
      case "New Services Available":
        newServicesSwitch.value = value;
        break;
      case "New Tips Available":
        newTipsSwitch.value = value;
        break;
    }
  }
}
