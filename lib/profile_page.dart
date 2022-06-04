import 'package:flutter/material.dart';
import 'package:mon_profile/profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Profile myprofile = Profile(nom: "GUEDJE",prenom: "Gédéon Prince");
  late TextEditingController nom;
  late TextEditingController prenom;
  late TextEditingController secret;
  bool showsecret=false;

  @override
  void initState() {
    super.initState();
    nom=TextEditingController();
    prenom=TextEditingController();
    secret=TextEditingController();
    nom.text=myprofile.nom;
    prenom.text=myprofile.prenom;
    secret.text=myprofile.secret;
  }

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    secret.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text('Age : ${myprofile.get_age()}'),
                  Text("Taille : ${myprofile.get_taille()}"),
                  Text('Genre : ${myprofile.get_gender()}'),
                  Text("Hobbies : ${myprofile.get_hoobies()}"),
                  Text("Language de programmation favori : ${myprofile.get_favoriteLang()}"),
                  ElevatedButton(onPressed:updateSecret, child: Text((showsecret)?"Cacher secret":"Montrer secret")),
                  (showsecret)?Text(myprofile.secret):Container(height: 0,width: 0,)
                ],
              ),
            )),
            Divider(color: Colors.deepPurpleAccent,thickness: 2),
            const Text("Modifier les infos ",style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
            myTextField(controller: nom, hint: "Entrez votre nom"),
            myTextField(controller: prenom, hint: "Entrez votre prénom"),
            myTextField(controller: secret, hint: "Dites nous un secret",isSecret: true),
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
            )
          ],
        ),
      ),
    );
  }

  TextField myTextField({required TextEditingController controller,required String hint,bool isSecret=false})
  {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,

      ),
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
      );
    });
  }

  updateSecret()
  {
    setState((){
      showsecret=!showsecret;
    });
  }
}
