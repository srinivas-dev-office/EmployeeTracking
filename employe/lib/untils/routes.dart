import 'package:employe/untils/exports.dart';



class Routes {
  static List<GetPage<dynamic>> routes = [
     GetPage(
        name: kLoginPage,
        transition: Transition.rightToLeft,
        page: () =>  const LoginPage()),
         GetPage(
        name: KSplash,
        transition: Transition.rightToLeft,
        page: () =>  const SplashScreen()),
         GetPage(
        name: kHomePage,
        transition: Transition.rightToLeft,
        page: () =>  const Home()),
      
       
       
      GetPage(
        name: korderconform,
        transition: Transition.rightToLeft,
        page: () =>  const OrderConformation()),
        
          GetPage(
        name: kupdate,
        transition: Transition.rightToLeft,
        page: () =>   UpdateDetails() ),
          GetPage(
        name: kregister,
        transition: Transition.rightToLeft,
        page: () =>   RegisterPage() ),
         GetPage(
        name: kcustomerlist,
        transition: Transition.rightToLeft,
        page: () =>   CustomersList() ),
         
       
         GetPage(
        name: Kinvoice,
        transition: Transition.rightToLeft,
        page: () =>   InvoicePage()),
         
  ];
}
