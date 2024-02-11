import 'package:auth/auth/data/authentication_data.dart';
import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  // late String email; // TODO Надо более обдуманно это решить

  SignBloc() : super(const SignState(signStatus: SignStatus.initial)) {
    on<SignButtonPressed>((event, emit) async {
      emit(const SignState(signStatus: SignStatus.loading));
      MyUser createMyUser = MyUser.empty;
      String email = event.email.contains('@')
          ? event.email
          : 'fake${DateTime.now().hashCode}@fake.com';
      createMyUser = MyUser(
          userId: 'xxx', // TODO check

          email: email,
          phoneNumber: Validator().clearPhoneNumber(event.phoneNumber),
          name: event.userName);

      MyUser myUserFromFirebase =
          await AuthenticationData().signUp(createMyUser, event.password);
      if (myUserFromFirebase != MyUser.empty) {
        String result =
            await FirebaseUserSettings().createUser(myUserFromFirebase);
        if (result == 'Success') {
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
