// ignore_for_file: deprecated_member_use

import 'package:employe/Api_logics/Api_controllers/dashboard_controller.dart';
import 'package:employe/Screens/employe_checkin.dart';
import 'package:employe/untils/exports.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controller initialization
  Dashboardcontroller apicontroller = Get.put(Dashboardcontroller());

  @override
  void initState() {
    super.initState();
    apicontroller.getadminbyid();
  }

  // Logout action
  Future<bool> _logoutAction() async {
    return (await showDialog(
        context: context, builder: (context) => const CustomLogout()));
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Employe Tracking",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            _buildLogoutAction(),
            IconButton(
              onPressed: _logoutAction,
              icon: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kGreen, kgreen1, kgreen2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  // Handle back press with a custom exit message
  Future<bool> _onWillPop() async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);
    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      const message = 'Press back again to exit';
      Fluttertoast.showToast(
        msg: message,
        fontSize: kTwelveFont,
        textColor: kwhite,
        backgroundColor: kblack,
      );
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  // Logout button widget
  Widget _buildLogoutAction() {
    return GestureDetector(
      onTap: () {
        _logoutAction();
      },
      child: Text(
        "Logout",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  // Body widget
  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => apicontroller.adminbyidloading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildAdminDetails()),
    );
  }

  // Admin details widget
  Widget _buildAdminDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  _buildAdminInfoRow(
        //     "Company Name ", apicontroller.adminbyiddata["data"]["name"]),
        //      SizedBox(height: 5.h),
        // _buildAdminInfoRow(
        //     "Email Id ", apicontroller.adminbyiddata["data"]["email"]),
        // SizedBox(height: 5.h),
        // _buildAdminInfoRow("Mobile Number ",
        //     apicontroller.adminbyiddata["data"]["mobile_no"]),
        // SizedBox(height: 5.h),
        // Text(
        //   "Address : ",
        //   style: GoogleFonts.poppins(
        //     fontSize: 14.sp,
        //     fontWeight: kFW500,
        //     color: KText,
        //   ),
        // ),
        // SizedBox(height: 5.h),
        // Text(
        //   apicontroller.adminbyiddata["data"]["address"],
        //   style: GoogleFonts.poppins(
        //     fontSize: 14.sp,
        //     fontWeight: kFW600,
        //   ),
        // ),
        // SizedBox(height: 10.h),
        // Divider(height: 10.h),
        Login_time(),
        SizedBox(height: 10.h),
        _buildGrid(),
      ],
    );
  }

  // Admin info row widget
  Widget _buildAdminInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$label : ",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: kFW500,
            color: KText,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: kFW600,
          ),
        ),
      ],
    );
  }

  // Grid widget for actions
  Widget _buildGrid() {
    return 
    Column(
     
      children: [
        _buildGridButton('assets/images/register.png', 'Add Customer',
            () {
          Get.toNamed(kregister);
        }),
        _buildGridButton('assets/images/register.png', "Customers List",
            () {
          Get.toNamed(kcustomerlist);
        }),
     
      ],
    );
  }

  // Grid button widget
  Widget _buildGridButton(String imagePath, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
       // height: 45.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50.0,
              height: 50.0,
              color: kGreen,
            ),
            const SizedBox(height: 10.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: kFW700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
