import 'package:bloc/bloc.dart';
import 'package:counter/Service/Login_Service/Login_servie.dart';
import 'package:counter/Utils/message_contants.dart';
import 'package:counter/Utils/utils.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';



class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():  super(LoginInitialState()){

    on<LoginPressedEvent>((event, emit) async{
      emit(LoginLoadingState());

      Map<String, dynamic> resultMap = await LoginService().loginUser(event.username, event.password);
      String? result = resultMap['result'] as String?;

        if(result == ConstantsMessage.serveError){
          emit(LoginErrorState(ConstantsMessage.serveError));
      }else if (result == ConstantsMessage.incorrectPassword) {
        emit(LoginErrorState(ConstantsMessage.incorrectPassword));
      }else{
        emit(LoginSuccessState());
      }
    });
  }
}
