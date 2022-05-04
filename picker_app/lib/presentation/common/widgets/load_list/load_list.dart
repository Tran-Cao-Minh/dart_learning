import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/data/exception/exception.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:picker/mixin/mixin.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/common/widgets/empty_list.dart';
import 'package:picker/presentation/common/widgets/error_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'load_list_view.dart';

typedef ListRender<T extends Entity> = Widget Function(List<T> items);
typedef ItemBuilder<T extends Entity> = Widget Function(T item, int index);
typedef ItemSeparatorBuilder = Widget Function(int index);
typedef ItemPlaceholderBuilder<T extends Entity> = Widget Function(T item);
typedef GroupHeaderBuilder<T> = Widget Function(String? headerTitle,
    {Map<String, dynamic>? extraData});
typedef GroupItemBuilder<I extends Entity> = Widget Function(I item);
typedef GroupItemPlaceholderBuilder<I extends Entity> = Widget Function(I item);
typedef OnItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnDataIsReady<T extends Entity> = void Function(
    List<T> data, bool isRefreshed);

class _ScrollbarWrapper extends StatelessWidget {
  const _ScrollbarWrapper({
    Key? key,
    required this.applyScrollbar,
    required this.child,
  }) : super(key: key);

  final bool applyScrollbar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (applyScrollbar) {
      return Scrollbar(
        child: child,
      );
    }

    return child;
  }
}

class LoadList<T extends Entity> extends StatefulWidget {
  LoadList({
    required this.blocKey,
    this.emptyWidget,
    this.errorWidget,
    this.errorTitle,
    this.errorMessage,
    this.emptyTitle,
    this.emptyMessage,
    this.listRender,
    this.itemBuilder,
    this.onItemRemoved,
    this.itemSeparatorBuilder,
    this.itemPlaceholderBuilder,
    this.groupHeaderBuilder,
    this.groupItemBuilder,
    this.groupItemPlaceholderBuilder,
    this.loadingWidget,
    this.onDataIsReady,
    this.onShouldRefresh,
    this.padding,
    this.needLoadMore = true,
    this.supportFlatGroup = false,
    this.params,
    this.scrollPhysics,
    this.isManualScrollControl = false,
    this.needRefresh = true,
    this.autoStart = false,
    this.controller,
    this.applyScrollBar = false,
    this.shrinkWrap = false,
    this.quantityCustomCell = 0,
    this.shouldDelayStart = true,
    this.shouldShowReload = false,
    this.shouldShowPlaceholder = false,
  }) : assert(
            listRender != null ||
                itemBuilder != null ||
                supportFlatGroup == true,
            'Must provide at least one render.');

  final Key blocKey;
  final String? errorTitle;
  final String? errorMessage;
  final String? emptyTitle;
  final String? emptyMessage;
  final ListRender<T>? listRender;
  final ItemBuilder<T>? itemBuilder;
  final OnItemRemoved<T>? onItemRemoved;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;

  final GroupHeaderBuilder? groupHeaderBuilder;
  final GroupItemBuilder? groupItemBuilder;
  final GroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;

  final OnDataIsReady<T>? onDataIsReady;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Function? onShouldRefresh;
  final EdgeInsets? padding;
  final bool needLoadMore;
  final bool supportFlatGroup;
  final Map<String, dynamic>? params;
  final ScrollPhysics? scrollPhysics;
  final bool needRefresh;
  final bool isManualScrollControl;
  final bool autoStart;
  final ScrollController? controller;
  final bool applyScrollBar;
  final bool shrinkWrap;
  final int quantityCustomCell;
  final bool shouldDelayStart;
  final bool shouldShowReload;
  final bool shouldShowPlaceholder;

  @override
  State<StatefulWidget> createState() {
    return _LoadListState<T>();
  }
}

class _LoadListState<T extends Entity> extends State<LoadList<T>>
    with WidgetDidMount<LoadList<T>> {
  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  bool _isRefresh = false;
  late ScrollController _scrollController;
  late bool _isConnected;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _isConnected = EventBus()
        .blocFromKey<ConnectivityBloc>(Keys.Blocs.connectivityBloc)!
        .state
        .isConnected;
  }

  @override
  void widgetDidMount(BuildContext context) {
    _onStart();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onStart() {
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
      _refreshController.refreshCompleted();

      _refreshController.loadComplete();
    }
  }

  Future<void> _refresh(BuildContext context) async {
    if (_isConnected) {
      if (widget.onShouldRefresh != null) {
        widget.onShouldRefresh!();
      }
      if (!_isRefresh) {
        _isRefresh = true;
      }
      EventBus().event<LoadListBloc>(
        widget.blocKey,
        LoadListRefreshed(
          params: widget.params,
        ),
      );
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
    _refreshController.loadComplete();
  }

  Future<void> _loadMore(BuildContext context) async {
    if (_isConnected) {
      //ignore: close_sinks
      final loadListBloc =
          EventBus().blocFromKey<LoadListBloc<T>>(widget.blocKey);
      if (loadListBloc == null) {
        _refreshController.loadFailed();
      } else {
        final nextItems = await loadListBloc.loadMore(
          params: widget.params,
          quantityCustomCell: widget.quantityCustomCell,
        );
        if (nextItems == null || nextItems.isEmpty) {
          _refreshController.loadNoData();
        } else {
          EventBus().event<LoadListBloc>(
            widget.blocKey,
            LoadListNextPage<T>(
              nextItems: nextItems,
              params: widget.params,
            ),
          );
          _refreshController.loadComplete();
        }
      }
    } else {
      _refreshController.loadFailed();
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
              widget.onItemRemoved != null) {
            widget.onItemRemoved!(asT<T>(state.removedItem)!);
          } else if (state is LoadListRunFailure) {
            if (state.error is ServerErrorException) {
              /// do something here.
            }
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
            return widget.loadingWidget ?? const OSLoading();
          }
          if (state is LoadListRunFailure) {
            var errorTitle = widget.errorTitle ?? '';
            if (state.error is TimeoutException) {
              errorTitle = 'Timeout exception! Try again!';
            }

            return widget.errorWidget ??
                ErrorList(
                  errorMessage: widget.errorMessage ?? state.errorMessage,
                  errorTitle: errorTitle,
                  shouldShowReload: widget.shouldShowReload,
                  doReload: _reload,
                );
          }

          if (state is LoadListLoadPageSuccess) {
            return state.items.isEmpty
                ? widget.emptyWidget ??
                    EmptyList(
                      title: widget.emptyTitle!,
                      message: widget.emptyMessage!,
                    )
                : _ScrollbarWrapper(
                    applyScrollbar: widget.applyScrollBar,
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullUp: widget.needLoadMore,
                      enablePullDown: widget.needRefresh,
                      header: ClassicHeader(
                        height: dimen_60.h,
                        spacing: dimen_12.w,
                        idleText: 'Pull to refresh',
                        failedText: 'Load failed.',
                        refreshingText: 'Loading ...',
                        completeText: 'Load completed',
                        releaseText: 'Release to reload',
                        textStyle:
                            Theme.of(context).primaryTextTheme.bodyText2!,
                      ),
                      footer: ClassicFooter(
                        height: dimen_60.h,
                        spacing: dimen_12.w,
                        noDataText: 'You got to the end of the search.',
                        failedText: 'Load failed.',
                        idleText: 'Swipe up to load more',
                        canLoadingText: 'Can loading',
                        loadingText: 'loading ...',
                        textStyle:
                            Theme.of(context).primaryTextTheme.bodyText2!,
                      ),
                      onRefresh: () async {
                        await Future.delayed(
                          const Duration(
                            milliseconds: loadListStartDelayedDuration,
                          ),
                        );
                        await _refresh(context);
                      },
                      onLoading: () async {
                        await Future.delayed(
                          const Duration(
                            milliseconds: loadListLoadMoreDelayedDuration,
                          ),
                        );

                        await _loadMore(context);
                      },
                      child: widget.listRender != null
                          ? widget.listRender!(asT<List<T>>(state.items)!)
                          : LoadListView<T>(
                              items: state.items,
                              scrollController: _scrollController,
                              itemSeparatorBuilder: widget.itemSeparatorBuilder,
                              groupItemBuilder: widget.groupItemBuilder,
                              groupHeaderBuilder: widget.groupHeaderBuilder,
                              groupItemPlaceholderBuilder:
                                  widget.groupItemPlaceholderBuilder,
                              itemPlaceholderBuilder:
                                  widget.itemPlaceholderBuilder,
                              itemBuilder: widget.itemBuilder,
                              scrollPhysics: widget.scrollPhysics,
                              padding: widget.padding,
                              supportFlatGroup: widget.supportFlatGroup,
                              shrinkWrap: widget.shrinkWrap,
                              isManualScrollControl:
                                  widget.isManualScrollControl,
                              shouldShowPlaceholder:
                                  widget.shouldShowPlaceholder,
                            ),
                    ),
                  );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
