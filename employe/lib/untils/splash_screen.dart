
import 'package:employe/Api_logics/Api_controllers/dashboard_controller.dart';
import 'package:employe/untils/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Dashboardcontroller apicontroller = Get.put(Dashboardcontroller());
  bool? isUserLoggedIn;
  @override
  void initState() {
    super.initState();

    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    Future.delayed(const Duration(seconds: 2), () {
      if (isUserLoggedIn != null && isUserLoggedIn == true) {
        Get.toNamed(kHomePage);
      } else {
        Get.toNamed(kLoginPage);
      }
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        body: Center(
            child: Image.asset(
          "assets/images/Logo.png",
          height: 200.h,
          width: 200.w,
          fit: BoxFit.cover,
        )));
  }
}
