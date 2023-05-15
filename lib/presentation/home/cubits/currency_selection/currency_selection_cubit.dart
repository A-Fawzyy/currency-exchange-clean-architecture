import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:injectable/injectable.dart';

part 'currency_selection_state.dart';

@injectable
class CurrencySelectionCubit extends Cubit<CurrencySelectionState> {
  CurrencySelectionCubit() : super(const CurrencySelectionState());

  void selectFromCurrency(CurrencyEntity currency) {
    _handleCurrencySelection(
      currency,
      selectedCurrency: state.selectedToCurrency,
      onClear: () => state.clearToCurrency(),
      onUpdate: (s) => emit(s.copyWith(selectedFromCurrency: currency)),
    );
  }

  void selectToCurrency(CurrencyEntity currency) {
    _handleCurrencySelection(
      currency,
      selectedCurrency: state.selectedFromCurrency,
      onClear: () => state.clearFromCurrency(),
      onUpdate: (s) => emit(s.copyWith(selectedToCurrency: currency)),
    );
  }

  void _handleCurrencySelection(
    CurrencyEntity currency, {
    required CurrencyEntity? selectedCurrency,
    required CurrencySelectionState Function() onClear,
    required Function(CurrencySelectionState) onUpdate,
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
