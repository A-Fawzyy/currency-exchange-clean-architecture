import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:currency_exchange/util/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrencyHistoryCartesianGraph extends StatelessWidget {
  final List<CurrencyHistoryDayEntity> dataList;

  const CurrencyHistoryCartesianGraph({super.key, this.dataList = const []});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        // Hide gridlines
        majorGridLines: const MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
        axisBorderType: AxisBorderType.withoutTopAndBottom,
        // Hide axis line
        axisLine: const AxisLine(width: 0),
      ),
      primaryYAxis: NumericAxis(
        // Hide gridlines
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        // Hide axis line
        axisLine: const AxisLine(width: 0),
      ),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(
        opacity: 0,
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          final castedData = data as CurrencyHistoryDayEntity;
          return Container(
            decoration: BoxDecoration(
              color: AppColors.blue.color,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              '${castedData.value?.toStringAsFixed(2)}, ${castedData.date}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      series: <SplineSeries<CurrencyHistoryDayEntity, String>>[
        SplineSeries<CurrencyHistoryDayEntity, String>(
          dataSource: dataList,
          xValueMapper: (CurrencyHistoryDayEntity history, _) => DateUtil.formatDateString(history.date),
          yValueMapper: (CurrencyHistoryDayEntity history, _) => history.value,
        ),
      ],
    );
  }
}
