import 'package:flutter/material.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:provider/provider.dart';

class ModelsTable extends StatelessWidget {
  const ModelsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getModels(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return _TableWidget(
          models: snapshot.data,
        );
      },
    );
  }
}

class _TableWidget extends StatefulWidget {
  const _TableWidget({
    super.key,
    required this.models,
  });

  final List<Model>? models;
  @override
  State<_TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<_TableWidget> {
  int selectedIndex = -1;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      onSelectAll: (val) {
        setState(() {
          selectedIndex = -1;
        });
      },
      columns: const [
        DataColumn(label: Text('Language')),
        DataColumn(label: Text('Translation')),
      ],
      rows: widget.models!
          .map((e) => DataRow(cells: [
                DataCell(Text(e.name ?? "")),
                const DataCell(
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'paine'),
                  ),
                ),
              ]))
          .toList(),
    );
  }
}


// [
//         DataRow(
//             selected: 0 == selectedIndex,
//             onSelectChanged: (val) {
//               setState(() {
//                 selectedIndex = 0;
//               });
//             },
//             cells: [
//               DataCell(
//                 Text(
//                   "RO",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     color = Colors.lightBlueAccent;
//                   });
//                 },
//               ),
//               DataCell(
//                 TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none, hintText: 'paine'),
//                 ),
//               ),
//             ]),
//         DataRow(
//             selected: 1 == selectedIndex,
//             onSelectChanged: (val) {
//               setState(() {
//                 selectedIndex = 1;
//               });
//             },
//             cells: [
//               DataCell(
//                   Text(
//                     "EN",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ), onTap: () {
//                 print('EN is clicked');
//               }),
//               DataCell(
//                 TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none, hintText: 'bread'),
//                 ),
//               ),
//             ]),
//         DataRow(
//             selected: 2 == selectedIndex,
//             onSelectChanged: (val) {
//               setState(() {
//                 selectedIndex = 2;
//               });

//               print(selectedIndex);
//             },
//             cells: [
//               DataCell(
//                   Text(
//                     "FR",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ), onTap: () {
//                 print('FR is clicked');
//               }),
//               DataCell(
//                 TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none, hintText: 'pain'),
//                 ),
//               ),
//             ]),
//       ],