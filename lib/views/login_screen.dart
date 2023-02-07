import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/views/home_page_view.dart';

import '../cubit/login_cubit/login_cubit.dart';
import '../repository/login_object_repo/login_object_repo_impl.dart';
import '../utils/constants.dart';
import 'alert_dialog.dart';

String id = "";
String pass = "";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(153, 90, 126, 193),
                Color.fromARGB(255, 99, 195, 212),
                Color.fromARGB(204, 90, 160, 193),
                Color.fromARGB(102, 90, 160, 193),
              ])),
          child: BlocProvider(
            create: (context) => LoginCubit(LoginObjectRepoImpl()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    // print("hello${state.loginObject.auth}");
                    if (state.loginObject.auth == "1") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage(loginObject: state.loginObject
                            // title: state.loginObject.auth!,
                            );
                      }));
                    }
                  }
                },
                builder: (context, state) {
                  if (state is LoginInitial) {
                    return initialLoginScreen(context);
                  } else if (state is LoginLoading) {
                    return loadingScreen();
                  } else if (state is LoginSuccess) {
                    if (state.loginObject.auth == "0") {
                      //Show alert dialog
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        alertDialog(context, "Warning!",
                            "Incorrect user id or password");
                      });
                    }
                    return initialLoginScreen(context);
                  } else {
                    //Show alert dialog
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      alertDialog(context, "Warning!",
                          "Something went wrong! Please try again or contact IT.");
                    });

                    return initialLoginScreen(context);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Center loadingScreen() {
  return const Center(
    child: CircularProgressIndicator(color: Colors.white),
  );
}

Column initialLoginScreen(BuildContext context) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const SizedBox(height: 50),
      Expanded(
        child: Image.asset(
          'lib/assets/mjlogo.png',
          // height: 160,
          width: 220,
          color: Colors.white,
        ),
      ),
      const BuildTextField(
        hintText: "User ID",
        icon: Icons.person,
        sizedBoxHeight: 20,
        track: 0,
        obsecureText: false,
      ),
      const BuildTextField(
        hintText: "Password",
        icon: Icons.lock,
        sizedBoxHeight: 40,
        track: 1,
        obsecureText: true,
      ),
      buildLoginButton(context),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.centerRight,
        child: const Text(
          Constants.appVersion,
          style: TextStyle(color: Colors.white),
        ),
      ),
      const SizedBox(height: 70)
    ],
  );
}

// ignore: camel_case_types
class BuildTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final double sizedBoxHeight;
  final int track;
  final bool obsecureText;

  const BuildTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.sizedBoxHeight,
    required this.track,
    required this.obsecureText,
  });

  @override
  State<BuildTextField> createState() =>
      _BuildTextFieldState(hintText, icon, sizedBoxHeight, track, obsecureText);
}

class _BuildTextFieldState extends State<BuildTextField> {
  String hintText;
  IconData icon;
  double sizedBoxHeight;
  int track;
  bool obsecureText;

  _BuildTextFieldState(this.hintText, this.icon, this.sizedBoxHeight,
      this.track, this.obsecureText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            hintText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60,
          child: TextField(
            onChanged: (value) {
              setState(() {
                if (track == 0) {
                  id = value;
                } else {
                  pass = value;
                }
              });
            },
            // controller: track == 0 ? id : pass,
            obscureText: obsecureText,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                icon,
                color: Colors.blue,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38),
            ),
          ),
        ),
        SizedBox(
          height: sizedBoxHeight,
        )
      ],
    );
  }
}

ElevatedButton buildLoginButton(
  BuildContext context,
) {
  // print("UID:$userId Pass: $password");
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 5,
        padding: const EdgeInsets.all(15),
        minimumSize: const Size(double.infinity, 50)),
    child: const Text(
      'LOGIN',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      // print('Login Pressed');
      // _setText();
      if (id.isEmpty || pass.isEmpty) {
        alertDialog(context, "Warning", "Enter UserID and Password");
      } else {
        // print("UserID: ${id}Password: $pass");
        context.read<LoginCubit>().getLoginData(id, pass, "344", "0");
      }
    },
  );
}
