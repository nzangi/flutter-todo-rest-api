import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_page.dart';
import 'package:http/http.dart' as http;
import '../screens/add_page.dart';


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
                final id = item['_id'] as String;
                
            return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text('${index + 1}',style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(item['title'],style: const TextStyle(color: Colors.black),),
                  subtitle: Text(item['description'],style: const TextStyle(color: Colors.black)),
                  trailing: PopupMenuButton(
                    onSelected: (value){
                      if(value == 'edit'){
                        //perform edit
                        navigateToEditPage(item);
                      }else if(value == 'delete'){
                        //perform delete item
                        deleteItemById(id);
                      }
                    },
                    itemBuilder: (context){
                      return [
                        PopupMenuItem(child: Text('Edit'),value: 'edit',),
                        PopupMenuItem(child: Text('Delete'),value: 'delete')
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
  Future<void> navigateToAddPage() async{
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading=true;
    });
    fetchData();
  }

  //navigate to EditTodoPage
  Future <void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo:item),
    );
    await Navigator.push(context, route);

    setState(() {
      isLoading=true;
    });
    fetchData();
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

  
  Future<void> deleteItemById(String id) async {

    // delete item
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200){
      final newItemsAfterDeletion = items.where((element) => element['_id'] != id).toList();
      items = newItemsAfterDeletion;
      print('TODO $id was deleted');
      //remove from the list
    }else{
      showErrorMessage('Deletion Failed');
      print('TODO $id was not deleted');

      //show an error
    }


  }
  void showErrorMessage(String message){
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
