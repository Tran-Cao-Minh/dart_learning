import 'package:equatable/equatable.dart';

abstract class LoaderState extends Equatable {
  LoaderState();

  @override
  List<Object> get props => [];
}

class LoaderInitial extends LoaderState {}

class LoaderStartSuccess extends LoaderState {}

class LoaderStopSuccess extends LoaderState {}
