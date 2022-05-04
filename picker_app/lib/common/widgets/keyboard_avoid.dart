import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:picker/common/utils/cast_type.dart';

class KeyboardAvoid extends StatefulWidget {
  final Widget child;

  final Duration duration;

  final Curve curve;

  final bool autoScroll;

  final double focusPadding;

  KeyboardAvoid({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.autoScroll = false,
    this.focusPadding = 12.0,
    // ignore: avoid_bool_literals_in_conditional_expressions
  })  : assert(child is ScrollView ? child.controller != null : true, ''),
        super(key: key);

  @override
  _KeyboardAvoidState createState() => _KeyboardAvoidState();
}

class _KeyboardAvoidState extends State<KeyboardAvoid>
    with WidgetsBindingObserver {
  final _animationKey = GlobalKey<ImplicitlyAnimatedWidgetState>();
  Function(AnimationStatus)? _animationListener;
  late ScrollController _scrollController;
  double _overlap = 0.0;

  ///WidgetBinding Observer
  Timer? _appLifecycleTimer;
  AppLifecycleState _lifecycleState = AppLifecycleState.resumed;
  bool _isResizeScheduled = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance!.removeObserver(this);
    _animationKey.currentState?.animation
        .removeStatusListener(_animationListener!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleTimer?.cancel();

    if (_lifecycleState != AppLifecycleState.resumed &&
        state == AppLifecycleState.resumed) {
      final prevState = _lifecycleState;
      _appLifecycleTimer = Timer(const Duration(milliseconds: 300), () {
        if (prevState == _lifecycleState) {
          _lifecycleState = state;
        }
        if (_isResizeScheduled) {
          didChangeMetrics();
        }
      });
    } else {
      _lifecycleState = state;
    }
  }

  @override
  void didChangeMetrics() {
    if (_lifecycleState != AppLifecycleState.resumed) {
      _isResizeScheduled = true;

      return;
    }

    _isResizeScheduled = false;

    // rare case: there might be no frames scheduled
    // if this is called from didChangeAppLifecycleState
    WidgetsBinding.instance?.scheduleFrame();

    // Need to wait a frame to get the new size
    WidgetsBinding.instance?.addPostFrameCallback(_reSize);
  }

  void _reSize(_) {
    if (!mounted) {
      return;
    }

    final object = context.findRenderObject();
    final box = object as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final widgetRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      box.size.width,
      box.size.height,
    );

    // calculate top of keyboard
    final screenSize = MediaQuery.of(context).size;
    final screenInsets = MediaQuery.of(context).viewInsets;
    final keyboardTop = screenSize.height - screenInsets.bottom;

    // If widget is entirely covered by keyboard, do nothing
    if (widgetRect.top > keyboardTop) {
      return;
    }

    // If widget is partially obscured by the keyboard, adjust bottom padding
    // to fully expose it.
    final overlap = max(0.0, widgetRect.bottom - keyboardTop);
    if (overlap != _overlap) {
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0.0;
      // The overlap is not because of the keyboard. So ignore it.
      if (overlap > 0.0 && !keyboardVisible) {
        return;
      }
      setState(() {
        _overlap = overlap;
      });
    }
  }

  void _keyboardShown() {
    // If auto scroll is not enabled, do nothing
    if (!widget.autoScroll) {
      return;
    }

    // Need to wait a frame to get the new size
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToFocusedObject();
    });
  }

  void _scrollToFocusedObject() {
    final object = context.findRenderObject();
    if (object != null) {
      final focused = _findFocusedObject(object);
      if (focused != null) {
        _scrollToObject(focused);
      }
    }
  }

  // Finds the first focused [RenderEditable] child of [root]
  // using a breadth-first search.
  RenderObject? _findFocusedObject(RenderObject root) {
    final queue = Queue<RenderObject>()..add(root);

    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      if (node is RenderEditable && node.hasFocus) {
        return node;
      }

      node.visitChildren(queue.add);
    }

    return null;
  }

  void _scrollToObject(RenderObject object) {
    // Calculate the offset needed to show the object in the [ScrollView]
    // so that its bottom touches the top of the keyboard.
    final viewport = RenderAbstractViewport.of(object);
    if (viewport != null) {
      final offset =
          viewport.getOffsetToReveal(object, 1.0).offset + widget.focusPadding;

      // If the object is covered by the keyboard, scroll to reveal it,
      // and add [focusPadding] between it and top of the keyboard.
      if (offset > _scrollController.position.pixels) {
        _scrollController.position.moveTo(
          offset,
          duration: widget.duration,
          curve: widget.curve,
        );
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0.0;
      if (keyboardVisible) {
        _keyboardShown();
      }
    }
  }

  // Add a status listener to the animation after the initial build.
  // Wait a frame so that _animationKey.currentState is not null.
  void _onAnimationListener() {
    if (_animationListener == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _animationListener = _animationStatusChanged;
        _animationKey.currentState?.animation
            .addStatusListener(_animationListener!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _onAnimationListener();

    if (widget.child is ScrollView) {
      final scrollView = asT<ScrollView>(widget.child)!;
      _scrollController = scrollView.controller!;
      return AnimatedContainer(
        key: _animationKey,
        padding: EdgeInsets.only(bottom: _overlap),
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      );
    }

    if (widget.autoScroll) {
      _scrollController = ScrollController();
      return AnimatedContainer(
        key: _animationKey,
        padding: EdgeInsets.only(bottom: _overlap),
        duration: widget.duration,
        curve: widget.curve,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: widget.child,
              ),
            );
          },
        ),
      );
    }

    // Just embed the [child] directly in an [AnimatedContainer].
    return AnimatedContainer(
      key: _animationKey,
      padding: EdgeInsets.only(bottom: _overlap),
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
    );
  }
}
