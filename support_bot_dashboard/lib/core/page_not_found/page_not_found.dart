// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class PageNotFound extends StatefulWidget {
//   const PageNotFound({super.key});

//   @override
//   State<PageNotFound> createState() => _PageNotFoundState();
// }

// class _PageNotFoundState extends State<PageNotFound> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.sentiment_very_dissatisfied,
//                 size: 200,
//               ),
//               const Text(
//                 "404",
//                 style: TextStyle(fontSize: 40),
//               ),
//               const Text(
//                 "Page Not Found",
//                 style: TextStyle(fontSize: 20),
//               ),
//               Container(
//                 constraints: const BoxConstraints(
//                     maxWidth: 150, minWidth: 100, maxHeight: 30),
//                 child: CustomButton(
//                     onPressed: () {
//                       setState(() async {
//                         context.goNamed(RouteConstants.login);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const LoginResponsivePage()));
//                         await clearOrganization();
//                       });
//                     },
//                     text: "Go to Login",
//                     textColor: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// clearOrganization() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.clear();
//   await serviceLocator<ApiCacheManager>().emptyCache();

//   return;
// }
