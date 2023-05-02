



import 'package:bloc/bloc.dart';
import 'package:counter/Bloc/ServiceData/ServiceEvent.dart';
import 'package:counter/Bloc/ServiceData/ServiceState.dart';
import 'package:counter/Service/ServiceApi/ServiceApi.dart';
import 'package:counter/Utils/message_contants.dart';

class ServiceBloc extends Bloc<ServiceEvent,ServiceState>{
  ServiceBloc(): super(ServiceInitialState()){


    on<onPressedEvent>((event,emit) async{
      emit(ServiceLoadingState());


      dynamic result = await ServiceApi().sendData(event.headcode, event.train_uid, event.origin_location, event.destination_location, event.origin_time, event.destination_time, event.ota, event.otd, event.joining, event.alightning, event.delay, event.comment);
      if(result == ConstantsMessage.serveError){
        emit(ServiceErrorState(ConstantsMessage.serveError));
      }else if (result == ConstantsMessage.incorrectPassword) {
        emit(ServiceErrorState(ConstantsMessage.incorrectPassword));
      }else{
        emit(ServiceSuccessState());
      }

    });
  }
}