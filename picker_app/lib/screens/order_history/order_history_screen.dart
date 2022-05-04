import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common/common.dart';
import 'package:picker/screens/order_history/order_history_mock_data.dart';
import 'package:picker/screens/order_history/order_history_provider.dart';
import 'package:picker/screens/order_history/widget/item_order_history_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => OrderHistoryProvider(),
      builder: (c, child) => const _OrderHistoryConsumer(),
    );
  }
}

class _OrderHistoryConsumer extends StatefulWidget {
  const _OrderHistoryConsumer({Key? key}) : super(key: key);

  @override
  State<_OrderHistoryConsumer> createState() => __OrderHistoryConsumerState();
}

class __OrderHistoryConsumerState extends State<_OrderHistoryConsumer> {
  Future<void> _onRefreshData() async {
    ///
    ///
    ///
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          elevation: 1,
          title: Text(
            'Lịch sử đơn hàng',
            style: TextStyleCommon.displayHeader(context,
                fontSize: 17, color: black3F),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/ic_nav_back.svg',
              color: black3F,
              height: normalize(17),
              width: normalize(17),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefreshData,
          child: const _OrderHistoryContentView(),
        ),
      ),
    );
  }
}

class _OrderHistoryContentView extends StatelessWidget {
  const _OrderHistoryContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyF8,
      child: Column(
        children: const [
          _DateFilterView(),
          Expanded(child: _OrderHistoryListView()) // OrderHistoryEmptyView()
        ],
      ),
    );
  }
}

class _DateFilterView extends StatelessWidget {
  const _DateFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: normalize(generalHorizontalPadding)),
      height: normalize(53),
      child: Row(
        children: [
          const _DateFilterTitleView(),
          const Spacer(),
          Text(
            '25/02/2022',
            style: TextStyleCommon.displayHeader(context,
                color: black.withOpacity(0.65)),
          )
        ],
      ),
    );
  }
}

class _DateFilterTitleView extends StatelessWidget {
  const _DateFilterTitleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showSelectRangeDateFilterBottomSheet(context);
          if (result != null) {
            debugPrint(result.toString());
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: normalize(generalHorizontalPadding)),
          height: normalize(53),
          child: Row(
            children: [
              Text(
                'Hôm nay',
                style: TextStyleCommon.displayHeader(context, color: blueFF),
              ),
              SizedBox(
                width: normalize(6),
              ),
              SvgPicture.asset(
                'assets/icons/ic_drop_down.svg',
                color: blueFF,
                fit: BoxFit.scaleDown,
                height: normalize(11),
                width: normalize(7),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderHistoryListView extends StatelessWidget {
  const _OrderHistoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orderHistoryMockData.length,
        itemBuilder: (context, pos) => ItemOrderHistoryView(
              item: orderHistoryMockData[pos],
            ));
  }
}
