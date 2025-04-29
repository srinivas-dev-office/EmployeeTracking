import 'package:flutter/services.dart';
import 'package:employe/untils/exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiController apicontroller = Get.put(ApiController());

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _formKey = GlobalKey<FormState>();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = true;
    });
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(
            msg: message,
            fontSize: 12,
            textColor: kwhite,
            backgroundColor: kblack,
          );
          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Adjust layout when keyboard appears
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height, // Ensures Stack gets a defined height
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Image with additional margin and rounded corners
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/images/Logo.png",
                        width: screenWidth * 0.5,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.08),

                    // 'Login' heading
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.07,
                        fontWeight: kFW800,
                        color: kblack,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Custom divider with a soft effect
                    Divider(
                      color: kblack.withOpacity(0.1),
                      height: screenHeight * 0.002,
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Email TextField with more space and shadow effect
                    Customoutline(
                      controller: apicontroller.emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      onTap: () {},
                      maxLines: 1,
                      readOnly: false,
                      labelText: "Email id",
                      hintText: "Please enter your email id",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.03,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email id';
                        }
                        return null;
                      },
                     
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Password TextField with visibility toggle and shadow effect
                    Customoutline(
                      onTap: () {},
                      controller: apicontroller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscured,
                      maxLines: 1,
                      readOnly: false,
                      labelText: "Password",
                      hintText: "Enter your password",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.03,
                      ),
                      suffix: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.02),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: screenWidth * 0.05,
                            color: kblack,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                     
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Forgot Password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Add navigation or logic for forgot password here
                         // Get.toNamed(kForgotPasswordPage);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: kblack.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Login Button with a soft gradient effect
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        margin: EdgeInsets.zero,
                        height: 50.h,
                        textColor: kblack,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        fontSize: 16.sp,
                        fontWeight: kFW700,
                        label: "LOGIN",
                        isLoading: false,
                        // gradient: LinearGradient(
                        //   colors: [Color(0xFF4CAF50), Color(0xFF81C784)], // Soft gradient
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        onTap: () {
                          Get.toNamed(kHomePage);
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05), // Extra space for scrolling
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
