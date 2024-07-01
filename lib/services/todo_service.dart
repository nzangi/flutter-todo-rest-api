import 'dart:convert';
import 'package:http/http.dart' as http;


// call the API from here
class TodoService{
  // delete item service
  static   Future<bool> deleteItemById(String id) async {
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    return response.statusCode == 200;

  }
  static  Future<List?> fetchDataService() async {
    // submit the data to server
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result ;
    }else{
      return null;
    }

  }
  static  Future<bool> updateTodo(String id,Map body) async {
    // submit the data to server
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'
        });

    return response.statusCode == 200;

  }

  static  Future<bool> createTodo(Map body) async {
    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    // http.post(uri);

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'
        });

    return response.statusCode == 201;
  }

  }