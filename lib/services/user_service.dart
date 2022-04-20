import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import '../model/application.dart';

class UserService{
   final Firestore db = Firestore.instance;



  Future getOtherApplications()async{

     List<Application> allAppsinDevice = await DeviceApps.getInstalledApplications(includeAppIcons: true,includeSystemApps: false,onlyAppsWithLaunchIntent: false);
     List<App> fetchNotIndianApplication = await db.collection('applications').where('isIndian',isEqualTo: false).getDocuments().then((value) => value.documents.map((e) => App.fromFirestore(e)).toList());
     List<Application> otherAppInstalled = [];

       for(Application deviceapp in allAppsinDevice){
          for(App app in fetchNotIndianApplication){  
              if(deviceapp.packageName == app.packageName){
                otherAppInstalled.add(deviceapp);
              }
           }
       }


    return otherAppInstalled;


  }

  Future getIndianApplications()async{
    List<Application> allAppsinDevice = await DeviceApps.getInstalledApplications(includeAppIcons: true,includeSystemApps: false,onlyAppsWithLaunchIntent: false);
    List<App> fetchIndianApplications = await db.collection('applications').where('isIndian',isEqualTo: true).getDocuments().then((value) => value.documents.map((e) => App.fromFirestore(e)).toList());
    List<App> indianAppInstall = [];
    indianAppInstall.addAll(fetchIndianApplications);

  for(Application alreadyapp in allAppsinDevice){
     for(App indianapp in fetchIndianApplications){
       if(alreadyapp.packageName==indianapp.packageName){
         indianAppInstall.remove(indianapp);
       }
     }
  }


     return indianAppInstall;


  }




}