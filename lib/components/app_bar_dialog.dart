import 'package:flutter/material.dart';

import '../classes/main_theme.dart';

class AppBarDialog extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final List<Widget> actions;

  AppBarDialog({
    required this.scaffoldKey,
    required this.title,
    this.actions = const [],
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
          size: 24.0,
        ),
      ),
      title: Text(
        title,
        style: MainTheme.of(context).bodyText1.override(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF14181B),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
      ),
      actions: actions,
      centerTitle: true,
      elevation: 0.0,
    );
  }
}
