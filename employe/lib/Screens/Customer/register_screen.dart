import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:employe/untils/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class Framedata {
  String name = '';
  String mobilenumber = '';
  String emailAddress = '';
  String surname = '';
  String password = '';
  String age = '';
  String id = '';
  String address = '';
}

class _RegisterPageState extends State<RegisterPage> {
  final Framedata data = Framedata();
  final _formKey = GlobalKey<FormState>();

  File? selectedImage;
  File? selectedDoc;

  bool isLoading = false;

  String? _gender;
  String? selectedCategory;

  final _focusNodes = List.generate(9, (index) => FocusNode());

  void _hideKeyboard() => FocusScope.of(context).unfocus();

  Future<void> pickFile({required bool isDocument, required String type}) async {
    setState(() => isLoading = true);

    final picked = await ImagePicker().pickImage(
      source: type == "camera" ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );

    if (picked != null) {
      if (isDocument) {
        selectedDoc = File(picked.path);
      } else {
        selectedImage = File(picked.path);
      }
    }

    setState(() => isLoading = false);
  }

  Future<void> submitData() async {
    if (selectedImage == null || selectedDoc == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile image and document are mandatory')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      var uri = Uri.parse('https://frs-backend.vibhohcm.com/Drivers/Driversignup');
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer \${UserSimplePreferences.getToken()}",
        })
        ..fields['name'] = data.name
        ..fields['mobile_no'] = data.mobilenumber
        ..fields['email'] = data.emailAddress
        ..fields['Gender'] = _gender ?? ''
        ..fields['surname'] = data.surname
        ..fields['password'] = data.password
        ..fields['age'] = data.age
        ..fields['address'] = data.address
        ..fields['id_no'] = data.id;

      request.files.add(await http.MultipartFile.fromPath('profile_pic', selectedImage!.path));
      request.files.add(await http.MultipartFile.fromPath('id_document', selectedDoc!.path));

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client Registered Successfully')),
        );
      } else {
        final resStr = await response.stream.bytesToString();
        final resJson = jsonDecode(resStr);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resJson['message'] ?? 'An error occurred')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to the server')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: KgradientBlack, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Customer',
          style: GoogleFonts.inter(
            fontSize: kEighteenFont,
            fontWeight: kFW600,
            color: KgradientBlack,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kGreen, kgreen1, kgreen2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomSheet: CustomButton(
        margin: EdgeInsets.all(15),
        height: 50.h,
        width: double.infinity,
        textColor: kwhite,
        borderRadius: BorderRadius.circular(8.r),
        fontSize: 14.sp,
        fontWeight: kFW600,
        label: "SUBMIT",
        isLoading: isLoading,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            submitData();
          }
        },
      ),
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFormCard([
                  buildTextField(0, 'Client Name', (val) => data.name = val),
                  buildTextField(1, 'Company Name', (val) => data.surname = val),
                  buildTextField(2, 'Email ID', (val) => data.emailAddress = val, validator: emailValidator),
                  buildTextField(3, 'Mobile Number', (val) => data.mobilenumber = val, keyboardType: TextInputType.phone, maxLength: 10, prefix: Text('+91 ')),
                  CustomDropDown(
                    shouldValidate: true,
                    label: "Category",
                    isMandatory: true,
                    item: const ["Framer", "Retailer", "Distributor"],
                    value: selectedCategory,
                    onChanged: (value) => setState(() => selectedCategory = value),
                    hintText: 'Select Category',
                    validationMessage: 'Please select Category',
                  ),
                SizedBox(height: 14.h),
                  buildTextField(4, 'Address', (val) => data.address = val),
                  buildTextField(5, 'Description', (val) => data.address = val, maxLines: 4),
                ]),
                Text('Document Upload', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => pickFile(isDocument: true, type: 'gallery'),
                  child: DottedBorder(
                    color: kGreen,
                    strokeWidth: 2,
                    dashPattern: [6, 4],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: selectedDoc != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(selectedDoc!, fit: BoxFit.cover),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined, color: kGreen, size: 40),
                                SizedBox(height: 8),
                                Text("Tap to upload document", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget buildTextField(int index, String label, Function(String) onChanged,
      {TextInputType? keyboardType, int? maxLength, int maxLines = 1, Widget? prefix, String? Function(String?)? validator}) {
    return Column(
      children: [
        CustomTextFormField(
          isMandatory: true,
          focusNode: _focusNodes[index],
          onChanged: onChanged,
          hintText: label,
          labelText: label,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          prefix: prefix != null ? Padding(padding: EdgeInsets.only(left: 10,top: 12), child: prefix) : null,
          validator: validator ?? (val) => val!.isEmpty ? 'Please enter $label' : null,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
          readOnly: false,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  String? emailValidator(String? val) {
    if (val == null || val.isEmpty) return 'Please enter Email ID';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(val)) return 'Enter valid Email ID';
    return null;
  }
}