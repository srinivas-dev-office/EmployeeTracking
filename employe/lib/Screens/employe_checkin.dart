// ignore_for_file: camel_case_types, unused_local_variable, unnecessary_string_interpolations, must_be_immutable, prefer_final_fields, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';


import 'package:employe/Map/google_map.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

import '../untils/exports.dart';

class Login_time extends StatefulWidget {
  Map? homedir;
  Login_time({super.key, this.homedir});

  @override
  State<Login_time> createState() => _LogintimeState();
}

class _LogintimeState extends State<Login_time> {
  ServiceController serviceController = Get.put(ServiceController());
  bool isLoading = false;

  File? selectedImage;

  String base64Image = "";
  ////////////////Image
  Future<void> chooseImage(type) async {
    setState(() {
      isLoading = true;
    });
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
      // var value = await Services.profileimage(File(image.path));
      // controller.profileImageData = value["msg"];
      // Fluttertoast.showToast(msg: value["msg"]);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm a').format(now);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: kwhite,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 6),
              color: KText.withOpacity(0.2),
            )
          ],
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: kwhite,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r)),
                child:  Google_map()),
          ),
          Container(
              padding: EdgeInsets.all(13.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                

                        "${TimeOfDay.fromDateTime(DateTime.now()).format(context)} ",
                        style: TextStyle(
                            fontSize: kEighteenFont,
                            fontWeight: kFW600,
                            color: KText),
                      ),
                      CustomButton(
                       // Color: korange,
                        fontWeight: kFW600,
                        fontSize: 13.sp,
                        padding:EdgeInsets.all(10) ,
                        borderRadius: BorderRadius.circular(5.r),
                        Padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 6.h, bottom: 6.h),
                        label: "Check In",
                        //  "Check-In",
                        textColor: kwhite,
                        isLoading: false,

                        onTap: ()  {
                           chooseImage("camera");
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(
                        width: 8.w,
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text:
                              "${DateFormat.MMMd().format(DateTime.now())} | ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW500,
                              color: ktitle),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${DateFormat.E().format(DateTime.now())} ',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: kFW500,
                                  color: ktitle),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      serviceController.address.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: kFW700, color: KText),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
