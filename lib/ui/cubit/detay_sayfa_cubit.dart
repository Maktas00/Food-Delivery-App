import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/repo/yemeklerdao_repository.dart';
import 'package:yemekler/data/entity/yemekler.dart';


class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var yrepo=YemeklerDaoRepository();

  Future<void> sepeteEkle(String yemek_adi,
      String resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi
      )async{
    await yrepo.sepeteEkle(yemek_adi, resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);

  }
}