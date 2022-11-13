// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../constans.dart';

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.wb_sunny_outlined)),
//             Text(
//               'Plan Your Trip',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(color: kAppBarElementsColor),
//             ),
//             IconButton(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) => SimpleDialog(
//                             contentPadding: EdgeInsets.all(20),
//                             alignment: Alignment.center,
//                             title: Text('Contact Info'),
//                             children: [
//                               Text(
//                                 aboutMe,
//                                 textAlign: TextAlign.center,
//                               )
//                             ],
//                           ));
//                 },
//                 icon: Icon(
//                   Icons.info_outline_rounded,
//                   color: kAppBarElementsColor,
//                 )),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: kSearchBg,
//               borderRadius: BorderRadius.circular(kDefaultRadius),
//             ),
//             child: Center(
//               child: TextField(
//                 keyboardType: TextInputType.streetAddress,
//                 textInputAction: TextInputAction.search,
//                 textCapitalization: TextCapitalization.sentences,
//                 controller: _searchController,
//                 style: TextStyle(color: kAppBarElementsColor),
//                 onChanged: (String text) {
//                   setState(() {
//                     suchText = text;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   prefixIcon:
//                       const Icon(Icons.search, color: kAppBarElementsColor),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.clear, color: kAppBarElementsColor),
//                     onPressed: () {
//                       setState(() {
//                         _searchBoolean = false;
//                         suchText = '';
//                         _searchController.clear();
//                       });
//                     },
//                   ),
//                   hintText: 'Search...',
//                   hintStyle: TextStyle(color: kAppBarElementsColor),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
