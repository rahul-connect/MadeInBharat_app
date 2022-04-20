import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class App{
  final String appName;
  final String packageName;
  final String country;
  final String image;
  final String playstore;
  final String status;
  final bool isIndian;
  DateTime date;

  App({this.appName, @required this.packageName, this.country,this.playstore, this.image,this.status,this.isIndian,this.date});

  factory App.fromFirestore(DocumentSnapshot snapshot){
    return App(
      appName: snapshot.data['appName']??'',
      packageName: snapshot.data['packageName'],
      country: snapshot.data['country'],
      image: snapshot.data['image']??'',
      playstore: snapshot.data['playstore']??'',
      isIndian: snapshot.data['isIndian']??false,
      status: snapshot.data['status']??'',
    );
 }



  
}