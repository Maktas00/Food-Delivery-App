import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yemekler/ui/views/kayit_sayfa.dart';

class GirisSayfa extends StatefulWidget {

   GirisSayfa({super.key});


  @override
  State<GirisSayfa> createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<GirisSayfa> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  void login() async{
  //  showDialog(context: context, builder: (context){
  //    return Center(
   //     child: CircularProgressIndicator(),
 //    );
 //   });

 //   final _authService=AuthService();
//    await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text);

}
on FirebaseAuthException catch(e){
 showDialog(context: context, builder: (context){
   return AlertDialog(
     title: Center(
       child: Text("Bilgileriniz Hatalı"),
     ),

   );
 });
}



  //  Navigator.pop(context);



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book,size: 72,),
            SizedBox(height: 25,),
            Text("Food Order App",style: TextStyle(
                fontSize: 16,),),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",


                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),

                ),
              ),


              ),
            ),
            SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Şifre",

                  enabledBorder: OutlineInputBorder(

                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),

                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: (){
                  login();

              },
              child: Container(
                padding: EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Giriş yap",
                    style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),

                  ),

                ),
              ),
            ),
            SizedBox(height: 25,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Üye değil misin?",style: TextStyle(color:Colors.grey.shade700, ),),

                 SizedBox(width: 4,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>KayitSayfa()));

                    },
                    child: Text("kayıt ol",style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.bold),)),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
