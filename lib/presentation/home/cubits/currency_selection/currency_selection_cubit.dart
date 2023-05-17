import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:injectable/injectable.dart';

part 'currency_selection_state.dart';

typedef OnBothCurrenciesSelected = Future<void> Function({
required CurrencyEntity? fromCurrency,
required CurrencyEntity? toCurrency,
});


@injectable
class CurrencySelectionCubit extends Cubit<CurrencySelectionState> {
  CurrencySelectionCubit() : super(const CurrencySelectionState());

  void selectFromCurrency(
    CurrencyEntity currency,
    OnBothCurrenciesSelected onBothCurrenciesSelected,
  ) {
    _handleCurrencySelection(
      currency,
      selectedCurrency: state.selectedToCurrency,
      onClear: () => state.clearToCurrency(),
      onUpdate: (s) => emit(s.copyWith(selectedFromCurrency: currency)),
      onBothCurrenciesSelected: onBothCurrenciesSelected,
    );
  }

  void selectToCurrency(
    CurrencyEntity currency,
    OnBothCurrenciesSelected onBothCurrenciesSelected,
  ) {
    _handleCurrencySelection(
      currency,
      selectedCurrency: state.selectedFromCurrency,
      onClear: () => state.clearFromCurrency(),
      onUpdate: (s) => emit(s.copyWith(selectedToCurrency: currency)),
      onBothCurrenciesSelected: onBothCurrenciesSelected,
    );
  }

  void _handleCurrencySelection(
    CurrencyEntity currency, {
    required CurrencyEntity? selectedCurrency,
    required CurrencySelectionState Function() onClear,
    required Function(CurrencySelectionState) onUpdate,
    required OnBothCurrenciesSelected onBothCurrenciesSelected,
  }) {
    final shouldSwapCurrencies =
        currency == selectedCurrency && selectedCurrency != null;

    if (selectedCurrency == null && state.selectedFromCurrency == currency) {
      final clearedState = onClear();
      onUpdate(clearedState);
    } else if (shouldSwapCurrencies) {
      _swapCurrencies();
    } else {
      onUpdate(state);
      onBothCurrenciesSelected(
        fromCurrency: state.selectedFromCurrency,
        toCurrency: state.selectedToCurrency,
      );
    }
  }

  void updateShouldConvertLocally(bool shouldConvertLocally) {
    emit(state.copyWith(shouldConvertLocally: shouldConvertLocally));
  }

  void _swapCurrencies() {
    emit(
      state.swapCurrencies(
        selectedFromCurrency: state.selectedToCurrency,
        selectedToCurrency: state.selectedFromCurrency,
      ),
    );
  }
}
