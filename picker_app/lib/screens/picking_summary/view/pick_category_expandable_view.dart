import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common_widget/expandable_section_view.dart';
import 'package:picker/common_widget/image_network.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

enum EPickCategoryType { exchangeItem, pickOnePiece, outOfStock, collectEnough }

extension EPickCategoryTypeExt on EPickCategoryType {
  String get title => _getTitle();
  Color get color => _getColor();
  String get sectionAssetsName => _getAssetsName();
  String get itemAssetsName => _getAssetsName();

  String _getAssetsName() {
    switch (this) {
      case EPickCategoryType.exchangeItem:
        return 'ic_exchange_item';
      case EPickCategoryType.pickOnePiece:
        return 'ic_pick_one_piece';
      case EPickCategoryType.outOfStock:
        return 'ic_out_of_stock';
      case EPickCategoryType.collectEnough:
        return 'ic_order_completed';
      default:
        return 'ic_order_completed';
    }
  }

  String _getItemAssetsName() {
    switch (this) {
      case EPickCategoryType.exchangeItem:
        return 'ic_exchange_item';
      case EPickCategoryType.pickOnePiece:
        return 'ic_pick_one_piece';
      case EPickCategoryType.outOfStock:
        return 'ic_out_of_stock';
      case EPickCategoryType.collectEnough:
        return 'ic_order_completed';
      default:
        return 'ic_order_completed';
    }
  }

  String _getTitle() {
    switch (this) {
      case EPickCategoryType.exchangeItem:
        return 'Có đổi hàng';
      case EPickCategoryType.pickOnePiece:
        return 'Nhặt 1 phần';
      case EPickCategoryType.outOfStock:
        return 'Hết hàng';
      case EPickCategoryType.collectEnough:
        return 'Đủ hàng';
      default:
        return '';
    }
  }

  Color _getColor() {
    switch (this) {
      case EPickCategoryType.exchangeItem:
        return green41;
      case EPickCategoryType.pickOnePiece:
        return yellow00;
      case EPickCategoryType.outOfStock:
        return red;
      case EPickCategoryType.collectEnough:
        return green41;
      default:
        return green41;
    }
  }
}

class PickCategoryExpandableView extends StatelessWidget {
  final EPickCategoryType type;
  final List<dynamic> data;

  const PickCategoryExpandableView({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      margin: EdgeInsets.only(top: normalize(8)),
      padding: EdgeInsets.symmetric(
          horizontal: normalize(16), vertical: normalize(8)),
      child: Column(
        children: [
          SizedBox(
            height: normalize(25),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/${type.sectionAssetsName}.svg'),
                SizedBox(
                  width: normalize(8),
                ),
                Expanded(
                    child: Text(
                  type.title,
                  style: TextStyleCommon.displayHeader(context,
                      color: type.color, fontSize: 20),
                )),
                SvgPicture.asset(
                  'assets/icons/ic_drop_down.svg',
                  width: normalize(12),
                  height: normalize(12),
                )
              ],
            ),
          ),
          ExpandableSection(
            expand: true,
            child: Padding(
              padding: EdgeInsets.only(top: normalize(8)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, pos) {
                  switch (type) {
                    case EPickCategoryType.exchangeItem:
                      return _ExchangeItemView();
                    case EPickCategoryType.pickOnePiece:
                    case EPickCategoryType.outOfStock:
                    case EPickCategoryType.collectEnough:
                      return _InventoryItemView(type: type);
                    default:
                      return SizedBox.shrink();
                  }
                },
                itemCount: data.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ExchangeItemView extends StatelessWidget {
  const _ExchangeItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: normalize(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InventoryItemView(
              sourceLabel: 'Original', type: EPickCategoryType.exchangeItem),
          SizedBox(
            width: normalize(50),
            child: SvgPicture.asset(
              'assets/icons/ic_arrow_down.svg',
              fit: BoxFit.scaleDown,
              width: normalize(14),
              height: normalize(14),
            ),
          ),
          _InventoryItemView(
              sourceLabel: 'Replaced',
              isOriginalItem: false,
              type: EPickCategoryType.exchangeItem),
          SizedBox(
            height: normalize(6),
          ),
          Divider(
            height: 1,
            indent: normalize(25),
            color: greyE6,
          ),
          SizedBox(
            height: normalize(6),
          ),
        ],
      ),
    );
  }
}

class _InventoryItemView extends StatelessWidget {
  final String? sourceLabel;
  final bool isOriginalItem;
  final EPickCategoryType type;

  const _InventoryItemView({
    Key? key,
    this.sourceLabel,
    this.isOriginalItem = true,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ImageNetwork(
          url: 'url',
          fit: BoxFit.contain,
          width: normalize(50),
          height: normalize(47),
        ),
        SizedBox(
          width: normalize(8),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type == EPickCategoryType.exchangeItem && sourceLabel != null
                    ? sourceLabel!
                    : '',
                style: TextStyleCommon.displayHeaderBold(context, fontSize: 12),
              ),
              SizedBox(
                height: normalize(2),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Combo 8 hạt nhập khẩu từ Úc, size 45, bịch 300g',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleCommon.displaySubBody(context,
                          fontSize: 18, color: black33, height: 22.62 / 18),
                    ),
                  ),
                  SizedBox(
                    width: normalize(4),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          (isOriginalItem &&
                                  type == EPickCategoryType.exchangeItem)
                              ? SizedBox.shrink()
                              : SvgPicture.asset(
                                  'assets/icons/${type.sectionAssetsName}.svg',
                                ),
                          SizedBox(
                            width: normalize(4),
                          ),
                          Text(
                            '01/03',
                            style: TextStyleCommon.displayHeaderBold(
                              context,
                              fontSize: 16,
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: normalize(4),
                      ),
                      Text(
                        '450.000đ',
                        style: TextStyleCommon.displaySubBody(context,
                            color: black.withOpacity(0.5), height: 16.41 / 14),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
