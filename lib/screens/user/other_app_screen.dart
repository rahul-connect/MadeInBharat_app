import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/homeBloc/export_home_bloc.dart';
import '../../model/user.dart';
import 'package:uninstall_apps/uninstall_apps.dart';
import 'package:auto_size_text/auto_size_text.dart';


class OtherAppScreen extends StatefulWidget {
   List<Application> applications;
  User user;

   OtherAppScreen({Key key, this.applications,this.user}) : super(key: key);

  @override
  _OtherAppScreenState createState() => _OtherAppScreenState();
}

class _OtherAppScreenState extends State<OtherAppScreen> {
     Future<void> uninstallApplication(String appId) async {
        await UninstallApps.uninstall("$appId");
  }



  @override
  Widget build(BuildContext context) {
    return widget.applications.length < 1 ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/salute.jpg',height: 100,width: 100,),
          Text("Salute to you",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Text('No App to delete',style: TextStyle(fontSize: 25),)
        ],
      )
    ):GridView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: widget.applications.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.80
                             //  MediaQuery.of(context).size.height / 978,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                           Application app = widget.applications[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: app is ApplicationWithIcon
                            ? Container(
                              height: 100,
                              child: Image.memory(app.icon),
                            )
                            : null,
                                        
                                        ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 30,
                                  child: AutoSizeText(
                                    app.appName,
                                    maxLines: 2,
                                    minFontSize: 13.0,
                                    maxFontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: RaisedButton.icon(
                                    icon: Icon(Icons.delete,color:Colors.white,),
                                      color: Colors.red,
                                      onPressed: ()async {
                                        await uninstallApplication(app.packageName);
                                        widget.user.appdeleted++;
                                        await Firestore.instance.collection('users').document(widget.user.userId).updateData({
                                          'appdeleted':widget.user.appdeleted,
                                        });

                                        widget.applications.remove(app);
                                        setState(() {
                                          
                                        });
                                      },
                                      label:Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          );
                        });
  }
}