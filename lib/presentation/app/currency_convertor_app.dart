import 'package:currency_exchange/presentation/home/page/home_page.dart';
import 'package:flutter/material.dart';

class CurrencyConvertorApp extends StatelessWidget {
  const CurrencyConvertorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Convertor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
