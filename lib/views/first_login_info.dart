import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/controllers/first_login_info_controller.dart';
import 'package:kanofit/main.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/components/date_picker.dart';
import 'package:kanofit/views/login.dart';

import '../components/profile_image.dart';
import '../components/text_field.dart';
import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '/classes/utils.dart';
import '../components/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FirstLoginInfo extends StatefulWidget {
  const FirstLoginInfo({Key? key}) : super(key: key);

  @override
  _FirstLoginInfoState createState() => _FirstLoginInfoState();
}

class _FirstLoginInfoState extends State<FirstLoginInfo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FirstLoginInfoController _controller = FirstLoginInfoController();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut();
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginWidget(),
          ),
          (r) => false,
        );
        return false;
      },
      child: AuthUserStreamWidget(
        builder: (context) => StreamBuilder<UsersRecord?>(
          stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')),
          builder: (context, snapshot) {
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Text(
                  'Moje ciele',
                  style: MainTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF14181B),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0.0,
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E7),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => ProfileImage(
                                imageUrl: valueOrDefault<String>(
                                  profilePageUsersRecord.photoUrl,
                                  'https://images.unsplash.com/photo-1680393339458-d4c8d4e55249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                          child: CustomTextField(
                            controller: _controller.textController,
                            labelText: 'Cieľová váha',
                            hintText: '',
                            keyboardType: TextInputType.number,
                            initialValue: profilePageUsersRecord.goalWeight?.toString() ?? _controller.goalWeight.toString(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                          child: CustomDatePicker(
                              labelText: 'Cieľový dátum',
                              initialDate: _controller.goalDate,
                              firstDate: DateTime.now().add(
                                Duration(days: 1),
                              ),
                              lastDate: DateTime.now().add(
                                Duration(days: 3650),
                              ),
                              onDateChanged: (date) => {
                                    setState(() {
                                      _controller.goalDate = date;
                                    })
                                  }),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                          child: CustomTextField(
                            controller: _controller.textControllerSecond,
                            labelText: 'Výška',
                            hintText: '',
                            keyboardType: TextInputType.number,
                            initialValue: profilePageUsersRecord.height?.toString() ?? _controller.height.toString(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                          child: CustomDatePicker(
                              labelText: 'Dátum narodenia',
                              initialDate: _controller.birthDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now().subtract(
                                Duration(days: 3650),
                              ),
                              onDateChanged: (date) => {
                                    setState(() {
                                      _controller.birthDate = date;
                                    })
                                  }),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButtonWidget(
                                onPressed: () async {
                                  await _controller.onSavePressed();
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBarPage(initialPage: 'silhouette'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Uložiť',
                                options: CustomButtonOptions(
                                  width: 110.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: Colors.white,
                                  textStyle: MainTheme.of(context).bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: MainTheme.of(context).primaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  elevation: 2.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
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
      ),
    );
  }
}
