import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/entity/sepet_yemekler.dart';
import 'package:yemekler/data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yrepo=YemeklerDaoRepository();

  Future<void> sepetGetir(String kullanici_adi) async{
    var liste=await yrepo.sepetGetir(kullanici_adi);
    emit(liste);
  }

  Future<void> sepetSil(int sepet_yemek_id,String kullanici_adi) async{
    await yrepo.sepetSil(sepet_yemek_id, kullanici_adi);
    await sepetGetir(kullanici_adi);

  }
}