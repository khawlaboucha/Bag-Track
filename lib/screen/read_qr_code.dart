import 'package:bag_track/configiration/color.dart';
import 'package:bag_track/screen/screnn_track.dart';
import 'package:bag_track/widget/text_overImage.dart';
import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadQrCode extends StatefulWidget {
  final String status;
  final String from;
  final String destination;
  final String type;
  final String track_num;
  const ReadQrCode({Key? key, required this.status, required this.from, required this.destination, required this.type, required this.track_num}) : super(key: key);

  @override
  State<ReadQrCode> createState() => _ReadQrCodeState();
}

class _ReadQrCodeState extends State<ReadQrCode>{
  late String imageAsset;
  @override
  Widget build(BuildContext context) {
    if (widget.status == 'Emission') {
      imageAsset = 'assets/emission_package_sheet.png';
      //imageAsset = 'assets/deliveryed_sheet.png';
    } else if (widget.status == 'Posed') {
      imageAsset = 'assets/posed_package_sheet.png';
    } else if (widget.status == 'Deliverd') {
      imageAsset = 'assets/arrived_package_sheet.png'; // Default image if status is neither 'emission' nor 'posed'
    }else if (widget.status == 'Arrived') {
      imageAsset = 'assets/arrived_package_sheet.png'; // Default image if status is neither 'emission' nor 'posed'
    }
    Size size=MediaQuery.of(context).size;
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
        body:Stack(children: [
        Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryLightColor, AppColor.primaryColor],
          begin: Alignment.topRight,
          //end:Alignment.bottomRight,
        )),
           child: Stack(children: [
              Positioned(
                    top: 60, // Adjust this value to position the image vertically
                    right: 40, // Adjust this value to position the image horizontally
                   child: Container(
                    width: 40,
                   height: 40,
                   decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.grey.shade300,
                // Add your image here
                   ),)),
                Padding(
              padding: EdgeInsets.only(bottom: 110),
                 child: Container(
                 decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(imageAsset),
                   fit:BoxFit.cover,
                      ),
                         ),
                      ),
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Padding(
                   padding: EdgeInsets.only(top: 15,left: 85),
                   child: Text(
                     'Parcel Details',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 19,
                       fontFamily: 'Poppins',
                       fontWeight: FontWeight.bold,
                       color: AppColor.primaryColor,
                     ),
                   ),
                 ),
                 Spacer(), // Adds space between text and icon
                 Padding(
                   padding: EdgeInsets.only(top: 15),
                   child: Container(
                     width: 80, // Adjust the width as needed
                     height: 80, // Adjust the height as needed
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage("assets/icon_map_logo.png"),
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                 ),
               ],
             ),

             Positioned(
                   bottom:30,
                    left: 0,
                    right: 0,
                   child: Container(
                     height:380,
                    width:double.infinity,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                     image: AssetImage("assets/card_booking_blue.png"),
                      fit:BoxFit.fill
                   ),
                  ),
                   child: Column(
                     children:[
                       Row(
                         children:[
                           Padding(
                               padding: const EdgeInsets.only(
                                    left: 70,top: 20),
                               child: Container(
                                 height: 70, width: 70,
                                 decoration: BoxDecoration(
                                   image: DecorationImage(
                                     image: AssetImage("assets/package_icon_1.png")
                                   )
                                 ),
                               )),
                           Padding(
                             padding: EdgeInsets.only(top: 20,right: 50),
                             child: Column(
                                 children:[
                                   Text('Tracking Number',style:TextStyle(
                                     fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                                   )
                                   ),
                                   Text('#ID: ${widget.track_num}',style:TextStyle(
                                       fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w200,color:Colors.white
                                   )
                                   ),
                                 ]
                             ),
                           )
                         ]
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 10),
                         child: Container(
                           width: 290,
                           height: 1.5,
                           color: Colors.white,
                         ),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Padding(
                             padding: EdgeInsets.only(top: 20),
                             child: Column(
                                 children:[
                                   Text('Company',style:TextStyle(
                                       fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                                   )
                                   ),
                                   Text('SudExpress',style:TextStyle(
                                       fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w200,color:Colors.white
                                   )
                                   ),
                                 ]
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 20),
                             child: Column(
                                 children:[
                                   Text('Type',style:TextStyle(
                                       fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                                   )
                                   ),
                                   Text(widget.type,style:TextStyle(
                                       fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w200,color:Colors.white
                                   )
                                   ),
                                 ]
                             ),
                           )
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Padding(
                             padding: EdgeInsets.only(top: 20),
                             child: Column(
                                 children:[
                                   Text('From',style:TextStyle(
                                       fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                                   )
                                   ),
                                   Text(widget.from,style:TextStyle(
                                       fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w200,color:Colors.white
                                   )
                                   ),
                                 ]
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 20),
                             child: Column(
                                 children:[
                                   Text('Destination',style:TextStyle(
                                       fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                                   )
                                   ),
                                   Text(widget.destination,style:TextStyle(
                                       fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w200,color:Colors.white
                                   )
                                   ),
                                 ]
                             ),
                           )
                         ],
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 20),
                         child: Container(
                           width: 290,
                           height: 1.5,
                           color: Colors.white,
                         ),
                       ),
                       Row(
                           children:[
                             Padding(
                               padding: EdgeInsets.only( left:80,top: 17),
                               child: Text('Status',style:TextStyle(
                                   fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color:Colors.white
                               )
                               ),
                             ),
                             Padding(
                                 padding: const EdgeInsets.only(top:15,left: 10),
                               child: Center(
                               child: TextOverImage(
                               text: widget.status,
                                fontSize: 15.0,
                               textColor: Colors.white,
                                )


                                 ),

                               ),

                                 ]
                       ),



                     ]
                   ),

                   )),
                Positioned(
                 bottom:0,left: 0,right: 0,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     GestureDetector(
                       onTap:(){
                         Navigator.of(context).push(
                           MaterialPageRoute(
                               builder: (context) =>ScreenTracking()
                           ),
                         );
                       },
                       child: Container(
                         width: 270,height: 70,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: AssetImage('assets/book_now_button.png'))
                         ),
                         child: Center( // Center the text horizontally and vertically
                           child: Padding(
                             padding: const EdgeInsets.only(bottom: 10),
                             child: Text(
                               'Exit',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontFamily: 'Poppins',
                                 fontWeight: FontWeight.w600,
                                 color: Color(0XFF383A69),
                                 fontSize: 16,
                               ),
                             ),
                           ),
                         ),

                       ),
                     ),
                   ],
                 )
             ),

           ]))]));
    }
}
