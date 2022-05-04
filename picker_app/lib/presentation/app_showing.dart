import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/presentation/blocs/blocs.dart';

class AppShowing extends StatelessWidget {
  final Widget child;

  AppShowing({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: BlocBuilder<LoaderBloc, LoaderState>(
            builder: (context, state) {
              if (state is LoaderStartSuccess) {
                return Material(
                  type: MaterialType.transparency,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(
                        child: OSLoading(),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
