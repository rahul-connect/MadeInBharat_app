import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:madeinbharat/model/user.dart';
import '../../model/application.dart';
import 'package:store_redirect/store_redirect.dart';


class IndianApplications extends StatefulWidget {
  final List<App> applications;
  User user;

  IndianApplications({Key key, this.applications,this.user}) : super(key: key);

  @override
  _IndianApplicationsState createState() => _IndianApplicationsState();
}

class _IndianApplicationsState extends State<IndianApplications> {
  Future<void> installApplication(String appId) async {
     
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                           App app = widget.applications[index];

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
                                    child: Container(
                                      height: 100,
                                      child: app.image != '' ? CachedNetworkImage(
                                      imageUrl: app.image,
                                      placeholder: (context,_)=>Image.asset('assets/images/placeholder.png',height: 100,),
                                        ):Center(child: Text("No Image")),
                                    )
                                        
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
                                    icon: Icon(Icons.android,color:Colors.white,),
                                      color: Colors.green,
                                      onPressed: ()async {
                                        await StoreRedirect.redirect(androidAppId: app.packageName);
                                        widget.user.appInstalled++;
                                        await Firestore.instance.collection('users').document(widget.user.userId).updateData({
                                          'appInstalled':widget.user.appInstalled,
                                        });

                                        widget.applications.remove(app);
                                        setState(() {
                                          
                                        });
                                      },
                                      label:Text(
                                        "Install",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          );
                        });
  }
}