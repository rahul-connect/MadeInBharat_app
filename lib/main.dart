import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/user/home.dart';
import './services/auth_service.dart';
import 'package:package_info/package_info.dart';
import './model/user.dart';
import 'screens/loginScreen/login_screen.dart';
import 'screens/splash_screen.dart';
import './screens/admin/dashboard.dart';
import './bloc/homeBloc/export_home_bloc.dart';
import 'screens/update_app.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final AuthService authService = AuthService(firebaseAuth: firebaseAuth);

  runApp(MyApp(
    authService: authService,
  ));
}

class MyApp extends StatefulWidget {
  final AuthService _authService;

  MyApp({@required AuthService authService})
      : assert(authService!=null),
        _authService = authService;


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String appUrl;

  Future<bool> checkUpdate()async{
     DocumentSnapshot latestupdate = await Firestore.instance.collection('update').document('checkupdateforapp').get();
     
     String latestapp =  latestupdate['buildNumber'];
     appUrl = latestupdate['url'];

     PackageInfo packageInfo = await PackageInfo.fromPlatform();
     String currentapp = packageInfo.buildNumber;

      if(int.parse(latestapp) > int.parse(currentapp)){
         return true;
      }else{
        return false;
      }
    
  }

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
           BlocProvider<HomeBloc>(
          create: (context)=>HomeBloc(),
        ),
        ],
          child: MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Made In India',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
         routes: {
             '/auth':(context)=>MyApp(authService: widget._authService),
           },
        home: StreamBuilder(
            stream: widget._authService.onAuthChange(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.hasData){
                // Check App update
                  checkUpdate().then((bool value) {
                    if(value){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>UpdateAppScreen(appUrl: appUrl,)));
                    }
                  });
                
                return FutureBuilder(
                    future: widget._authService.getFirestoreUser(snapshot.data),
                    builder: (context, documentSnapshot) {
                      if (documentSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      } else if (documentSnapshot.hasData) {
                        User currentUser = User.fromJson(documentSnapshot.data);
                        
                        if (documentSnapshot.data['role'] == 'user') {
                          return HomePage(user: currentUser,shareUrl: appUrl,);
                        } else {
                          return DashBoard(
                            user:currentUser
                          );
                        }
                      }
                    });
              } else {
                return LoginScreen(authService: widget._authService);
              }
            },
          ),
      ),
    );
  }
}


