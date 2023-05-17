import 'package:currency_exchange/core/infrastructure/database/base_database.dart';
import 'package:currency_exchange/data/model/currency_list/currency_model.dart';
import 'package:currency_exchange/util/constants/database_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseDatabase)
class HiveDatabaseClient implements BaseDatabase {
  @override
  Future<void> init() async {
    await Hive.initFlutter();

    // region register adapters
    Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
    // endregion

    // region open boxes
    await Hive.openBox<CurrencyModel>(DatabaseConstants.currenciesBoxKey);
    // endregion
  }

  @override
  Future<void> save<T>({
    required String tableName,
    required String key,
    required T value,
  }) async {
    final box = Hive.box<T>(tableName);
    return box.put(key, value);
  }

  @override
  Future<void> saveAll<T>({
required String tableName,
    required List<T>? list,
    required List<dynamic>? keys,
  }) async {
    if(list != null && keys != null && list.length == keys.length){
      final box = Hive.box<T>(tableName);
      for (int i = 0; i < list.length; i++) {
        await box.put(keys[i], list[i]);
      }
    }
  }

  @override
  Future<T?> get<T>({
    required String tableName,
    required String key,
  }) async {
    final box = Hive.box<T>(tableName);
    return box.get(key);
  }

  @override
  List<T>? getAll<T>({
    required String tableName,
  }) {
    final box = Hive.box<T>(tableName);
    return box.values.toList();
  }

  @override
  Future<void> delete({
    required String tableName,
    required String key,
  }) async {
    final box = Hive.box(tableName);
    return box.delete(key);
  }

  @override
  Future<int> clear({
    required String tableName,
  }) async {
    final box = Hive.box(tableName);
    return box.clear();
  }
}
