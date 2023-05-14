import 'package:currency_exchange/core/base/base_use_case.dart';
import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/base_repo/base_currency_convertor_repo.dart';
import 'package:currency_exchange/domain/entity/currency_request/history_currency_request_entity.dart';
import 'package:currency_exchange/domain/entity/history/currency_history_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Returns a list of all supported currencies
///
@LazySingleton()
class GetCurrencyHistoryUseCase extends BaseUseCase<CurrencyHistoryListEntity,
    HistoryCurrencyRequestEntity> {
  final BaseCurrencyConvertorRepo _currencyRepository;

  GetCurrencyHistoryUseCase(this._currencyRepository);

  @override
  Future<Either<Failure, CurrencyHistoryListEntity>> call(
    HistoryCurrencyRequestEntity params,
  ) async {
    return _currencyRepository.getHistoryForCurrency(params);
  }
}
