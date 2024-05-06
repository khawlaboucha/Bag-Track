import 'package:bag_track/configiration/color.dart';
import 'package:flutter/material.dart';
class TextOverImage extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final double imageWidth;
  final double imageHeight;

  TextOverImage({
    required this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.black,
    this.imageWidth = 200.0,
    this.imageHeight = 45.0,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/blue_indicator.png'; // Default image path

    // Determine the image path based on the text
    if (text == 'Emission') {
      imagePath = 'assets/grey_indicatorr.png';
    } else  if (text == 'Arrived') {
      imagePath = 'assets/green_indicator.png';
    }else  if (text == 'Posed') {
      imagePath = 'assets/posed_test_sheet.png';
    }else  if (text == 'Deliverd') {
      imagePath = 'assets/white_indicator.png';
    }

    return Container(
      width: 140,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: AppColor.neumorphPrimary, width: 0.3),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(bottom: 5,
            left: 90,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
