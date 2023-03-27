import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:provider/provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    Key? key,
    required this.sum,
    required this.dataMap,
    required this.listOfColors,
  }) : super(key: key);

  final String sum;
  final Map<String, double> dataMap;
  final List<Color> listOfColors;

  @override
  Widget build(BuildContext context) {
    final currenycModel = Provider.of<CurrencyModel>(context, listen: true);
    return Center(
      child: SizedBox(
        height: 200.h,
        width: 200.w,
        child: pie.PieChart(
          centerText: '$sum ${currenycModel.currentCurrency}',
          centerTextStyle: TextStyle(
            fontSize: 20.sp,
            foreground: null,
            backgroundColor: Colors.transparent,
            color: Colors.black,
          ),
          dataMap: dataMap.isEmpty ? <String, double>{"yes": 20.0} : dataMap,
          chartType: pie.ChartType.ring,
          colorList: listOfColors.isEmpty ? [Colors.grey] : listOfColors,
          ringStrokeWidth: 12.5.w,
          legendOptions: const pie.LegendOptions(showLegends: false),
          chartValuesOptions: const pie.ChartValuesOptions(
            chartValueBackgroundColor: Colors.transparent,
            showChartValues: false,
          ),
        ),
      ),
    );
  }
}
