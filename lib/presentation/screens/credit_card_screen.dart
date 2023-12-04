import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:flutter/material.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.5,
              backgroundColor: kAppBarColor,
              toolbarHeight: rp.hp(10),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/Logologohome.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ])),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 0),
                  child: Text("Numero De Tarjeta",
                      style: TextStyle(
                        color: kTextColor,
                        fontFamily: 'Poppins',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                      border: Border.all(
                          width: 2,
                          color: kloginColor), // Optional: Set a border color
                    ),
                    child: TextField(
                      onChanged: (value) => {},
                      decoration: const InputDecoration(
                        border: InputBorder
                            .none, // Remove TextField's default border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0), // Adjust content padding
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 0),
                  child: Text("Nombre De La Tarjeta",
                      style: TextStyle(
                        color: kTextColor,
                        fontFamily: 'Poppins',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                      border: Border.all(
                          width: 2,
                          color: kloginColor), // Optional: Set a border color
                    ),
                    child: TextField(
                      onChanged: (value) => {},
                      decoration: const InputDecoration(
                        border: InputBorder
                            .none, // Remove TextField's default border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0), // Adjust content padding
                      ),
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 8, top: 8, bottom: 0),
                            child: Text("Fecha De Expiración",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius
                                border: Border.all(
                                    width: 2,
                                    color:
                                        kloginColor), // Optional: Set a border color
                              ),
                              child: TextField(
                                onChanged: (value) => {},
                                decoration: const InputDecoration(
                                  hintText: "04/2027",
                                  border: InputBorder
                                      .none, // Remove TextField's default border
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          16.0), // Adjust content padding
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 8, top: 8, bottom: 0),
                            child: Text("CVV",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius
                                border: Border.all(
                                    width: 2,
                                    color:
                                        kloginColor), // Optional: Set a border color
                              ),
                              child: TextField(
                                onChanged: (value) => {},
                                decoration: const InputDecoration(
                                  hintText: "- - -",
                                  border: InputBorder
                                      .none, // Remove TextField's default border
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          16.0), // Adjust content padding
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ]),
                SizedBox(height: 30),
                Center(
                  child: TextButton(
                      style: TextButton.styleFrom(
                          fixedSize: const Size(279, 38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: ktextColorAmount),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreditCardScreen()),
                        );
                      },
                      child: const Text(
                        "Pagar",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                )
              ])),
    );
  }
}
