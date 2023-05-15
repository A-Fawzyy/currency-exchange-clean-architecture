// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/base_data_source/index.dart' as _i7;
import '../../data/data_source/currency_convertor_remote_data_source.dart'
    as _i8;
import '../../data/data_source/currency_list_remote_data_source.dart' as _i10;
import '../../data/repo/currency_convertor_repo.dart' as _i12;
import '../../domain/base_repo/base_currency_convertor_repo.dart' as _i11;
import '../../domain/use_case/convert_amount_use_case.dart' as _i13;
import '../../domain/use_case/get_currency_history_use_case.dart' as _i15;
import '../../domain/use_case/get_currency_list_use_case.dart' as _i16;
import '../../presentation/home/cubits/currency_conversion_cubit/currency_conversion_cubit.dart'
    as _i14;
import '../../presentation/home/cubits/currency_history_cubit/currency_history_cubit.dart'
    as _i17;
import '../../presentation/home/cubits/currency_list_cubit/currency_list_cubit.dart'
    as _i18;
import '../../presentation/home/cubits/currency_selection/currency_selection_cubit.dart'
    as _i3;
import '../infrastructure/base_network_client.dart' as _i5;
import '../infrastructure/dio_client.dart' as _i6;
import '../infrastructure/index.dart' as _i9;
import 'register_module.dart' as _i19;

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
    gh.factory<_i3.CurrencySelectionCubit>(() => _i3.CurrencySelectionCubit());
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.singleton<String>(
      registerModule.baseUrl,
      instanceName: 'FREE_CURRENCY_API_BASE_URL_DI_KEY',
    );
    gh.singleton<String>(
      registerModule.apiKey,
      instanceName: 'FREE_CURRENCY_API_KEY_DI_KEY',
    );
    gh.lazySingleton<_i5.BaseNetworkClient>(() => _i6.DioClient(
          gh<_i4.Dio>(),
          gh<String>(instanceName: 'FREE_CURRENCY_API_BASE_URL_DI_KEY'),
          gh<String>(instanceName: 'FREE_CURRENCY_API_KEY_DI_KEY'),
        ));
    gh.lazySingleton<_i7.BaseCurrencyConvertorDataSource>(() =>
        _i8.CurrencyConvertorRemoteDataSource(gh<_i9.BaseNetworkClient>()));
    gh.lazySingleton<_i7.BaseCurrencyListDataSource>(
        () => _i10.CurrencyListRemoteDataSource(gh<_i9.BaseNetworkClient>()));
    gh.lazySingleton<_i11.BaseCurrencyConvertorRepo>(
        () => _i12.CurrencyConvertorRepo(
              gh<_i7.BaseCurrencyConvertorDataSource>(),
              gh<_i7.BaseCurrencyListDataSource>(),
            ));
    gh.lazySingleton<_i13.ConvertAmountUseCase>(
        () => _i13.ConvertAmountUseCase(gh<_i11.BaseCurrencyConvertorRepo>()));
    gh.factory<_i14.CurrencyConversionCubit>(
        () => _i14.CurrencyConversionCubit(gh<_i13.ConvertAmountUseCase>()));
    gh.lazySingleton<_i15.GetCurrencyHistoryUseCase>(() =>
        _i15.GetCurrencyHistoryUseCase(gh<_i11.BaseCurrencyConvertorRepo>()));
    gh.lazySingleton<_i16.GetCurrencyListUseCase>(() =>
        _i16.GetCurrencyListUseCase(gh<_i11.BaseCurrencyConvertorRepo>()));
    gh.factory<_i17.CurrencyHistoryCubit>(
        () => _i17.CurrencyHistoryCubit(gh<_i15.GetCurrencyHistoryUseCase>()));
    gh.factory<_i18.CurrencyListCubit>(
        () => _i18.CurrencyListCubit(gh<_i16.GetCurrencyListUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
