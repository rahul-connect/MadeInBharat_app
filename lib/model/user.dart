

import 'package:cloud_firestore/cloud_firestore.dart';

class User{
    String fullName;
    final String phoneNo;
    final String role;
    final String userId;
    String deviceToken;
    int appdeleted;
    int appInstalled;
    bool verified;


  User({this.fullName,this.phoneNo, this.role,this.userId,this.appInstalled,this.appdeleted,this.deviceToken,this.verified});

  factory User.fromJson(DocumentSnapshot snapshot){
      return User(
        fullName: snapshot.data['fullName'],
        phoneNo: snapshot.data['phone'],
        role: snapshot.data['role'],
        userId: snapshot.data['userId'],
        appInstalled: snapshot.data['appInstalled'],
        appdeleted: snapshot.data['appdeleted'],
        deviceToken: snapshot.data['deviceToken'],
        verified: snapshot.data['verified'] ?? false,
      );
    }

      Map<String,dynamic> toJson(User user){
      return {
        'fullName':user.fullName,
        'phone':user.phoneNo,
        'role':user.role,
        'userId':user.userId,
        'appDeleted':user.appdeleted,
        'appInstalled':user.appInstalled,
        'deviceToken':user.deviceToken,
        'verified':user.verified
      };

    }




    
}