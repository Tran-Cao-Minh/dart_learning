import 'package:equatable/equatable.dart';
import 'package:picker/domain/entity/entity.dart';

abstract class LoadListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadListInitial extends LoadListState {}

class LoadListStartInProgress extends LoadListState {}

class LoadListLoadPageSuccess<T extends Entity> extends LoadListState {
  final List<T> items;
  final int nextPage;
  final bool isFinish;

  LoadListLoadPageSuccess(
      this.items, {
        this.nextPage = 0,
        this.isFinish = false,
      });

  @override
  List<Object> get props => [
    items,
    nextPage,
    isFinish,
  ];
}

class LoadListRunFailure extends LoadListState {
  final String errorMessage;
  final dynamic error;

  LoadListRunFailure(this.errorMessage, this.error);

  @override
  List<Object> get props => [errorMessage];
}

class LoadListRemoveItemSuccess<T extends Object> extends LoadListState {
  final T removedItem;

  LoadListRemoveItemSuccess(this.removedItem);

  @override
  List<Object> get props => [removedItem];
}
