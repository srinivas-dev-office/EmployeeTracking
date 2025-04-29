import 'package:employe/untils/exports.dart';
 
class UpdateDetails extends StatefulWidget {
  const UpdateDetails({super.key});
 
  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}
 
class _UpdateDetailsState extends State<UpdateDetails> {
  Map<String, int> selectedMaterials = {};
  Map<String, dynamic> selectedPrices = {};
  Map<String, dynamic> selectedId = {};
 
  List<Map<String, dynamic>> dropdownItems = [
    {"product_name": "Cement", "price": 300, "_id": "1"},
    {"product_name": "Sand", "price": 100, "_id": "2"},
    {"product_name": "Bricks", "price": 5, "_id": "3"},
  ];
 
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
 
    return Scaffold(
      appBar: AppBar(
       flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kGreen, kgreen1, kgreen2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        automaticallyImplyLeading: false,
       
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: KgradientBlack, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          ' Update',
          style: GoogleFonts.inter(
            fontSize: kEighteenFont,
            fontWeight: kFW600,
            color: KgradientBlack,
          ),
        ),
      
      ),
      backgroundColor: kwhite,
      body: 
     
          SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                 
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bunty",
                                  style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: kFW800,
                                      color: KgradientBlack)),
                              Text("29/04/2025",
                                  style: GoogleFonts.inter(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW600,
                                      color: KgradientBlack)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Siva Kumar",
                                    style: GoogleFonts.inter(
                                        fontSize: kFourteenFont,
                                        fontWeight: kFW600,
                                        color: KdarkText)),
                                Text("Siva2004@gmail.com",
                                    style: GoogleFonts.inter(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW500,
                                        color: KgradientBlack)),
                              ],
                            ),
                            const Spacer(),
                            Text("7878278282",
                                style: GoogleFonts.inter(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: const Color.fromARGB(255, 116, 227, 114))),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        const Divider(),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Retailer",
                                    style: GoogleFonts.inter(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW400,
                                        color: korange)),
                                SizedBox(height: 3.h),
                                Text("vibho technologies privated",
                                    style: GoogleFonts.inter(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: KgradientBlack)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total Order Placed",
                                    style: GoogleFonts.inter(
                                        fontSize: kTenFont,
                                        fontWeight: kFW400,
                                        color: KgradientBlack)),
                                SizedBox(width: 4.w),
                                Icon(Icons.shopping_bag_outlined,
                                    color: KgradientBlack, size: 18.sp),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
               
                       
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                   _buildMaterialSelection(),
                        ..._buildMaterialQuantityFields(),
               
                        SizedBox(height: 10.h),
                       CustomButton(
  margin: EdgeInsets.zero,
  height: screenHeight * 0.05,
  textColor: KgradientBlack,
  borderRadius: BorderRadius.circular(screenWidth * 0.02),
  fontSize: 14.sp,
  fontWeight: kFW700,
  label: "Review",
  isLoading: false,
  onTap: () {
    Map<String, dynamic> orderDetails = {
      "user_name": "Bunty",
      "date": "29/04/2025",
      "email": "Siva2004@gmail.com",
      "phone": "7878278282",
      "retailer": "vibho technologies private",
      "materials": selectedMaterials,
      "prices": selectedPrices,
      "ids": selectedId,
    };

    Get.toNamed(
      Kinvoice,
      arguments: orderDetails, // Pass data here
    );
  },
),

                ],
              ),
            ),
          )
      
    );
  }
 
  Widget _buildMaterialSelection() {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedMaterials.isEmpty
                    ? 'Select materials'
                    : selectedMaterials.keys.join(', '),
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
 
  List<Widget> _buildMaterialQuantityFields() {
    return selectedMaterials.entries.map((entry) {
      return _buildMaterialQuantityField(entry.key, entry.value);
    }).toList();
  }
 
  Widget _buildMaterialQuantityField(String materialName, int quantity) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Kdarkgreen.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(materialName,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              Text(
                " (R ${selectedPrices[materialName]?.toString()}/ per unit)",
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: kblack.withOpacity(0.5),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          _buildQuantityInput(materialName, quantity),
          SizedBox(height: 10.h),
         
        ],
      ),
    );
  }
 
  Widget _buildQuantityInput(String materialName, int quantity) {
    return TextFormField(
      initialValue: quantity.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter quantity',
        border: const OutlineInputBorder(),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 13, left: 10),
          child: Text("Kgs", style: TextStyle(fontSize: 14.sp, fontWeight: kFW700)),
        ),
      ),
      onChanged: (materialValue) {
        setState(() {
          selectedMaterials[materialName] = int.tryParse(materialValue) ?? 0;
        });
      },
    );
  }
 
 
 
  void _showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: dropdownItems.map((item) {
            return CheckboxListTile(
              title: Text(item["product_name"]),
              value: selectedMaterials.containsKey(item["product_name"]),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedMaterials[item["product_name"]] = 0;
                    selectedPrices[item["product_name"]] = item["price"];
                    selectedId[item["product_name"]] = item["_id"];
                  } else {
                    selectedMaterials.remove(item["product_name"]);
                    selectedPrices.remove(item["product_name"]);
                    selectedId.remove(item["product_name"]);
                  }
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}