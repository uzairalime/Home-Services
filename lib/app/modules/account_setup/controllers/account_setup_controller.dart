import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AccountSetupController extends GetxController {
  //TODO: Implement AccountSetupController
  TextEditingController namecontroller = TextEditingController();
  TextEditingController nicknamecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  TextEditingController emailcontrolller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  DateTime today = DateTime.now();
  selectdate(DateTime day, DateTime focusedDay) {
    today = day;
    update();
  }

  alertbox() {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      content: SizedBox(
        height: 400,
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: today,
          selectedDayPredicate: (day) => isSameDay(day, today),
          onDaySelected: (selectedDay, focusedDay) {
            selectdate(selectedDay, focusedDay);
            datecontroller.text = DateFormat('yyyy-MM-dd').format(selectedDay);
            Get.back();
          },
          availableGestures: AvailableGestures.all,
          headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> _pickedFile = Rx<XFile?>(null);

  XFile? get pickedFile => _pickedFile.value;
  String path = '';
  pickImage() async {
    _pickedFile.value = await _picker.pickImage(source: ImageSource.gallery);

    if (_pickedFile.value != null) {
      path = _pickedFile.value!.path;
      update();
      //print(path);
    }
  }
}
