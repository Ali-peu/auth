import 'package:auth/auth/data/authentication_data.dart';
import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(const SignState(signStatus: SignStatus.initial)) {
    on<SignButtonPressed>((event, emit) async {
      emit(const SignState(signStatus: SignStatus.loading));
      MyUser createMyUser = MyUser.empty; // Что тут происходит? 
      createMyUser = MyUser(
          userId: 'xxx', // TODO check

          email: event.email,
          phoneNumber: Validator().clearPhoneNumber(event.phoneNumber),
          name: event.userName);

      MyUser myUserFromFirebase =
          await AuthenticationData().signUp(createMyUser, event.password);
      if (myUserFromFirebase != MyUser.empty) {
        String result =
            await FirebaseUserSettings().createUser(myUserFromFirebase);
        if (result == 'Success') { // Указание на эту проблему в authentithication_data.dart
          emit(SignState(signStatus: SignStatus.success, result: result));
        } else {
          emit(SignState(signStatus: SignStatus.success, result: result));
        }
      } else {
        emit(SignState(
            signStatus: SignStatus.failure, result: myUserFromFirebase.name));
      }
    });
  }
}
