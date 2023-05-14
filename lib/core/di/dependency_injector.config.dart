// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/base_data_source/index.dart' as _i6;
import '../../data/data_source/currency_convertor_remote_data_source.dart'
    as _i7;
import '../../data/data_source/currency_list_remote_data_source.dart' as _i9;
import '../../data/repo/currency_convertor_repo.dart' as _i11;
import '../../domain/base_repo/base_currency_convertor_repo.dart' as _i10;
import '../../domain/use_case/convert_amount_use_case.dart' as _i12;
import '../../domain/use_case/get_currency_history_use_case.dart' as _i13;
import '../../domain/use_case/get_currency_list_use_case.dart' as _i14;
import '../../presentation/home/cubits/currency_list_cubit/currency_list_cubit.dart'
    as _i15;
import '../infrastructure/base_network_client.dart' as _i4;
import '../infrastructure/dio_client.dart' as _i5;
import '../infrastructure/index.dart' as _i8;
import 'register_module.dart' as _i16;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.dio);
    gh.singleton<String>(
      registerModule.baseUrl,
      instanceName: 'FREE_CURRENCY_API_BASE_URL_DI_KEY',
    );
    gh.singleton<String>(
      registerModule.apiKey,
      instanceName: 'FREE_CURRENCY_API_KEY_DI_KEY',
    );
    gh.lazySingleton<_i4.BaseNetworkClient>(() => _i5.DioClient(
          gh<_i3.Dio>(),
          gh<String>(instanceName: 'FREE_CURRENCY_API_BASE_URL_DI_KEY'),
          gh<String>(instanceName: 'FREE_CURRENCY_API_KEY_DI_KEY'),
        ));
    gh.lazySingleton<_i6.BaseCurrencyConvertorDataSource>(() =>
        _i7.CurrencyConvertorRemoteDataSource(gh<_i8.BaseNetworkClient>()));
    gh.lazySingleton<_i6.BaseCurrencyListDataSource>(
        () => _i9.CurrencyListRemoteDataSource(gh<_i8.BaseNetworkClient>()));
    gh.lazySingleton<_i10.BaseCurrencyConvertorRepo>(
        () => _i11.CurrencyConvertorRepo(
              gh<_i6.BaseCurrencyConvertorDataSource>(),
              gh<_i6.BaseCurrencyListDataSource>(),
            ));
    gh.lazySingleton<_i12.ConvertAmountUseCase>(
        () => _i12.ConvertAmountUseCase(gh<_i10.BaseCurrencyConvertorRepo>()));
    gh.lazySingleton<_i13.GetCurrencyHistoryUseCase>(() =>
        _i13.GetCurrencyHistoryUseCase(gh<_i10.BaseCurrencyConvertorRepo>()));
    gh.lazySingleton<_i14.GetCurrencyListUseCase>(() =>
        _i14.GetCurrencyListUseCase(gh<_i10.BaseCurrencyConvertorRepo>()));
    gh.factory<_i15.CurrencyListCubit>(() => _i15.CurrencyListCubit(
        getCurrencyListUseCase: gh<_i14.GetCurrencyListUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i16.RegisterModule {}
