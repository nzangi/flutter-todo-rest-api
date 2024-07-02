import 'package:flutter/material.dart';
import 'package:todoapp/screens/todo_item_page.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditPage;
  final Function(String) deleteItemById;

  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateToEditPage,
      required this.deleteItemById,
      });

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      child: ListTile(
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
              const PopupMenuItem(child: Text('Edit'),value: 'edit',),
              const PopupMenuItem(child: Text('Delete'),value: 'delete')
            ];
          },
        ),
        onTap: (){
          Navigator.push(context,
                MaterialPageRoute(builder: (context) => NextPage(data: item)));
        }

      ),
    );
    ;
  }
}
