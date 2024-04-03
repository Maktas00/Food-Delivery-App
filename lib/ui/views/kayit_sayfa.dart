import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yemekler/ui/views/anasayfa.dart';
import 'package:yemekler/ui/views/giris_sayfa.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmpasswordController=TextEditingController();

  void register ()async{
   // final _authService=AuthService();

    //passwords match->create user
    if(passwordController.text==confirmpasswordController.text){
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text,password:  passwordController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GirisSayfa()));
      }
      //error
      catch (e){
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text(e.toString()),));
      }

    }

    //doesnt password match->show error
    else{
      showDialog(context: context, builder: (context)=>AlertDialog(title: Text("password doesnt match"),));
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book,size: 72,),
              SizedBox(height: 25,),
              Text("Senin için hesap oluşturalım",style: TextStyle(
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
              SizedBox(height: 10,),
              
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(controller: confirmpasswordController,
                  decoration: InputDecoration(
                    hintText: "Şifreyi Onayla",
              
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
                  register();
              
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
                      "Kayıt ol",
                      style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),

                    ),

                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabın var mı ?",style: TextStyle(color:Colors.grey.shade700, ),),
              
                  SizedBox(width: 4,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GirisSayfa()));



                      },
                      child: Text("Giriş yap",style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.bold),)),
                ],
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
