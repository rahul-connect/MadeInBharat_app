import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';


class UserDrawer extends StatelessWidget {
  final User user;
  UserDrawer({this.user});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("${user.fullName}"),
                accountEmail: Text("${user.phoneNo}"),
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: AssetImage('assets/images/ic_launcher.png'),
                // ),
              ),
            ListTile(
               leading: Icon(Icons.home,),
              title: Text('Home'),
              onTap: () {
               // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CustomerHomeScreen(user: user,)));

              },
            ),

  
            ListTile(
               leading: Icon(Icons.playlist_add),
              title: Text('Suggest App'),
              onTap: () {

        

              },
            ),

              ListTile(
                 leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
              
              },
            ),

        

              ListTile(
                leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () {
                  Navigator.pop(context);
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/auth');
              
              },
            ),
            Divider(),

            // user.role=='seller'? 
            //       ListTile(
            //      leading: Icon(Icons.work),
            //   title: Text('Back to Seller View'),
            //   onTap: () {
               
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>DashBoard(user: user,)));
            //   },
            // ): SizedBox.shrink(),
        
              ListTile(
                 leading: Icon(Icons.phone),
              title: Text('Contact us'),
              onTap: () {
               
              },
            ),

          ],
        ),
      );
  }
}