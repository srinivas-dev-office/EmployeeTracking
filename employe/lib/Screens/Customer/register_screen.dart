// ignore_for_file: unused_element, depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

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

  final _focusNodes = List.generate(8, (index) => FocusNode());

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
          "Authorization": "Bearer ${UserSimplePreferences.getToken()}",
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
        title: Text("Add Client", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
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
                CustomTextFormField(
                  isMandatory: true,
                  focusNode: _focusNodes[0],
                  onChanged: (val) => data.name = val,
                  hintText: "Name",
                  labelText: 'Name',
                  validator: (val) => val!.isEmpty ? 'Please enter name' : null,
                  maxLines: 1,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w), readOnly: false,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  isMandatory: true,
                  maxLines: 1,
                  focusNode: _focusNodes[1],
                  onChanged: (val) => data.surname = val,
                  hintText: "Company Name",
                  labelText: 'Company Name',
                  validator: (val) => val!.isEmpty ? 'Please enter company name' : null,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w), readOnly: false,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  isMandatory: true,
                  readOnly: false,
                  focusNode: _focusNodes[2],
                  onChanged: (val) => data.emailAddress = val,
                  hintText: "Email ID",
                  labelText: 'Email ID',
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter Email ID';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) return 'Enter valid Email ID';
                    return null;
                  },
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w), maxLines: 1,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  isMandatory: true,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  readOnly: false,
                  focusNode: _focusNodes[3],
                  onChanged: (val) => data.mobilenumber = val,
                  hintText: "Mobile Number",
                  labelText: 'Mobile Number',
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter mobile number';
                    if (!RegExp(r'^[0-9]+$').hasMatch(val) || val.length != 10) return 'Enter a valid 10-digit mobile number';
                    return null;
                  },
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Text("+91", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w), maxLines: 1,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  isMandatory: false,
                  focusNode: _focusNodes[4],
                  onChanged: (val) => data.address = val,
                  hintText: "Description",
                  labelText: 'Description',
                  maxLines: 4,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w), readOnly: false,
                ),
                SizedBox(height: 20.h),
                Text('Profile Image', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => pickFile(isDocument: false, type: 'gallery'),
                  child: DottedBorder(
                    color: Colors.grey,
                    dashPattern: [6, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: selectedImage != null
                          ? Image.file(selectedImage!, fit: BoxFit.cover)
                          : Icon(Icons.camera_alt, color: Colors.grey, size: 50),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text('Document Upload', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => pickFile(isDocument: true, type: 'gallery'),
                  child: DottedBorder(
                    color: Colors.grey,
                    dashPattern: [6, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: selectedDoc != null
                          ? Image.file(selectedDoc!, fit: BoxFit.cover)
                          : Icon(Icons.file_upload, color: Colors.grey, size: 50),
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
}
