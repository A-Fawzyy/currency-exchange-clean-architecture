part of 'currency_selection_cubit.dart';

class CurrencySelectionState extends BaseState {
  const CurrencySelectionState({
    super.status = CubitStatus.initial,
    super.failureMessage,
    this.selectedFromCurrency,
    this.selectedToCurrency,
  });

  final CurrencyEntity? selectedFromCurrency;
  final CurrencyEntity? selectedToCurrency;

  bool get isReadyToConvert =>
      selectedFromCurrency != null && selectedToCurrency != null;

  CurrencySelectionState clearFromCurrency() => CurrencySelectionState(
        selectedToCurrency: selectedToCurrency,
        status: status,
        failureMessage: failureMessage,
      );

  CurrencySelectionState clearToCurrency() => CurrencySelectionState(
        selectedFromCurrency: selectedFromCurrency,
        status: status,
        failureMessage: failureMessage,
      );

  CurrencySelectionState copyWith({
    CurrencyEntity? selectedFromCurrency,
    CurrencyEntity? selectedToCurrency,
    CubitStatus? status,
    String? failureMessage,
    bool? shouldConvertLocally,
  }) =>
      CurrencySelectionState(
        selectedFromCurrency: selectedFromCurrency ?? this.selectedFromCurrency,
        selectedToCurrency: selectedToCurrency ?? this.selectedToCurrency,
        status: status ?? this.status,
        failureMessage: failureMessage ?? this.failureMessage,
      );

  CurrencySelectionState swapCurrencies({
    CurrencyEntity? selectedFromCurrency,
    CurrencyEntity? selectedToCurrency,
  }) =>
      CurrencySelectionState(
        selectedFromCurrency: selectedFromCurrency,
        selectedToCurrency: selectedToCurrency,
      );

  @override
  List<Object?> get props => [
        selectedFromCurrency,
        selectedToCurrency,
        status,
        failureMessage,
      ];
}
