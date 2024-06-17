import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/transaksi.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiTransaksi {
  String token = '';

  static final String url = networkURL.prefix + networkURL.endpoint;

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
    var uri = Uri.parse(url + "transaksi/${id}");
    try {
      var response = await http.get(uri,
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
      var uri = Uri.parse(url + "transaksi");
      
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
    var uri = Uri.parse(url + "transaksi");
    try {
      var response = await http.post(
        uri,
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
      var uri = Uri.parse(url + "transaksi/${transaksi.id}");
      var response = await http.put(
        uri,
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
    var uri = Uri.parse(url + "transaksi/$id");
    try {
      var response = await http.delete(
        uri,
        headers: _setHeaders(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> konfirmasi(int id) async {
    token = await getToken();
    var uri = Uri.parse(url + "konfirmasi-customer/$id");
    print("uri konfrimasi : ${uri}");
    try {
      print("id = $id");
      var response = await http.post(
        uri,
        headers: _setHeaders(),
      );
      print("response ${response.body}");
      return response;
    } catch (e) {
      return Future.error(e.toString());  
    }
  }
}
