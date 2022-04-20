import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import '../../model/application.dart';
import './home_event.dart';
import './home_state.dart';
import '../../services/user_service.dart';


class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final UserService userService = UserService();

  @override
  HomeState get initialState =>  HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{

    if(event is FetchHomeScreenApps){
        yield LoadingState();
        List<Application> otherApps = await userService.getOtherApplications();
        List<App> indianApps = await userService.getIndianApplications();
        
        yield OtherAppFetchedState(otherApps,indianApps);

    }

  }

}