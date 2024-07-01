import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/services/todo_service.dart';

import '../utils/snakbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if(todo != null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),

        // ? const Text('Edit Todo') :const
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children:   [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Todo Title',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
              ),

            ),
          ),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              controller: descriptionController ,
              decoration: const InputDecoration(
                  hintText: 'Todo Description',
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              minLines: 5,
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
                isEdit? updateFormData() :submitFormData();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text( isEdit ? 'Update ':'Submit',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );

  }


  Future<void> updateFormData() async {
    final todo = widget.todo;
    if(todo == null){
      return;
    }
    // get the id and is_completed from todoItem

    final id = todo['_id'];
    final isCompleted = todo['is_completed'];

    // submit the data to server
    final updateSuccess = await TodoService.updateTodo(id, body);

    // show code

    if (updateSuccess){
      showSuccessMessage(context,message: 'Todo Updated');
    }else{
      showErrorMessage(context,message: 'Todo Updated');
    }

  }

    Future<void> submitFormData() async {

    // submit the data to server
    final createSuccess = await TodoService.createTodo(body);

    //handle success or error
    if (createSuccess){
      print('Creation was success');
      titleController.text='';
      descriptionController.text='';
      showSuccessMessage(context,message: 'Creation was success');

    }else{
      print('Creation failed');
      showErrorMessage(context,message: 'Creation failed');
    }

  }

  Map get body{
    // get the data from the form to update

    final title = titleController.text;
    final description = descriptionController.text;

    return {
      "title": title,
      "description": description,
      "is_completed": false
    };
  }






}
