import 'package:finance_manager/entity/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../default_data/default_categories_data.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.listOfExpensesOrIncomesSortedByDate,
    required this.findCategory,
  });
  final List<dynamic> listOfExpensesOrIncomesSortedByDate;
  final Category Function(String categoryName) findCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFececec)),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBehindEverything: true,
                      sideTitles: SideTitles(
                        interval: 20000,
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString().length > 3
                                ? "${value.toInt().toString().substring(0, 2)}K"
                                : value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF606060),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Icon(
                              DefaultCategoriesData.iconsMap[findCategory(
                                      listOfExpensesOrIncomesSortedByDate[index]
                                          .category)
                                  .icon],
                              color: Color(int.parse(findCategory(
                                      listOfExpensesOrIncomesSortedByDate[index]
                                          .category)
                                  .color)),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xFFececec),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: listOfExpensesOrIncomesSortedByDate
                      .map(
                        (data) => BarChartGroupData(
                          x: listOfExpensesOrIncomesSortedByDate.indexOf(data),
                          barRods: [
                            BarChartRodData(
                              toY: data.price,
                              color: Color(
                                  int.parse(findCategory(data.category).color)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
