import 'package:currency_exchange/domain/entity/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const fromAmount = 100.0;
  const conversionRate = 0.85;
  const convertedAmount = 85.0;

  const sut = CurrencyConversionEntity(
    fromAmount: fromAmount,
    conversionRate: conversionRate,
    convertedAmount: convertedAmount,
  );

  group('constructor', () {
    test('upon creation, entity should have correct properties', () {
      expect(sut.fromAmount, fromAmount);
      expect(sut.conversionRate, conversionRate);
      expect(sut.convertedAmount, convertedAmount);
    });
    test('constructor should throw AssertionError when fromAmount is negative',
        () {
      expect(
        () => CurrencyConversionEntity(
          fromAmount: -1,
          conversionRate: 0.85,
          convertedAmount: 85.0,
        ),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'fromAmount must be greater than 0',
          ),
        ),
      );
    });

    test(
        'constructor should throw AssertionError when conversionRate is negative',
        () {
      expect(
        () => CurrencyConversionEntity(
          fromAmount: 100,
          conversionRate: -0.85,
          convertedAmount: 85.0,
        ),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'conversionRate must be greater than 0',
          ),
        ),
      );
    });

    test(
        'constructor should throw AssertionError when convertedAmount is negative',
        () {
      expect(
        () => CurrencyConversionEntity(
          fromAmount: 100,
          conversionRate: 0.85,
          convertedAmount: -85.0,
        ),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'convertedAmount must be greater than 0',
          ),
        ),
      );
    });
  });

  group('copyWith', () {
    test('copyWith with fromAmount, should create a copy correctly', () {
      final copy = sut.copyWith(fromAmount: 60.0);

      expect(copy.fromAmount, 60.0);
      expect(copy.conversionRate, sut.conversionRate);
      expect(copy.convertedAmount, sut.convertedAmount);
    });

    test('copyWith with conversionRate, should create a copy correctly', () {
      final copy = sut.copyWith(conversionRate: 0.70);

      expect(copy.fromAmount, sut.fromAmount);
      expect(copy.conversionRate, 0.70);
      expect(copy.convertedAmount, sut.convertedAmount);
    });

    test('copyWith with convertedAmount, should create a copy correctly', () {
      final copy = sut.copyWith(convertedAmount: 80.0);

      expect(copy.fromAmount, sut.fromAmount);
      expect(copy.conversionRate, sut.conversionRate);
      expect(copy.convertedAmount, 80.0);
    });

    test('copyWith should correctly create an identical copy', () {
      final copy = sut.copyWith();

      expect(copy.fromAmount, sut.fromAmount);
      expect(copy.conversionRate, sut.conversionRate);
      expect(copy.convertedAmount, sut.convertedAmount);
    });
  });

  group('equality and stringification', () {
    const usdCurrency = CurrencyEntity(code: 'USD', name: 'United States Dollar');
    const eurCurrency = CurrencyEntity(code: 'EUR', name: 'Euro');

    const requestEntity1 = ConvertCurrencyRequestEntity(
      from: usdCurrency,
      to: eurCurrency,
      amount: 100.0,
    );

    const requestEntity2 = ConvertCurrencyRequestEntity(
      from: usdCurrency,
      to: eurCurrency,
      amount: 100.0,
    );

    const requestEntity3 = ConvertCurrencyRequestEntity(
      from: eurCurrency,
      to: usdCurrency,
      amount: 100.0,
    );


    test('equal entities should have same props and string representation', () {
      expect(requestEntity1, requestEntity2);
      expect(requestEntity1.props, requestEntity2.props);
      expect(requestEntity1.toString(), requestEntity2.toString());
    });

    test('not equal entities should have different props and string representation', () {
      expect(requestEntity1, isNot(requestEntity3));
      expect(requestEntity1.props, isNot(requestEntity3.props));
      expect(requestEntity1.toString(), isNot(requestEntity3.toString()));
    });

    test('should have fromAmount, conversionRate, convertedAmount props', (){
      expect(sut.props, [fromAmount, conversionRate, convertedAmount]);
    });

  });
}
