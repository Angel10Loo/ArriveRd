import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/home_sceen.dart';
import 'package:arriverdapp/presentation/screens/login_screen.dart';
import 'package:arriverdapp/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _token = false;
  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    try {
      String? loadedToken = await AuthStorage.getToken();

      if (loadedToken != null) {
        setState(() {
          if (loadedToken.isNotEmpty) _token = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);
    return _token ? const HomeScreen() : mainScreen(rp: rp);
  }
}

class mainScreen extends StatelessWidget {
  const mainScreen({
    super.key,
    required this.rp,
  });

  final Responsive rp;

  @override
  Widget build(BuildContext context) {
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
              height: rp.hp(20),
              decoration: BoxDecoration(
                  color: kloginColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: rp.hp(4)),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            side: const BorderSide(
                              color: kPrimaryColor,
                              width: 1,
                            ),
                            backgroundColor: kBackgroundColor),
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              )
                            },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 14, left: 14),
                          child: Text(
                            "Registrarse",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: rp.hp(4)),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: kPrimaryColor),
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              )
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
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
