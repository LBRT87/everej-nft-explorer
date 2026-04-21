import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiEverej {
  static const String iphost = "http://10.0.2.2:3000";

  static Future<bool> registration(String email, String password) async {
    final response = await http.post(
      Uri.parse("$iphost/user/registration"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response.statusCode == 201;
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$iphost/user/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> getComment(int id) async {
    final response = await http.get(Uri.parse("$iphost/comment/readComment/$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  static Future<bool> postComment(int id, String user, String comment) async {
    final response = await http.post(
      Uri.parse("$iphost/comment/createComment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"product_id": id, "user": user, "comment": comment}),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateComment(int id, String comment) async {
    final response = await http.put(
      Uri.parse("$iphost/comment/updateComment/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"comment": comment}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteComment(int id) async {
    final response = await http.delete(Uri.parse("$iphost/comment/deleteComment/$id"));
    return response.statusCode == 200;
  }
}
