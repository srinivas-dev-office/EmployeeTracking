import 'dart:async';

import 'package:employe/untils/exports.dart';


class OrderConformation extends StatefulWidget {
  const OrderConformation({super.key});

  @override
  State<OrderConformation> createState() => _OrderConformationState();
}

class _OrderConformationState extends State<OrderConformation> {
  @override
  void initState() {
    super.initState();
    
    Timer(Duration(seconds: 2), () {
      Get.offAllNamed(kHomePage); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Lottie.asset('assets/images/conform.json',height: 200.h),
        ),
      ),
    );
  }
}
