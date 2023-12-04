import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/domain/models/hotel_model.dart';
import 'package:arriverdapp/domain/repository/base_api_service.dart';
import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/bookin_screen.dart';
import 'package:arriverdapp/presentation/widgets/carrousel_slider_widget.dart';
import 'package:arriverdapp/presentation/widgets/hotel_info_widget.dart';
import 'package:flutter/material.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final List<String> hotelImages = [
    'https://www.institucionaldominicana.com/wp-content/uploads/2019/08/los-5-mejores-hoteles.jpg',
    // Add more image URLs as needed
  ];

  Future<List<String>> getImages(int hotelId) async {
    try {
      String? token = await AuthStorage.getToken();

      final apiService = ApiService(token!);

      Map<String, dynamic> response =
          await apiService.get("excursions/$hotelId/images");
      List<HotelIImage> list = response["data"]
          .map((images) => HotelIImage.fromJson(images))
          .toList()
          .cast<HotelIImage>();
      List<String> imageURLs =
          list.map((hotelImage) => hotelImage.url).toList();
      return imageURLs;
    } catch (e) {
      print(e);
    }
    return List.empty();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int hotelId = args["id"];
    final Hotel hotelSended = args["hotel"] as Hotel;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 5),
            FutureBuilder<List<String>>(
              future: getImages(hotelId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Handle loading state
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data is loaded, pass it to your custom widget
                  List<String> stringList = snapshot.data!;
                  return CarrouselImagesWidget(
                      images: stringList, hotelName: hotelSended.name);
                }
              },
            ),
            const SizedBox(height: 10.0),
            HotelInformation(hotel: hotelSended),
            const SizedBox(height: 18),
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
                          builder: (context) =>
                              BookingScreen(hotel: hotelSended)),
                    );
                  },
                  child: const Text(
                    "Hacer Una Reserva",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
