// import 'package:flutter/material.dart';
// import 'package:gasworks/views/addrooms/addrooms_view_model.dart';
// import 'package:stacked/stacked.dart';

// class RoomListWidget extends StatelessWidget {
//   const RoomListWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return ViewModelBuilder<AddRoomsViewModel>.reactive(
//       builder: (context, model, child) {
//         return Container(
//           height: 50,width: width*0.95,
//           margin: EdgeInsets.all(2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 height: height * 0.05,
//                 width: width * 0.3,
//                 child: Text("Room Name"),
//               ),
//               VerticalDivider(),
//               Container(
//                 height: height * 0.05,
//                 width: width * 0.3,
//                 child: Text("Square Metres"),
//               ),
//               VerticalDivider(),
//               Container(
//                 height: height * 0.05,
//                 width: width * 0.2,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       model.removeRoom();
//                     },
//                     child: Text('Delete')),
//               ),
//             ],
//           ),
//         );
//       },
//       viewModelBuilder: () => AddRoomsViewModel(),
//     );
//   }
// }
