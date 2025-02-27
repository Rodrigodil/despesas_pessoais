import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {super.key});
  
  //Agrupamento das transações
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      //Dias da semana
      String dayOfWeek;
      switch (weekDay.weekday) {
        case 1:
          dayOfWeek = 'seg';
          break;
        case 2:
          dayOfWeek = 'ter';
          break;
        case 3:
          dayOfWeek = 'qua';
          break;
        case 4:
          dayOfWeek = 'qui';
          break;
        case 5:
          dayOfWeek = 'sex';
          break;
        case 6:
          dayOfWeek = 'sab';
          break;
        case 7:
          dayOfWeek = 'dom';
          break;
        default:
          dayOfWeek = '';
      }

      return {
        'day': dayOfWeek,
        'value': totalSum,
      };
    }).reversed.toList(); //Inversão da lista
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {//Construção do gráfico
    groupedTransactions;
    return Card(//Cartão
      elevation: 2,
      margin: const EdgeInsets.all(5),//Margem
      child: Padding(
        padding: const EdgeInsets.all(10),//Preenchimento
        child: Row(//Linha do gráfico
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tr['day'] as String,
                tr['value'] as double,
                _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue, requiredPercentage: 0,
                
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
