import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';

import 'loader.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(Key key)
      : super(
          key,
          initialState: LoaderInitial(),
        ) {
    on<LoaderStarted>(_onLoaderStarted);
    on<LoaderStopped>(_onLoaderStopped);
  }

  factory LoaderBloc.instance() {
    return EventBus().newBloc<LoaderBloc>(Keys.Blocs.loaderBloc);
  }

  Future<void> _onLoaderStarted(
    LoaderStarted event,
    Emitter<LoaderState> emit,
  ) async {
    if (!(state is LoaderStartSuccess)) {
      emit(LoaderStartSuccess());
    }
  }

  Future<void> _onLoaderStopped(
    LoaderStopped event,
    Emitter<LoaderState> emit,
  ) async {
    if (!(state is LoaderStopSuccess)) {
      emit(LoaderStopSuccess());
    }
  }
}
