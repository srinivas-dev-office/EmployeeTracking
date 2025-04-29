import 'package:employe/untils/exports.dart';

class PendingTab extends StatefulWidget {
  const PendingTab({super.key});

  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: kwhite,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row (Name and Date)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bunty",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: kFW800,
                            color: KgradientBlack,
                          ),
                        ),
                        Text(
                          "29/04/2025",
                          style: GoogleFonts.inter(
                            fontSize: kTwelveFont,
                            fontWeight: kFW600,
                            color: KgradientBlack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Email and Phone Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Siva2004@gmail.com",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW500,
                                color: KgradientBlack,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "7878278282",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: const Color.fromARGB(255, 116, 227, 114),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 5),
                    // Retailer and Order Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Retailer",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW400,
                                color: korange,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "vibho technologies privated",
                              style: GoogleFonts.inter(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: KgradientBlack,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total Order Placed",
                              style: GoogleFonts.inter(
                                fontSize: kTenFont,
                                fontWeight: kFW400,
                                color: KgradientBlack,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: KgradientBlack,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Place Order Button
                    CustomButton(
                      margin: EdgeInsets.zero,
                      height: 45.h,
                      textColor: KgradientBlack,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      fontSize: 14.sp,
                      fontWeight: kFW700,
                      label: "Place Order",
                      isLoading: false,
                      onTap: () {
                        Get.toNamed(kupdate);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
