import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile_version_bloc/models/absensi.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiAbsensi {
  String token = '';
  String tempToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5YmQ4MDEwNC04YTBhLTRhYTQtYWY0My1lNmE4YWI4OTZhNjciLCJqdGkiOiJhYjk0OTgzMDcxMjlmMzA0ZTg4N2U3Yzk3MmM0YzJkN2FkMzBhNWU5NWIwMjVmNzNiNDZhYmZlNTE3OTMzODY0YTBlMjAzZTFlMGNhMzM5NyIsImlhdCI6MTcxNTIxMTgwNC44OTQ3NDMsIm5iZiI6MTcxNTIxMTgwNC44OTQ3NDUsImV4cCI6MTc0Njc0NzgwNC44ODcxMDUsInN1YiI6IjUzIiwic2NvcGVzIjpbXX0.NW3giXY150-2UpyvKyKOSIy4U8KjiAWbBUX3lc2yb9f_dzSp_j--iMk8s6EHD1iVjeZTK5edb2I3XYU5q9ei-Tu--7D2RoX8Mk3vPItkSt-exz0vFT0y3ICK7V-z8cX5xUNKPLNJY_oS3Ua6_49hxHjEggsCZikzU7CHiH-AQmFXUqttOiHol-ztU-RSeTbpYl-h6aGrAP8OPRtEiHlIwJ5ufSdTA5fpJcHZ5N9vPibFkuuKnhqnuA3mXi-dNImdDuY-sr4ZqgrIqj9eiMTInXF9EGd8Y7lR2jGHmINJ6aJoW_d6QrDEwT0oP8qOvvzqC2Wz2hHLkJgn8CWhX47uGWEqR9jXCxjMyMx9-rIvCZByRtug7IKrXE3wsFy6I7fECfn23vyzmOWjZlqisuIpfX4LNkdQg-_sYg2PWzzPJaIxfCj5xMhXxOD2qOM9SwMHD7-r9EZqAeVmPRyqsazkNuPxUyIHLfx3r3LCu4QQOp2Dumin4Zj32aecw9SPc8sVVdQ_HR96GcDYancpXJCB3LRTuWDFy5tLT089gdR5lHP1LiMLadtcuBhboO16pYeZFlxgpfgMh3yuyP2US80C4McvOrKYozjbaLM863Xe-Xw4TAMgb3ikggA1VZ_i729w2kx7cBNgDX2mLKADipRQ7yBEbvC8_b5w4Jv9CZrtOqE";

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
      var response = await http.get(
        Uri.http(url, '/api/absensi'),
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
      var response = await post(
        Uri.http(url, '/api/absensi'),
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
      var response = await put(
        Uri.http(url, '/api/absensi/${id_absensi}'),
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
      var response = await delete(
        Uri.http(url, '/api/absensi/${id}'),
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
