import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/widgets/drawer/bottom_user_info.dart';
import 'package:mb_control/widgets/drawer/custom_list_tile.dart';
import 'package:mb_control/widgets/drawer/header.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return SafeArea(
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            _isCollapsed = !_isCollapsed;
          });
        },
        onHorizontalDragStart: (details) {
          setState(() {
            _isCollapsed = !_isCollapsed;
          });
        },
        // onHorizontalDragEnd: (details) {
        //   setState(() {
        //     _isCollapsed = !_isCollapsed;
        //   });
        // },
        // onHorizontalDragUpdate: (details) {
        //   setState(() {
        //     _isCollapsed = !_isCollapsed;
        //   });
        // },
        onTap: () {
          setState(() {
            _isCollapsed = !_isCollapsed;
          });
        },
        child: AnimatedContainer(
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 500),
          width: _isCollapsed ? 300 : 70,
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Color(0xFF000B49),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomDrawerHeader(isColapsed: _isCollapsed),
                const Divider(
                  color: Colors.grey,
                ),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.home_outlined,
                    title: 'Home',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/home')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.bar_chart_sharp,
                    title: 'Usuarios',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/users')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.build,
                    title: 'Empresas',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/companies')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.verified_user_sharp,
                    title: 'Clientes',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/clients')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.money,
                    title: 'Operaciones',
                    infoCount: 0,
                    onTap: () {
                      userHndl.clearOperations();
                      Navigator.of(context).pushNamed('/operations');
                    }),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.manage_accounts,
                    title: 'Promotores',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/promoters')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.document_scanner,
                    title: 'Facturas',
                    infoCount: 0,
                    onTap: () => Navigator.of(context).pushNamed('/invoices')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.calculate,
                    title: 'Proveedores In',
                    infoCount: 0,
                    onTap: () =>
                        Navigator.of(context).pushNamed('/proveedores-in')),
                CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.deselect,
                    title: 'Proveedores Out',
                    infoCount: 0,
                    onTap: () =>
                        Navigator.of(context).pushNamed('/proveedores-out')),

                const Divider(color: Colors.grey),
                const Spacer(),
                // CustomListTile(
                //   isCollapsed: _isCollapsed,
                //   icon: Icons.notifications,
                //   title: 'Notifications',
                //   infoCount: 2,
                // ),
                CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.settings,
                  title: 'Editar usuario',
                  infoCount: 0,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                BottomUserInfo(isCollapsed: _isCollapsed),
                Align(
                  alignment: _isCollapsed
                      ? Alignment.bottomRight
                      : Alignment.bottomCenter,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _isCollapsed
                          ? Icons.arrow_back_ios
                          : Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
