import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/get_currency_history_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'currency_history_state.dart';

@injectable
class CurrencyHistoryCubit extends Cubit<CurrencyHistoryState> {
  final GetCurrencyHistoryUseCase _getCurrencyHistoryUseCase;

  CurrencyHistoryCubit(this._getCurrencyHistoryUseCase) : super(const CurrencyHistoryState());

  Future<void> getCurrencyHistory({
    required CurrencyEntity? fromCurrency,
    required CurrencyEntity? toCurrency,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _getCurrencyHistoryUseCase(
      HistoryCurrencyRequestEntity(
        from: fromCurrency,
        to: toCurrency,
      ),
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: CubitStatus.failure,
            failureMessage: error.message,
          ),
        );
      },
      (history) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            currencyHistoryList: history.currencyHistoryList,
          ),
        );
      },
    );
  }
}
