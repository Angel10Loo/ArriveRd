import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarrouselImagesWidget extends StatefulWidget {
  List<String> images = [];
  final String hotelName;

  CarrouselImagesWidget(
      {super.key, required this.images, required this.hotelName});

  @override
  State<CarrouselImagesWidget> createState() => _CarrouselImagesWidgetState();
}

class _CarrouselImagesWidgetState extends State<CarrouselImagesWidget> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 210.0,
            autoPlayCurve: Curves.easeInOutCubicEmphasized,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          items: widget.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.hotelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            return _buildIndicator(index);
          }),
        ),
      ],
    );
  }

  Widget _buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentImageIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
