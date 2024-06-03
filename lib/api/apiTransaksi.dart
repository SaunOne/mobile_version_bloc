import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/transaksi.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiTransaksi {
  String token = '';

  static final String url = networkURL.prefix;

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token') ?? '';
    return token;
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<Transaksi> findById(int id) async {
    token = await getToken();

    try {
      var response = await http.get(Uri.http(url , '/transaksi/$id'),
          headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Transaksi.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Transaksi>> findByUser() async {
    token = await getToken();

    try {
      var uri = Uri.http(url , '/api/transaksi');
      
      var response = await http.get(uri,
          headers: _setHeaders());
          print('url nya : ${uri}');
      // print('url nya : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      // print('isinya : ${response.body}');
      Iterable list = json.decode(response.body)['data'];
      print('data : ${list.map((e) => Transaksi.fromJson(e)).toList()}');
      return list.map((e) => Transaksi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> store(Transaksi transaksi) async {
    token = await getToken();
    try {
      var response = await http.post(
        Uri.http(url, '/api/transaksi'),
        headers: _setHeaders(),
        body: transaksi.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> update(Transaksi transaksi) async {
    token = await getToken();
    try {
      var response = await http.put(
        Uri.http(url, '/api/transaksi/${transaksi.id}'),
        headers: _setHeaders(),
        body: transaksi.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> destroy(int id) async {
    token = await getToken();
    try {
      var response = await http.delete(
        Uri.http(url, '/api/transaksi/$id'),
        headers: _setHeaders(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
