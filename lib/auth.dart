import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/facebook.dart';
import 'package:facebook_auth/google.dart';
import 'package:facebook_auth/phone/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatelessWidget {
  final phoneNumber;
    const AuthScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMediaCubit, SocialMediaStates>(
      listener: (context, state) {
        if (state is GetFacebookAuthSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const FacebookScreen(),
            ),
          );
        }
        if (state is GetGoogleAuthSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GoogleScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialMediaCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.socialSignWithFacebook();
                      },
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0.0),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          )),
                      child: SvgPicture.asset(
                        'assets/images/facebook.svg',
                        height: 60.0,
                        width: 60.0,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.socialSignInWithGoogle();
                      },
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0.0),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          )),
                      child: SvgPicture.asset(
                        'assets/images/google.svg',
                        height: 60.0,
                        width: 60.0,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  PhoneAuth(phoneNumber: phoneNumber.toString()),
                          ),
                        );
                      },
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0.0),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          )),
                      child: SvgPicture.asset(
                        'assets/images/phone.svg',
                        height: 60.0,
                        width: 60.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//80eb84fcf3473edcaa60fa0ff1ff354b
