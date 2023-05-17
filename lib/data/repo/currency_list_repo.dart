import 'dart:async';

import 'package:currency_exchange/core/error_handling/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseCurrencyListRepo)
class CurrencyListRepo implements BaseCurrencyListRepo {
  final BaseCurrencyListDataSource remoteCurrencyListDataSource;
  final BaseCurrencyListLocalDataSource localCurrencyListDataSource;

  CurrencyListRepo({
    required this.remoteCurrencyListDataSource,
    required this.localCurrencyListDataSource,
  });

  @override
  Future<Either<Failure, CurrencyListEntity>> getCurrencyList() async {
    final localResult = await _getLocalCurrencyList();
    return localResult.fold(
      (_) => _getRemoteCurrencyList(),
      (local) => Future.value(Right(local)),
    );
  }

  Future<Either<Failure, CurrencyListEntity>> _getLocalCurrencyList() async {
    try {
      final currencyListFromLocalDataSource =
          await localCurrencyListDataSource.getAllSupportedCurrencies();
      final isCurrencyListAvailableLocally =
          currencyListFromLocalDataSource.currencyList?.isNotEmpty == true;

      if (isCurrencyListAvailableLocally) {
        return Right(currencyListFromLocalDataSource.toDomain());
      } else {
        return Left(CurrencyListNotFound());
      }
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, CurrencyListEntity>> _getRemoteCurrencyList() async {
    try {
      final response =
          await remoteCurrencyListDataSource.getAllSupportedCurrencies();
      await localCurrencyListDataSource.saveSupportedCurrencies(response);
      return Right(response.toDomain());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
