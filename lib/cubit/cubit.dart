import 'package:bloc/bloc.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/model/facebook_user_model.dart';
import 'package:facebook_auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaCubit extends Cubit<SocialMediaStates> {
  SocialMediaCubit() : super(InitialSocialMediaState());

  static SocialMediaCubit get(context) => BlocProvider.of(context);

  final fireAuth = FirebaseAuth.instance;
  String? userVerificationId;
  int? userForceResendingToken;

  //_______________________________SignIn with facebook__________________________
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
    await fireAuth.signInWithCredential(credential).then((value) {
      emit(GetFacebookAuthSuccessState(userModel));
    }).catchError((error) {
      emit(GetFacebookAuthErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
  //_______________________________SignOut with facebook__________________________
  Future<void>socialSignOutWithFacebook()async
  {
    final Map<String, dynamic> userData =
    await FacebookAuth.instance.getUserData(fields: 'name,email');
    final userDataConverted = FacebookUserModel.fromMap(userData);
    final userModel = UserModel(
      email: userDataConverted.email!,
      password: userDataConverted.name!,
    );
    FirebaseAuth.instance.signOut().then((value)
    {
      emit(SignOutFacebookSuccessState(userModel));
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SignOutFacebookErrorState(error.toString()));
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
    await fireAuth.signInWithCredential(credential).then((value) {
      emit(GetGoogleAuthSuccessState(userModel));
    }).catchError((error) {
      emit(GetGoogleAuthErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

 //_______________________________SignIn with Phone ______________________________

  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,

    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    debugPrint('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) async {
    debugPrint('verificationFailed');
    emit(GetPhoneAuthErrorState(error.toString()));
    debugPrint('Error: $error');
  }

  void codeSent(String verificationId, int? forceResendingToken) {
    debugPrint('codeSent');
    this.verificationId = verificationId;
    emit(GetPhoneAuthSuccessState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    debugPrint('codeAutoRetrievalTimeout');
  }

  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
        await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential)async
  {
       await fireAuth.signInWithCredential(credential).then((value)
       {
         emit(GetOTPSuccessState());
       }).catchError((error)
       {
         debugPrint('Error: $error');
         emit(GetOTPErrorState(error.toString()));
       });
    }

//_______________________________SignOut with Phone ___________________________

  Future<void>signOutWithPhone()async
  {
    await FirebaseAuth.instance.signOut().then((value)
    {
      emit(SignOutWithPhoneSuccessState());
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SignOutWithPhoneErrorState(error.toString()));
    });
  }




  }






