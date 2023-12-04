import 'package:arriverdapp/config/constants.dart';
import 'package:arriverdapp/domain/models/hotel_model.dart';
import 'package:arriverdapp/presentation/screens/hotel_detail_screen.dart';
import 'package:arriverdapp/utils/helper.dart';
import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  final String image;
  final int hotelId;
  final String description;
  final String price;
  final String name;
  final Hotel hotel;
  final String location;

  const HotelCard(
      {super.key,
      required this.hotelId,
      required this.hotel,
      required this.image,
      required this.description,
      required this.price,
      required this.name,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(
                          arguments: {"id": hotelId, "hotel": hotel}),
                      builder: (context) => const HotelDetailScreen()),
                );
              },
              child: image.startsWith("h")
                  ? Image.network(
                      image,
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image is fully loaded
                          return child;
                        } else {
                          // Show a loading indicator while the image is loading
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : Image.asset(
                      image,
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Price: \$ ${Helper.formatNumberWithCommas(Helper.removeTrailingZeros(double.parse(price)).toString())}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    '📍 Location: $location',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
