import 'dart:ui';
import 'package:bag_track/widget/glass_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bag_track/screen/read_qr_code.dart';
import 'package:bag_track/widget/edit_text_image.dart';
import 'package:bag_track/configiration/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenTracking extends StatefulWidget {
  const ScreenTracking({Key? key}) : super(key: key);

  @override
  State<ScreenTracking> createState() => _ScreenTrackingState();
}

class _ScreenTrackingState extends State<ScreenTracking> {
  final TextEditingController _controller = TextEditingController();
  String sender = '';
  String receiver = '';
  String type = '';
  String destination = '';
  String from = '';
  String status = '';
  String Tracking_num = '';
  bool isLoading = false; // Track whether data is being fetched
  Future<void> fetchData(String trackingNumber) async {
    setState(() {
      isLoading = true; // Show loading indicator when fetching data
    });
    final url =
        'https://sudexpress-parcels.idevelop.club/Dashboard/api/tracking-parcel/$trackingNumber';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        sender = jsonData['parcel']['sender'];
        receiver = jsonData['parcel']['receiver'];
        Tracking_num = jsonData['parcel']['tracking_number'];
        type = jsonData['parcel']['type']['name'];
        status = jsonData['parcel']['status']['name'];
        destination = jsonData['parcel']['arrive']['name'];
        from = jsonData['parcel']['depart']['name'];
      });
      print('Sender: $sender');
      print('Receiver: $receiver');
      print('Tracking_num: $Tracking_num');
      print('Type: $type');
      print('Status: $status');
      print('Destination: $destination');
      print('From: $from');
    } else {
      throw Exception('Failed to load data');
    }
    setState(() {
      isLoading = false; // Hide loading indicator after data is fetched
    });
  }

  var qrstr = 'Tracking number';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Main background container with gradient
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryLightColor, AppColor.primaryColor],
                  begin: Alignment.topRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/sheet_package_search.png"),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/card_booking_glass.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Welcome, Bag Track ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          Text(
                            'Track your Belongings',
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: AppColor.SecondtText,
                              height: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 265,
                            height: 60,
                            child: ImageTextField(
                              controller: _controller,
                              hintText: qrstr,
                              imagePath: 'assets/text_field_keyboardd.png',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 4.0),
                              onScan: (scannedData) {
                                if (scannedData != null) {
                                  final scanData = scannedData.toString();
                                  setState(() {
                                    qrstr = scanData;
                                    // Print the scanned data
                                    print('Scanned Data: $scanData');
                                    // Set the cursor position to the end of the text
                                    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
                                    // Call fetchData function after updating qrstr
                                    fetchData(scanData);
                                  });
                                } else {
                                  print('Scanned data is null.');
                                }
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: GestureDetector(
                            onTap: () {
                              scanQr();
                            },
                            child: Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/scan_qr.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor), // Change the color here
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  if (_controller.text.isNotEmpty || qrstr.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await fetchData(_controller.text.isNotEmpty ? _controller.text : qrstr);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReadQrCode(
                            status: status,
                            from: from,
                            destination: destination,
                            type: type,
                            track_num: Tracking_num,
                          ),
                        ),
                      );
                    } catch (e) {
                      showGlassDialog(context, "Error", "Failed to fetch data. Please try again.");
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  } else {
                    showGlassDialog(context, "Error", "Please enter a tracking number or scan a QR code.");
                  }
                },
                child: Container(
                  width: 270,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/book_now_button.png'),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Track',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Future<void> scanQr() async {
    try {
      String scannedData = await FlutterBarcodeScanner.scanBarcode(
        '#2A99CF',
        'cancel',
        true,
        ScanMode.QR,
      );
      setState(() {
        qrstr = scannedData;
        fetchData(scannedData);
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }*/
  Future<void> scanQr() async {
    try {
      String scannedData = await FlutterBarcodeScanner.scanBarcode(
        '#2A99CF',
        'cancel',
        true,
        ScanMode.QR,
      );
      if (scannedData != '-1') {
        setState(() {
          qrstr = scannedData;
          fetchData(scannedData);
        });
      } else {
        //showGlassDialog(context);
        showGlassDialog(context, "Error", "Please present your QR code to scan.");

        // "QR Code not found",// "Please present your QR code to scan.",
      }
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }













}
