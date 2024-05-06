import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ImageTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String imagePath;
  final bool obscureText;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final Function(String) onScan;

  ImageTextField({
    required this.controller,
    required this.hintText,
    required this.imagePath,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.padding = const EdgeInsets.all(4.0),
    required this.onScan,
  });

  @override
  _ImageTextFieldState createState() => _ImageTextFieldState();
}

class _ImageTextFieldState extends State<ImageTextField> {
  late String scannedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.infinity,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w500,fontSize: 13,),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(color:Colors.black.withOpacity(0.3), fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w700,),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          // Set the text color to black

        ),
      ),

    );
  }

  Future<String> scanQr() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#2A99CF', 'Cancel', true, ScanMode.QR);
      return barcodeScanRes;
    } catch (e) {
      return 'Unable to read QR';
    }
  }
}

