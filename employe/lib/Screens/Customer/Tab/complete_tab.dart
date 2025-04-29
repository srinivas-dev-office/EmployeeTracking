import 'package:employe/untils/exports.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  _CompletedTabState createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row with Name and Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Srinivas",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
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

                    // Second Row with Email and Phone Number
                    Row(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),

                    // Retailer and Order Info Row
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
                    const SizedBox(height: 5),

                    // Status Row
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: GoogleFonts.inter(
                            fontSize: kTwelveFont,
                            fontWeight: kFW600,
                            color: KgradientBlack,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: GoogleFonts.inter(
                            fontSize: kTwelveFont,
                            fontWeight: kFW600,
                            color: Colors.green, // Green color for completed status
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
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
