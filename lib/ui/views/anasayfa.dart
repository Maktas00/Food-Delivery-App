import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekler/data/entity/yemekler.dart';
import 'package:yemekler/ui/cubit/anasayfa_cubit.dart';
import 'package:yemekler/ui/views/detay_sayfa.dart';
import 'package:yemekler/ui/views/sepet.dart';

class Anasayfa extends StatefulWidget {
  final user=FirebaseAuth.instance.currentUser;

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  void logout(){
    //
    //final authService=AuthService();
    //     authService.signOut();
    FirebaseAuth.instance.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey.shade300,
      appBar: AppBar(

        title: Text("Food Order App"),centerTitle: true,actions: [
          IconButton(onPressed: (){


          }, icon: Icon(Icons.shopping_bag_rounded))
      ],),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Icon(Icons.menu_book,size: 80,),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Divider(color: Colors.grey.shade100,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("A N A S A Y F A",style: TextStyle(color: Colors.black87),),
                leading: Icon(Icons.home,color: Colors.grey.shade700,),
                onTap: ()=>
                  Navigator.pop(context),

              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),

              child: ListTile(
                title: Text("Ç I K I Ş  Y A P",style: TextStyle(color: Colors.black87),),
                leading: Icon(Icons.logout,color: Colors.grey.shade700,),
                onTap: (){
                  logout();
                },

              ),
            ),
            SizedBox(height: 25,)

          ],
        ),
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(decoration: InputDecoration(labelText: "Arama",suffixIcon: Icon(Icons.search)),

              onChanged: (aramakelimesi){
                context.read<AnasayfaCubit>().aramaGetir(aramakelimesi);
              },




            ),
          ),
          Expanded(
            child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
              builder: (context,yemeklerListesi){
            
                  return GridView.builder(
                    itemCount: yemeklerListesi.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.8 ),
                    itemBuilder: (context,indeks){
                      var yemek=yemeklerListesi[indeks];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>DetaySayfa(yemek: yemek)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                Text(yemek.yemek_adi,style: TextStyle(fontSize: 20),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("₺${yemek.yemek_fiyat} ",style: TextStyle(fontSize: 20),),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.add_box_rounded)),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                }
            ),
          ),
        ],
      ),

    );
  }
}
