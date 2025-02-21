import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Lista de transações
    //Coluna do valor e descrição
    return SizedBox(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text(
            'Nenhuma transação cadastrada!',
            style: Theme.of(context).textTheme.titleLarge,
            ),


            
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tr = transactions[index];
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      // color: Colors.green.shade600,
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toString()}', // Interpolação de string
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // color: Colors.green,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // Coluna de produtos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('d/M/y').format(tr.date),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 116, 115, 115),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
