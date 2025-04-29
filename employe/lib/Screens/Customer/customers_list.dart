import 'package:employe/Screens/Customer/Tab/complete_tab.dart';
import 'package:employe/Screens/Customer/Tab/pending_tab.dart';
import 'package:employe/untils/exports.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            PendingTab(),
            CompletedTab(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 60),
      child: AppBar(
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
          'Customers List',
          style: GoogleFonts.inter(
            fontSize: kEighteenFont,
            fontWeight: kFW600,
            color: KgradientBlack,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: _buildTabBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return 
    TabBar(
      labelColor: kblack,
    unselectedLabelColor: kblack,
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w800,
        fontSize: 13.sp
      ),
      
      unselectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: kblack
      ),
      
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: kwhite,
        borderRadius: BorderRadius.circular(16),
       
      ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(text: 'Pending'),
        Tab(text: 'Completed'),
      ],
    );
  }
}
