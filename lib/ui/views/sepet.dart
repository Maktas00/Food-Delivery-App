import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/entity/sepet_yemekler.dart';
import 'package:yemekler/data/entity/yemekler.dart';
import 'package:yemekler/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekler/ui/views/anasayfa.dart';
import 'package:yemekler/ui/views/detay_sayfa.dart';
import 'package:yemekler/ui/views/teslimat.dart';

class Sepet extends StatefulWidget {
  Yemekler yemek;
int adet=0;



Sepet({required this.yemek,required this.adet});



@override
  State<Sepet> createState() => _SepetState();


}

class _SepetState extends State<Sepet> {
  bool visible=true;

  int hesap=0;
  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetGetir("maktas");


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SEPETİM"),centerTitle: true,),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
            builder: (context,sepetListesi) {
              if (sepetListesi.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: sepetListesi.length,
                    itemBuilder: (context, indeks) {
                      var yemek = sepetListesi[indeks];
                      hesap=0;
                      for(var i=0;i<sepetListesi.length;i++) {

                        hesap = hesap + (int.parse(
                            sepetListesi[i].yemek_fiyat) * int.parse(
                            sepetListesi[i].yemek_siparis_adet));
                      }
                      Future.microtask(() => setState(() {

                      }),
                      );


                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",width: 150,height: 150,),
                              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(yemek.yemek_adi),
                                  Text("Fiyat : ${yemek.yemek_fiyat}"),
                                  Text("Adet: ${yemek.yemek_siparis_adet}"),
                                ],
                              ),
                              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(onPressed: (){
                                    context.read<SepetSayfaCubit>().sepetSil(int.parse(yemek.sepet_yemek_id), "maktas");
                                    if(sepetListesi.length==1){
                                      setState(() {
                                        sepetListesi.clear();
                                        hesap=0;
                                        visible=false;

                                      });
                                    }


                                    setState(() {
                                      var x=(int.parse(sepetListesi[indeks].yemek_fiyat)*int.parse(sepetListesi[indeks].yemek_siparis_adet));
                                      hesap=hesap-x;
                                    });

                                  }, icon: Icon(Icons.restore_from_trash_outlined)),

                                  Text("${int.parse(yemek.yemek_siparis_adet)*int.parse(yemek.yemek_fiyat)}₺"),

                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else {

                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sepetiniz Boş",style: TextStyle(fontSize: 25),),
                    ],
                  ),
                );
              }
            }
          ),




             Text("$hesap ₺", style: TextStyle(fontSize: 40),),

          visible ?

          ElevatedButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Teslimat()));
          }, child: Text("Sepeti Onayla")):
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
              }, child: Text("Anasayfaya Dön"))
        ],
      ),
    );
  }
}
