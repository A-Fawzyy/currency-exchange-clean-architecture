import 'dart:async';

import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCurrencyListRepo {
  Future<Either<Failure, CurrencyListEntity>> getCurrencyList();
}
