import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/login_bloc.dart';
import 'package:store_manager_app/screens/home_screen.dart';
import 'package:store_manager_app/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  @override
  void initState() {
    super.initState();
    //Como não é possivel criar uma nova tela no build utiliza o initState
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    title: Text("Error"),
                    content: Text("Fail Sing In."),
                  ));
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                );
              case LoginState.FAIL:
                break;
              case LoginState.SUCCESS:
                break;
              case LoginState.IDLE:
                return Stack(alignment: Alignment.center, children: [
                  Container(),
                  SingleChildScrollView(
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
                          const SizedBox(height: 30),
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
                                    onPressed: snapshot.hasData
                                        ? _loginBloc.submit
                                        : null,
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ]);
              default:
                break;
            }
            return Container();
          }),
    );
  }
}
