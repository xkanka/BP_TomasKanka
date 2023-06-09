import 'package:flutter/material.dart';

import '../auth/auth_util.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  ProfileImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFFDBE2E7),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
        child: AuthUserStreamWidget(
          builder: (context) => Container(
            width: 90.0,
            height: 90.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
