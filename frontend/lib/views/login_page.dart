import 'package:danim/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danim',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
          builder: (ctx, viewModel, child) {
            return SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      // The user CANNOT close this dialog  by pressing outsite it
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // The loading indicator
                                Lottie.asset(
                                    'assets/lottie/around_the_world.json',
                                    frameRate: FrameRate.max),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Some text
                                const Text('로그인 중...')
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    viewModel.loginButtonPressed(context);
                  },
                  child: Image.asset('assets/images/kakao_login.png'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
