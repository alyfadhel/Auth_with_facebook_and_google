import 'package:bloc/bloc.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/model/facebook_user_model.dart';
import 'package:facebook_auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaCubit extends Cubit<SocialMediaStates>
{
  SocialMediaCubit():super(InitialSocialMediaState());

 static SocialMediaCubit get(context)=>BlocProvider.of(context);

  final fireAuth = FirebaseAuth.instance;
  String? userVerificationId;
  int? userForceResendingToken;

  //_______________________________Sign with facebook__________________________
  Future<void> socialSignWithFacebook() async {
    emit(GetFacebookAuthLoadingState());
    final LoginResult result = await FacebookAuth.instance.login();

    final Map<String, dynamic> userData =
    await FacebookAuth.instance.getUserData(fields: 'name,email');
    final userDataConverted = FacebookUserModel.fromMap(userData);
    final userModel = UserModel(
      email: userDataConverted.email!,
      password: userDataConverted.name!,
    );

    final OAuthCredential credential =
    FacebookAuthProvider.credential(result.accessToken!.token);
    await fireAuth.signInWithCredential(credential)
        .then((value){
          emit(GetFacebookAuthSuccessState(userModel));
    }).catchError((error)
    {
      emit(GetFacebookAuthErrorState(error.toString()));
      debugPrint(error.toString());
    });

  }

  //_______________________________Sign with Google______________________________
  Future<void> socialSignWithGoogle() async {
    emit(GetGoogleAuthLoadingState());
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final googleSignInAccount = await googleSignIn.signIn();
    final googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final UserModel userModel = UserModel(
        email: googleSignInAccount.email, password: googleSignInAccount.id);
    await fireAuth.signInWithCredential(credential).then((value)
    {
      emit(GetGoogleAuthSuccessState(userModel));
    }).catchError((error)
    {
      emit(GetGoogleAuthErrorState(error.toString()));
      debugPrint(error.toString());
    });


  }

//_______________________________Sign with Phone ______________________________


  Future<void> socialSignWithPhoneNumber(String phoneNumber) async {

    late PhoneAuthState phoneAuthState;

    fireAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        final result = await fireAuth.signInWithCredential(credential);
        final user = result.user;
        if (user != null) {
          phoneAuthState = PhoneAuthState.automatic;
        }
      },

      verificationFailed: (error) =>
      throw FirebaseAuthException(code: error.code),

      codeSent: (verificationId, forceResendingToken) async {
        userVerificationId = verificationId;
        phoneAuthState = PhoneAuthState.manual;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    ).then((value)
    {
      emit(GetPhoneAuthSuccessState(phoneAuthState));
    }).catchError((error)
    {
      emit(GetGoogleAuthErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  //__________________________Otp verification_______________________________________
  Future<void> socialOtpVerification(String code) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: userVerificationId!, smsCode: code);
    final result = await fireAuth.signInWithCredential(credential);
    final user = result.user;
    if (user != null) {
      emit(GetOTPSuccessState());
    }
    emit(GetOTPErrorState());
  }

}

enum PhoneAuthState {
  automatic,
  manual,
}