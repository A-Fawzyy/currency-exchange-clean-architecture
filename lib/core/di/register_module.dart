import 'package:currency_exchange/util/constants/di_named_keys_constants.dart';
import 'package:currency_exchange/util/constants/environment_keys.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {

  @LazySingleton()
  Dio get dio => Dio();

  @Singleton()
  @Named(DINamedKeysConstants.freeCurrencyApiBaseUrlNamedKey)
  String get baseUrl => EnvironmentKeys.apiBaseUrl.getValue();

  @Singleton()
  @Named(DINamedKeysConstants.freeCurrencyApiKeyNamedKey)
  String get apiKey => EnvironmentKeys.apiKey.getValue();
}
