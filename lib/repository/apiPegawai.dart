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
      var uri = Uri.parse(url + "karyawan");
      var response = await http.get(
        uri,
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
      var uri = Uri.parse(url + "pegawai/$id");
      var response = await http.get(uri,
          headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Karyawan.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> store(Karyawan karyawan) async {
    try {
      var uri = Uri.parse(url + "pegawai");
      var response = await http.post(
        uri,
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
      var uri = Uri.parse(url + "pegawai/${karyawan.id}");
      var response = await http.put(
        uri,
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
