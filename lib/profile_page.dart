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

  @override
  void initState() {
    super.initState();
    nom=TextEditingController();
    prenom=TextEditingController();
    secret=TextEditingController();
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
                  Text("Language de programmation favori : ${myprofile.get_favoriteLang()}")
                ],
              ),
            )),
            Divider(color: Colors.deepPurpleAccent,thickness: 2),
            Text("Modifier les infos ",style: TextStyle(),),
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
    );
  }
}
