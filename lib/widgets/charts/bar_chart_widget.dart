import 'package:finance_manager/domain/data_provider/default_data/default_categories_data.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    required this.listOfExpensesOrIncomesSortedByDate,
    required this.findCategory,
    super.key,
  });
  final List<dynamic> listOfExpensesOrIncomesSortedByDate;
  final Category Function(String categoryName) findCategory;

  String setValue(double value) {
    switch (value.toInt().toString().length) {
      case 6:
        return '${value.toInt().toString().substring(0, 3)}K';
      case 5:
        return '${value.toInt().toString().substring(0, 2)}K';
      case 4:
        return '${value.toInt().toString().substring(0, 1)}K';
      case 7:
        return '${value.toInt().toString().substring(0, 1)}.${value.toInt().toString().substring(1, 2)}M';
      case 8:
        return '${value.toInt().toString().substring(0, 2)}M';
      case 9:
        return '${value.toInt().toString().substring(0, 3)}M';
      default:
        return '${value.toInt().toString()}K';
    }
  }

  double setInterval(List<dynamic> listOfExpensesOrIncomesSortedByDate) {
    final listOfPrices = listOfExpensesOrIncomesSortedByDate
        .map((e) => e.price as double)
        .toList();
    if (listOfExpensesOrIncomesSortedByDate.isEmpty) {
      return 10.0;
    }
    final maxPrice = listOfPrices.fold(
      listOfPrices[0],
      (currentMax, number) => number > currentMax ? number : currentMax,
    );
    if (maxPrice.toInt().toString().length <= 3) {
      return 100.0;
    } else if (maxPrice.toInt().toString().length >= 4 &&
        maxPrice.toInt().toString().length < 5) {
      return 1000.0;
    } else if (maxPrice.toInt().toString().length >= 5 &&
        maxPrice.toInt().toString().length < 6) {
      return 10000.0;
    } else if (maxPrice.toInt().toString().length >= 6 &&
        maxPrice.toInt().toString().length < 7) {
      return 100000.0;
    } else if (maxPrice.toInt().toString().length >= 7 &&
        maxPrice.toInt().toString().length < 8) {
      return 500000.0;
    } else if (maxPrice.toInt().toString().length >= 8 &&
        maxPrice.toInt().toString().length < 9) {
      return 5000000.0;
    }

    return 10;
  }

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
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFececec)),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      // drawBehindEverything: true,
                      sideTitles: SideTitles(
                        interval:
                            setInterval(listOfExpensesOrIncomesSortedByDate),
                        showTitles: true,
                        reservedSize: 30.w,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            setValue(value),
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
                                    .category,
                              ).icon],
                              color: Color(
                                int.parse(
                                  findCategory(
                                    listOfExpensesOrIncomesSortedByDate[index]
                                        .category,
                                  ).color,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => const FlLine(
                      color: Color(0xFFececec),
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
                                int.parse(findCategory(data.category).color),
                              ),
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
