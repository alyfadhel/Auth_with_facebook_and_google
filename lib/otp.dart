import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:facebook_auth/phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var otpController = TextEditingController();

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMediaCubit, SocialMediaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialMediaCubit.get(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      'OTP',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    prefixIcon: const Icon(Icons.phone_android_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              OutlinedButton(
                onPressed: () {
                  cubit.socialOtpVerification('123456').then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhoneScreen(),
                      ),
                    );
                  });
                },
                child: Text(
                  'OTP',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.blue,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
