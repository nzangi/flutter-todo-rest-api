import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text(
            'Todo List',
            style: TextStyle(color: Colors.white),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            navigateToAddPage();
            print('Add TODO');
          },
          label: const Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add,color: Colors.black),
              SizedBox(width: 8),
              Text(
                'Add ToDo',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ]
          ),
      ),
    );
  }

  //Move  to AddTodoPage
  void navigateToAddPage(){
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    Navigator.push(context, route);
  }
}
