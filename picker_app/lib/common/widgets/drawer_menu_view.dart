import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common_widget/red_dot_notify_view.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:yaml/yaml.dart';
import '../../constants/constants.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeaderView(),
          _DrawerMenuItem(
            resourceName: 'ic_printer',
            title: 'Cài đặt máy in',
            onPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).pushFadeTransition(
              //   routeName: Screens.placeOrderCompleted,
              //   arguments: {},
              // );
            },
          ),
          const _MenuGroup(),
          _DrawerMenuItem(
            resourceName: 'ic_exit',
            title: 'Đăng xuất',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const _VersionView()
        ],
      ),
    );
  }
}

class _DrawerHeaderView extends StatelessWidget {
  const _DrawerHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.symmetric(horizontal: normalize(22)),
      decoration: const BoxDecoration(
        color: fushiaC8A,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: greyC4,
            radius: normalize(20),
            child: Text(
              'NT',
              style: TextStyleCommon.displayHeader(context, color: white),
            ),
          ),
          SizedBox(height: normalize(6)),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Nguyễn Văn Tèo',
                  style: TextStyleCommon.displayHeader(context,
                      color: white, fontSize: 24),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/ic_nav_right.svg',
                width: normalize(10),
                height: normalize(18),
                fit: BoxFit.scaleDown,
              )
            ],
          ),
          SizedBox(height: normalize(6)),
          Text(
            'MSNV: 949204103',
            style: TextStyleCommon.displaySubBody(context,
                color: white, fontSize: 17),
          ),
          SizedBox(height: normalize(12)),
        ],
      ),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  const _MenuGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: normalize(9), vertical: normalize(9)),
      decoration: BoxDecoration(
          border: Border.all(color: greyF3),
          borderRadius: BorderRadius.circular(normalize(15))),
      child: Column(
        children: [
          _DrawerMenuItem(
            resourceName: 'ic_notification',
            title: 'Thông báo',
            isShowDivider: true,
            isSingleItem: false,
            notifyCount: 10,
            onPressed: () {
              Navigator.pop(context);

              // Navigator.of(context).pushTTBTransition(
              //   routeName: Screens.confirmNewOrder,
              //   arguments: {},
              // );
            },
          ),
          _DrawerMenuItem(
            resourceName: 'ic_lock',
            title: 'Đổi mật khẩu',
            isShowDivider: true,
            isSingleItem: false,
            onPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).pushFadeTransition(
              //   routeName: Screens.pickingSummary,
              //   arguments: {},
              // );
            },
          ),
          _DrawerMenuItem(
            resourceName: 'ic_note_list',
            title: 'Lịch sử đơn hàng',
            isSingleItem: false,
            onPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).pushFadeTransition(
              //   routeName: Screens.orderHistory,
              //   arguments: {},
              // );
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final String resourceName;
  final String title;
  final VoidCallback onPressed;
  final bool isSingleItem;
  final bool isShowDivider;
  final int notifyCount;
  const _DrawerMenuItem({
    Key? key,
    required this.resourceName,
    required this.title,
    required this.onPressed,
    this.isShowDivider = false,
    this.isSingleItem = true,
    this.notifyCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: normalize(57),
      margin:
          isSingleItem ? EdgeInsets.symmetric(horizontal: normalize(9)) : null,
      decoration: BoxDecoration(
          border: isSingleItem ? Border.all(color: greyF3) : null,
          borderRadius: BorderRadius.circular(normalize(15))),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(normalize(15))),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/$resourceName.svg',
                  width: normalize(24),
                  height: normalize(24),
                ),
                SizedBox(
                  width: normalize(14),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyleCommon.displaySubBody(context,
                                  color: black, fontSize: 16),
                            ),
                          ),
                          notifyCount > 0
                              ? RedDotNotifyView(notifyCount: notifyCount)
                              : const SizedBox.shrink(),
                          SizedBox(
                            width: normalize(8),
                          ),
                          SvgPicture.asset(
                            'assets/icons/ic_nav_right.svg',
                            color: grey59,
                            fit: BoxFit.scaleDown,
                            width: normalize(8),
                            height: normalize(12),
                          )
                        ],
                      ),
                    ),
                    isShowDivider
                        ? const Divider(
                            height: 1,
                            color: greyE7,
                          )
                        : const SizedBox.shrink()
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VersionView extends StatefulWidget {
  const _VersionView({Key? key}) : super(key: key);

  @override
  __VersionViewState createState() => __VersionViewState();
}

class __VersionViewState extends State<_VersionView> {
  Future<VerionInfo?>? getYalm() async {
    var versionName;
    var build;
    try {
      String yamlText = await rootBundle.loadString('pubspec.yaml');

      final data = loadYaml(yamlText);
      String rawVersion = data['version'];
      final version = rawVersion.split('+');

      if (version.isNotEmpty) {
        if (version.length > 1) {
          versionName = version[0];
          build = version[1];
        } else {
          versionName = version[0];
        }
      } else {
        versionName = rawVersion;
      }
    } catch (e) {
      return null;
    }

    return VerionInfo(versionName, build);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VerionInfo?>(
        future: getYalm(), // _newVersion.getVersionStatus(),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: normalize(11)),
              child: Center(
                child: Text(
                    'Phiên bản ${snapshot.data?.versionName} ${_getBuild(snapshot.data?.build)}',
                    style: TextStyleCommon.displaySubBody(context,
                        fontSize: 16, color: black1A)),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  String _getBuild(String build) {
    if (build == null || build.isEmpty) {
      return '';
    }
    return '(${build})';
  }
}

class VerionInfo {
  final versionName;
  final build;

  VerionInfo(this.versionName, this.build);
}
