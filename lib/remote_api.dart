import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_json_data/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({super.key});

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserModelList() async {
    // dio ile uzak sunuculardan veri çekecegimiz için async yapısını kullanıyoruz

    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      List<UserModel> userlist = [];
      if (response.statusCode == 200) {
        // bağlantı başarılı ise
        var userList = response
            .data; // dio kullandıgımız için jsondecode kullanmamıza gerek kalmadı zaten burda veriler bize liste halinde dönüyor
        // yapmamız gereken bize dönen liste elemanları birer map formatında oldugu için bunları mape çevirip
        // userModel.fromjson() fonksiyonu ile de user model  nesneleri halinde bir listede tutmak

        userlist =
            (userList as List).map((e) => UserModel.fromJson(e)).toList();
      }
      return userlist;
    } on DioError catch (e) {
      return Future.error(e.message
          .toString()); // future verilerle çalıştığımız için sorun olmuyor

    }
  }

  late Future<List<UserModel>> _kList;
  @override
  void initState() {
    _kList = _getUserModelList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("remote api with dio"),
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: _kList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<UserModel> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(users[index].name.toString()),
                    subtitle: Text(users[index].address.toString()),
                    leading: Text(users[index].id.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
