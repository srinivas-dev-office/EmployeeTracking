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
  Dashboardcontroller apicontroller = Get.put(Dashboardcontroller());

  @override
  void initState() {
    super.initState();
    apicontroller.getadminbyid();
  }

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Employee Tracking",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: kFW700,
              color: kblack,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _logoutAction,
              icon:  Icon(Icons.logout, color: Kred.withOpacity(0.6)),
              tooltip: "Logout",
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
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [kGreen, kgreen1, kgreen2],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child:
                  _buildAdminDetails()),
            ),
          ),
        ),
      
    );
  }

  Future<bool> _onWillPop() async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);
    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      Fluttertoast.showToast(
        msg: 'Press back again to exit',
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

  Widget _buildAdminDetails() {
    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
       
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: kpuple,
              ),
            ),
            const SizedBox(width: 8),
            Text(
             "Srinivas Alathur !..",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Login_time(),
        const SizedBox(height: 20),
        _buildActionCards(),
      ],
    );
  }

  Widget _buildActionCards() {
    return Column(
      children: [
        _buildActionTile(
          iconPath: 'assets/images/register.png',
          label: 'Add Customer',
          onTap: () => Get.toNamed(kregister),
        ),
        const SizedBox(height: 16),
        _buildActionTile(
          iconPath: 'assets/images/register.png',
          label: 'Customers List',
          onTap: () => Get.toNamed(kcustomerlist),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  iconPath,
                  width: 40,
                  height: 40,
                  color: kGreen,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18, color: kGreen),
            ],
          ),
        ),
      ),
    );
  }
}
