import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.jfif',
              height: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              'Daftar Rumah Sakit Rujukan Pasien Covid-19',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalListPage()),
                );
              },
              child: Text('Lihat Daftar Rumah Sakit'),
            ),
          ],
        ),
      ),
    );
  }
}
