import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../widget/c_filled_btn.dart';
import '../../../../../../widget/c_icon_btn.dart';
import '../controllers/calender_controller.dart';

class CalenderView extends GetView<CalenderController> {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final height = MediaQuery.sizeOf(context).height;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final labelLarge = Theme.of(context).textTheme.labelLarge!.fontSize;
    final width = MediaQuery.sizeOf(context).width;
    return GetBuilder<CalenderController>(
        init: Get.put(CalenderController()),
        builder: (obj) {
          return Scaffold(
              appBar: AppBar(
                leading: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: AppColor.secondary),
                    child: SvgPicture.asset("assets/icons/ic_logo.svg")),
                title: CText(
                    text: "My Bookings",
                    fontWeight: FontWeight.bold,
                    color: txtTheme,
                    fontsize: mediaQueryHeight(context) * 0.025),
                actions: [
                  CIconBtn(
                      onPressed: () {},
                      child: SvgPicture.asset(
                          "assets/icons/ic_more_outlined.svg",
                          color: svgTheme))
                ],
              ),
              body: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: obj.today,
                            rowHeight: height * 0.043,
                            calendarStyle: const CalendarStyle(
                                cellMargin: EdgeInsets.all(4),
                                selectedTextStyle: TextStyle(
                                    fontSize: 13, color: AppColor.white),
                                defaultTextStyle: TextStyle(fontSize: 12)),
                            selectedDayPredicate: (day) =>
                                isSameDay(day, obj.today),
                            onDaySelected: (selectedDay, focusedDay) =>
                                obj.selectdate(selectedDay, focusedDay),
                            availableGestures: AvailableGestures.all,
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.9,
                          child: CText(
                            text: 'Service Booking (0)',
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                            fontsize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: mediaQueryHeight(context) * 0.012,
                              horizontal: mediaQueryWidth(context) * 0.05),
                          child: Row(children: [
                            Expanded(
                                child: Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/service_img.jpeg"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))))),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                              text: "Cleaning",
                                              fontsize: titleLarge),
                                          CText(
                                              text: "Jenny Wilson",
                                              fontsize: labelLarge,
                                              color: AppColor.grey),
                                          SizedBox(
                                              width: mediaQueryWidth(context) *
                                                  0.22,
                                              height:
                                                  mediaQueryHeight(context) *
                                                      0.035,
                                              child: CButton(
                                                ontab: () {},
                                                fontsize: labelLarge,
                                                text: "Upcoming",
                                                borderradius: 7,
                                              ))
                                        ]))),
                            Expanded(
                                child: CircleAvatar(
                                    backgroundColor:
                                        AppColor.grey.withOpacity(0.3),
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                            "assets/icons/ic_message.svg"))))
                          ]),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: mediaQueryHeight(context) * 0.012,
                              horizontal: mediaQueryWidth(context) * 0.05),
                          child: Row(children: [
                            Expanded(
                                child: Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/service_img.jpeg"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))))),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                              text: "Applience",
                                              fontsize: titleLarge),
                                          CText(
                                              text: "Alex Wilson",
                                              fontsize: labelLarge,
                                              color: AppColor.grey),
                                          SizedBox(
                                              width: mediaQueryWidth(context) *
                                                  0.22,
                                              height:
                                                  mediaQueryHeight(context) *
                                                      0.035,
                                              child: CButton(
                                                ontab: () {},
                                                fontsize: labelLarge,
                                                text: "Upcoming",
                                                borderradius: 7,
                                              ))
                                        ]))),
                            Expanded(
                                child: CircleAvatar(
                                    backgroundColor:
                                        AppColor.grey.withOpacity(0.3),
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                            "assets/icons/ic_message.svg"))))
                          ]),
                        ),
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.9,
                          child: CText(
                            text: 'You have no service booking',
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            fontsize: height * 0.02,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.9,
                          child: CText(
                            text:
                                "You don't have a service booking on this day",
                            fontsize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
