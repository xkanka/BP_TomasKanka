import 'package:kanofit/controllers/create_account_controller.dart';
import 'package:kanofit/views/first_login_info.dart';

import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '/classes/utils.dart';
import '../components/util_widgets.dart';
import 'package:kanofit/views/login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  CreateAccountController _controller = CreateAccountController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller.emailAddressController ??= TextEditingController();
    _controller.passwordController ??= TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF262D34),
      body: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        decoration: BoxDecoration(
          color: Color(0xFF262D34),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/login_BG.png',
            ).image,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 70.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: MainTheme.of(context).white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  'Vytvorenie účtu',
                                  style: MainTheme.of(context).title1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _controller.emailAddressController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: MainTheme.of(context).bodyText1.override(
                                          fontFamily: 'Overpass',
                                          color: Color(0xFF95A1AC),
                                        ),
                                    hintText: 'Sem vložte svoj email...',
                                    hintStyle: MainTheme.of(context).bodyText1.override(
                                          fontFamily: 'Overpass',
                                          color: Color(0xFF95A1AC),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: MainTheme.of(context).white,
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
                                  ),
                                  style: MainTheme.of(context).bodyText1.override(
                                        fontFamily: 'Overpass',
                                        color: Color(0xFF2B343A),
                                      ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Text is empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _controller.passwordController,
                                  obscureText: !_controller.passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Heslo',
                                    labelStyle: MainTheme.of(context).bodyText1.override(
                                          fontFamily: 'Overpass',
                                          color: Color(0xFF95A1AC),
                                        ),
                                    hintText: 'Sem vložte heslo...',
                                    hintStyle: MainTheme.of(context).bodyText1.override(
                                          fontFamily: 'Overpass',
                                          color: Color(0xFF95A1AC),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: MainTheme.of(context).white,
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => _controller.passwordVisibility = !_controller.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _controller.passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                        color: Color(0xFF95A1AC),
                                        size: 22.0,
                                      ),
                                    ),
                                  ),
                                  style: MainTheme.of(context).bodyText1.override(
                                        fontFamily: 'Overpass',
                                        color: Color(0xFF2B343A),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButtonWidget(
                                onPressed: () async {
                                  final user = await createAccountWithEmail(
                                    context,
                                    _controller.emailAddressController.text,
                                    _controller.passwordController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FirstLoginInfo(),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Vytvoriť účet',
                                options: CustomButtonOptions(
                                  width: 170.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: MainTheme.of(context).primaryColor,
                                  textStyle: MainTheme.of(context).subtitle2.override(
                                        fontFamily: 'Overpass',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
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
                        Divider(
                          height: 2.0,
                          thickness: 2.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Color(0xFFDBE2E7),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                          child: CustomButtonWidget(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 250),
                                  reverseDuration: Duration(milliseconds: 250),
                                  child: LoginWidget(),
                                ),
                              );
                            },
                            text: 'Prihlásiť sa',
                            options: CustomButtonOptions(
                              width: 170.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: MainTheme.of(context).white,
                              textStyle: MainTheme.of(context).subtitle2.override(
                                    fontFamily: 'Overpass',
                                    color: MainTheme.of(context).primaryColor,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
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
      ),
    );
  }
}
