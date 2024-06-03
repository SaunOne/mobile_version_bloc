import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/karyawan.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiKaryawan {
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

  Future<List<Karyawan>> fetchAll() async {
    token = await getToken();
    try {
      var response = await http.get(
        Uri.http(url, '/api/karyawan'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      // print('list before: ${list}');
      // print('list : ${list.map((e) => Karyawan.fromJson(e)).toList()}');
      return list.map((e) => Karyawan.fromJson(e)).toList();
    } catch (e) {
      print("error");
      return Future.error(e.toString());
    }
  }

  Future<Karyawan> findById(int id) async {
    token = await getToken();

    try {
      var response = await http.get(Uri.parse(url + '/api/pegawai/$id'),
          headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Karyawan.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> store(Karyawan karyawan) async {
    try {
      var response = await http.post(
        Uri.http(url, '/api/pegawai'),
        headers: _setHeaders(),
        body: karyawan.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> update(Karyawan karyawan) async {
    try {
      var response = await http.put(
        Uri.http(url, '/api/pegawai/${karyawan.id}'),
        headers: _setHeaders(),
        body: karyawan.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> destroy(int id) async {
    try {
      var response = await http.delete(
        Uri.http(url, '/api/pegawai/$id'),
        headers: _setHeaders(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
