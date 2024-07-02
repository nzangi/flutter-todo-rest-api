import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_page.dart';
import 'package:todoapp/services/todo_service.dart';
import 'package:todoapp/widget/todo_card.dart';
import '../utils/snakbar_helper.dart';


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
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCard(
                      index: index,
                      item: item,
                      navigateToEditPage: navigateToEditPage,
                      deleteItemById: deleteItemById
                  );
                }),
          ),
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
    final  response = await TodoService.fetchDataService();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      //show error
      showErrorMessage(context,message: 'Something went wrong!');
    }
    setState(() {
      isLoading = false;
    });
  }

  
  Future<void> deleteItemById(String id) async {
    // delete item
    final isSuccess = await TodoService.deleteItemById(id);
    if(isSuccess){
      final newItemsAfterDeletion = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = newItemsAfterDeletion;
      });
      print('TODO $id was deleted');
      //remove from the list
    }else{
      showErrorMessage(context,message: 'Deletion Failed');
      print('TODO $id was not deleted');
      //show an error
    }


  }

}
