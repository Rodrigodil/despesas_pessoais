import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar(
    this.label, 
    this.value, 
    this.percentage, 
    {super.key, required num requiredPercentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Texto do valor
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text('R\$${value.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,//Alinhamento do gráfico
            children: [
              // Container do gráfico
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,//Cor do gráfico
                    // color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}