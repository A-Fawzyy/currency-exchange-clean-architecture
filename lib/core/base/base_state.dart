import 'package:currency_exchange/core/base/cubit_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class BaseState extends Equatable {
  final CubitStatus status;
  final String? failureMessage;

  bool get isLoading => status == CubitStatus.loading;

  const BaseState({
    this.status = CubitStatus.initial,
    this.failureMessage,
  });

  @override
  List<Object?> get props => [
    status,
    failureMessage,
  ];
}
