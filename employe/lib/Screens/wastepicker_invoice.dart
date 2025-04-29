import '../untils/exports.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    // Extract the data from the arguments passed
    final Map<String, dynamic> orderDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Calculate total items and total price
    int totalItems = orderDetails['materials'].length;
    double totalPrice = 0.0;
    orderDetails['materials'].entries.forEach((entry) {
      totalPrice += (entry.value.toDouble() * (orderDetails['prices'][entry.key] as num).toDouble());
    });

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
          'Invoice',
          style: GoogleFonts.inter(
            fontSize: kEighteenFont,
            fontWeight: kFW600,
            color: KgradientBlack,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(15),
        child: CustomButton(
          margin: EdgeInsets.zero,
          height: 45.h,
          textColor: KgradientBlack,
          borderRadius: BorderRadius.circular(10),
          fontSize: 14.sp,
          fontWeight: kFW700,
          label: "Place Order",
          isLoading: false,
          onTap: () {
            Get.toNamed(korderconform);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            
            // Customer details section
            _buildInfoRow('Name:', orderDetails['user_name']),
            _buildInfoRow('Date:', orderDetails['date']),
            _buildInfoRow('Email:', orderDetails['email']),
            _buildInfoRow('Phone:', orderDetails['phone']),
            SizedBox(height: 20),
            _buildInfoRow('Retailer:', orderDetails['retailer']),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),

            // Materials section
            Text('Materials:', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildMaterialTable(orderDetails),
            SizedBox(height: 20),

            // Display total items and total price
            _buildInfoRow('Total Items:', totalItems.toString()),
            _buildInfoRow('Total Price:', 'R $totalPrice'),
          ],
        ),
      ),
    );
  }

  // Helper function to create key-value rows for order details
  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),
      ],
    );
  }

  // Helper function to create the material table
  Widget _buildMaterialTable(Map<String, dynamic> orderDetails) {
    return Column(
      children: [
        _buildMaterialTableHeader(),
        Divider(), // Divider between header and rows
        ...orderDetails['materials'].entries.map<Widget>((entry) {
          return Column(
            children: [
              _buildMaterialTableRow(
                entry.key, 
                entry.value.toDouble(), // Ensure the quantity is a double
                (orderDetails['prices'][entry.key] as num).toDouble(), // Ensure the price is a double
              ),
              Divider(), // Divider between rows
            ],
          );
        }).toList(),
      ],
    );
  }

  // Header row for the materials table
  Widget _buildMaterialTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTableHeaderCell('Material'),
          _buildTableHeaderCell('Quantity (Kgs)'),
          _buildTableHeaderCell('Price per unit'),
        ],
      ),
    );
  }

  // Table cell style for header
  Widget _buildTableHeaderCell(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: KgradientBlack),
    );
  }

  // Row for each material in the table
  Widget _buildMaterialTableRow(String material, double quantity, double pricePerUnit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(material, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),
          Text('$quantity', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),
          Text('R $pricePerUnit', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
