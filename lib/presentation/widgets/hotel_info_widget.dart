import 'package:arriverdapp/domain/models/hotel_model.dart';
import 'package:arriverdapp/utils/helper.dart';
import 'package:flutter/material.dart';

class HotelInformation extends StatelessWidget {
  final Hotel hotel;
  const HotelInformation({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            hotel.name,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Price: \$ ${hotel.price} per night',
            style: const TextStyle(fontSize: 16.0, color: Colors.green),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Location: ${hotel.destinationLocation}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Capacidad: ${Helper.formatNumberWithCommas(hotel.capacity.toString())}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Acientos Disponible: ${Helper.formatNumberWithCommas(hotel.availableSeats.toString())}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Description:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            hotel.description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
