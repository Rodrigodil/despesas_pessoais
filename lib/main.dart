import 'package:despesas_pessoais/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import '../models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          //Esquema de cores do tema
          primary: Colors.green,
          secondary: const Color.fromARGB(255, 7, 123, 255),
        ),
        textTheme: tema.textTheme.copyWith(
          //Estilo do texto do tema
          titleLarge: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 51, 50, 50),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Classe para criar a tela principal
class _MyHomePageState extends State<MyHomePage> {
  //Lista de transações
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // Função para adicionar transação
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    // Fechar o modal
    Navigator.of(context).pop();
  }
  // Função para remover transação
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // Função para abrir o modal
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  // Método para criar a tela principal
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.monetization_on,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text('Despesas Pessoais'),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        // onPressed: () => _openTransactionFormModal(context),
        // icon: Icon(Icons.add_circle),
        //   ),
        // ],
      ),
      // Corpo da tela
      body: SingleChildScrollView(
        // Corpo da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gráfico
            Chart(_recentTransactions),
            // SizedBox(
            //   child: Card(
            //     color: Colors.green,
            //     elevation: 5,
            //     child: Text('Gráfico'),
            //   ),
            // ),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      // Botão de adicionar transação
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
