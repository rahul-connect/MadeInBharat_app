import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/application.dart';
import '../../model/user.dart';
import './user_drawer.dart';
import '../../bloc/homeBloc/export_home_bloc.dart';
import './other_app_screen.dart';
import './indian_app_screen.dart';
import 'package:share/share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomePage extends StatefulWidget {
  User user;
  String shareUrl;
  HomePage({ @required this.user,this.shareUrl});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
   var homeBloc;

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() { 
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context)..add(FetchHomeScreenApps());
  }


  Widget screen(List<Application> otherAppData,List<App> indianApplication){
     List screens = [
    Container(
      padding: EdgeInsets.only(top: 40.0),
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
              ),
      child: OtherAppScreen(applications: otherAppData,user: widget.user,)),
    Container(
      padding: EdgeInsets.only(top: 40.0),
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(75)),
              ),
      child: IndianApplications(applications: indianApplication,user: widget.user)),
    ];

    return screens[_selectedIndex];

  }
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      //drawer: UserDrawer(user:widget.user),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: ()async{

      //     var packageName = "com.tencent.iglite";
      //     var country = "china";
      //     var appName = "PUBG MOBILE LITE";
      //     var image = "https://lh3.googleusercontent.com/kFGbjmOBij0w5lsatJZ4NiGuHIPmKPGcOVpFg6Z1xChfvX1dO7TKjlxmDaHW99Tgyw=s180-rw";
      //     bool isIndian = false;

      //      // Check if already exists
      //    QuerySnapshot checkDatabase = await Firestore.instance.collection('applications').where('packageName', isEqualTo: packageName).getDocuments();

        
      //   if(checkDatabase.documents.length > 0){
      //     print("Application Already Exists");

      //   }else{

      //       await Firestore.instance.collection('applications').add({
      //       'appName':'$appName',
      //       'category':'',
      //       'country':'$country',
      //       'date':DateTime.now(),
      //       'image':'$image',
      //       'isIndian':isIndian,
      //       'packageName':'$packageName',
      //       'playstore':'https://play.google.com/store/apps/details?id=$packageName',
      //       'status':''
      //     });

      //      print("Application Added SUCCESSFULLY");
      //   }


      //   }
      //   ),

      appBar: AppBar(
        leading: Image.asset('assets/images/india.png',height: 20,),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: AutoSizeText("Made In Bharat",maxLines: 2,softWrap: true,style: GoogleFonts.indieFlower(fontSize: 30),),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: ()async{
          await Share.share(widget.shareUrl, subject: 'Lets try to use only Indian Apps from now on. Aatma Nirbhar Bharat !');
          })
        ],
      ),
      body: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
          if(state is HomeInitialState || state is LoadingState){
            return Container(
               padding: EdgeInsets.only(top: 40.0),
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75),topRight: Radius.circular(75)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitRotatingCircle(color: Colors.blue,size: 50.0,),
                  SizedBox(height: 20,),
                  Text("Please Wait. It may take a While !")
                ],
              ),
            );
          }else if(state is OtherAppFetchedState){
             List<Application> otherApps = state.otherApplications;
             List<App> indianApps = state.indianApplications;
             return screen(otherApps,indianApps);
          }
          return null;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            title: Text('Non-Indian Installed Apps'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text('Download Indian Apps'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}





