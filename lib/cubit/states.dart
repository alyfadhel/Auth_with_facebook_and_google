import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/model/user_model.dart';

abstract class SocialMediaStates{}

class InitialSocialMediaState extends SocialMediaStates{}
//---------------------------------------------------------------
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
//----------------------------------------------------------------

class LogOutFacebookSuccessState extends SocialMediaStates
{
  final UserModel userModel;

  LogOutFacebookSuccessState(this.userModel);
}
class LogOutFacebookErrorState extends SocialMediaStates
{
  final String error;

  LogOutFacebookErrorState(this.error);
}
//--------------------------------------------------------------------

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
//---------------------------------------------------------------------
class LogOutGoogleSuccessState extends SocialMediaStates
{
  final UserModel userModel;

  LogOutGoogleSuccessState(this.userModel);
}
class LogOutGoogleErrorState extends SocialMediaStates
{
  final String error;

  LogOutGoogleErrorState(this.error);
}
//---------------------------------------------------------------------

class GetPhoneAuthLoadingState extends SocialMediaStates{}
class GetPhoneAuthSuccessState extends SocialMediaStates
{}
class GetPhoneAuthErrorState extends SocialMediaStates
{
  final String error;

  GetPhoneAuthErrorState(this.error);
}


class GetOTPSuccessState extends SocialMediaStates{}
class GetOTPErrorState extends SocialMediaStates{
  final String error;

  GetOTPErrorState(this.error);
}

class LogOutWithPhoneSuccessState extends SocialMediaStates{}
class LogOutWithPhoneErrorState extends SocialMediaStates
{
  final String error;

  LogOutWithPhoneErrorState(this.error);

}