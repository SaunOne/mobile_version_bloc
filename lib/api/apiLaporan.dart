import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_version_bloc/models/laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/models/laporan/laporanPemasukanPengeluaran.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLaporan {
  // Replace with your actual API endpoint
  static final String url = networkURL.prefix ;
  String token = "";

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

  Future<DataStok> getDataStok() async {
    
    token = await getToken();
    try {
      print(url);
      var response = await http.get(
        Uri.http(url, '/api/laporan-stok-bahan'),
        headers: _setHeaders(),
      );
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      DataStok data = DataStok.fromJson(json.decode(response.body)['data']);
      print("data : ${data}");
      return data;
    } catch (e) {
      print("error");
      return Future.error(e.toString());
    }
  }

  Future<DataStok> getDataPemakaianBahanBaku(String start,String end) async {
    
    var dataPost = {
      "start_date" : start,
      "end_date" : end
    };

    token = await getToken();
    try {
      print(url);
      var response = await http.post(
        Uri.http(url, '/api/laporan-pemakaian-bahan'),
        headers: _setHeaders(),
        body: jsonEncode(dataPost) ,
        
      );
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      DataStok data = await DataStok.fromJson(json.decode(response.body)['data']);
      
      print("data : ${data}");
      return data;
    } catch (e) {
      print("error");
      return Future.error(e.toString());
    }
  }

  Future<ModelLaporanPemasukanPengeluaran> getDataPengeluaranPemasukan(String date) async {
    
    token = await getToken();
    // DateTime parsedDate = DateTime.parse(date);
    // // Format the date to yyyy-MM
    // String formattedDate = DateFormat('yyyy-MM').format(parsedDate);
    try {

      
      print( Uri.http(url, '/api/laporan-pengeluaran-pemasukkan/${date}'));
      var response = await http.get(
        Uri.http(url, '/api/laporan-pengeluaran-pemasukkan/${date}'),
        
        headers: _setHeaders(),
      );
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      ModelLaporanPemasukanPengeluaran data = ModelLaporanPemasukanPengeluaran.fromJson(json.decode(response.body)['data']);
      print("data : ${data}");
      return data;
    } catch (e) {
      print("error");
      return Future.error(e.toString());
    }
  }
}
