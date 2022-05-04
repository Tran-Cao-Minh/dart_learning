import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/mixin/mixin.dart';
import 'package:picker/presentation/journey/common/order_card/order_card.dart';
import 'package:picker/presentation/journey/home/widgets/home_appbar_content.dart';
import 'package:picker/presentation/journey/home/widgets/home_order_summary.dart';
import 'package:picker/presentation/journey/home/widgets/home_product_summary.dart';
import 'package:picker/presentation/journey/home/widgets/home_productivity_summary.dart';
import 'package:picker/presentation/journey/home/widgets/home_section.dart';
import 'package:picker/presentation/theme/theme.dart';

extension HomeScreenTheme on ThemeData {
  TextStyle get homeScreenSeeAllBtn => primaryButton.copyWith(
        color: blue1976,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetDidMount<HomeScreen> {
  @override
  void widgetDidMount(BuildContext context) {
    setState(() {});
  }

  void _onSeeAllTapped() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackF1F1,
      appBar: MyAppBar(
        height: dimen_68.h,
        bgColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        content: const HomeAppBarContent(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: dimen_12.h,
              left: dimen_8.w,
              right: dimen_8.w,
            ),
            sliver: SliverToBoxAdapter(
              child: HomeOrderSummary(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: dimen_12.h,
              left: dimen_8.w,
              right: dimen_8.w,
            ),
            sliver: SliverToBoxAdapter(
              child: HomeProductSummary(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: dimen_12.h,
              left: dimen_8.w,
              right: dimen_8.w,
            ),
            sliver: SliverToBoxAdapter(
              child: HomeProductivitySummary(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: dimen_12.h,
              left: dimen_8.w,
              right: dimen_8.w,
              bottom: dimen_24.h + context.queryPaddingBottom,
            ),
            sliver: SliverToBoxAdapter(
              child: HomeSection(
                icon: AppIcons.orderHistory,
                title: 'Lịch sử chọn hàng',
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      padding: EdgeInsets.symmetric(
                        vertical: dimen_16.h,
                      ),
                      separatorBuilder: (_, __) {
                        return SizedBox(
                          height: dimen_16.h,
                        );
                      },
                      itemBuilder: (_, index) {
                        return OrderCard();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: dimen_16.h,
                        bottom: dimen_12.h,
                      ),
                      child: InkButton(
                        onTap: _onSeeAllTapped,
                        padding: EdgeInsets.symmetric(
                          vertical: dimen_6.h,
                        ),
                        child: Text(
                          'Xem tất cả',
                          style: Theme.of(context).homeScreenSeeAllBtn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
