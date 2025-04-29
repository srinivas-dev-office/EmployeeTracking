import 'dart:convert';
import 'dart:io';

import 'package:employe/untils/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Assuming you're using ScreenUtil for responsive design
import 'package:get/get.dart'; // Assuming you're using GetX for navigation
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoicePage extends StatefulWidget {
  final Map<String, dynamic> payload;

  const InvoicePage({super.key, required this.payload});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  bool isPayOnlineLoading = false;

  @override
  Widget build(BuildContext context) {
    // Extracting values from the payload
    final String driverId = widget.payload["driver_id"];
    final String driverName = widget.payload["driver_name"];
    final String driverEmail = widget.payload["driver_email"];
    final String driverNumber = widget.payload["driver_number"];
    final String driverGender = widget.payload["driver_gender"];
    final List<dynamic> products = widget.payload["products"] ?? [];

    final double total = products.fold(
      0.0,
      (sum, product) => sum + (product["quantity"] * product["price"]),
    );

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isPayOnlineLoading?_buildLoadingSection():
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDriverInfo(driverName, driverEmail, driverNumber, driverGender),
            const SizedBox(height: 20),
            _buildProductTable(products),
            const SizedBox(height: 20),
            _buildTotalSection(total),
            const SizedBox(height: 20),
            _buildPaymentButtons(),
          ],
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.greenAccent, Colors.green[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          title: Text(
            "Payment Details",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  // Driver Info
  Widget _buildDriverInfo(String driverName, String driverEmail, String driverNumber, String driverGender) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kGreen.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}, Time: ${DateFormat('hh:mm a').format(DateTime.now())}"),
          _buildDriverDetailText(driverName),
          _buildDriverDetailText(driverEmail),
          _buildDriverDetailText(driverNumber),
          _buildDriverDetailText(driverGender),
        ],
      ),
    );
  }

  // Driver Detail Text Widget
  Widget _buildDriverDetailText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: kFW600),
    );
  }

  // Product Table
  Widget _buildProductTable(List<dynamic> products) {
    return Expanded(
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey[300]!, width: 1),
            verticalInside: BorderSide(color: Colors.grey[300]!, width: 1),
            bottom: BorderSide(color: Colors.grey[600]!, width: 2),
          ),
          columnWidths: const {
            0: FixedColumnWidth(110),
            1: FixedColumnWidth(60),
            2: FixedColumnWidth(80),
          },
          children: [
            _buildTableHeader(),
            ...products.map(_buildProductRow).toList(),
          ],
        ),
      ),
    );
  }

  // Table Header
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.7)),
      children:  [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Items', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Unit Cost", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp)),
        ),
      ],
    );
  }

  // Product Row
  TableRow _buildProductRow(dynamic product) {
    return TableRow(
      
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product['product_name'] ?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product['quantity'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${(product['quantity'] * product['price']).toStringAsFixed(0)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp)),
        ),
      ],
    );
  }

  // Total Section
  Widget _buildTotalSection(double total) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Total Amount :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
            "${total.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Payment Buttons
  Widget _buildPaymentButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPaymentButton("Pay on cash", onTapPayOnline, isPayOnlineLoading),
        CustomButton(
      margin: const EdgeInsets.all(15),
      height: 50.h,
      width: 150.w,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      label: "Pay Online",
      isLoading: false,
      onTap: (){}, // Disable the button while loading
    ),
        //_buildPaymentButton("Pay Online", onTapPayOnline, isPayOnlineLoading),
      ],
    );
  }

  // Payment Button
  Widget _buildPaymentButton(String label, VoidCallback onTap, bool isLoading) {
    return CustomButton(
      margin: const EdgeInsets.all(15),
      height: 50.h,
      width: 150.w,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      label: label,
      isLoading: isLoading,
      onTap: isLoading ? null : onTap, // Disable the button while loading
    );
  }
// Loading Section
  Widget _buildLoadingSection() {
    return 
    Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: 
      Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
         const  CircularProgressIndicator(color: kgreen1),
          const SizedBox(height: 15),
          Text(
            "Waiting...",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
           const SizedBox(height: 10),
          Text(
            "We are Uploading images, generating invoice...",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  void onTapPayOnline() async {
    setState(() {
      isPayOnlineLoading = true; // Start loading
    });

    final String driverId = widget.payload["driver_id"];
    final List<dynamic> products = widget.payload["products"];
    final Map weightImage = widget.payload["scale"];
    final Map productImage = widget.payload["image"];

    // Prepare the product list for sending
    List<Map<String, dynamic>> productList = products.map((product) {
      return {
        "product_id": product["product_id"],
        "product_name": product["product_name"],
        "quantity": product["quantity"],
        "price": product["price"],
      };
    }).toList();

    // API Request using MultipartRequest
    var uri = Uri.parse('https://employe-backend.vibhohcm.com/Transactions/createTransaction');
    var request = http.MultipartRequest('POST', uri);

    // Headers
    request.headers["Content-Type"] = 'application/json';
    request.headers["accept"] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${UserSimplePreferences.getToken()}';

    // Add fields to the request
    request.fields['driver_id'] = driverId;
    request.fields['products'] = json.encode(productList);
    request.fields['payment_method'] = "Cash";
    //"Online";
    request.fields['payment_status'] = "Done";

    // Weight images
    for (var entry in weightImage.entries) {
      var key = entry.key;
      var value = entry.value.path; // Get the actual file path
      var file = await http.MultipartFile.fromPath("${key}_scale", value);
      request.files.add(file);
    }

    // Product images
    for (var entry in productImage.entries) {
      var key = entry.key;
      var value = entry.value.path; // Get the actual file path
      var file1 = await http.MultipartFile.fromPath("${key}_image", value);
      request.files.add(file1);
    }

    try {
      // Send request
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle success
        Get.toNamed(korderconform); // Navigate on success
      } else {
        String responseBody = await response.stream.bytesToString();
        try {
          var errorResponse = jsonDecode(responseBody);
          String errorMessage = errorResponse['message'] ?? 'An error occurred';

          // Optionally show an error message
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
        } catch (jsonError) {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred')));
        }
      }
    } catch (e) {
      print('API Error: $e');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to connect to the server')));
    } finally {
      setState(() {
        isPayOnlineLoading = false; // Stop loading
      });
    }
  }
}
