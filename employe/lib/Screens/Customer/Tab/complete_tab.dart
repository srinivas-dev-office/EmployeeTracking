

import 'package:employe/untils/exports.dart';

class CompletedTab extends StatelessWidget {
  const CompletedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kwhite,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                 // height: 170.h,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), 
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Top Row
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 0.3, right: 0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan ID",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW500,
                                color: kgrey,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW800,
                                color: kActiveTabColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: Image.asset(
                              'assets/images/profile.png',
                              height: 50.h,
                            ),
                          ),

                          const SizedBox(
                              width: 8), 
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Siva Kumar",
                                style: GoogleFonts.inter(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW600,
                                  color: KdarkText,
                                ),
                              ),
                              Text(
                                "Checking ••8871",
                                style: GoogleFonts.inter(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW500,
                                  color: kgrey,
                                ),
                              )
                            ],
                          ),

                         const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "3yrs",
                                style: GoogleFonts.inter(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW600,
                                  color: KdarkText,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "8.5%",
                                style: GoogleFonts.inter(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW600,
                                  color: kgrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type of loan",
                                style: GoogleFonts.inter(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW400,
                                  color: kgrey,
                                ),
                              ),
                               SizedBox(
                        height: 3.h,
                      ),
                              Text(
                                "₹48,158.00",
                                style: GoogleFonts.inter(
                                  fontSize: kEighteenFont,
                                  fontWeight: kFW600,
                                  color: KdarkText,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  color: Kgreen, size: 18.sp),
                              SizedBox(width: 4.w),
                              Text(
                                "12-Apr-2023",
                                style: GoogleFonts.inter(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW400,
                                  color: Kgreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}