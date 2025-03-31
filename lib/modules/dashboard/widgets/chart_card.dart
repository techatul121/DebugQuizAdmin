import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/constants/image_path_constants.dart';
import '../../../common/extensions/date_extension.dart';
import '../../../common/extensions/list_extension.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../error/views/card_error_view.dart';
import '../model/dashboard_data_response_model.dart';
import 'custom_title.dart';

class ChartCard extends StatefulWidget {
  ChartCard({super.key, required this.activeUserGraph});
  final ActiveUserGraph activeUserGraph;

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  List<FlSpot> _getSpot() {
    final value = widget.activeUserGraph.value;

    return value
        .mapIndexed((index, e) => FlSpot(index.toDouble(), e.users.toDouble()))
        .toList();
  }

  (double, double, double) _getMinYMaxY() {
    final values = widget.activeUserGraph.value.map((e) => e.users).toList();
    values.sort();
    final min = values.first;
    final max = values.last;

    if (min == max) return (min.toDouble(), max.toDouble() + 5, 5);

    double range = (max - min).toDouble();

    double roundingFactor = _getDynamicRoundingFactor(range);

    double minValue = _roundDownToNearest(min.toDouble(), roundingFactor);
    double maxValue = _roundUpToNearest(max.toDouble(), roundingFactor);

    double interval = (maxValue - minValue) / 4;
    if (interval == 0) interval = roundingFactor / 2;

    return (minValue, maxValue, interval);
  }

  double _getDynamicRoundingFactor(double range) {
    if (range <= 0) return 10;
    double magnitude = pow(10, (log(range) / log(10)).floor()).toDouble();

    if (range / magnitude < 2) {
      magnitude /= 2;
    } else if (range / magnitude > 5) {
      magnitude *= 2;
    }

    return magnitude;
  }

  double _roundDownToNearest(double value, double multiple) {
    return (value ~/ multiple) * multiple;
  }

  double _roundUpToNearest(double value, double multiple) {
    return ((value + multiple - 1) ~/ multiple) * multiple;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: AppSize.size465,
      child: Column(
        spacing: AppSize.size35,
        children: [
          CustomTitle(
            assetName: SvgImages.tagUserIcon,
            title: widget.activeUserGraph.title,
          ),
          widget.activeUserGraph.xAxisRange.isEmpty &&
                  widget.activeUserGraph.yAxisRange.isEmpty
              ? const CardErrorView(message: AppStrings.noChartData)
              : Container(
                height: AppSize.size360,
                padding: AppEdgeInsets.a15,
                child: LineChart(
                  LineChartData(
                    minY: _getMinYMaxY().$1,
                    maxY: _getMinYMaxY().$2,
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getSpot(),
                        isCurved: true,
                        color: AppColors.blue,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameSize: AppSize.size20,
                        axisNameWidget: Text16W500(
                          widget.activeUserGraph.yAxisLabel,
                          color: AppColors.blue,
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: AppSize.size60,
                          interval: _getMinYMaxY().$3,

                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: AppEdgeInsets.a7,
                              child: Text16W500(value.toInt().toString()),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameSize: AppSize.size20,
                        axisNameWidget: Text16W500(
                          widget.activeUserGraph.xAxisLabel,
                          color: AppColors.blue,
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: AppSize.size80,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            final formattedDate =
                                widget
                                    .activeUserGraph
                                    .value[index]
                                    .date
                                    .formatDate;
                            return RotatedBox(
                              quarterTurns: 1,
                              child: Text14W500(formattedDate),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border.symmetric(
                        vertical: BorderSide(color: AppColors.borderColor),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: false,
                      verticalInterval: 1,
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: AppColors.borderColor,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    minX: 0,
                    maxX: widget.activeUserGraph.value.length.toDouble() - 1,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipMargin: 10,
                        getTooltipColor: (touchedSpot) => AppColors.blue,

                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((e) {
                            return LineTooltipItem(
                              _getSpot()[e.spotIndex].y.toString(),
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                      touchCallback:
                          (FlTouchEvent event, LineTouchResponse? response) {},
                      handleBuiltInTouches: true,
                      getTouchedSpotIndicator: (
                        LineChartBarData barData,
                        List<int> indicators,
                      ) {
                        return indicators.map((index) {
                          return const TouchedSpotIndicatorData(
                            FlLine(color: AppColors.blue, strokeWidth: 1),
                            FlDotData(show: true),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
