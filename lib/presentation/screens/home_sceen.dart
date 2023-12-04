import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/domain/models/hotel_model.dart';
import 'package:arriverdapp/domain/repository/base_api_service.dart';
import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/profile_Screen.dart';
import 'package:arriverdapp/presentation/widgets/hotel_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hotel> hotels = [];
  String _username = "";
  String _email = "";
  String? _token = "";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getoKen();
  }

  Future<List<Hotel>> getHotel() async {
    try {
      String? token = await AuthStorage.getToken();

      final apiService = ApiService(token!);

      Map<String, dynamic> response = await apiService.get("excursions");
      hotels = response["data"]
          .map((hotel) => Hotel.fromJson(hotel))
          .toList()
          .cast<Hotel>();

      return hotels;
    } catch (e) {
      print(e);
    }
    return List.empty();
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

    return SafeArea(
      child: Scaffold(
        appBar: _currentIndex == 0 ? appBar(rp) : null,
        body: _currentIndex == 0 ? homeWidget() : const ProfileScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(Responsive rp) {
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: kBackgroundColor,
        toolbarHeight: rp.hp(10),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            "assets/images/Logologohome.png",
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              // Add some space between the image and text
              Text(
                _username,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(width: 8.0),
              Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.cover,
                width: 50, // Adjust the width as needed
                height: 50, // Adjust the height as needed
              ),
            ],
          ),
        ]));
  }

  Column homeWidget() {
    return Column(children: <Widget>[
      FutureBuilder(
        future: getHotel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            // Handle error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    Hotel item = hotels[index];
                    return HotelCard(
                        hotel: item,
                        hotelId: item.id,
                        name: item.name,
                        image: item.primaryImageUrl.isNotEmpty
                            ? item.primaryImageUrl
                            : "assets/images/hotel1.png",
                        description: item.description,
                        price: item.price.toString(),
                        location: item.destinationLocation);
                  },
                ),
              );
            }
            return const Center(child: Text("No hay Data"));
          }
        },
      ),
    ]);
  }
}
