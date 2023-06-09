import 'package:kanofit/controllers/register_page_controller.dart';
import 'package:kanofit/views/first_login_info.dart';

import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '../components/util_widgets.dart';
import 'package:flutter/material.dart';

class RegisterPageWidget extends StatefulWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  @override
  _RegisterPageWidgetState createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  late RegisterPageController _controller = RegisterPageController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller.inputNormalController ??= TextEditingController();
    _controller.passwordTextController ??= TextEditingController();
    _controller.confirmPasswordTextController ??= TextEditingController();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Register',
                    style: MainTheme.of(context).title1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 70.0, 0.0),
                      child: Text(
                        'Create an account below, by entering your information.',
                        style: MainTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                      child: TextFormField(
                        controller: _controller.inputNormalController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: MainTheme.of(context).bodyText1.override(
                                fontFamily: 'Overpass',
                                color: MainTheme.of(context).secondaryColor,
                              ),
                          hintText: 'Enter your email address...',
                          hintStyle: MainTheme.of(context).bodyText1.override(
                                fontFamily: 'Overpass',
                                color: MainTheme.of(context).secondaryColor,
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
                        ),
                        style: MainTheme.of(context).bodyText1.override(
                              fontFamily: 'Overpass',
                              color: MainTheme.of(context).primaryColor,
                            ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
                    child: TextFormField(
                        controller: _controller.passwordTextController,
                        obscureText: !_controller.passwordVisibility1,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: MainTheme.of(context).bodyText1.override(
                                fontFamily: 'Overpass',
                                color: MainTheme.of(context).secondaryColor,
                              ),
                          hintText: 'Enter Password',
                          hintStyle: MainTheme.of(context).bodyText1.override(
                                fontFamily: 'Overpass',
                                color: MainTheme.of(context).secondaryColor,
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
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => _controller.passwordVisibility1 = !_controller.passwordVisibility1,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              _controller.passwordVisibility1 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: MainTheme.of(context).secondaryColor,
                              size: 20.0,
                            ),
                          ),
                        ),
                        style: MainTheme.of(context).bodyText1.override(
                              fontFamily: 'Overpass',
                              color: Color(0xFF14181B),
                            )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                    child: TextFormField(
                      controller: _controller.confirmPasswordTextController,
                      obscureText: !_controller.passwordVisibility2,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: MainTheme.of(context).bodyText1.override(
                              fontFamily: 'Overpass',
                              color: MainTheme.of(context).secondaryColor,
                            ),
                        hintText: 'Enter Password',
                        hintStyle: MainTheme.of(context).bodyText1.override(
                              fontFamily: 'Overpass',
                              color: MainTheme.of(context).secondaryColor,
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
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => _controller.passwordVisibility2 = !_controller.passwordVisibility2,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            _controller.passwordVisibility2 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: MainTheme.of(context).secondaryColor,
                            size: 20.0,
                          ),
                        ),
                      ),
                      style: MainTheme.of(context).bodyText1.override(
                            fontFamily: 'Overpass',
                            color: MainTheme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWidget(
                    onPressed: () async {
                      if (_controller.passwordTextController?.text != _controller.confirmPasswordTextController?.text ||
                          _controller.passwordTextController?.text == null ||
                          _controller.confirmPasswordTextController?.text == null ||
                          _controller.passwordTextController?.text == '' ||
                          _controller.confirmPasswordTextController?.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Hesla sa nezhoduju!',
                            ),
                          ),
                        );
                        return;
                      }

                      final user = await createAccountWithEmail(
                        context,
                        _controller.inputNormalController!.text,
                        _controller.passwordTextController!.text,
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
                      width: 230.0,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: MainTheme.of(context).primaryColor,
                      textStyle: MainTheme.of(context).subtitle2.override(
                            fontFamily: 'Overpass',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
