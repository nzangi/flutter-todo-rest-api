import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
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
                submitFormData();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );

  }
  Future<void> submitFormData() async {
    // get the data from the form
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    // submit the data to server
    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    // http.post(uri);

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'
    });

    //handle success or error
    if (response.statusCode == 201){
      print('Creation was success');
      titleController.text='';
      descriptionController.text='';
      showSuccessMessage('Creation was success');

    }else{
      print('Creation failed');
      showErrorMessage('Creation failed');
    }
    print(response.statusCode);
    print(response.body);

  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
