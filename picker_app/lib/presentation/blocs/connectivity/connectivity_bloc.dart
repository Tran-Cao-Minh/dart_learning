import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';

import 'connectivity.dart';

typedef CheckingInternet = Future<List<InternetAddress>> Function(String host,
    {InternetAddressType type});

class ConnectivityBloc extends BaseBloc<ConnectivityEvent, ConnectivityState> {
  late final Connectivity _connectivity;
  late final CheckingInternet _internetCheckingFunction;
  late final String _internetCheckingHost;
  late StreamSubscription _subscription;

  ConnectivityBloc(
    Key key, {
    Connectivity? connectivity,
    CheckingInternet? internetCheckingFunction,
    String? internetCheckingHost,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetCheckingHost = internetCheckingHost ?? 'google.com',
        _internetCheckingFunction =
            internetCheckingFunction ?? InternetAddress.lookup,
        super(
          key,
          initialState: ConnectivityInitial(),
        ) {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        final isConnected = await _checkConnection();

        if (isConnected != state.isConnected) {
          add(ConnectivityChanged(isConnected));
        }
      },
    );
    on<ConnectivityChecked>(_onConnectivityChecked);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  factory ConnectivityBloc.instance() {
    return EventBus().newBloc<ConnectivityBloc>(Keys.Blocs.connectivityBloc);
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();

    await super.close();
  }

  Future<void> _onConnectivityChecked(
    ConnectivityChecked event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await _checkConnection();
    emit(ConnectivityUpdateSuccess(isConnected));
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(ConnectivityUpdateSuccess(event.isConnected));
  }

  Future<bool> _checkConnection() async {
    var hasConnection = state.isConnected;
    try {
      final result = await _internetCheckingFunction(_internetCheckingHost);
      hasConnection = result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      hasConnection = false;
    }

    return hasConnection;
  }
}
