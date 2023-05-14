import 'package:currency_exchange/data/model/history/currency_history_day_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CurrencyHistoryListModel extends Equatable {
  const CurrencyHistoryListModel({
    this.currencyHistoryList,
  });

  final List<CurrencyHistoryDayModel>? currencyHistoryList;

  factory CurrencyHistoryListModel.fromJson(Map<String, dynamic> map) {
    if (map['data'] == null) {
      return const CurrencyHistoryListModel(currencyHistoryList: []);
    }

    final data = map['data'] as Map<String, Map<String, dynamic>>;
    final list = mapJsonToCurrencyHistoryList(data);
    final mappedList =
        list.map((e) => CurrencyHistoryDayModel.fromJson(e)).toList();
    return CurrencyHistoryListModel(currencyHistoryList: mappedList);
  }

  static List<Map<String, dynamic>> mapJsonToCurrencyHistoryList(
    Map<String, Map<String, dynamic>> data,
  ) {
    final List<Map<String, dynamic>> currencyHistoryList = [];

    for (int i = 0; i < data.keys.length; i++) {
      final currentDate = data.keys.elementAt(i);
      final currencyName = data.values.elementAt(i).keys.elementAt(0);
      final currencyValue = data.values.elementAt(i).values.elementAt(0);
      final currentMap = <String, dynamic>{};
      currentMap['date'] = currentDate;
      currentMap['name'] = currencyName;
      currentMap['value'] = currencyValue;
      currencyHistoryList.add(currentMap);
    }
    return currencyHistoryList;
  }

  @override
  List<Object?> get props => [currencyHistoryList];
}
