import '../utils/app_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/loading_spinner.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  auth.User user;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
            bottom: 40.0,
            top: 30.0,
          ),
          color: Colors.teal[900].withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 5.0,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return AppLocalizations.of(context)
                            .translate("Invalid E-mail address");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal[300], width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'E-mail',
                      labelStyle:
                          Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.white,
                          ),
                      cursorColor: Colors.white,
                      key: ValueKey('Username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return AppLocalizations.of(context)
                              .translate("Enter more than 4 characters");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.tealAccent, width: 2.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        labelText:
                            AppLocalizations.of(context).translate("Username"),
                        labelStyle:
                            Theme.of(context).textTheme.bodyText1.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                        ),
                    cursorColor: Colors.white,
                    key: ValueKey('Password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return AppLocalizations.of(context).translate(
                            "The password needs to be at least 7 characters long");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.tealAccent, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText:
                          AppLocalizations.of(context).translate("Password"),
                      labelStyle:
                          Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  if (widget.isLoading) LoadingSpinner(Colors.white),
                  if (!widget.isLoading)
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      color: Colors.white,
                      child: Text(
                        _isLogin
                            ? AppLocalizations.of(context).translate("Login")
                            : AppLocalizations.of(context).translate("Sign in"),
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? AppLocalizations.of(context)
                                .translate("Create a new account")
                            : AppLocalizations.of(context)
                                .translate("I already have an account"),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  SizedBox(
                    height: 4.0,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/tudo_seu_avatar_logo.jpg'),
                    radius: 20.0,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
