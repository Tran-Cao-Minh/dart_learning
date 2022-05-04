import 'package:flutter/material.dart';
import 'package:picker/data/models/dummy_picker_info_model.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

DummyPickerInfoModel dummyPickerInfoModel = DummyPickerInfoModel(
  name: 'Nguyễn Văn A',
  isActive: false,
  totalOrder: 203,
  completedOrderCount: 150,
  missedOrderCount: 40,
  canceledOrderCount: 23,
  orderProductivityPercent: 70.5,
  timePerOrder: 32,
  timePerItem: 5,
  timeProductivityPercent: 90.5,
);

class PickerStatus extends StatefulWidget {
  PickerStatus({Key? key}) : super(key: key);

  @override
  _PickerStatusState createState() => _PickerStatusState();
}

class _PickerStatusState extends State<PickerStatus>
    with WidgetsBindingObserver {
  String today = '';
  String currentDate = '';
  bool isAllowLocation = true;
  late bool serviceEnabled;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    var now = DateTime.now();
    switch (now.weekday) {
      case 1:
        today = 'T2';
        break;
      case 2:
        today = 'T3';
        break;
      case 3:
        today = 'T4';
        break;
      case 4:
        today = 'T5';
        break;
      case 5:
        today = 'T6';
        break;
      case 6:
        today = 'T7';
        break;
      case 7:
        today = 'CN';
        break;
      default:
        today = '';
        break;
    }
    currentDate = todayFormatter.format(now);

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isAllowLocation = false;
        });
        return;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        setState(() {
          isAllowLocation = false;
        });
      } else {
        setState(() {
          isAllowLocation = true;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        checkPermission(); //this will check the status of permission when the user returns back from the settings page.
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<bool> determinePosition() async {
    LocationPermission permission2;

    permission2 = await Geolocator.checkPermission();

    if (permission2 == LocationPermission.denied) {
      permission2 = await Geolocator.requestPermission();
      if (permission2 == LocationPermission.deniedForever) {
        setState(() {
          isAllowLocation = false;
        });
        Geolocator.openAppSettings();
        return Future.error('Location permissions are denied');
      }
      if (permission2 == LocationPermission.denied) {
        setState(() {
          isAllowLocation = false;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission2 == LocationPermission.deniedForever) {
      setState(() {
        isAllowLocation = false;
      });
      Geolocator.openAppSettings();
      return Future.error('Location permissions are permanently denied');
    }

    setState(() {
      isAllowLocation = true;
    });

    return true;
  }

  checkPermission() async {
    LocationPermission permission3;
    permission3 = await Geolocator.checkPermission();
    if (permission3 == LocationPermission.always ||
        permission3 == LocationPermission.whileInUse) {
      setState(() {
        isAllowLocation = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: normalize(68),
          padding: EdgeInsets.only(left: normalize(8), right: normalize(16)),
          color: white,
          child: Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/hamburger.svg',
                    height: normalize(40),
                    width: normalize(40),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: normalize(8),
                    right: normalize(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyPickerInfoModel.name,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: normalize(16),
                          height: 20 / 16,
                          fontWeight: FontWeight.bold,
                          color: black33,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: normalize(4))),
                      Text(
                        '$today, $currentDate',
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: normalize(14),
                          height: 20 / 14,
                          fontWeight: FontWeight.normal,
                          color: black33,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: normalize(105),
                height: normalize(32),
                decoration: BoxDecoration(
                  color: purpleE7,
                  borderRadius: BorderRadius.all(
                    Radius.circular(normalize(16)),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(normalize(16)),
                    ),
                    onTap: () {
                      determinePosition();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: normalize(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dummyPickerInfoModel.isActive
                                ? 'Active'
                                : 'Inactive',
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: normalize(14),
                              height: 1.1,
                              fontWeight: FontWeight.normal,
                              color: red0D,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/picker_status.svg',
                            height: normalize(24),
                            width: normalize(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: !isAllowLocation ? normalize(128) : 0,
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(normalize(16)),
                  height: normalize(128),
                  color: red0D,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vui lòng cung cấp vị trí của bạn ở trạng thái “Luôn cho phép” để bắt đầu nhận đơn hàng',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: normalize(16),
                          height: 20 / 16,
                          fontWeight: FontWeight.normal,
                          color: white,
                        ),
                      ),
                      Container(
                        width: normalize(126),
                        height: normalize(40),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(normalize(8)),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(normalize(8)),
                            ),
                            onTap: () {
                              determinePosition();
                            },
                            child: Center(
                              child: Text(
                                'OK, đồng ý',
                                maxLines: 1,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: normalize(16),
                                  height: 20 / 16,
                                  fontWeight: FontWeight.bold,
                                  color: red0D,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: normalize(56),
                  top: -normalize(12),
                  child: SvgPicture.asset(
                    'assets/icons/red_arrow.svg',
                    height: normalize(16),
                    width: normalize(23),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
