import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange[300],
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                // top: 50,
                left: 20,
                child: Image.asset('assets/images/tiger.png',height: 200,width: 200,),
              //   child: Icon(
              //     Icons.supervised_user_circle,
              //     color: Colors.white,
              //     size: 100.0,
              //   ),
              ),
              SizedBox(
                width: 240,
                height: 230,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
