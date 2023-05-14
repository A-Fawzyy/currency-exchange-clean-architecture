import 'package:currency_exchange/core/di/dependency_injector.dart';
import 'package:currency_exchange/presentation/app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await dotenv.load(fileName: 'keys.env');
  runApp(const CurrencyConvertorApp());
}
