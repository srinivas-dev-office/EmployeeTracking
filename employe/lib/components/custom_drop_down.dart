// ignore_for_file: unnecessary_const, must_be_immutable, use_super_parameters

import 'package:dropdown_button2/dropdown_button2.dart';

import '../untils/exports.dart';
class CustomDropDown extends StatelessWidget {
  String label;
  String hintText;
  bool isMandatory;
  List<String> item;
  dynamic onChanged;
  dynamic onSaved;
  dynamic value;
  dynamic validator;
  String validationMessage; // Custom validation message

  CustomDropDown({
    Key? key,
    this.validator,
    required this.label, // Add label back in
    required this.hintText,
    required this.isMandatory,
    this.onChanged,
    this.onSaved,
    this.value,
    required this.item,
    required this.validationMessage, // Custom validation message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        decoration: InputDecoration(
          focusColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  kblack.withOpacity(0.3), width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          fillColor: kwhite,
          filled: true,
          alignLabelWithHint: true,
          hintStyle: GoogleFonts.poppins(
            color: kblack,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        isExpanded: true,
        hint: isMandatory
            ? RichText(
                text: TextSpan(
                  text: hintText,
                  style: GoogleFonts.poppins(
                    color: kblack.withOpacity(0.7),
                    fontSize: 14.sp,
                    fontWeight: kFW500,
                  ),
                  children: isMandatory
                      ? [
                          TextSpan(
                            text: ' *',
                            style: GoogleFonts.poppins(
                              fontSize: kFourteenFont,
                              color: Kred,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ]
                      : [],
                ),
              )
            : Text(
                hintText,
                style: GoogleFonts.poppins(
                  color: kblack.withOpacity(0.7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
        items: item
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: kFW600),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return validationMessage; // Use the custom validation message
          }
          return null;
        },
        onChanged: onChanged,
        value: value,
        onSaved: onSaved,
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: kblack.withOpacity(0.6),
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 6),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
