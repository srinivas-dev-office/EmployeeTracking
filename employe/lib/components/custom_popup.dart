// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables



import '../untils/exports.dart';


class CustomLogout extends StatefulWidget {
  const CustomLogout({super.key});

  @override
  State<CustomLogout> createState() => _CustomLogoutState();
}

class _CustomLogoutState extends State<CustomLogout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are You Sure',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13.sp, fontWeight: kFW700, color: korange)),
      content: Text('You Want To LogOut?',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: kFW700,
              color: kblack)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); 
          },
          child: Text('No',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: kFW700, color: kblack)),
        ),
        TextButton(
          onPressed: () async {
        
            
            UserSimplePreferences.clearAllData();
            Get.offAllNamed(kLoginPage); 
            
          },
          child: Text('Yes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: kFW700, color: kblack)),
        )
      ],
    );
  }}
