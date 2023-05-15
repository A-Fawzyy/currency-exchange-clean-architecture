import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/convert_amount_use_case.dart';
import 'package:injectable/injectable.dart';

part 'currency_conversion_state.dart';

@injectable
class CurrencyConversionCubit extends Cubit<CurrencyConversionState> {
  final ConvertAmountUseCase _convertAmountUseCase;

  CurrencyConversionCubit(
    this._convertAmountUseCase,
  ) : super(const CurrencyConversionState());

  void convertCurrency({
    required CurrencyEntity? fromCurrency,
    required CurrencyEntity? toCurrency,
    required double amount,
    required void Function() onSuccess,
  }) {
    emit(state.copyWith(status: CubitStatus.loading));

    final params = ConvertCurrencyRequestEntity(
      from: fromCurrency,
      to: toCurrency,
      amount: amount,
    );
    _convertAmountUseCase(params).then(
      (result) {
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
            onSuccess();
            emit(
              state.copyWith(
                fromAmount: data.convertedAmount,
                conversionRate: data.conversionRate,
                convertedAmount: data.convertedAmount,
                status: CubitStatus.success,
              ),
            );
          },
        );
      },
    );
  }

  void resetState() {
    emit(const CurrencyConversionState());
  }

  void updateAmount(String value) {
    final amount = double.tryParse(value) ?? 0;
    emit(state.copyWith(fromAmount: amount));
  }
}
