import 'package:danim/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danim')),
      body: ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                    // width: MediaQuery.of(context).size.width,
                    child: InkWell(
                  onTap: () {
                    viewModel.loginButtonPressed(context);
                  },
                  child: Image.asset('assets/images/kakao_login.png'),
                )),
              );
            },
          )),
    );
  }
}
