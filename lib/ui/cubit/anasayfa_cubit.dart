import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/entity/yemekler.dart';
import 'package:yemekler/data/repo/yemeklerdao_repository.dart';
class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo=YemeklerDaoRepository();

  Future<void> yemekleriYukle()async {
    var liste=await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> aramaGetir(String aramakelimesi)async {
    var liste=await yrepo.aramaGetir(aramakelimesi);
    emit(liste);
  }

}





