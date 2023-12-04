import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";
  String _email = "";
  String? _token = "";
  @override
  void initState() {
    super.initState();

    getoKen();
  }

  Future<void> getoKen() async {
    try {
      _token = await AuthStorage.getToken();

      Map<String, dynamic> decodedToken = JwtDecoder.decode(_token!);

      setState(() {
        _username = decodedToken[
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'];
        _email = decodedToken[
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'];
      });
    } catch (e) {
      print('Error decoding JWT: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);

    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 16.0),
        const CircleAvatar(
          radius: 60.0,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        const SizedBox(height: 16.0),
        Text(
          _username,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _email,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16.0),
        IconButton(
            onPressed: () {
              AuthStorage.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            )),
        const Text(
          'Cerrar Sesión',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20.0),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: rp.hp(6.9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: kbooking,
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: kTextColor,
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
            ),
            const Positioned(
                top: 16,
                left: 28,
                child: Column(
                  children: [
                    Text(
                      "Mis Reservaciones",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ))
          ],
        ),
      ]),
    );
  }
}
