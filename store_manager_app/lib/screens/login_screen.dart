import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/login_bloc.dart';
import 'package:store_manager_app/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginBloc = LoginBloc();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.store,
                color: Theme.of(context).primaryColorLight,
                size: 160,
              ),
              InputField(
                icon: Icons.person_outline,
                hint: "Email",
                obscuretext: false,
                stream: _loginBloc.outEmail,
                onChanged: _loginBloc.changeEmail,
              ),
              InputField(
                icon: Icons.lock_outline,
                hint: "Password",
                obscuretext: true,
                stream: _loginBloc.outPassword,
                onChanged: _loginBloc.changePassword,
              ),
              SizedBox(height: 30),
              StreamBuilder<bool>(
                  stream: _loginBloc.outSubmitedValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: snapshot.hasData
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.3),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: snapshot.hasData ? () {} : null,
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
