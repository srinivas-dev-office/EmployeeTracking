import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:employe/Api_logics/Api_controllers/dashboard_controller.dart';
import '../untils/exports.dart';

class UpdateDetails extends StatefulWidget {
  const UpdateDetails({super.key});

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  final Map<String, int> selectedMaterials = {};
  final Map<String, int> selectedPrices = {};
  final Map<String, String> selectedId = {};
  final Dashboardcontroller apiController = Get.put(Dashboardcontroller());
  bool isLoading = false;

  final Map<String, File?> selectedImages = {};
  final Map<String, File?> selectedWeight = {};
  final Map<String, String> base64Images = {};

  File? selectedDoc;
  List<Map<String, dynamic>> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    //_fetchProducts();
    _initializeData();
    // apiController.studentbyid();
    // apiController.studentinventorydata();
  }

  Future<void> _fetchProducts() async {
    try {
      await apiController.getAllproducts();
      final products = apiController.productsdata["data"];
      if (products is List) {
        final filteredProducts =
            products.where((product) => product["status"] == true).toList();
        setState(() {
          dropdownItems = filteredProducts.map((product) {
            return {
              "product_name": product["product_name"].toString(),
              "price": product["price"],
              "_id": product["_id"]
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> chooseImage(String selectedId) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          selectedImages[selectedId] = File(image.path);
          base64Images[selectedId] =
              base64Encode(File(image.path).readAsBytesSync());
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> chooseweight(String selectedId) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          selectedWeight[selectedId] = File(image.path);
          base64Images[selectedId] =
              base64Encode(File(image.path).readAsBytesSync());
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  Future<void> _initializeData() async {
  // Fetch the products and other API data initially
  await _fetchProducts();
  await apiController.studentbyid();
  await apiController.studentinventorydata();
}
Future<void> _reloadApiData() async {
  setState(() {
    isLoading = true; // Show loading indicator during API reload
  });
  await _initializeData();
  setState(() {
    isLoading = false; // Hide loading indicator after data is loaded
  });
}
  @override
  Widget build(BuildContext context) {
   Map<String, dynamic>? responseDataMap = Get.arguments?['responseData'];

  // Automatically reload the API if responseDataMap is null
  if (responseDataMap == null) {
    _reloadApiData(); // Reload API data
    return const Center(
      child: CircularProgressIndicator(), // Show loading while reloading data
    );
  }

  List<dynamic> responseData = responseDataMap.values.toList();

    return Scaffold(
      appBar: _buildAppBar(),
      bottomSheet: _buildUpdateButton(responseDataMap),
      body: responseData.isNotEmpty
          ? _buildContent(responseDataMap)
          : const Center(child: Text('No data available')),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Product Assign',
        style: GoogleFonts.poppins(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: ktitle,
        ),
      ),
    );
  }

  Widget _buildUpdateButton(Map<String, dynamic> responseData) {
    final bool isButtonEnabled =
        selectedId.isNotEmpty; // Check if at least one item is selected

    return CustomButton(
      margin: const EdgeInsets.all(15),
      height: 50.h,
      width: double.infinity,
      textColor: isButtonEnabled
          ? kwhite
          : Colors.grey, // Change text color based on the state
      // backgroundColor: isButtonEnabled ? kgreen : Colors.grey, // Change background color
      borderRadius: BorderRadius.circular(8.r),
      fontSize: 14.sp,
      fontWeight: kFW600,
      label: "Submit",
      isLoading: apiController.transactionloading.value,
      onTap: () {
        if (isButtonEnabled) {
          Map<String, dynamic> payload = {
            "driver_id": responseData["data"]["_id"],
            "driver_name": responseData["data"]["name"],
            "driver_email": responseData["data"]["email"],
            "driver_number": responseData["data"]["mobile_no"],
            "driver_gender": responseData["data"]["Gender"],
            "scale": selectedWeight,
            "image": selectedImages,
            "products": selectedMaterials.entries.map((entry) {
              var product = dropdownItems.firstWhere(
                (item) => item["product_name"] == entry.key,
                orElse: () => {},
              );

              return {
                "product_name": entry.key,
                "product_id": product["_id"],
                "quantity": entry.value,
                "price": selectedPrices[entry.key] ?? 0,
              };
            }).toList(),
          };

          // Navigate to the next page with payload
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoicePage(payload: payload),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Please select at least one material!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Kgreen,
            textColor: kblack,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  Widget _buildContent(Map<String, dynamic> responseData) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.r),
      child: Column(
        children: [
          _buildProfileImage(),
          SizedBox(height: 10.h),
          _buildStudentInfo(responseData),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.r),
      child: apiController.driveridData["data"] != null?
      CachedNetworkImage(
        imageUrl: apiController.driveridData["data"]["profile_pic"] ,
        height: 120.h,
        width: 120.w,
        fit: BoxFit.cover,
        placeholder: (_, __) => _buildPlaceholder(),
        errorWidget: (_, __, ___) => _buildPlaceholder(),
      ):_buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 120.w,
      height: 120.h,
      child: Icon(Icons.person,size: 100,),
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color:kgreen1 ),
      ),
    );
  }

  Widget _buildStudentInfo(Map<String, dynamic> responseData) {
    final studentData = responseData["data"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStudentName(studentData["name"] + studentData["surname"]),
        SizedBox(height: 20.h),
        _buildPersonalInfoSection(studentData),
        SizedBox(height: 20.h),
        _buildMaterialSelection(),
        if (selectedMaterials.isNotEmpty) ..._buildMaterialQuantityFields(),
      ],
    );
  }

  Widget _buildStudentName(String name) {
    return Center(
      child: Text(
        name,
        style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: kFW600,
          color: kdarkbrown,
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(Map<String, dynamic> studentData) {
    final personalDetails = {
      'Email id ': studentData["email"] ?? "Not available",
      'Mobile no ': studentData["mobile_no"] ?? "Not available",
      'Gender ': studentData["Gender"] ?? "Not available",
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kwhite,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: GoogleFonts.poppins(
              fontWeight: kFW600,
              fontSize: 14.sp,
              color: kdarkbrown,
            ),
          ),
          const Divider(),
          ...personalDetails.entries.map((entry) {
            return Text(
              '${entry.key}: ${entry.value}',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: kFW400,
                color: kblack,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

Widget _buildMaterialSelection() {
  return GestureDetector(
    onTap: _showMultiSelectDialog,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selectedMaterials.isEmpty
                  ? 'Select materials'
                  : selectedMaterials.keys.join(', '),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
              ),
              softWrap: true,  // Allow text to wrap
              overflow: TextOverflow.visible,  // Prevent text from being cut off
            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    ),
  );
}

  List<Widget> _buildMaterialQuantityFields() {
    return selectedMaterials.entries.map((entry) {
      return _buildMaterialQuantityField(entry.key, entry.value);
    }).toList();
  }

  Widget _buildMaterialQuantityField(String materialName, int quantity) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Kdarkgreen.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                materialName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //   Text(
              //     "(${selectedId[materialName]?.toString()} per unit price)",
              //  ),
              Text(
                "(R ${selectedPrices[materialName]?.toString()}/ per unit )",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: kblack.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          _buildQuantityInput(materialName, quantity),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(flex: 2, child: _buildDriverImage(materialName)),
              SizedBox(width: 10.w),
              Expanded(flex: 2, child: _buildweightImage(materialName)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuantityInput(String materialName, int quantity) {
    return TextFormField(
      initialValue: quantity.toString(),
      keyboardType: TextInputType.number,
      decoration:  InputDecoration(
        labelText: 'Enter quantity',
        border: const OutlineInputBorder(),
        suffixIcon: 
        Padding(
          padding: const EdgeInsets.only(top: 13,left: 10),
          child: Text("Kgs",style: TextStyle(fontSize: 14.sp,fontWeight: kFW700),),
        )
      ),
      
      onChanged: (materialValue) {
        setState(() {
          selectedMaterials[materialName] = int.tryParse(materialValue) ?? 0;
        });
      },
    );
  }

  Widget _buildDriverImage(String materialName) {
    return InkWell(
      onTap: () => chooseImage(selectedId[materialName] ?? ""),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          color: Kgreen,
          strokeWidth: 2,
          child: Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            child: selectedImages[selectedId[materialName]] != null
                ? Image.file(selectedImages[selectedId[materialName]]!,
                    fit: BoxFit.cover)
                : const Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }

  Widget _buildweightImage(String materialName) {
    return InkWell(
      onTap: () => chooseweight(selectedId[materialName] ?? ""),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          color: Kgreen,
          strokeWidth: 2,
          child: Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            child: selectedWeight[selectedId[materialName]] != null
                ? Image.file(selectedWeight[selectedId[materialName]]!,
                    fit: BoxFit.cover)
                : const Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }

  void _showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: dropdownItems.map((item) {
            return CheckboxListTile(
              title: Text(item["product_name"]),
              value: selectedMaterials.containsKey(item["product_name"]),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedMaterials[item["product_name"]] = 0;
                    selectedPrices[item["product_name"]] = item["price"];
                    selectedId[item["product_name"]] = item["_id"];
                  } else {
                    selectedMaterials.remove(item["product_name"]);
                    selectedPrices.remove(item["product_name"]);
                    selectedId.remove(item["product_name"]);
                  }
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
