// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:employe/Map/service_controller.dart';
import 'package:employe/untils/exports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
 


class Google_map extends StatefulWidget {
  const Google_map({super.key});

  @override
  State<Google_map> createState() => _Google_mapState();
}

class _Google_mapState extends State<Google_map> {
  ServiceController serviceController = Get.put(ServiceController());
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  String? _currentAddress;
  var isLoading = "none";
  bool isPermissionGiven = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndFetchLocation();
    });
  }

  /// **Check if permission is given, if not, fetch location**
  void _checkAndFetchLocation() {
    if (serviceController.address.value.isEmpty || serviceController.position == null || !isPermissionGiven) {
      _getCurrentLocation();
    }
  }

  /// **Get current location**
  void _getCurrentLocation() async {
    setState(() {
      isLoading = "started";
    });

    Position? position = await _determinePosition();

    if (position != null) {
      setState(() {
        serviceController.position = position;
        serviceController.latittude = position.latitude;
        serviceController.longitude = position.longitude;
        isPermissionGiven = true;
      });

      _getAddressFromLatLng(position);
    } else {
      debugPrint("Position is null, unable to fetch location.");
    }

    setState(() {
      isLoading = "ended";
    });
  }

  /// **Determine the user's position**
  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Location services are disabled.");
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showMyDialog();
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Location permissions are permanently denied. Enable from settings.");
      return null;
    }

    try {
      Position positionData = await Geolocator.getCurrentPosition();
      serviceController.loacationIsEnabled(true);
      return positionData;
    } catch (e) {
      debugPrint("$e");
      serviceController.loacationIsEnabled(false);
      return null;
    }
  }

  /// **Show permission request dialog**
  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 350.h,
            width: double.infinity,
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text('Location Permission', style: TextStyle(color: KdarkText, fontSize: 14.sp, fontWeight: kFW900)),
                SizedBox(height: 8.h),
                Text(
                  'VIBHOHCM APP collects Your Location Info to MarkUp your Attendance',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: KdarkText, fontSize: kTenFont, fontWeight: kFW500),
                ),
                SizedBox(height: 15.h),
                Image.asset("assets/images/location.png", width: 150.w),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_OutlineButton(
                      borderRadius: BorderRadius.circular(15.r),
                      margin: EdgeInsets.all(10.r),
                      width: 110.w,
                      height: 35.h,
                      Color: Kgreen,
                      textColor: kblack,
                      fontSize: 12.sp,
                      fontWeight: kFW700,
                      label: "Cancel",
                      isLoading: false,
                      onTap: () {
                        setState(() {
                          isPermissionGiven = false;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    CustomButton(
                      borderRadius: BorderRadius.circular(15.r),
                      margin: EdgeInsets.all(10.r),
                      width: 110.w,
                      height: 35.h,
                   
                      textColor: kwhite,
                      fontSize: 12.sp,
                      fontWeight: kFW700,
                      label: "Accept",
                      isLoading: false,
                      onTap: () {
                        setState(() {
                          isPermissionGiven = true;
                        });
                        Navigator.of(context).pop();
                        _getCurrentLocation(); // Fetch location after accepting
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  /// **Convert Lat/Lon to Address**
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea} ${place.postalCode}';
          serviceController.address.value = _currentAddress!;
          serviceController.addressLatitude.value = position.latitude.toString();
          serviceController.addressLongitude.value = position.longitude.toString();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool locationEnabled = serviceController.loacationIsEnabled.value ?? false;
      Position? currentPosition = serviceController.position;

      if (isLoading == "ended" && isPermissionGiven && locationEnabled && currentPosition != null) {
        return GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          scrollGesturesEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      } else if (isLoading == "none") {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/locationBanner.png", fit: BoxFit.contain),
              Text("Location Loading...", style: TextStyle(color: Kgreen, fontSize: 20.sp, fontWeight: kFW900)),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText("Please wait until it loads...", textStyle: TextStyle(color: KText, fontSize: 15.sp, fontWeight: kFW900)),
                ],
              ),
            ],
          ),
        );
      } else {
        return Center(child: Image.asset("assets/images/nolocation.png", fit: BoxFit.contain));
      }
    });
  }
}
