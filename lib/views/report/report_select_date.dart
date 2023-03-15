import 'package:flutter/material.dart';
import 'package:mb_control/models/client_model.dart';
import 'package:mb_control/models/users.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/tools/color_hex.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportSelectDate extends StatelessWidget {
  const ReportSelectDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final FlightSearchHndl flightSearchHndl =
    //     Provider.of<FlightSearchHndl>(context);

    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
      title: "Seleccione el rango de fechas",
      showBackBtn: true,
      body: Column(
        children: [
          const _SelectLinkers(),
          SizedBox(
            height: size.height * 0.6,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  enableMultiView: true,
                  // selectionShape: DateRangePickerSelectionShape.rectangle,
                  navigationDirection:
                      DateRangePickerNavigationDirection.vertical,
                  viewSpacing: 10,
                  enablePastDates: true,
                  view: DateRangePickerView.month,
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                      blackoutDateTextStyle: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      specialDatesTextStyle: TextStyle(color: Colors.red),
                      weekendTextStyle: TextStyle(color: Colors.green)),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      specialDates: [
                        DateTime(2023, 02, 14),
                      ],
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          backgroundColor: HexColor('#F6F7F9'),
                          textStyle: const TextStyle(
                              fontSize: 14, color: Colors.black))),
                  todayHighlightColor: const Color(0xFF000B49),
                  selectionColor: const Color(0xFF000B49),
                  onSelectionChanged: (args) {
                    if (args.value is PickerDateRange) {
                      userHndl.startDateTime = args.value.startDate;
                      userHndl.endDateTime = args.value.endDate;
                    }
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/operations'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36)),
              minimumSize: const Size(200, 50),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectLinkers extends StatelessWidget {
  const _SelectLinkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        userHndl.linkerEmail = snapshot.data?[0].email ?? "";
        return SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            value: snapshot.data![0].email,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            onChanged: (String? value) {
              userHndl.linkerEmail = value;
            },
            items: snapshot.data!.map<DropdownMenuItem<String>>((Users value) {
              return DropdownMenuItem<String>(
                value: value.email,
                child: Text(value.userName ?? ""),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


//  Center(
//                     child: 
//                   ),