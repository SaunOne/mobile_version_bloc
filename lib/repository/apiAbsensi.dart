import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile_version_bloc/models/absensi.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiAbsensi {
  String token = '';

  static final String url = networkURL.prefix;

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print('token : ${localStorage.getString('token')}' );
    token = localStorage.getString('token') ?? '';
    return token;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<List<Absensi>> fetchAll() async {
    token = await getToken();
    try {
      var uri = Uri.parse(url + "absensi");
      var response = await http.get(
        uri,
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      print('list before: ${list}');
      print('list : ${list.map((e) => Absensi.fromJson(e)).toList()}');
      return list.map((e) => Absensi.fromJson(e)).toList();
    } catch (e) {
      print("error");
      return Future.error(e.toString());
    }
  }

  Future<Absensi> findById(int id) async {
    token = await getToken();

    try {
      var response = await http.get(Uri.parse(url + '/api/$id'),
          headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await Absensi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> store(int id, String tanggal) async {
    var data = {"id_user": id, "tanggal": tanggal};
    try {
      var uri = Uri.parse(url + "absensi");
      var response = await post(
        uri,
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print("Berhasil Add : ${response.body}");
        return response;
      }
      print("Berhasil Add : ${response.body}");
      return response;
    } catch (e) {
      print("error : ${e}");
      return Future.error(e.toString());
    }
  }

  Future<Response> update({required int id_absensi, String? tanggal}) async {
    var data = {"tanggal": tanggal};
    try {
      var uri = Uri.parse(url + "absensi/${id_absensi}");
      var response = await put(
        uri,
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print("Berhasil update : ${response.body}");
        return response;
      }
      print("Berhasil update : ${response.body}");
      return response;
    } catch (e) {
      print("error : ${e}");
      return Future.error(e.toString());
    }
  }

  Future<Response> destroy(id) async {
    try {
      var uri = Uri.parse(url + "absensi/$id");
      var response = await delete(
        uri,
        headers: _setHeaders(),
      );
      if (response.statusCode == 200) {
        print("Berhasil Add : ${response.body}");
        return response;
      }
      print("Berhasil Add : ${response.body}");
      return response;
    } catch (e) {
      print("error : ${e}");
      return Future.error(e.toString());
    }
  }
}
