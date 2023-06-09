import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/users_record.dart';

import 'package:kanofit/views/edit_goals.dart';
import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '/classes/utils.dart';
import 'package:kanofit/views/change_password.dart';
import 'package:kanofit/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<UsersRecord?>(
        stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')).asBroadcastStream(),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
            }

            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCircle(
                  color: MainTheme.of(context).primaryColor,
                  size: 50.0,
                ),
              ),
            );
          }
          final profilePageUsersRecord = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF1F4F8),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/bballHero@2x.png',
                      ).image,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: MainTheme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                  child: Container(
                                    width: 76.0,
                                    height: 76.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        profilePageUsersRecord.photoUrl,
                                        'https://images.unsplash.com/photo-1680393339458-d4c8d4e55249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  profilePageUsersRecord.displayName,
                                  'Užívateľ',
                                ),
                                style: MainTheme.of(context).title1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: MainTheme.of(context).white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                profilePageUsersRecord.email!,
                                style: MainTheme.of(context).bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFFEE8B60),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditGoalsPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: MainTheme.of(context).grayLines,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Moje ciele',
                                        style: MainTheme.of(context).bodyText1.override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                        child: Icon(
                                          Icons.sports_score_sharp,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 24.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF95A1AC),
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: MainTheme.of(context).grayLines,
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Upraviť profil',
                                        style: MainTheme.of(context).bodyText1.override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF95A1AC),
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePasswordWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: MainTheme.of(context).grayLines,
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Resetovať heslo',
                                        style: MainTheme.of(context).bodyText1.override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF95A1AC),
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
