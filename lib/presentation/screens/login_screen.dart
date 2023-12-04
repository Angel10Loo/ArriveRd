import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/domain/models/user_crendential.dart';
import 'package:arriverdapp/domain/repository/base_api_service.dart';
import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/home_sceen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final UserCredentials userCredentials = UserCredentials(
      email: '', password: '', passwordConfirm: '', userName: '');
  final apiService = ApiService("");

  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgroundImage.png', // Replace with your image path
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

                    const Text("Usuario",
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
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                        border: Border.all(
                            color:
                                kBackgroundColor), // Optional: Set a border color
                      ),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          border: InputBorder
                              .none, // Remove TextField's default border
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0), // Adjust content padding
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0), // Spacer

                    const Text("Contraseña",
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
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                        border: Border.all(
                            color:
                                kBackgroundColor), // Optional: Set a border color
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true, // Hide the entered text
                        decoration: const InputDecoration(
                          border: InputBorder
                              .none, // Remove TextField's default border
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0), // Adjust content padding
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0), // Spacer

                    // Your Submit Button or Additional UI Elements can be added here
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
                              userCredentials.email = userNameController.text;
                              userCredentials.password =
                                  passwordController.text;
                              if (userCredentials.email.isEmpty ||
                                  userCredentials.password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  _showSnackBar(context,
                                      'Debes Completar todos los campos'),
                                );
                                return;
                              } else {
                                loginUser(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 18, left: 18),
                              child: Text(
                                "Iniciar Sección",
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

  Future<void> loginUser(BuildContext context) async {
    try {
      // Perform login
      // ...
      final postData = await apiService.postLogin("auth/login", {
        'username': userCredentials.email,
        'password': userCredentials.password
      });

      final Map<String, dynamic> dataValue = postData['data'];
      final String token = dataValue['token'];
      AuthStorage.setToken(token);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (error) {
      // Handle login error

      print(error);
    }
  }
}
