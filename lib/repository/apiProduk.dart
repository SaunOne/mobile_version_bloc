import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/produk.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProduk {
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

  Future<List<Produk>> fetchAll() async {
    print('token : ${token}' );
    token = await getToken();
    
    try {
      var uri = Uri.parse(url + "produk");
      
      
      var response = await http.get(uri,
          headers: _setHeaders());
          print('url nya : ${uri}');
      // print('url nya : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      // print('isinya : ${response.body}');
      Iterable list = json.decode(response.body)['data'];
      // print('data : ${list.map((e) => Produk.fromJson(e)).toList()}');
      return list.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Produk>> fetchAllByTanggal(String tanggal) async {
    print('token : ${token}' );
    token = await getToken();
    print("tanggal yanbg di cari : ${tanggal}");
    try {
      // var uri = Uri.http(url , '/api/produk/$tanggal');
      var uri = Uri.parse(url + "produk/$tanggal");
      var response = await http.get(uri,
          headers: _setHeaders());
          print('url nya : ${uri}');


      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      print('isinya : ${response.body}');
      Iterable list = json.decode(response.body)['data'];
      print('data : ${list.map((e) => Produk.fromJson(e)).toList()}');
      return list.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Produk>> fetchAllTerlaris() async {
    print('token : ${token}' );
    token = await getToken();
    
    try {
      
      var uri = Uri.parse(url + "produk-terlaris");
      var response = await http.get(uri,
          headers: _setHeaders());
          print('url nya : ${uri}');
      // print('url nya : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      // print('isinya : ${response.body}');
      Iterable list = json.decode(response.body)['data'];
      // print('data : ${list.map((e) => Produk.fromJson(e)).toList()}');
      return list.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Produk> findById(int id) async {
    token = await getToken();

    try {
      var response = await http.get(Uri.parse(url + '/api/produk/$id'),
          headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Produk.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> store(Produk produk) async {
    token = await getToken();
    try {
      var uri = Uri.parse(url + "produk");
      var response = await http.post(
        uri,
        headers: _setHeaders(),
        body: produk.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> update(Produk produk) async {
    try {
      var uri = Uri.parse(url + "produk/${produk.id}");
      var response = await http.put(
        uri,
        headers: _setHeaders(),
        body: produk.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> destroy(int id) async {
    try {
      var response = await http.delete(
        Uri.http(url, '/api/produk/$id'),
        headers: _setHeaders(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
