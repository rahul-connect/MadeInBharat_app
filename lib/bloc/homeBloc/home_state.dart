import 'package:device_apps/device_apps.dart';
import '../../model/application.dart';

abstract class HomeState{

}



class HomeInitialState extends HomeState{

}


class OtherAppFetchedState extends HomeState{
 final  List<Application> otherApplications;
 final  List<App> indianApplications;

  OtherAppFetchedState(this.otherApplications,this.indianApplications);
  
}


class LoadingState extends HomeState{

}





