import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_json_data/model/araba_model.dart';

class Local_json extends StatefulWidget {
  const Local_json({super.key});

  @override
  State<Local_json> createState() => _Local_jsonState();
}

class _Local_jsonState extends State<Local_json> {
  late final Future<List<ArabaModel>> _listeArabalar;

  @override
  void initState() {
    _listeArabalar = jsondan_oku();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bu sınıfta yazılan metodlar  statful widget olduğu için contex istemedi statless widget olsaydı context isteyecekti

    return Scaffold(
      appBar: AppBar(
        title: Text("local data page"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ArabaModel>>(
        //uzun süren veri işlemleri için kullanılacak bir fonksiyondur içinde arabamodelleri olan nesnelerle çalış
        future:
            _listeArabalar, // içinde araba modelleri olan future formatında bir yapı sunar burdan dönen yapıları buildera snapshot aracılığıyla iletecek
        // initialData: InitialData,
        // initial data sayesinde verilerimiz olduğu için circilerprogresindigator kullandığımız kısım görünmez zaten amaç da budur ilk açıldıpında belirli verileri gösterip asıl veri geldipinde güncellenmesi

        initialData: [
          ArabaModel(
              arabam: "mazda",
              kurulusYil: 1950,
              lke: "belçika",
              model: [Model(modelAdi: "cx2", fiyat: 650000, benzinli: true)])
        ], // internetten veya lokalden veri gelene kadar kullanıcıya ekranda göstermesini istediğimiz veriyi buraya veriyoruz
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ArabaModel> arabalar = snapshot.data;
            // veri gelirse listview oluştur
            return ListView.builder(
              itemCount: arabalar.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(arabalar[index].arabam.toString()),
                subtitle: Text(arabalar[index].lke),
                leading: CircleAvatar(
                  child: Text((arabalar[index].model[0].fiyat).toString()),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // hata oluşursa hatayı ekranda göster
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            // veri getirme işlemi uzun sürecekse
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
// önemli Future ile çalışıyorsak kesinlikle try catch yapısı kullanmamız gerekiyor

  Future<List<ArabaModel>> jsondan_oku() async {
    // json dosyasından okuyup nesnelere çevirmesi zaman aldığı return yapacağımız veri future olması gerekiyor

    // bu karışıklıktan kurtulmak için ve bu tür kodlarımızı ayrı bir dosyada tutmak için model sınıflarımızı kullanırız ve okunaklığı da arttırmış oluruz

    // okunan veriler hemen gelmeyeceği için bu yapıyı async yapısını kullandık
    try {
      String okunanString = await DefaultAssetBundle.of(context).loadString(
          'assets/data/arabalar.json'); // asset dosyalardan veri okumak için kullandığımız bir sınıftır.
      /*debugPrint(
        okunanString); // string şeklinde okundu bu veri bu veriyi bizim json tipine çevirip  nesnelere falan atayabiliriz
    List json_read = jsonDecode(okunanString);
    debugPrint("fsdfdfsdfsdf");
    debugPrint(json_read[1]["model"][0]["model_adi"].toString());*/
      List jsonnesnesi = jsonDecode(okunanString);
      List<ArabaModel> arabalar = (jsonnesnesi as List) // liste gibi davran
          .map((arabaMap) => ArabaModel.fromJson(arabaMap))
          .toList();
      // map elemanları vardı bunları tek tek gezip arabamodel nesnelerine dönüştür ve liste yap
      return arabalar;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e
          .toString()); // future yapısında bir fonksiyon oldugu için o türde verileri return eder
      // bu fonksiyon sayesinde hata mesajını fonksiyonun çağrıldıgı yere gönderebiliriz

    }
  }
}
