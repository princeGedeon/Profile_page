import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{

  ProfilePageState createState()=>ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
{

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Mon profil'),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              child: Container(

              ),
            )

          ],
        ),
      ),
    );
  }

}