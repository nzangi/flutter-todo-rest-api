import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
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
              decoration: InputDecoration(
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
            child: const TextField(
              decoration: InputDecoration(
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
}
