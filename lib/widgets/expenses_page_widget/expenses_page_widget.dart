import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../entity/expense.dart';
import '../../session/session_id_model.dart';

class ExpensesPageWidget extends StatefulWidget {
  const ExpensesPageWidget({super.key});

  @override
  State<ExpensesPageWidget> createState() => _ExpensesPageWidgetState();
}

class _ExpensesPageWidgetState extends State<ExpensesPageWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final sessionIdModel =
          Provider.of<SessionIdModel>(context, listen: false);
      final userId = sessionIdModel.readUserId("uid");
      context.read<ExpensesPageModel>().setup(context, userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ExpensesPageModel>();
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text('Loged in as ${user.email!}'),
          const SizedBox(height: 20),
          SizedBox(
            width: 392.7,
            height: 200,
            child: Stack(
              children: [
                Center(
                  child: _PieChartWidget(model: model),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: RawMaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/main_page/add'),
                    fillColor: const Color.fromARGB(255, 93, 176, 117),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _ExpensesListViewWidget(
              expenses: model.listOfExpenses,
              userId: userId,
            ),
          ),
        ],
      ),
    );
  }
}

class _PieChartWidget extends StatelessWidget {
  const _PieChartWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ExpensesPageModel model;

  @override
  Widget build(BuildContext context) {
    final sum = model.sum;
    return SizedBox(
      height: 200,
      width: 200,
      child: PieChart(
        centerText: '$sum ₸',
        centerTextStyle: const TextStyle(
          fontSize: 20,
          foreground: null,
          backgroundColor: Colors.transparent,
          color: Colors.black,
        ),
        dataMap: model.dataMap.isEmpty
            ? <String, double>{"yes": 20.0}
            : model.dataMap,
        chartType: ChartType.ring,
        colorList:
            model.listOfColors.isEmpty ? [Colors.grey] : model.listOfColors,
        ringStrokeWidth: 12.5,
        legendOptions: const LegendOptions(showLegends: false),
        chartValuesOptions: const ChartValuesOptions(
          chartValueBackgroundColor: Colors.transparent,
          showChartValues: false,
        ),
      ),
    );
  }
}

class _ExpensesListViewWidget extends StatelessWidget {
  final List<Expense> expenses;
  final Future<String?> userId;
  const _ExpensesListViewWidget({
    Key? key,
    required this.expenses,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return _ExpensesListTileWidget(
          expenses: expenses,
          index: index,
          userId: userId,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1.5,
          height: 1,
        );
      },
    );
  }
}

class _ExpensesListTileWidget extends StatelessWidget {
  final List<Expense> expenses;
  final int index;
  final Future<String?> userId;
  const _ExpensesListTileWidget({
    required this.expenses,
    required this.index,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExpensesPageModel>(context);
    return Slidable(
      groupTag: 0,
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await model.deleteExpense(
                expenses[index].id,
                context,
                userId,
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        dense: false,
        minLeadingWidth: 25,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: double.infinity,
            child: Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                color: Color(int.parse(
                    model.findCategory(expenses[index].category).color)),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        title: Text(
          expenses[index].category.toString(),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text("${expenses[index].price.toInt().toString()} ₸"),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
}
