import 'package:currency_exchange/core/base/base_state.dart';
import 'package:currency_exchange/core/base/base_widgets/app_error_widget.dart';
import 'package:currency_exchange/core/base/cubit_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocConsumer<T extends Cubit<S>, S extends BaseState>
    extends StatelessWidget {
  final void Function(BuildContext context, S state)? listener;

  final Widget Function(BuildContext context, S state) onSuccess;
  final Widget Function(BuildContext context, S state)? onFailure;
  final Widget Function(BuildContext context, S state)? onLoading;

  const BaseBlocConsumer({
    super.key,
    required this.onSuccess,
    this.listener,
    this.onFailure,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, S>(
      listener: (context, state) {
        if (listener != null) {
          listener?.call(context, state);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CubitStatus.initial:
          case CubitStatus.loading:
            return onLoading?.call(context, state) ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          case CubitStatus.failure:
            return onFailure?.call(context, state) ??
                AppErrorWidget(message: state.failureMessage);
          case CubitStatus.success:
            return onSuccess(context, state);
        }
      },
    );
  }
}
