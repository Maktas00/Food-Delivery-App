import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemekler/data/entity/sepet_yemekler.dart';
import 'package:yemekler/data/entity/sepet_yemekler_cevap.dart';
import 'package:yemekler/data/entity/yemekler.dart';
import 'package:yemekler/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository {

  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(jsonDecode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }


  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<void> sepeteEkle(String yemek_adi, String  yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async{

    var url="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi};

    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Yemek Kaydet : ${cevap.data.toString()}");

  }

  Future<List<SepetYemekler>> sepetGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri={"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("aaa : $cevap");
    return parseSepetYemekler(cevap.data.toString());


  }
  Future<void> sepetSil(int sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri={"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("silinme : ${cevap.data.toString()}");



  }
  Future<List<Yemekler>> aramaGetir(String aramakelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    var yemekList= parseYemekler(cevap.data.toString());
    Iterable<Yemekler> filtrenenListe=yemekList.where((yemekNesne) => yemekNesne.yemek_adi.toLowerCase().contains(aramakelimesi));
    var listeAra=filtrenenListe.toList();
    return listeAra;


  }




}
