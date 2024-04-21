// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:vendorapp/local_storage/secure_storage.dart';
// import 'package:vendorapp/screens/app_properties.dart';

// class Comments extends StatefulWidget {
//   const Comments({super.key});

//   @override
//   State<Comments> createState() => _CommentsState();
// }

// class _CommentsState extends State<Comments> {
//   TextEditingController comment = TextEditingController();
//   TextEditingController title = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Center(
//             child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SingleChildScrollView(
//                     child: Column(children: [
//                   TextField(
//                     controller: comment,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.comment),
//                       // Add a label here
//                       hintText: "title",
//                       fillColor: HexColor("#f0f3f1"),
//                       contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                       hintStyle: GoogleFonts.poppins(
//                         fontSize: 15,
//                         color: HexColor("#8d8d8d"),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Comment",
//                         style: GoogleFonts.poppins(
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                           color: HexColor("#4f4f4f"),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: comment,
//                     maxLines: 7,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.comment),
//                       // Add a label here
//                       hintText: "Leave your comment, here",
//                       fillColor: HexColor("#f0f3f1"),
//                       contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                       hintStyle: GoogleFonts.poppins(
//                         fontSize: 15,
//                         color: HexColor("#8d8d8d"),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (comment.text != null) {
//                         Comment_post(comment.text);
//                       } else {
//                         Get.snackbar("Error", "Comment can not be Empty");
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
//                       child: Container(
//                         padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
//                         height: 55,
//                         width: 275,
//                         decoration: BoxDecoration(
//                           color: HexColor('#44564a'),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Text(
//                           "Comment",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]))),
//           )),
//     );
//   }

//   Comment_post(String comment) async {
//     final dio = Dio();
//     var secStore = SecureStorage();
//     var token = await secStore.readSecureData('token');
//     final Options options = Options(
//       headers: {
//         "Authorization": "Bearer ${token}",
//       },
//     );

//     // try {
//     //   var response =
//     //       await dio.post("https://api.semer.dev/api/news/comment/create/",
//     //           data: {
//     //             "text": comment,
//     //             "news_id": 4,
//     //           },
//     //           options: options);
//     //   print(response.data);
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Title",
                        style: GoogleFonts.poppins(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#4f4f4f"),
                        ),
                      ),
                    ],
                  ),
                ),

                Image.network(
                  'https://i.ytimg.com/vi/l79tTXZ-A_g/maxresdefault.jpg',
                  fit: BoxFit.cover,
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Description goes here,Description goes here,Description goes here,Description goes here,Description goes here,Description goes here,Description goes here,Description goes here",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: HexColor("#8d8d8d"),
                    ),
                  ),
                ),

                // Floating Green Button with Icon
                // Container(
                //   margin: const EdgeInsets.all(20.0),
                //   child: FloatingActionButton(
                //     onPressed: () {
                //       // Handle button click here
                //     },
                //     label: Text(
                //       "Button Text",
                //       style: GoogleFonts.poppins(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     icon: Icon(
                //       Icons.description, // Replace with your desired icon
                //       size: 24,
                //     ),
                //     backgroundColor: HexColor('#44564a'),
                //   ),
                // ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 60, // Set the desired width
                          height: 60, // Set the desired height
                          child: FloatingActionButton(
                            tooltip: "Chat",
                            backgroundColor: Colors.green,
                            onPressed: () {
                              // Handle button click here
                            },
                            child: Icon(
                              Icons.comment,
                              size: 40, // Set the desired icon size
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext fcontext) {
        return AlertDialog(
          title: const Text('Login Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(
                  Icons.check_box_rounded,
                  color: Colors.green,
                  size: 120,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => MainPage()));
              },
            ),
          ],
        );
      },
    );
  }
}
