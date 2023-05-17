part of 'currency_list_cubit.dart';

@immutable
class CurrencyListState extends BaseState {
  final List<CurrencyEntity> currencies;

  const CurrencyListState({
    super.status = CubitStatus.initial,
    super.failureMessage,
    this.currencies = const [],
  });

  CurrencyListState copyWith({
    List<CurrencyEntity>? currencies,
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
