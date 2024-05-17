import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/booking_controller.dart';
import 'location_view.dart';

class BookingDetailsView extends GetView {
  final ServicesModel? model;
  const BookingDetailsView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    _picDateTime(context, 0);

    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(BookingController());
    controller.setServicesModel(model!);
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        BookingController.to.onClanederControllerClear();
      },
      child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                    top: BorderSide(
                  color: AppColor.greylight,
                ))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: CButton(
                text:
                    "${LocaleKeys.booking_detail_items_continue_button.tr} ${controller.total} AED",
                shadow: true,
                borderradius: widht * 0.075,
                fontWeight: FontWeight.bold,
                ontab: () {
                  _onButtonPress();
                },
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              LocaleKeys.booking_detail_items_booking_detail.tr,
              style: appbar,
            ),
          ),
          body: GetBuilder<BookingController>(
              init: BookingController(),
              builder: (obj) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widht * 0.05, vertical: height * 0.025),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: widht,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text:
                                LocaleKeys.booking_detail_items_select_date.tr,
                            fontWeight: bold4,
                            fontsize: 14,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TableCalendar(
                            firstDay: obj.start,
                            lastDay: obj.lastday,
                            focusedDay: obj.selectedDate,
                            rowHeight: height * 0.043,
                            calendarStyle: const CalendarStyle(
                                cellMargin: EdgeInsets.all(4),
                                selectedDecoration: BoxDecoration(
                                    color: AppColor.primary,
                                    shape: BoxShape.circle),
                                selectedTextStyle: TextStyle(
                                    fontSize: 13, color: AppColor.white),
                                defaultTextStyle: TextStyle(fontSize: 12)),
                            selectedDayPredicate: (day) =>
                                isSameDay(day, obj.selectedDate),
                            onDaySelected: (selectedDay, focusedDay) =>
                                obj.selectdate(selectedDay, focusedDay),
                            availableGestures: AvailableGestures.all,
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          CText(
                            text: LocaleKeys
                                .booking_detail_items_choose_start_time.tr,
                            fontWeight: bold6,
                            fontsize: 16,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          DefaultTabController(
                            length: generateTabs(
                                    model!.openingHours![0].fromHour,
                                    model!.openingHours![0].toHour)
                                .length,
                            initialIndex: 0,
                            animationDuration: const Duration(milliseconds: 3),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.04,
                                  child: ButtonsTabBar(
                                    onTap: (val) {
                                      _picDateTime(context, val);
                                    },
                                    radius: 35,
                                    buttonMargin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    contentPadding: const EdgeInsets.only(
                                        left: 18, right: 18, top: 0, bottom: 0),
                                    backgroundColor: AppColor.primary,
                                    borderWidth: 1,
                                    borderColor: AppColor.primary,
                                    unselectedBackgroundColor:
                                        Colors.transparent,
                                    unselectedLabelStyle: unselectedtab,
                                    unselectedBorderColor: AppColor.primary,
                                    labelStyle: selectedtab,
                                    tabs: generateTabs(
                                        model!.openingHours![0].fromHour,
                                        model!.openingHours![0].toHour),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  DateTime calculateSelectedTime(int index) {
    DateTime openingTime =
        DateTime.parse("2022-01-01 ${model!.openingHours![0].fromHour}");

    DateTime selectedTime = openingTime.add(Duration(minutes: 30 * index));

    return selectedTime;
  }

  List<Tab> generateTabs(String? fromHour, String? toHour) {
    if (fromHour == null || toHour == null) {
      // Handle the case where fromHour or toHour is null
      return [];
    }

    DateTime fromTime = DateTime.parse("2022-01-01 $fromHour");
    DateTime toTime = DateTime.parse("2022-01-01 $toHour");

    List<Tab> tabs = [];
    int intervals = 30; // 30 minutes interval

    for (DateTime time = fromTime;
        time.isBefore(toTime);
        time = time.add(Duration(minutes: intervals))) {
      tabs.add(
        Tab(
          text:
              "${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour < 12 ? 'AM' : 'PM'}",
        ),
      );
    }

    return tabs;
  }

  _onButtonPress() {
    Get.to(() => const LocationView());
  }

  _picDateTime(BuildContext context, int val) {
    DateTime selectedtime = calculateSelectedTime(val);

    DateTime selecteddate = BookingController.to.selectedDate;

    DateTime startdatetime = selecteddate.add(Duration(
        hours: selectedtime.hour,
        minutes: selectedtime.minute,
        seconds: selectedtime.second));

    DateTime enddatetime =
        startdatetime.add(Duration(hours: BookingController.to.hours.value));

    BookingController.to.setStartdatetime(startdatetime);
    BookingController.to.setEnddatetime(enddatetime);
  }
}
