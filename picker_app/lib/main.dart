import 'package:flutter/material.dart';
import 'package:picker/common/utils/responsive_layout.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/app_showing.dart';
import 'package:picker/presentation/blocs/base/bloc_observer.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/routes.dart';
import 'package:flutter/services.dart';
import 'package:picker/utils/precache_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global/global.dart';
import 'injection.dart';
import 'presentation/theme/theme.dart';

Future<void> main() async {
  await _initialize();
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  await Injection().initialize();

  await Future.wait<void>([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    PreCacheSvg.preCacheLoadSvg(),
  ]);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _initApp();
  }

  Future<void> _initApp() async {
    //notification
    //Remove this method to stop OneSignal Debugging
    //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    try {
      // await OneSignal.shared.setAppId("3beede2c-86ed-4292-b924-563a3995c132"); //Prod
      await OneSignal.shared
          .setAppId('0ae24f01-ea17-4b00-bbc9-9586f840b0ec'); //Dev
      await OneSignal.shared.consentGranted(true);
      // The promptForPushNotificationsWithUserResponse function will show the
      // iOS push notification prompt. We recommend removing the following
      // code and instead using an In-App Message to prompt
      // for notification permission
      await OneSignal.shared
          .promptUserForPushNotificationPermission()
          .then((accepted) {
        debugPrint('Accepted permission: $accepted');
      });

      OneSignal.shared
          .setInAppMessageClickedHandler((OSInAppMessageAction action) {});
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) =>
              ConnectivityBloc.instance()..add(ConnectivityChecked()),
        ),
        BlocProvider<LoaderBloc>(create: (_) => LoaderBloc.instance()),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        navigatorObservers: [
          AppRouteObserver(),
          HeroController(),
        ],
        builder: (context, widget) {
          ResponsiveLayout.init(context);
          widget = AppShowing(
            child: widget ?? Container(),
          );

          return MultiBlocListener(
            listeners: [
              BlocListener<LoaderBloc, LoaderState>(
                listener: (_, state) {},
              ),
            ],
            child: widget,
          );
        },
        theme: loadTheme(context),
        title: 'Rino Picker',
        routes: Routes.allRoutes(context),
        initialRoute: Screens.splash,
      ),
    );
  }
}
