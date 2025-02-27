import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Lista de transações
    //Coluna das transações
    return SizedBox(
      height: 600,
      child: transactions.isEmpty 
      ? Column(
        children: [
          
          Text(
            'Nenhuma transação cadastrada!',
            style: Theme.of(context).textTheme.titleLarge,
            ),


            
        ],
        
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tr = transactions[index];//transação
          return Card(//Cartão
            elevation: 2,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            //Linha com o avatar, descrição e data
            child: ListTile(
            leading: CircleAvatar( //Avatar
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(//Ajusta o texto
                  child: Text('R\$${tr.value}'),//Valor da transação
                ),
              ),
            ),
            title: Text(
              tr.title,//Descrição da transação
              style: Theme.of(context).textTheme.titleLarge,//Estilo do texto
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => onRemove(tr.id),
              ),
            ),
          );
          
        },
      ),
    );
  }
}
