
class Profile{
  String nom;
  String prenom;
  int age;
  bool gender;
  double taille;
  String secret;
  List<String> hobbies=[];
  String favoriteLang;

  Profile({
    this.nom="",
    this.prenom="",
    this.age=0,
    this.gender=true,
    this.taille=0.0,
    this.secret="",
    this.hobbies=const [],
    this.favoriteLang="Python"
});

  String get_fullname()
  {
    return "$nom  $prenom";
  }

  String get_age()
  {
    String ageString="$age an";
    if (age>1)
      {
        ageString+="s";
      }
    return ageString;
  }

  String get_gender()
  {
    return (gender)? "Féminin":"Masculin";
  }

  String get_taille()
  {
    return '$taille cm';
  }

  String get_hoobies(){
    String tohobbiesstring="";
    if (hobbies.length==0){
      return tohobbiesstring;
    }
    else{
      tohobbiesstring=" Mes hobbies sont :";
    hobbies.forEach((element) {
      tohobbiesstring+=" $element ,";
    });
    return tohobbiesstring;
    }


  }
  String get_favoriteLang(){
    return favoriteLang;
  }

}