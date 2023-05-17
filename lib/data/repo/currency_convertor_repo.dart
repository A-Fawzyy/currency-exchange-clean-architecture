import 'dart:async';

import 'package:currency_exchange/core/error_handling/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseCurrencyConvertorRepo)
class CurrencyConvertorRepo implements BaseCurrencyConvertorRepo {
  final BaseCurrencyConvertorDataSource dataSource;
  final BaseCurrencyListRepo currencyListRepository;


  const CurrencyConvertorRepo(
    this.dataSource,
    this.currencyListRepository,
  );

  @override
  Future<Either<Failure, CurrencyListEntity>> getCurrencyList() =>
      currencyListRepository.getCurrencyList();

  @override
  Future<Either<Failure, CurrencyConversionEntity>> convertCurrency(
    ConvertCurrencyRequestEntity params,
  ) async {
    try {
      final amount = await dataSource.convertCurrency(params.toData());
      return Right(amount.toDomain());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrencyHistoryListEntity>> getHistoryForCurrency(
    HistoryCurrencyRequestEntity requestEntity,
  ) async {
    try {
      final response =
          await dataSource.getHistoryForCurrency(requestEntity.toData());
      return Right(response.toDomain());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
