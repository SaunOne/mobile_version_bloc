
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_version_bloc/models/absensi.dart';

class ListAbsensi extends StatelessWidget {
  ListAbsensi({required this.listAbsensi, super.key});
  List<Absensi> listAbsensi = [];


  @override
  Widget build(BuildContext context) {
    print("list ${listAbsensi.length}");
    return Container(
      height: 350,
      child: SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(5),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(178, 117, 89, 79),
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Nama "),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Jabatan"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Action"),
                  ),
                ),
              ],
            ),
            for(Absensi absensi in listAbsensi)
            
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(absensi.karyawan!.nama_lengkap,),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(absensi.karyawan!.jabatan),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: MaterialButton(
                      minWidth: 20, // Atur lebar minimum
                      height: 20,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
