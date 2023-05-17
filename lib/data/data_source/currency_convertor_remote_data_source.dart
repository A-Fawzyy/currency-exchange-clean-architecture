import 'dart:convert';

import 'package:currency_exchange/core/infrastructure/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/util/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseCurrencyConvertorDataSource)
class CurrencyConvertorRemoteDataSource implements BaseCurrencyConvertorDataSource {
  final BaseNetworkClient client;

  const CurrencyConvertorRemoteDataSource(this.client);

  @override
  Future<CurrencyConversionModel> convertCurrency(
    ConvertCurrencyRequestModel request,
  ) async {
    final response = await client.get(
      ApiConstants.latestCurrencyPath,
      queryParameters: {
        ApiQueryParamsKeys.baseCurrency: request.from?.code,
        ApiQueryParamsKeys.currencies: request.to?.code,
      },
    );
    final parsedJson = json.decode(response.toString());
    final conversionRate = parsedJson['data'][request.to?.code] as double;
    final result = CurrencyConversionModel(
      fromAmount: request.amount ?? .0,
      conversionRate: conversionRate,
    );
    return result;
  }

  @override
  Future<CurrencyHistoryListModel> getHistoryForCurrency(
    HistoryCurrencyRequestModel request,
  ) async {
    final dateTo = DateTime.now().subtract(const Duration(days: 2)).toUtc();
    final dateFrom = dateTo.subtract(const Duration(days: 9)).toUtc();

    try {
      final response = await client.get(
        ApiConstants.currencyHistoryPath,
        queryParameters: {
          ApiQueryParamsKeys.currencies: request.to?.code,
          ApiQueryParamsKeys.dateFrom: dateFrom,
          ApiQueryParamsKeys.dateTo: dateTo,
        },
      );

      final decodedJson = json.decode(response.toString());
      final historyList =
          CurrencyHistoryListModel.fromJson(decodedJson as Map<String, dynamic>);
      return historyList;
    } catch (e) {
      debugPrint((e as DioError).response?.data.toString());
      rethrow;
    }
  }
}
