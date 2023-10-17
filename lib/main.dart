import 'package:flutter/material.dart';
import 'package:http_json_data/local_json.dart';
import 'package:http_json_data/remote_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title:
          "local json dosyasından veri okuma işlemi ", // ekrani küçülttüğümüzde yani çalışan uygulamalar gözüktüğünde bu yazı orda olacaktır
      home: Home_Page(),
    );
  }
}

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("local json veri alma "),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade700,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Local_json(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "local data",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RemoteApi(),
                    )),
                child: Text("remote api page"))
          ],
        ),
      ),
    );
  }
}
