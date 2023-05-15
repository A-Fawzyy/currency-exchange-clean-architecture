part of 'currency_conversion_cubit.dart';

class CurrencyConversionState extends BaseState {
  final double? fromAmount;
  final double? conversionRate;
  final double? convertedAmount;

  const CurrencyConversionState({
    this.fromAmount = 0,
    this.conversionRate = 0,
    this.convertedAmount = 0,
    super.status = CubitStatus.initial,
    super.failureMessage,
  });

  @override
  List<Object?> get props => [
        fromAmount,
        conversionRate,
        convertedAmount,
        status,
        failureMessage,
      ];

  CurrencyConversionState copyWith({
    double? fromAmount,
    double? conversionRate,
    double? convertedAmount,
    CubitStatus? status,
    String? failureMessage,
  }) {
    return CurrencyConversionState(
      fromAmount: fromAmount ?? this.fromAmount,
      conversionRate: conversionRate ?? this.conversionRate,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}
