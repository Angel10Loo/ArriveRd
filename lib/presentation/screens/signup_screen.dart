import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/domain/models/user_crendential.dart';
import 'package:arriverdapp/domain/repository/base_api_service.dart';
import 'package:arriverdapp/presentation/screens/login_screen.dart';
import 'package:arriverdapp/utils/helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final UserCredentials userCredentials = UserCredentials(
      email: '', password: '', passwordConfirm: '', userName: '');
  final apiService = ApiService("");
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgroundImage.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/logomain.png"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: rp.hp(70),
              decoration: BoxDecoration(
                  color: kloginColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text("Bienvenido!",
                          style: TextStyle(
                            color: kBackgroundColor,
                            fontFamily: 'Poppins',
                            fontSize: 40.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    const SizedBox(height: 20.0),

                    const Text("Nombre De Usuario",
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 9.0),
                    Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: kBackgroundColor),
                      ),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    const Text("Email",
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 9.0),
                    Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: kBackgroundColor),
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    const Text("Contraseña",
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 9.0), // Spacer
                    Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                        border: Border.all(
                            color:
                                kBackgroundColor), // Optional: Set a border color
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0), // Spacer

                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: rp.hp(0.1)),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: kPrimaryColor),
                            onPressed: () {
                              userCredentials.email = emailController.text;
                              userCredentials.password =
                                  passwordController.text;
                              userCredentials.userName =
                                  userNameController.text;
                              if (!Helper.isEmailValid(userCredentials.email)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  _showSnackBar(
                                      context, 'Favor colocar un email valido'),
                                );
                                return;
                              }
                              if (!Helper.hasSpecialCharacter(
                                  userCredentials.password)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  _showSnackBar(context,
                                      'La contraseña debe de tener al menos un carater especial'),
                                );
                                return;
                              }
                              if (userCredentials.email.isEmpty ||
                                  userCredentials.password.isEmpty ||
                                  userCredentials.userName.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  _showSnackBar(context,
                                      'Debes Completar todos los campos'),
                                );
                              } else {
                                registerUser(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 18, left: 18),
                              child: Text(
                                "Registrarse",
                                style: TextStyle(
                                  color: kBackgroundColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  SnackBar _showSnackBar(BuildContext context, String text) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 20.0,
      backgroundColor: Colors.red,
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {},
        textColor: Colors.white,
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      // Perform login
      // ...
      final postData = await apiService.postLogin("auth/register", {
        'username': userCredentials.userName,
        'email': userCredentials.email,
        'password': userCredentials.password
      });

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (error) {
      // Handle login error

      print(error);
    }
  }
}
