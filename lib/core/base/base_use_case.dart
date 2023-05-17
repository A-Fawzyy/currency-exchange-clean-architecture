import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/entity/history/currency_history_list_entity.dart';
import 'package:dartz/dartz.dart';

/// Base class for all use cases
/// [Type] is the return type of the use case
/// [Params] is the type of the parameter
///
/// For example, if the use case is to get a currency history,
/// then [Type] will be [CurrencyHistoryListEntity] and [Params]
/// will be [CurrencyHistoryRequestEntity]
///
abstract class BaseUseCase<Type, Params> {
  /// Executes the use case
  ///
  /// [params] is the parameter to be passed to the use case
  /// Returns the result of the use case
  ///
  /// This is callable class so that it can be called directly
  /// without having to create an instance of the class
  /// example: GetCurrencyListUseCase() instead of GetCurrencyListUseCase().call()
  ///
  Future<Either<Failure, Type>> call(Params params);
}
