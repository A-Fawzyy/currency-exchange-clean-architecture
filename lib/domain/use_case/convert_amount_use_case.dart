import 'package:currency_exchange/core/base/base_use_case.dart';
import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/base_repo/base_currency_convertor_repo.dart';
import 'package:currency_exchange/domain/entity/currency_request/convert_currency_request_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Converts an amount from one currency to another
@LazySingleton()
class ConvertAmountUseCase
    extends BaseUseCase<double, ConvertCurrencyRequestEntity> {
  final BaseCurrencyConvertorRepo _currencyRepository;

  ConvertAmountUseCase(this._currencyRepository);

  @override
  Future<Either<Failure, double>> call(ConvertCurrencyRequestEntity params) {
    return _currencyRepository.convertCurrency(params);
  }
}
