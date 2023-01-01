import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/model/user_model.dart';

abstract class SocialMediaStates{}

class InitialSocialMediaState extends SocialMediaStates{}

class GetFacebookAuthLoadingState extends SocialMediaStates{}
class GetFacebookAuthSuccessState extends SocialMediaStates
{
  final UserModel userModel;

  GetFacebookAuthSuccessState(this.userModel);
}
class GetFacebookAuthErrorState extends SocialMediaStates
{
  final String error;

  GetFacebookAuthErrorState(this.error);
}

class GetGoogleAuthLoadingState extends SocialMediaStates{}
class GetGoogleAuthSuccessState extends SocialMediaStates
{
  final UserModel userModel;

  GetGoogleAuthSuccessState(this.userModel);
}
class GetGoogleAuthErrorState extends SocialMediaStates
{
  final String error;

  GetGoogleAuthErrorState(this.error);
}

class GetPhoneAuthLoadingState extends SocialMediaStates{}
class GetPhoneAuthSuccessState extends SocialMediaStates
{
  final PhoneAuthState phoneAuthState;

  GetPhoneAuthSuccessState(this.phoneAuthState);
}
class GetPhoneAuthErrorState extends SocialMediaStates
{
  final String error;

  GetPhoneAuthErrorState(this.error);
}


class GetOTPSuccessState extends SocialMediaStates{}
class GetOTPErrorState extends SocialMediaStates{}