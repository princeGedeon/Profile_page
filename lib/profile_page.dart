import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_profile/profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Profile myprofile = Profile(nom: "GUEDJE",prenom: "Gédéon Prince");
  late TextEditingController nom;
  late TextEditingController prenom;
  late TextEditingController secret;
  late TextEditingController age;
  bool showsecret=false;
  Map<String,bool> hoobies={
    "Mangas":false,
    "Coder":false,
    "Football":false,
    "Séries":false
  };
  ImagePicker picker=ImagePicker();
  File? imgFile;



  @override
  void initState() {
    super.initState();
    nom=TextEditingController();
    prenom=TextEditingController();
    secret=TextEditingController();
    age=TextEditingController();
    age.text=myprofile.age.toString();
    nom.text=myprofile.nom;
    prenom.text=myprofile.prenom;
    secret.text=myprofile.secret;
  }

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    secret.dispose();
    age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize=MediaQuery.of(context).size.width/4;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
                color: Colors.deepPurple.shade100,
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,

              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(myprofile.get_fullname()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3.5,
                        child: (imgFile==null)?Image.asset("images/hammer-471884_1920.jpg",height: imageSize,width: imageSize,):Image.file(imgFile!,height: imageSize,width: imageSize,),
                      ),
                      Column(
                        children: [
                          Text('Age : ${myprofile.get_age()}'),
                          Text("Taille : ${myprofile.get_taille()}"),
                          Text('Genre : ${myprofile.get_gender()}'),
                        ],
                      )
                    ],
                  ),

                  Text("Hobbies : ${myprofile.get_hoobies()}"),
                  Text("Language de programmation favori : ${myprofile.get_favoriteLang()}"),
                  ElevatedButton(onPressed:updateSecret, child: Text((showsecret)?"Cacher secret":"Montrer secret")),
                  (showsecret)?Text(myprofile.secret):Container(height: 0,width: 0,)
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(onPressed:(()=>getImage(source: ImageSource.camera)), icon: Icon(Icons.camera_alt_rounded),color: Colors.deepPurple,),
                IconButton(onPressed:(()=>getImage(source: ImageSource.gallery)), icon: Icon(Icons.photo_album_outlined),color: Colors.deepPurple),
              ],
            ),
            Divider(color: Colors.deepPurpleAccent,thickness: 2),
           myTitle("Modifier les infos"),
            myTextField(controller: nom, hint: "Entrez votre nom"),
            myTextField(controller: prenom, hint: "Entrez votre prénom"),
            myTextField(controller: secret, hint: "Dites nous un secret",isSecret: true),
            myTextField(controller: age, hint: "Entrez votre age",type: TextInputType.number),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Genre : ${myprofile.get_gender()}"),
                Switch(value: myprofile.gender, onChanged: ((newBool){
                  setState((){
                    myprofile.gender=newBool;
                  });
                }))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Taille : ${myprofile.get_taille()}"),
                Slider(min: 0,max: 250,value: myprofile.taille, onChanged: ((newHeight){
                  setState((){
                    myprofile.taille=newHeight;
                  });
                })),


              ],
            ),
            Divider(color: Colors.deepPurpleAccent,thickness: 2),
            myHobbies(),
            Divider(color: Colors.deepPurpleAccent,thickness: 2),
            myRadios(),

          ],
        ),
      ),
    );
  }

  TextField myTextField({required TextEditingController controller,required String hint,bool isSecret=false,TextInputType type=TextInputType.text})
  {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,

      ),
      keyboardType: type,
      obscureText: isSecret,
      onSubmitted: ((newValue){
        updateUser();

      }),
    );
  }

  void updateUser(){
    setState((){
      myprofile=Profile(
        nom:(nom.text!=myprofile.nom)?nom.text:myprofile.nom,
        prenom:(prenom.text!=myprofile.prenom)?prenom.text:myprofile.prenom,
        secret: (secret.text!=myprofile.secret)?secret.text:myprofile.secret,
        favoriteLang: myprofile.favoriteLang,
        hobbies: myprofile.hobbies,
        taille: myprofile.taille,
        age: int.parse(age.text),
        gender: myprofile.gender
      );
    });
  }

  updateSecret()
  {
    setState((){
      showsecret=!showsecret;
    });
  }
  Column myHobbies(){
    List<Widget> widgets=[myTitle("Mes hobbies")];
    hoobies.forEach((hobbie, like) {
      Row r=Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hobbie),
          Checkbox(value: like, onChanged: (newbool){
            setState((){
              hoobies[hobbie]= newbool??false;
              List<String> str=[];
              hoobies.forEach((key, value) {
                if (value==true){
                  str.add(key);
                }

            });
              myprofile.hobbies=str;

      });

          })
        ],
      );
      widgets.add(r);
    });
    return Column(children: widgets,);
  }

  Text myTitle(String texte)
  {
    return Text(texte,style: TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),);
  }
  
  Column myRadios(){
   
    List<Widget> w=[];
    List<String> langs=["Dart","Python","C++","Java","C","Aucun"];
    int index=langs.indexWhere((element) => element.startsWith(myprofile.favoriteLang));
    for (var x=0;x<langs.length;x++)

      {
        Column r=Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(langs[x]),
            Radio(value: x, groupValue: index, onChanged: (newValue){
              setState((){
                myprofile.favoriteLang=langs[newValue as int];
              });
            })
          ],
        );
        w.add(r);
      }
    return Column(
      children: [
        myTitle("Language préféré"),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: w,
        )
      ],
    );
  }
  Future getImage({required ImageSource source}) async{
    final choosenFile=await picker.getImage(source: source);
    setState((){
      if (choosenFile==null)
        {
          print("Je n'ai rien ajoute");
        }
      else{
        imgFile=File(choosenFile.path);

      }
    });
  }
}
