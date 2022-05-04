import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common_widget/dotted_line.dart';
import 'package:picker/common_widget/remaining_time_pick_view.dart';
import 'package:picker/screens/picking_summary/bottomsheet/confirm_cancel_order_bottom_sheet.dart';
import 'package:picker/screens/picking_summary/picking_summary_mock_data.dart';
import 'package:picker/screens/picking_summary/picking_summary_provider.dart';
import 'package:picker/screens/picking_summary/view/pick_category_expandable_view.dart';
import 'package:picker/screens/picking_summary/view/pick_summary_section_info_view.dart';
import 'package:picker/screens/picking_summary/view/rounded_icon_label_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class PickingSummaryScreen extends StatelessWidget {
  const PickingSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PickingSummaryProvider>(
        create: (c) => PickingSummaryProvider(),
        builder: (context, child) {
          return const PickingSummaryScreenConsummer();
        });
  }
}

class PickingSummaryScreenConsummer extends StatefulWidget {
  const PickingSummaryScreenConsummer({Key? key}) : super(key: key);

  @override
  State<PickingSummaryScreenConsummer> createState() =>
      _PickingSummaryScreenConsummerState();
}

class _PickingSummaryScreenConsummerState
    extends State<PickingSummaryScreenConsummer> {
  void _showReasonCancelOrderBS() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (context) => const ConfirmCancelOrderBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: greyF8,
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              floating: false,
              titleSpacing: 0,
              backgroundColor: white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(54),
                child: RemainingTimePickView(
                  onCallCustomer: () {},
                ),
              ),
              title: Text(
                'Picking Summary',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w700,
                  fontSize: normalize(16),
                  height: 19.0 / 16.0,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/ic_nav_back.svg',
                  fit: BoxFit.scaleDown,
                  height: normalize(30),
                  width: normalize(30),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: _showReasonCancelOrderBS,
                    child: Text(
                      'Huỷ đơn',
                      style: TextStyleCommon.displayHeader(context,
                          fontSize: 16, color: red),
                    ))
              ],
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () async {},
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, pos) {
                  final item = pickingMockData[pos];
                  return PickCategoryExpandableView(
                    data: [
                      Object(),
                      Object(),
                    ],
                    type: item.type,
                  );
                }, childCount: pickingMockData.length)),
                const SliverToBoxAdapter(
                  child: _PaymentInfoView(),
                ),
                const SliverToBoxAdapter(
                  child: _OrderInfoView(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: normalize(25)),
                    color: white,
                    padding: EdgeInsets.symmetric(
                        horizontal: normalize(16), vertical: normalize(16)),
                    child: ConfirmationSlider(
                      shadow: const BoxShadow(),
                      backgroundColor: lilac,
                      height: normalize(55),
                      text: 'Xác nhận hết hàng',
                      foregroundColor: white,
                      sliderButtonContent: SvgPicture.asset(
                        'assets/icons/ic_arrow_right.svg',
                        color: lilac,
                        fit: BoxFit.scaleDown,
                        width: normalize(25),
                        height: normalize(25),
                      ),
                      textStyle: TextStyleCommon.displayHeader(context,
                          fontSize: 16, color: white),
                      onConfirmation: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentInfoView extends StatelessWidget {
  const _PaymentInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: normalize(8)),
      child: PSSectionInfoView(
        title: 'Thông tin thanh toán',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PSInfoPropertyView(
              label: 'Phuơng thức thanh toán',
              value: 'COD',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
            PSInfoPropertyView(
              label: 'Khuyến mãi',
              value: '-150,000đ',
            ),
            PSInfoPropertyView(
              label: 'Tổng tiền hàng ban đầu',
              value: '3,150,000đ',
            ),
            SizedBox(
              height: normalize(8),
            ),
            const DottedLine(
              dashColor: greyCC,
              dashLength: 4,
            ),
            SizedBox(
              height: normalize(8),
            ),
            PSInfoPropertyView(
              label: 'Đã gom hàng',
              value: '3,195,000đ',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
            PSInfoPropertyView(
              label: 'Chênh lệch',
              value: ' thiếu 45,000đ',
              valueStyle: TextStyleCommon.displayHeader(context,
                  fontSize: 16, color: red),
            ),
            const _PaymentNoteView()
          ],
        ),
      ),
    );
  }
}

class _PaymentNoteView extends StatelessWidget {
  const _PaymentNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: normalize(10)),
      padding: EdgeInsets.all(normalize(12)),
      decoration: BoxDecoration(
          color: pinkD9.withOpacity(0.2),
          borderRadius: BorderRadius.circular(normalize(6))),
      child: Text(
        'Vui lòng thông báo xác nhận tới khách hàng về việc thu thêm 45,000đ khi nhận hàng',
        style: TextStyleCommon.displaySubBody(context, height: 20.26 / 14)
            .copyWith(fontStyle: FontStyle.italic),
      ),
    );
  }
}

class _OrderInfoView extends StatelessWidget {
  const _OrderInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: normalize(8)),
      child: PSSectionInfoView(
        title: 'Thông tin đơn hàng',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PSInfoPropertyView(
              label: 'Mã đơn hàng ',
              value: '#03294234231',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
            PSInfoPropertyView(
              label: 'Mã pick ',
              value: '94234231',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
            SizedBox(
              height: normalize(8),
            ),
            const DottedLine(
              dashColor: greyCC,
              dashLength: 4,
            ),
            SizedBox(
              height: normalize(8),
            ),
            PSInfoPropertyView(
              label: 'Số sản phẩm đã lấy',
              value: '65 sản phẩm',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
            PSInfoPropertyView(
              label: 'Hết hàng',
              value: '12 sản phẩm',
              valueStyle: TextStyleCommon.displayHeader(context, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class PickingSummaryModel {
  final EPickCategoryType type;

  PickingSummaryModel({required this.type});
}
