import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/facebook.dart';
import 'package:facebook_auth/google.dart';
import 'package:facebook_auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

var phoneController = TextEditingController();

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
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
                        cubit.socialSignWithGoogle();
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
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Text(
              //   'ــــــــــــ Or ــــــــــــ ',
              //   style: Theme.of(context).textTheme.headlineSmall,
              // ),
              // const SizedBox(
              //   height: 30.0,
              // ),
              // Text(
              //   'Phone Number',
              //   style: Theme.of(context).textTheme.headlineSmall,
              // ),
              // const SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: TextFormField(
              //     controller: phoneController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20.0),
              //       ),
              //       label: Text(
              //         'Phone Number',
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //       prefixIcon: const Icon(Icons.phone_android_outlined),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20.0,
              // ),
              // OutlinedButton(
              //   onPressed: () {
              //     cubit.socialSignWithPhoneNumber('00201225010913').then((value) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const OTPScreen(),
              //         ),
              //       );
              //     });
              //   },
              //   child: Text(
              //     'Enter Your Number',
              //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
              //       color: Colors.blue,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

//80eb84fcf3473edcaa60fa0ff1ff354b
