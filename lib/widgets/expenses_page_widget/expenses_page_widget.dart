import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../entity/expense.dart';
import '../add_widget/add_widget_model.dart';
import '../radial_percent/radial_percent_widget.dart';

class ExpensesPageWidget extends StatefulWidget {
  const ExpensesPageWidget({super.key});

  @override
  State<ExpensesPageWidget> createState() => _ExpensesPageWidgetState();
}

class _ExpensesPageWidgetState extends State<ExpensesPageWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero, () => context.read<ExpensesPageModel>().setup());
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ExpensesPageModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 392.7,
            height: 200,
            child: Stack(
              children: [
                const Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: RadialPercentWidget(
                      percent: 0.5,
                      backgroundColor: Color.fromRGBO(255, 10, 23, 0.0),
                      filledColor: Color.fromARGB(255, 37, 203, 103),
                      unfilledColor: Color.fromARGB(255, 232, 232, 232),
                      lineWidth: 5.5,
                      child: Text(
                        '\$100.01',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 93, 176, 117),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: RawMaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('main_page/add'),
                    fillColor: Color.fromARGB(255, 93, 176, 117),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12.0),
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
            child: _ExpensesListViewWidget(expenses: model.listOfExpenses),
            //FutureBuilder<List<Expense>>(
            //   future: model.readExpenses().first,
            //   builder: (context, snapshot) {
            //     final expenses = snapshot.data;
            //     if (expenses != null) {
            //       return _ExpensesListViewWidget(expenses: expenses);
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}

class _ExpensesListViewWidget extends StatelessWidget {
  final List<Expense> expenses;
  const _ExpensesListViewWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return _ExpensesListTileWidget(expenses: expenses, index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
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
  const _ExpensesListTileWidget({
    required this.expenses,
    required this.index,
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
            onPressed: (context) => model.deleteExpense(expenses[index].id),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        dense: false,
        leading: Container(
          width: 19,
          height: 19,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 93, 176, 117),
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          expenses[index].category.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        trailing: Text(expenses[index].price.toString()),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
}
