import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:picker/mixin/mixin.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/common/widgets/empty_list.dart';
import 'package:picker/presentation/common/widgets/error_list.dart';
import 'package:picker/presentation/models/models.dart';

import 'load_sliver_list_view.dart';

typedef SliverListRender<T extends Entity> = Widget Function(List<T> items);
typedef ItemSliverBuilder<T extends Entity> = Widget Function(
    T item, int index);
typedef ItemSliverPlaceholderBuilder<T extends Entity> = Widget Function(
    T item);
typedef GroupHeaderSliverBuilder = Widget Function(
    String headerTitle, List<Group> groups, int index,
    {Map<String, dynamic>? extraData});
typedef GroupItemSliverBuilder<I extends Entity> = Widget Function(
    I item, int index);
typedef GroupItemSliverPlaceholderBuilder<I extends Entity> = Widget Function(
    I item);
typedef OnItemSliverRemoved<T extends Object> = void Function(T removedItem);
typedef OnSliverDataIsReady<T extends Entity> = void Function(
    List<T> data, bool isRefreshed);

class LoadSliverList<T extends Entity> extends StatefulWidget {
  LoadSliverList({
    required this.blocKey,
    this.errorTitle,
    this.errorMessage,
    this.emptyTitle,
    this.emptyMessage,
    this.sliverListRender,
    this.itemSliverBuilder,
    this.onItemSliverRemoved,
    this.itemSliverPlaceholderBuilder,
    this.groupHeaderSliverBuilder,
    this.groupItemSliverBuilder,
    this.groupItemSliverPlaceholderBuilder,
    required this.emptyWidget,
    this.errorWidget,
    this.loadingWidget,
    this.onDataIsReady,
    this.onShouldRefresh,
    this.supportFlatGroup = false,
    this.params,
    this.autoStart = false,
    this.axisDirection,
    this.shouldDelayStart = false,
    this.shouldShowReload = false,
    this.shouldShowPlaceholder = false,
    this.onReLoad,
  }) : assert(
            sliverListRender != null ||
                itemSliverBuilder != null ||
                supportFlatGroup == true,
            'Must provide at least one render.');

  final Key blocKey;
  final String? errorTitle;
  final String? errorMessage;
  final String? emptyTitle;
  final String? emptyMessage;
  final SliverListRender<T>? sliverListRender;
  final ItemSliverBuilder<T>? itemSliverBuilder;
  final OnItemSliverRemoved<T>? onItemSliverRemoved;
  final ItemSliverPlaceholderBuilder<T>? itemSliverPlaceholderBuilder;

  final GroupHeaderSliverBuilder? groupHeaderSliverBuilder;
  final GroupItemSliverBuilder? groupItemSliverBuilder;
  final GroupItemSliverPlaceholderBuilder? groupItemSliverPlaceholderBuilder;

  final OnSliverDataIsReady<T>? onDataIsReady;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Function? onShouldRefresh;
  final bool supportFlatGroup;
  final Map<String, dynamic>? params;
  final bool autoStart;
  final bool shouldShowPlaceholder;
  final AxisDirection? axisDirection;
  final bool shouldDelayStart;
  final bool shouldShowReload;
  final VoidCallback? onReLoad;

  @override
  _LoadSliverListState createState() => _LoadSliverListState<T>();
}

class _LoadSliverListState<T extends Entity> extends State<LoadSliverList<T>>
    with WidgetDidMount<LoadSliverList<T>> {
  bool _isRefresh = false;
  late bool _isConnected;

  @override
  void initState() {
    super.initState();
    _isConnected = EventBus()
        .blocFromKey<ConnectivityBloc>(Keys.Blocs.connectivityBloc)!
        .state
        .isConnected;
  }

  @override
  void widgetDidMount(BuildContext context) {
    // ignore: close_sinks
    final loadListBloc =
        EventBus().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc != null) {
      final state = loadListBloc.state;
      if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
        widget.onDataIsReady!(asT<List<T>>(state.items)!, _isRefresh);
      } else if (state is LoadListInitial && widget.autoStart) {
        loadListBloc.start(
          shouldDelayStart: widget.shouldDelayStart,
          params: widget.params,
        );
      }
    }
  }

  void _reload() {
    if (widget.shouldShowReload && _isConnected) {
      EventBus().event<LoadListBloc>(
        widget.blocKey,
        LoadListRefreshed(
          params: widget.params,
        ),
      );
    }
  }

  void _proceedConnectivityUpdated(ConnectivityState state) {
    if (!_isConnected && state.isConnected) {
      /// handle refresh after reconnect if needed.
    }

    if (_isConnected != state.isConnected) {
      setState(() {
        _isConnected = state.isConnected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (_, state) {
            if (state is ConnectivityUpdateSuccess) {
              _proceedConnectivityUpdated(state);
            }
          },
        ),
      ],
      child: BlocConsumer<LoadListBloc<T>, LoadListState>(
        bloc: EventBus().blocFromKey<LoadListBloc<T>>(widget.blocKey),
        listenWhen: (previous, current) =>
            current is LoadListLoadPageSuccess ||
            current is LoadListRemoveItemSuccess ||
            current is LoadListRunFailure,
        listener: (context, state) {
          if (state is LoadListLoadPageSuccess &&
              widget.onDataIsReady != null) {
            widget.onDataIsReady!(asT<List<T>>(state.items)!, _isRefresh);
            if (_isRefresh) {
              _isRefresh = false;
            }
          } else if (state is LoadListRemoveItemSuccess &&
              widget.onItemSliverRemoved != null) {
            widget.onItemSliverRemoved!(asT<T>(state.removedItem)!);
          }
        },
        buildWhen: (previous, current) {
          if (current is LoadListRemoveItemSuccess) {
            return false;
          }

          return true;
        },
        builder: (context, state) {
          if (state is LoadListStartInProgress || state is LoadListInitial) {
            return widget.loadingWidget ??
                const SliverToBoxAdapter(
                  child: OSLoading(),
                );
          }
          if (state is LoadListRunFailure) {
            var errorTitle = widget.errorTitle ?? '';
            if (state.error is TimeoutException) {
              errorTitle = 'Timeout exception! Try again!';
            }

            return widget.errorWidget ??
                SliverToBoxAdapter(
                  child: ErrorList(
                    errorMessage: widget.errorMessage ?? state.errorMessage,
                    errorTitle: errorTitle,
                    shouldShowReload: widget.shouldShowReload,
                    doReload: _reload,
                  ),
                );
          }

          if (state is LoadListLoadPageSuccess) {
            return state.items.isEmpty
                ? widget.emptyWidget ??
                    SliverToBoxAdapter(
                      child: EmptyList(
                        title: widget.emptyTitle!,
                        message: widget.emptyMessage!,
                      ),
                    )
                : widget.sliverListRender != null
                    ? widget.sliverListRender!(asT<List<T>>(state.items)!)
                    : LoadSliverListView<T>(
                        items: state.items,
                        supportFlatGroup: widget.supportFlatGroup,
                        shouldShowPlaceholder: widget.shouldShowPlaceholder,
                        groupHeaderSliverBuilder:
                            widget.groupHeaderSliverBuilder,
                        groupItemSliverBuilder: widget.groupItemSliverBuilder,
                        itemSliverBuilder: widget.itemSliverBuilder,
                        itemSliverPlaceholderBuilder:
                            widget.itemSliverPlaceholderBuilder,
                        groupItemSliverPlaceholderBuilder:
                            widget.groupItemSliverPlaceholderBuilder,
                      );
          }

          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
