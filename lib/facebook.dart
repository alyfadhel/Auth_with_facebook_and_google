import 'package:facebook_auth/auth.dart';
import 'package:facebook_auth/cubit/cubit.dart';
import 'package:facebook_auth/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacebookScreen extends StatelessWidget {
  const FacebookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMediaCubit, SocialMediaStates>(
      listener: (context, state) {
        if (state is LogOutFacebookSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialMediaCubit.get(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Center(
                  child: Text(
                    'Login Facebook Successfully',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              OutlinedButton(
                onPressed: () {
                  cubit.socialLogOutWithFacebook();
                },
                child: Text(
                  'LogOut',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
