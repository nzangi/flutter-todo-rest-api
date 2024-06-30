import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blueAccent,
        title:  const Center(
          child: Text(
            'Todo List',
            style: TextStyle(color: Colors.white),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
            return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text('${index + 1}',style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(item['title'],style: const TextStyle(color: Colors.black),),
                  subtitle: Text(item['description'],style: const TextStyle(color: Colors.black)),
                  trailing: PopupMenuButton(
                    itemBuilder: (context){
                      return [
                        PopupMenuItem(child: Text('Edit')),
                        PopupMenuItem(child: Text('Delete'))
                      ];
                    },
                  ),
            );
          }),
        ),
        child: const Center(child: CircularProgressIndicator(),),
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
              Icon(Icons.add, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'Add ToDo',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ]),
      ),
    );
  }

  //Move  to AddTodoPage
  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    Navigator.push(context, route);
  }

  Future<void> fetchData() async {

    // submit the data to server
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      print(response.body);
      setState(() {
        items = result;
      });
    } else {
      //show error
    }
    setState(() {
      isLoading = false;
    });
  }
}
