import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/config/responsive.dart';
import 'package:arriverdapp/domain/models/hotel_model.dart';
import 'package:arriverdapp/presentation/screens/credit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final Hotel hotel;
  const BookingScreen({super.key, required this.hotel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Map<String, dynamic>> tableData = [
    {'person': 'Person 1', 'price': 20.0, 'quantity': 1},
    {'person': 'Person 2', 'price': 25.0, 'quantity': 2},
  ];
  TextEditingController entradaController = TextEditingController();
  TextEditingController salidaController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rp = Responsive(context);

    entradaController.text =
        DateFormat("dd-MM-yyyy").format(widget.hotel.schedule.meeting!);
    salidaController.text =
        DateFormat("dd-MM-yyyy").format(widget.hotel.schedule.departure!);
    locationController.text = widget.hotel.departureLocation;

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
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8, bottom: 0),
                    child: Text("Ubicación",
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
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                        border: Border.all(
                            width: 2,
                            color: kloginColor), // Optional: Set a border color
                      ),
                      child: TextField(
                        controller: locationController,
                        enabled: false,
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
                              child: Text("Fecha De Entrada",
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
                                  controller: entradaController,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    hintText: 'Fecha de entrada',
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
                              child: Text("Fecha De Salida",
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
                                  enabled: false,
                                  controller: salidaController,
                                  decoration: const InputDecoration(
                                    hintText: "Fecha Salida",
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
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Personas')),
                      DataColumn(label: Text('Precio')),
                      DataColumn(label: Text('Cantidad')),
                    ],
                    rows: tableData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data['person'])),
                          DataCell(Text(data['price'].toString())),
                          DataCell(
                            DropdownButton<int>(
                              value: data['quantity'],
                              items: List.generate(8, (index) => index + 1)
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                setState(() {
                                  data['quantity'] = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: RichText(
                    text: const TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Total: '),
                        TextSpan(
                            text: ' RD 2,000 ',
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: ktextColorAmount)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            fixedSize: const Size(279, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: kbooking),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreditCardScreen()),
                          );
                        },
                        child: const Text(
                          "Reservar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  )
                ]),
          )),
    );
  }
}
