class ApiConstants {
  static String flagBaseUrl(String languageCode) =>
      'https://flagcdn.com/w40/$languageCode.png';

  static const String latestCurrencyPath = 'latest';

  static const String currencyHistoryPath = 'historical';

  static const String currencyListPath = 'currencies';
}

class ApiQueryParamsKeys {
  static const String apiKey = 'apikey';
  static const String currencies = 'currencies';
  static const String baseCurrency = 'base_currency';
  static const String dateFrom = 'date_from';
  static const String dateTo = 'date_to';

}
