import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/model/place_auto_complate_response.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/animation_dialog.dart';
import 'package:home_brigadier/utils/logger.dart';
import "package:http/http.dart" as http;

import '../../../../../generated/locales.g.dart';
import '../../../../../model/main.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  List<AutocompletePrediction> placeprediction = [];
  void placeAutoComplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com",
        "maps/api/place/autocomplete/json", {"input": query, "key": apiKey});
    String? response = await NetwordUtils.fetchUl(uri);
    if (response != null) {
      logger.d(response);
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placeprediction = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GetStorage storage = GetStorage();
    final address =
        storage.read("address") ?? BookingController.to.currentAddress;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: SvgPicture.asset(
              "assets/icons/location.svg",
              height: 16,
              width: 16,
              color: secondaryColor40LightTheme,
            ),
          ),
        ),
        title: Text(
          LocaleKeys.location_screen_set_loation.tr,
          style: const TextStyle(color: textColorLightTheme),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ),
          const SizedBox(width: defaultPadding)
        ],
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                onChanged: (value) {
                  placeAutoComplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: LocaleKeys.location_screen_search_your_loaction.tr,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset(
                      "assets/icons/location_pin.svg",
                      color: secondaryColor40LightTheme,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton.icon(
              onPressed: () {
                // add current location function
                BookingController.to.getCurrentPosition(context).then((value) {
                  Get.back();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AnimationDialog(
                            text: LocaleKeys
                                .location_screen_successfully_address_changed
                                .tr,
                          ));
                }).onError((error, stackTrace) {
                  showsnackbar(
                      LocaleKeys.location_screen_something_went_wrong.tr, true);
                });
              },
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 16,
              ),
              label:
                  Text(LocaleKeys.location_screen_use_my_current_loaction.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          placeprediction.isEmpty
              ? Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: Text(
                              LocaleKeys.location_screen_selected_loaction.tr),
                        )),
                    LocationListTile(
                      location: '${address}',
                      press: () {},
                    ),
                  ],
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: placeprediction.length,
                    itemBuilder: (context, index) {
                      return LocationListTile(
                        press: () {
                          Get.back();
                          BookingController.to.currentAddress.value =
                              placeprediction[index].description!;

                          GetStorage storage = GetStorage();
                          storage.write(
                              "address", placeprediction[index].description!);

                          Get.back();
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AnimationDialog(
                                    text: LocaleKeys
                                        .location_screen_successfully_address_changed
                                        .tr,
                                  ));

                          logger.d(placeprediction[index].description);
                        },
                        location: "${placeprediction[index].description}",
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: SvgPicture.asset("assets/icons/location_pin.svg"),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: secondaryColor5LightTheme,
        ),
      ],
    );
  }
}

const String apiKey = "AIzaSyCuC0N234IJDgCJLD6pV3YHBh0NcL29Tuw";

const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme = Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme = Color(0xFF202225);
const Color secondaryColor60LightTheme = Color(0xFF313336);
const Color secondaryColor40LightTheme = Color(0xFF585858);
const Color secondaryColor20LightTheme = Color(0xFF787F84);
const Color secondaryColor10LightTheme = Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme = Color(0xFFF8F8F8);

const defaultPadding = 16.0;

class NetwordUtils {
  static Future<String?> fetchUl(Uri uri, {Map<String, String>? header}) async {
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      logger.d(e.toString());
    }
    return null;
  }
}
