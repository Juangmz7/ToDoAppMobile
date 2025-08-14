import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/providers/login_auth_provider.dart';
import 'package:todo_app/config/config.dart';


class SideMenu extends ConsumerStatefulWidget {
  
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey
  });

  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  
  @override
  Widget build(BuildContext context) {

    final backgroundColor = AppTheme.taskBoxColor;
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return NavigationDrawer(
      backgroundColor: backgroundColor,
      indicatorColor: backgroundColor,  // Same colour to avoid the apareance of a previous selection
      onDestinationSelected: 
        (_) => widget.scaffoldKey.currentState?.closeDrawer(),
      //* Lista de funciones del SideMenu
      children: [
          Padding(
            padding: EdgeInsets.fromLTRB(60, 40, 20, 15),
            child: Text(
              'Menu',
              style: textStyle.titleMedium
            )
          ),

          const Divider(
            color: Colors.white,
            thickness: 1,
            height: 1,
            indent: 15,
            endIndent: 15,
          ),

          SizedBox(height: size.width * 0.1),

          TextButton.icon(
            onPressed: () {},
            label: Text('Cuenta', style: textStyle.titleMedium),
            icon: Icon(
              Icons.person,
              size: size.width * 0.07
            ),
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft, // alineación a la izquierda
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),

          SizedBox(height: size.width * 0.025),

          TextButton.icon(
            onPressed: () async {
              await ref.read(loginAuthProvider.notifier).logout();
            },
            label: Text('Cerrar sesión', style: textStyle.titleMedium),
            icon: Icon(
              Icons.logout_outlined,
              size: size.width * 0.07,
            ),
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft, // alineación a la izquierda
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          )

          
          

      ],
    );
  }
}