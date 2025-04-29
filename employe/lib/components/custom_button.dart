


// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_super_parameters, prefer_const_constructors

import '../untils/exports.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final bool isLoading;
 
  final VoidCallback? onTap;
  
  final dynamic Padding;

  const CustomButton({
    super.key,
    required this.label,
    required this.isLoading,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.textColor,
    this.fontSize,
    this.Padding,
    this.fontWeight,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [kGreen, kgreen1, kgreen2], // Define your colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
         
          borderRadius: borderRadius,
        ),
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  textColor ?? Colors.white,
                ),
              )
            : Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }
}



class Custom_OutlineButton extends StatelessWidget {
  String label;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  final Color;
  final textColor;
  var Padding;
  var margin;
  BorderRadiusGeometry? borderRadius;

  bool isLoading;
  dynamic onTap;

  Custom_OutlineButton({
    super.key,
    this.height,
    this.width,
    this.Padding,
    this.Color,
    this.textColor,
    this.margin,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    required this.label,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: Padding,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: kblack, width: 1)),
              
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: fontSize, color: textColor, fontWeight: fontWeight),
          ),
        ));
  }
}

class Custom_textButton extends StatelessWidget {
  String images;
  String label;
  dynamic onTap;

  Custom_textButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(images, width: 15.w),
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: kTwelveFont, fontWeight: kFW600, color: Kred))
        ],
      ),
    );
  }
}

class Custom_text extends StatelessWidget {
  String titlelabel;

  String sublabel;
  final TitleColor;
  final SubColor;
  final Titlefontsize;
  final Subfontsize;

  dynamic onTap;

  Custom_text({
    Key? key,
    required this.titlelabel,
    required this.sublabel,
    this.TitleColor,
    this.SubColor,
    this.Titlefontsize,
    this.Subfontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titlelabel,
            style: GoogleFonts.poppins(
                fontSize: Titlefontsize,
                fontWeight: kFW600,
                color: TitleColor)),
        SizedBox(
          height: 5.h,
        ),
        Text(sublabel,
            style: GoogleFonts.poppins(
                fontSize: Subfontsize, fontWeight: kFW900, color: SubColor))
      ],
    );
  }
}

class floatingAction_Button extends StatelessWidget {
  String label;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  final Color;
  final textColor;
  var Padding;
  var margin;
  BorderRadiusGeometry? borderRadius;
  dynamic icon;
  bool isMandatory;

  var onTap;

  var isLoading; // Added icon field

  floatingAction_Button({
    super.key,
    this.height,
    this.width,
    this.Padding,
    this.Color,
    this.textColor,
    this.margin,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    required this.label,
    required this.isLoading,
    required this.onTap,
    this.icon,
    required this.isMandatory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: Padding,
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Color, borderRadius: borderRadius),
        child: isLoading
            ? CircularProgressIndicator(
                color: textColor) // Add progress indicator for loading state
            : Row(
                mainAxisSize:
                    MainAxisSize.min, // Adjust spacing for icon and text
                children: [
                  isMandatory
                      ? Icon(
                          icon,
                          color: textColor,
                          size: 15,
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
