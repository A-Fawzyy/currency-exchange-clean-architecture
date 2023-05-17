import 'package:currency_exchange/core/di/dependency_injector.dart';
import 'package:currency_exchange/core/infrastructure/database/index.dart';
import 'package:currency_exchange/presentation/app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'keys.env');
  configureDependencies();
  await di<BaseDatabase>().init();
  runApp(const CurrencyConvertorApp());
}
