// ignore_for_file: must_be_immutable

import '../untils/exports.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  String labelText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  bool obscureText;
  Widget? prefix;
  dynamic keyboardType;
  dynamic onTap;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  // ignore: use_super_parameters
  CustomFormField({
    Key? key,
    this.keyboardType,
    this.prefix,
    this.focusNode,
    required this.maxLines,
    this.suffix,
    this.value,
    this.onChanged,
    this.onTap,
    this.contentPadding,
    this.validator,
    required this.readOnly,
    required this.labelText,
    this.controller,
    required this.obscureText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: onTap,
        controller: controller,
        maxLines: maxLines,
        focusNode: focusNode,
      
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: kFW600,
          color: kblack,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
            filled:true,
          fillColor: Colors.white,
          suffixIcon: suffix,
          prefixIcon: prefix,
          hintText: hintText,
          alignLabelWithHint: true,
          //make hint text
          hintStyle: GoogleFonts.poppins(
            color: kblack.withOpacity(0.5),
            fontSize: kTenFont,
            fontWeight: FontWeight.w600,
          ),

          //create lable
          labelText: labelText,
          //lable style
          labelStyle: GoogleFonts.poppins(
            color: kblack,
            fontSize: kTwelveFont,
            fontWeight: FontWeight.w800,
          ),
        ),
        validator: validator,
        onChanged: onChanged);
  }
}

//////////////////////////////////////Login Text form feild
class Customoutline extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  String labelText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  bool obscureText;
  Widget? prefix;
  dynamic keyboardType;
  dynamic onTap;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  // ignore: use_super_parameters
  Customoutline(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.maxLines,
      required this.obscureText,
      this.suffix,
      this.value,
      this.onChanged,
      this.onTap,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      required this.labelText,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: onTap,
        controller: controller,
        maxLines: maxLines,
        focusNode: focusNode,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: kFW600,
          color: kblack,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: Kgreen,

          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kblack, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          fillColor: kwhite,
          filled: true,
          suffixIcon: suffix,
          prefixIcon: prefix,
          hintText: hintText,
          alignLabelWithHint: true,
          //make hint text
          hintStyle: GoogleFonts.poppins(
            color: kblack.withOpacity(0.4),
            fontSize: kTenFont,
            fontWeight: FontWeight.w600,
          ),

          //create lable
          labelText: labelText,
          //lable style
          labelStyle: GoogleFonts.poppins(
            color: kblack,
            fontSize: kTenFont,
            fontWeight: FontWeight.w800,
          ),
        ),
        validator: validator,
        onChanged: onChanged);
  }
}

/////////////////////Create Student
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label; // Made nullable
  final String hintText;
  final dynamic validator;
  final dynamic contentPadding;
  final String labelText;
  final bool readOnly;
  final dynamic value;
  final dynamic focusNode;
  final int maxLines;
  final int? maxLength;
  final dynamic onChanged;
  final Widget? prefix;
  final dynamic keyboardType;
  final dynamic onTap;
  final bool isMandatory;
  final TextStyle? titleStyle;
  final Widget? suffix;

  CustomTextFormField({
    Key? key,
    this.keyboardType,
    this.prefix,
    this.focusNode,
    required this.labelText,
    this.label, // Label can be optional
    required this.maxLines,
    this.maxLength,
    required this.isMandatory,
    this.suffix,
    this.titleStyle,
    this.value,
    this.onChanged,
    this.onTap,
    this.contentPadding,
    this.validator,
    required this.readOnly,
    this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Render label only if it is not null or empty
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: ktitle,
            ),
          ),
          SizedBox(height: 2.h),
        ],
        TextFormField(
          onTap: onTap,
          maxLines: maxLines,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: titleStyle ??
              GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ktitle,
              ),
          maxLength: maxLength,
          decoration: InputDecoration(
            focusColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 10.0,
            ),
            border: OutlineInputBorder(
              borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: kblack.withOpacity(0.3), width: 0.4),
              borderRadius: BorderRadius.circular(6.r),
            ),
            fillColor: kwhite,
            filled: true,
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            alignLabelWithHint: false,
            hintStyle: GoogleFonts.poppins(
              color: kblack.withOpacity(0.4),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            label: RichText(
              text: TextSpan(
                text: labelText,
                style: GoogleFonts.poppins(
                  color: kblack.withOpacity(0.7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: isMandatory
                    ? [
                        TextSpan(
                          text: ' *',
                          style: GoogleFonts.poppins(
                            color: Kred, // Color for the asterisk
                            fontSize: 14,
                          ),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
class CustomlabelformField extends StatelessWidget {
  TextEditingController? controller;
String label;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  int? maxLength;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  dynamic onTap;
  bool isMandatory;
  final TextStyle? titleStyle;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  // ignore: use_super_parameters
  CustomlabelformField(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
            required this.label,
      
      required this.maxLines,
      this.maxLength,
      required this.isMandatory,
      this.suffix,
      this.titleStyle,
      this.value,
      this.onChanged,
      this.onTap,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      this.controller,
      required this.hintText})
      : super(key: key);
  bool isRequired = true;

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: 
                GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: kFW700,
                  color: ktitle,
                ),),
                SizedBox(height: 2.h),
        TextFormField(
            onTap: onTap,
            maxLines: maxLines,
            focusNode: focusNode,
            keyboardType: keyboardType,
            style: titleStyle ??
                GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: kFW600,
                  color: ktitle,
                ),
                maxLength: maxLength,
            decoration: InputDecoration(
              focusColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:kgrey, width: 0.4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              fillColor:kwhite,
              filled: true,
              suffixIcon: suffix,
              prefixIcon: prefix,
              hintText: hintText,
              alignLabelWithHint: false,
              hintStyle: GoogleFonts.poppins(
                color: kblack.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              
             
             
            ),
            validator: validator,
            onChanged: onChanged),
      ],
    );
  }
}