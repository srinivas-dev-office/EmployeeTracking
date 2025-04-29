import 'dart:convert';

import 'package:employe/untils/exports.dart';

class Dashboardcontroller extends GetxController {
  final apiService = Get.put(ApiService());
  @override
  void onInit() {
  getAllDrivers();

  getAllproducts();
  
    super.onInit();
  }


  // get adminbyiddata
 var adminbyidloading = false.obs; // Observable for loading state
  var adminbyiddata = {}.obs; // Observable for admin data

  

  // Method to get admin details by ID
  Future<void> getadminbyid() async {
    adminbyidloading(true); // Start loading

    try {
      // API request
      var response = await apiService.getRequest(endpoint: "Admins/getAdminById");

      if (response != null) {
        var data = jsonDecode(response);

        if (data != null && data["success"] == true) {
          adminbyiddata.value = data; // Update admin data
          debugPrint("Admin data fetched successfully: $data");
        } else {
          debugPrint("Failed to fetch admin data: ${data?['message']}");
        }
      } else {
        debugPrint("API response is null");
      }
    } catch (e) {
      debugPrint("Error fetching admin data: $e");
    } finally {
      // Ensure this happens outside the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        adminbyidloading(false); // Stop loading
      });
    }
  }


// get all Drivers
 var driversData = [].obs; // Observable list
var driversLoading = false.obs;

Future<void> getAllDrivers() async {
  driversLoading(true);

  try {
    var response = await apiService.getRequest(endpoint: "Drivers/getDrivers");
    debugPrint("API Response: $response");

    // Decode the JSON response
    var data = jsonDecode(response);

    if (data["success"] == true) {
      driversData.value = data["data"] ?? []; // Assign the list
    } else {
      debugPrint("Error: ${data["message"] ?? "Unknown error"}");
    }
  } catch (e) {
      debugPrint("Exception caught: $e");
  } finally {
    driversLoading(false);
  }
}
// get all Drivers by All
 var driversallData = {}.obs; 
var driversallLoading = false.obs;

Future<void> getDriversall() async {
  driversallLoading(true);

  try {
    var response = await apiService.getRequest(endpoint: "Drivers/getDrivers?all=true?active=true"); // Fix the typo in URL
    debugPrint("API Response: $response");

    // Decode the JSON response
    var data = jsonDecode(response);

    if (data["success"] == true) {
      driversallData.value = data; // Assign the list of drivers data
    } else {
      debugPrint("Error: ${data["message"] ?? "Unknown error"}");
    }
  } catch (e) {
    debugPrint("Exception caught: $e");
  } finally {
    driversallLoading(false); // Fix the typo here
  }
}


// get all Drivers
  var allstudentsData = {}.obs;

  var allstudentsloading = false.obs;

  Future<void> getAllstudents() async {
    allstudentsloading(true);

    try {
      var response =
          await apiService.getRequest(endpoint: "Students/getStudentsPics");
      var data = jsonDecode(response);
      allstudentsData.value = data;

      debugPrint(response);
      if (data["data"] == null) { 
      } else {
        allstudentsData.value = data;
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      allstudentsloading(false);
    }
  }

// get Driversbyid
  var driversbyidData = {}.obs;

  var driversbyidloading = false.obs;

  Future<void> studentbyid() async {
    driversbyidloading(true);

    try {
      var response = await apiService.postRequest(
          endpoint: "Students/faceID");
      var data = jsonDecode(response);
      driversbyidData.value = data;

      debugPrint(response);
      if (data["data"] == null) {
      } else {
        driversbyidData.value = data;
        //Get.toNamed(kupdate);
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      driversbyidloading(false);
    }
  }
  //////Diver Assign 
  
var assign = {}.obs;
var assignloading = false.obs;

Future<void> AssignDiver(String id) async {
  assignloading(true);
  try {
    var response = await apiService.postidRequest(
        endpoint: "Drivers/assignDriver?driver_id=$id");

    print("Final API Response: $response");

    if (response == null) {
      debugPrint("Error: API response is null");
      Get.snackbar("Error", "No response from server");
      return;
    }

    if (response["success"] == true) {
      driversallData.value = response;
       Get.snackbar("Assigned Sucessfully", response["message"] ?? " ",
         
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(kHomePage);
    } else {
      Get.snackbar("Assigned Failed", response["message"] ?? "Unknown error",
         
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    debugPrint("Exception: $e");
    Get.snackbar("Error", "An unexpected error occurred: $e");
  } finally {
    assignloading(false);
  }
}


//////////////////
var driveridData = {}.obs;
var driveridloading = false.obs;

Future<void> getdriverid(String id) async {
  driveridloading(true); 

  try {
   
    var response = await apiService.getRequest(
      endpoint: "Drivers/getDriverById?driver_id=$id",
    );
    var data = jsonDecode(response);  

    if (data["success"] == true) {
      driveridData.value = data;  

     
      if (data.containsKey("data") && data["data"] != null) {
        var driver = data["data"];  

        var profilePic = driver['profile_pic'];  
        if (profilePic != null && profilePic.isNotEmpty) {
          try {
            // Fetch the signed image URL
            var imageResponse = await apiService.getRequest(
              endpoint: "S3Image/getSignedImage?image=$profilePic",
            );

            var imageData = jsonDecode(imageResponse);
            if (imageData["success"] == true) {
              driver["profile_pic"] = imageData["image"];  
            } else {
              driver["profile_pic"] = ""; 
            }
          } catch (e) {
            debugPrint("Error fetching image URL: $e");
            driver["profile_pic"] = "";  
          }
        } else {
          driver["profile_pic"] = "";  
        }

        driveridData.value = data;  
      }
    } else {
      debugPrint("Failed to fetch driver data: ${data['message'] ?? 'Unknown error'}");
    }
  } catch (e) {
    debugPrint("Error fetching driver data: $e");
  } finally {
    driveridloading(false);  // Set loading to false after completion
  }
}




  // get School Inventory
  var productsdata = {}.obs;

  var productsloading = false.obs;

  Future<void> getAllproducts() async {
    productsloading(true);

    try {
      var response =
          await apiService.getRequest(endpoint: "Products/getProducts");
      var data = jsonDecode(response);
      productsdata.value = data;

      debugPrint(response);
      if (data["data"] == null) {
      } else {
        productsdata.value = data;
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      productsloading(false);
    }
  }
  // post createTransaction
  var createtransactiondata = {}.obs;

  var transactionloading = false.obs;

  Future<void> createtransaction(payload) async {
  transactionloading(true);

  try {
    var response = await apiService.postRequest(
      endpoint: "Transactions/createTransaction",
      payload: payload,
    );

   
    createtransactiondata.value = response;

    debugPrint(response.toString());
    if (response["success"] == true) {
      createtransactiondata.value = response;
     //Get.toNamed(korderconform);
    Get.toNamed(Kinvoice);
    }
  } catch (e) {
    debugPrint("$e");
  } finally {
    transactionloading(false);
  }
}


  // get School Inventory
  var studentinventorydata = {}.obs;

  var studentinventoryloading = false.obs;

  Future<void> getstudentinventory(String id) async {
    studentinventoryloading(true);

    try {
      var response =
          await apiService.getRequest(endpoint: "Inventory/getStudentInventory?Student_id=$id");
      var data = jsonDecode(response);
      studentinventorydata.value = data;

      debugPrint(response);
      if (data["data"] == null) {
      } else {
        studentinventorydata.value = data;
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      studentinventoryloading(false);
    }
  }
}
