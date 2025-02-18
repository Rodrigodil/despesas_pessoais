import 'package:flutter/material.dart';
import 'models/transaction.dart';


main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {

  final titleController = TextEditingController(); 
  final valueController = TextEditingController(); 

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Presente pra Lutcha',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta do Iate',
      value: 211.32,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Column(        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text('Gráfico'),
            ),
          ),

          
          TransactionList(_transactions),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    )
                  ),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(
                      labelText: 'Valor (R\$)',
                    )
                  ),
                  // Botão de adicionar transação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(                      
                        child: const Text(
                          'Nova Transação',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            )
        ],
      ),
    );
  }
}
