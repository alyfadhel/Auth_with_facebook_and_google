import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/phone/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

var otpController = TextEditingController();

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMediaCubit, SocialMediaStates>(
      listener: (context, state) {
        if (state is GetOTPSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PhoneScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialMediaCubit.get(context);
        String otpCode = '';
        PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
            fontSize: 22,
            color: Color.fromRGBO(30, 60, 87, 1),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: Colors.teal),
          ),
        );
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  controller: otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    cubit.submitOtp(otpCode);
                  },
                  onCompleted: (code)
                  {
                    otpCode = code;
                  },
                  onChanged: (value)
                  {
                    debugPrint(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
