// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';


import 'package:employe/untils/exports.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController {
  final apiService = Get.put(ApiService());
  @override
  void onInit() {
   

    super.onInit();
  }

//// Login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Login API
var loginData = {}.obs;
var loginloading = false.obs;

Future<void> login(Map payload) async {
  loginloading(true);
  try {
    var response = await apiService.postAuthRequest(
        endpoint: "Employee/Login", payload: payload);
    var data = response;
    print(response);

    if (data["success"] == false) {
      String errorMessage = data["message"] ?? "Unknown error occurred.";
      
      // Additional specific error handling based on response codes
      if (data["message"] != null) {
        // Customize error message based on specific error codes
        switch (data["message"]) {
          case "INVALID_CREDENTIALS":
            errorMessage = "Invalid email or password.";
            break;
          case "ACCOUNT_LOCKED":
            errorMessage = "Your account has been locked.";
            break;
          default:
            errorMessage = "An error occurred. Please try again.";
        }
      }
      
      Get.snackbar(
        "Login",
        errorMessage,
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      loginData.value = data;

      await UserSimplePreferences.setLoginStatus(loginStatus: true);
      UserSimplePreferences.setToken(token: data["token"].toString());
      Get.toNamed(kHomePage);
      emailController.clear();
      passwordController.clear();
    }
  } catch (e) {
    String errorMessage = "INVALID CREDENTIALS";
    
    // if (e is TimeoutException) {
    //   errorMessage = "The request timed out. Please try again.";
    // } else if (e is SocketException) {
    //   errorMessage = "No internet connection. Please check your connection.";
    // } else {
    //   errorMessage = "${e}";
    // }

    Get.snackbar(
      "Login",
      errorMessage,
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    loginloading(false);
  }
}


}
