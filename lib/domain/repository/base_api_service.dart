import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://arriverd-be.azurewebsites.net/api";
  final String token;

  ApiService(this.token);

  Future<Map<String, dynamic>> get(String endpoint) async {
    return _sendRequestGet(endpoint, http.get);
  }

  Future<Map<String, dynamic>> postLogin(String endpoint, dynamic data) async {
    return _sendRequestLogin(endpoint, http.post, body: data);
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    return _sendRequest(endpoint, http.post, body: data);
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    return _sendRequest(endpoint, http.put, body: data);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    return _sendRequest(endpoint, http.delete);
  }

  Future<Map<String, dynamic>> _sendRequest(
      String endpoint,
      Future<http.Response> Function(Uri,
              {Map<String, String>? headers, Object? body})
          requestFunction,
      {dynamic body}) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': token,
    };

    final http.Response response = await requestFunction(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _sendRequestLogin(
      String endpoint,
      Future<http.Response> Function(Uri,
              {Map<String, String>? headers, Object? body})
          requestFunction,
      {dynamic body}) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    final Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    final http.Response response = await requestFunction(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _sendRequestlogin(
      String endpoint,
      Future<http.Response> Function(Uri,
              {Map<String, String>? headers, Object? body})
          requestFunction,
      {dynamic body}) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    final Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    final http.Response response = await requestFunction(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _sendRequestGet(
      String endpoint,
      Future<http.Response> Function(Uri, {Map<String, String>? headers})
          requestFunction) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    final Map<String, String> headers = {
      'accept': 'text/plain',
      'Authorization': "Bearer $token",
    };

    final http.Response response = await requestFunction(
      uri,
      headers: headers,
    );

    return _handleResponse(response);
  }

  // void loginUser() async {
  //   final String apiUrl =
  //       'https://arriverd-be.azurewebsites.net/api/auth/login';

  //   final Map<String, String> headers = {
  //     'accept': '*/*',
  //     'Content-Type': 'application/json',
  //   };

  //   final Map<String, String> body = {
  //     'username': 'Angel10Leonardo',
  //     'password': 'Leonardo1234,',
  //   };

  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );

  //     print('Response Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      result['data'] = json.decode(response.body);
    } else {
      result['error'] = 'Request failed with status: ${response.statusCode}';
    }
    return result;
  }
}
