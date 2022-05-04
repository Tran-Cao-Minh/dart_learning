import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/constants/duration.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:picker/domain/interactors/load_list_interactor.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/models/models.dart';
import 'package:picker/common/utils/cast_type.dart';

import 'load_list_event.dart';
import 'load_list_state.dart';

class LoadListBloc<T extends Entity>
    extends BaseBloc<LoadListEvent, LoadListState> {
  late final LoadListInteractor<T> _loadListInteractor;

  LoadListBloc(
    Key key, {
    required LoadListInteractor<T> loadListInteractor,
    Key? closeWithBlocKey,
  })  : _loadListInteractor = loadListInteractor,
        super(
          key,
          closeWithBlocKey: closeWithBlocKey,
          initialState: LoadListInitial(),
        ) {
    on<LoadListRemovedItem>(_onLoadListRemovedItem);
    on<LoadListEvent>(_onLoadListLoaded);
  }

  Future<void> _onLoadListRemovedItem(
    LoadListRemovedItem event,
    Emitter<LoadListState> emit,
  ) async {
    emit(LoadListRemoveItemSuccess(event.removedItem));
  }

  Future<void> _onLoadListLoaded(
    LoadListEvent event,
    Emitter<LoadListState> emit,
  ) async {
    if (event is LoadListRemovedItem) {
      return;
    }

    List<T>? items = <T>[];
    if (event is LoadListStarted) {
      emit(LoadListStartInProgress());
    } else if (event is LoadListRefreshed) {
      emit(LoadListStartInProgress());
      await _loadListInteractor.shouldRefreshItems(params: event.params);

      EventBus().cleanUp(parentKey: key);
    } else if (event is LoadListNextPage) {
      emit(LoadListStartInProgress());
      items = asT<List<T>>(event.nextItems);
    }

    try {
      List<T>? allItems = <T>[];
      var allGroupItems = <Group>[];
      var nextPage = 0;
      final previous = state;
      if (previous is LoadListLoadPageSuccess) {
        if (!GroupList.isListGroup(items.runtimeType.toString())) {
          allItems = List<T>.from(previous.items);
        } else {
          allGroupItems = List<Group>.from(previous.items);
        }
        nextPage = previous.nextPage;
      } else {
        final params = event.params ?? <String, dynamic>{};
        params[Keys.LoadListInteractors.offset] = 0;
        items = await _loadListInteractor.loadItems(params: params);
      }

      if (GroupList.isListGroup(items.runtimeType.toString())) {
        if (items == null || items.isEmpty) {
          emit(LoadListLoadPageSuccess(
            allGroupItems,
            isFinish: true,
            nextPage: nextPage,
          ));
        } else {
          final groups = List<Group>.from(allGroupItems)
            ..append(List<Group>.from(items));
          emit(LoadListLoadPageSuccess(
            groups,
            isFinish: false,
            nextPage: groups.totalItem(),
          ));
        }
      } else {
        if (items != null) {
          allItems = allItems + items;
        }
        emit(LoadListLoadPageSuccess(
          allItems,
          isFinish: items?.isEmpty ?? false,
          nextPage: allItems.length,
        ));
      }
    } catch (err) {
      debugPrint('Load List Bloc Error >> $err');

      emit(LoadListRunFailure(err.toString(), err));
    }
  }

  void start({
    bool shouldDelayStart = false,
    Map<String, dynamic>? params,
  }) {
    if (state is LoadListInitial) {
      if (shouldDelayStart) {
        addLater(
          LoadListStarted(params: params),
          after: const Duration(milliseconds: loadListStartDelayedDuration),
        );
      } else {
        add(LoadListStarted(params: params));
      }
    } else if (_loadListInteractor.shouldReloadData(params: params)) {
      add(LoadListRefreshed(params: params));
    }
  }

  Future<List<T>?> loadMore({
    Map<String, dynamic>? params,
    int? quantityCustomCell,
  }) async {
    final previous = state;
    if (previous is LoadListLoadPageSuccess) {
      final loadMoreParams = params ?? <String, dynamic>{};
      loadMoreParams[Keys.LoadListInteractors.offset] = previous.nextPage;

      final items = await _loadListInteractor.loadItems(params: loadMoreParams);
      return items;
    }

    return <T>[];
  }
}
