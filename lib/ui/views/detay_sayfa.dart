import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/entity/yemekler.dart';
import 'package:yemekler/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemekler/data/entity/sepet_yemekler.dart';
import 'package:yemekler/ui/views/sepet.dart';

class DetaySayfa extends StatefulWidget {
Yemekler yemek;



DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int sonuc=0;
  int fiyat=0;
  bool sepetVarmi=false;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if(sonuc>0){
      sepetVarmi=true;
    }
    else{
      sepetVarmi=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yemek Detayı"),centerTitle: true,),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text("₺${widget.yemek.yemek_fiyat}",style: TextStyle(fontSize: 30,color: Colors.blue),),
            Text(widget.yemek.yemek_adi,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    if(sonuc>0)
                    sonuc--;
                  });
                }, child: Text("-")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sonuc.toString(),style: TextStyle(fontSize: 30),),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    sonuc++;
                  });
                }, child: Text("+")),


              ],
            ),


            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${(int.parse(widget.yemek.yemek_fiyat)*sonuc)} ₺",style: TextStyle(fontSize: 30),),
                  sepetVarmi ?
                  ElevatedButton(onPressed: (){

                    context.read<DetaySayfaCubit>().sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat),sonuc, "maktas",).then((value){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sepet(yemek: widget.yemek, adet: sonuc)));
                    } );



                  },

                      child: Text("SEPETE EKLE")):
                      Text(""),







              ],
            ),



          ],
        ),
      ),
    );
  }
}
