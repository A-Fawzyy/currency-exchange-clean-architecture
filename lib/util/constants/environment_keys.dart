import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentKeys {
  apiBaseUrl('FREE_CURRENCY_API_BASE_URL'),
  apiKey('API_KEY');

  final String _keyName;
  const EnvironmentKeys(this._keyName);

  String getValue() => dotenv.env[_keyName] ?? '';
}
