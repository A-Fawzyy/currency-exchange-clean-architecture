part of 'currency_list_cubit.dart';

@immutable
class CurrencyListState extends BaseState {
  final CurrencyListEntity? currencies;

  const CurrencyListState({
    super.status = CubitStatus.initial,
    super.failureMessage,
    this.currencies,
  });

  factory CurrencyListState.initial() => const CurrencyListState(
        currencies: CurrencyListEntity(),
      );

  CurrencyListState copyWith({
    CurrencyListEntity? currencies,
    CubitStatus? status,
    String? failureMessage,
  }) {
    return CurrencyListState(
      currencies: currencies ?? this.currencies,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        currencies,
        failureMessage,
        status,
      ];
}
