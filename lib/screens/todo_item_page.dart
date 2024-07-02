import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final Map data;
  const NextPage({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todo',style: TextStyle(color: Colors.white,fontSize: 20),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Card(
        margin: const EdgeInsets.all(16.0),
        // margin : const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text(
            data['title'],
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(data['description'],
              style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
