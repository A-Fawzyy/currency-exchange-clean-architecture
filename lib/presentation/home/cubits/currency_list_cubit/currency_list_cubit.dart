import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/currency_list/index.dart';
import 'package:currency_exchange/domain/use_case/get_currency_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'currency_list_state.dart';

@injectable
class CurrencyListCubit extends Cubit<CurrencyListState> {
  final GetCurrencyListUseCase _getCurrencyListUseCase;

  CurrencyListCubit(
    this._getCurrencyListUseCase,
  ) : super(const CurrencyListState());

  Future<void> getCurrencyList() async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _getCurrencyListUseCase(null);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: CubitStatus.failure,
            failureMessage: error.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            currencies: data.currencyList,
          ),
        );
      },
    );
  }
}
