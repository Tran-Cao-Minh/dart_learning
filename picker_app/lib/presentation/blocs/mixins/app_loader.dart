import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';

mixin AppLoader {
  void showAppLoading({
    String? message,
    bool showLoadFailed = false,
  }) {
    EventBus().event<LoaderBloc>(
      Keys.Blocs.loaderBloc,
      LoaderStarted(),
    );
  }

  void hideAppLoading() {
    EventBus().event<LoaderBloc>(
      Keys.Blocs.loaderBloc,
      LoaderStopped(),
    );
  }
}
