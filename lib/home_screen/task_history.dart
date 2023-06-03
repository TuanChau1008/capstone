// import 'package:flutter/material.dart';
//
// import '../utils/constants/color_constant.dart';
//
// class History extends StatefulWidget {
//   const History({Key? key}) : super(key: key);
//
//   @override
//   State<History> createState() => _HistoryState();
// }
//
// class _HistoryState extends State<History> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task History'),
//         backgroundColor: ColorConstant.primaryColor,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             SizedBox(
//               height: size.height,
//               child: FirebaseAnimatedList(
//                 query: widget.taskhis.getInfoQuery(),
//                 itemBuilder: (context, snapshot, animation, index) {
//                   final json = snapshot.value as Map<dynamic, dynamic>;
//                   // final data = TaskHistory.fromJson(json);
//                   return ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     children: <Widget>[
//                       Card(
//                         child: ListTile(
//                           leading: Container(
//                             width: 5,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                             ),
//                           ),
//                           title: Text(data.dateTime.toString()),
//                           subtitle: Text('Task:'),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
