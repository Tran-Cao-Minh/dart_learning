import 'package:flutter/material.dart';

class _PlaceholderItemLayout extends StatelessWidget {
  _PlaceholderItemLayout({
    Key? key,
    required this.child,
    required this.placeholder,
  }) : super(key: key);

  final Widget child;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ListItemLayout extends StatelessWidget {
  ListItemLayout({
    Key? key,
    required this.child,
    required this.placeholder,
    required this.shouldShowPlaceholder,
  }) : super(key: key);

  final Widget child;
  final Widget placeholder;
  final bool shouldShowPlaceholder;

  @override
  Widget build(BuildContext context) {
    if (shouldShowPlaceholder) {
      return _PlaceholderItemLayout(
        placeholder: placeholder,
        child: child,
      );
    }

    return child;
  }
}
