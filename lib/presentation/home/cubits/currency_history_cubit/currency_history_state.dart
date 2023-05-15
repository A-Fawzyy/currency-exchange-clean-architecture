part of 'currency_history_cubit.dart';


@immutable
class CurrencyHistoryState extends BaseState {
  final List<CurrencyHistoryDayEntity> currencyHistoryList;


  const CurrencyHistoryState({
    this.currencyHistoryList = const [],
    super.status,
    super.failureMessage,
  });

  CurrencyHistoryState copyWith({
    List<CurrencyHistoryDayEntity>? currencyHistoryList,
    CubitStatus? status,
    String? failureMessage,
  }) =>
      CurrencyHistoryState(
        currencyHistoryList: currencyHistoryList ?? this.currencyHistoryList,
        status: status ?? this.status,
        failureMessage: failureMessage ?? this.failureMessage,
      );

  @override
  List<Object?> get props => [
    currencyHistoryList,
    status,
    failureMessage,
  ];

  @override
  bool get stringify => true;
}
