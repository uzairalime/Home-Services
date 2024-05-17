// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

import '../../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/laundry_controller.dart';

class LaundryBookingView extends GetView<LaundryController> {
  const LaundryBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    Get.put(LaundryController());
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Laundary Service',
          style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontSize: titlelarge,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: widht * 0.9,
              child: const CText(
                  textAlign: TextAlign.left,
                  text: 'Choose the size of house and color you want '),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: widht * 0.9,
              child: CText(
                textAlign: TextAlign.left,
                fontsize: titleMedium,
                text: 'Weight Total Clothing ',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: widht * 0.93,
              child: SizedBox(
                width: widht * 0.93,
                child: CTextField(
                  contentPadding: 15,
                  hint: '12',
                  suffix: Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: const CText(
                      text: 'KG',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: controller.weightcontroller,
                  borderColor: Colors.transparent,
                  borderRadius: 12,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: widht * 0.9,
              child: CText(
                textAlign: TextAlign.left,
                fontsize: titleMedium,
                text: 'Ironining Service ',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
                width: widht * 0.93,
                child: Obx(
                  () => Card(
                    elevation: 0,
                    color: AppColor.grey.withOpacity(0.1),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const CText(text: "Ironing Service"),
                      padding: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(12),
                      value: controller.selectedservice.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        controller.selectedservice.value = newValue!;
                      },
                      items: controller.serviceList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CText(text: value, color: txtTheme),
                        );
                      }).toList(),
                    ),
                  ),
                )),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: widht * 0.9,
              child: CText(
                textAlign: TextAlign.left,
                fontsize: titleMedium,
                text: 'Fragrance Service ',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
                width: widht * 0.93,
                child: Obx(
                  () => Card(
                    elevation: 0,
                    color: AppColor.grey.withOpacity(0.1),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const CText(text: "Fragrance Services"),
                      padding: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(12),
                      value: controller.fragranceservice.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        controller.fragranceservice.value = newValue!;
                      },
                      items: controller.fragranceList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CText(text: value, color: txtTheme),
                        );
                      }).toList(),
                    ),
                  ),
                )),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
                child: SizedBox(
              height: height * 0.1,
              width: widht,
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CButton(
                borderradius: widht * 0.075,
                text: "Continue - AED 0",
                shadow: true,
                fontWeight: FontWeight.bold,
                ontab: () => Get.to(() => BookingDetailsView()),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
