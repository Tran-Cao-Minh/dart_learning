import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/data/exception/exception.dart';
import 'package:picker/common/utils/cast_type.dart';

import 'broadcast.dart';
import 'event_bus.dart';

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> {
  final Key key;
  final Key? closeWithBlocKey;

  BaseBloc(
      this.key, {
        required S initialState,
        this.closeWithBlocKey,
      }) : super(initialState) {
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null &&
        closeWithBlocKey != Keys.Blocs.forceToDisposeBloc) {
      return;
    }

    EventBus().unsubscribes(key);
    EventBus().unhandle(key);

    otherBlocsUnSubscription();

    await super.close();
  }

  void handleException(Exception e) {
    if (e is ApiException) {
      debugPrint('Api Error >> $e');

      // show error here
    } else if (e is AppException) {
      debugPrint('App Error >> $e');

      // show error here
    }
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnSubscription() {}

  List<Broadcast>? subscribes() {
    return null;
  }

  void addLater(Object event,
      {Duration after = const Duration(milliseconds: 500)}) {
    Future.delayed(after, () {
      add(asT<E>(event)!);
    });
  }
}
