import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/screens/order_history/widget/order_history_section_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'picker_status.dart';
import 'home_section.dart';
import 'order_section.dart';
import 'product_section.dart';
import 'productivity_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        backgroundColor: greyF1,
        drawer: SafeArea(
          top: false,
          child: DrawerView(),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: PickerStatus(),
              ),
              SliverToBoxAdapter(
                child: HomeSection(
                  icon: 'assets/icons/order_section.svg',
                  title: 'Đơn hàng',
                  content: OrderSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: HomeSection(
                  icon: 'assets/icons/product_section.svg',
                  title: 'Sản phẩm',
                  content: ProductSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: HomeSection(
                  icon: 'assets/icons/productivity_section.svg',
                  title: 'Hiệu suất',
                  content: ProductivitySection(),
                ),
              ),
              SliverToBoxAdapter(
                child: OrderHistorySectionView(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: normalize(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
