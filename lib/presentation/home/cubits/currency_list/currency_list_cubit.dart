import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/domain/entity/currency_list/currency_list_entity.dart';
import 'package:currency_exchange/domain/use_case/get_currency_history_use_case.dart';
import 'package:flutter/material.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {

  final GetCurrencyListUseCase getCurrencyListUseCase;

  CurrencyListCubit({
    required this.getCurrencyListUseCase,
  }) : super(CurrencyListState.initial());

  Future<void> getCurrencyList() async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await getCurrencyListUseCase(null);

    result.fold(
          (error) =>
          emit(state.copyWith(status: CubitStatus.failure, failureMessage: error.message)),
          (data) => emit(state.copyWith(status: CubitStatus.success, currencies: data)),

    );
  }
}
