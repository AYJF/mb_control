import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mb_control/route_model.dart';
import 'package:mb_control/views/client/clients_table.dart';
import 'package:mb_control/views/home/home.dart';
import 'package:mb_control/views/operation/operantion_table.dart';
import 'package:mb_control/views/promoters/promoters_table.dart';

final List<RouteModel> routes = [
  const RouteModel(leading: Icons.home, view: Home()),
  const RouteModel(
      leading: MaterialCommunityIcons.calculator, view: OperationTable()),
  const RouteModel(leading: Icons.star_border_rounded, view: PromoterTable()),
  const RouteModel(leading: Ionicons.heart_outline, view: ClientTable()),
  const RouteModel(leading: Icons.settings, view: Home()),
];
