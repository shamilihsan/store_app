import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/auth.dart';
import 'package:string_validator/string_validator.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(33, 150, 243, 1).withOpacity(0.7),
                  Color.fromRGBO(23, 118, 194, 1).withOpacity(1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: deviceSize.width * 0.75,
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Image.asset('assets/images/logo.png', width: 220),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'contactNumber': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Oops.......'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  Future<String> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'],
            _authData['password'],
            _authData['name'],
            _authData['contactNumber']);
      }
    } catch (error) {
      print(error.code);
      var errorMessage;

      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          errorMessage = 'Seems like you entered a wrong password!';
          break;

        case 'ERROR_TOO_MANY_REQUESTS':
          errorMessage = 'Way too many failed login attempts. Try again later!';
          break;

        case 'ERROR_USER_NOT_FOUND':
          errorMessage = 'There is no account with this email!';
          break;

        case 'ERROR_EMAIL_ALREADY_IN_USE':
          errorMessage =
              'The email address is already in use by another account';
          break;

        default:
          {
            errorMessage =
                'Oops. Something\'s wrong. Check your internet connection or try again later!';
          }
      }
      _showErrorDialog(errorMessage, context);

      setState(() {
        _isLoading = false;
        _formKey.currentState.reset();
        _passwordController.clear();
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _formKey.currentState.reset();
        _passwordController.clear();
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _formKey.currentState.reset();
        _passwordController.clear();
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Name'),
                    textCapitalization: TextCapitalization.words,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value.isEmpty) {
                              return 'Enter your name!';
                            } else if (!isAlpha(value)) {
                              return 'Invalid Name';
                            }
                          }
                        : null,
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    keyboardType: TextInputType.number,
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    textCapitalization: TextCapitalization.words,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value.isEmpty) {
                              return 'Enter a phone number!';
                            } else if (!RegExp('^(?:[+0]9)?[0-9]{10}')
                                .hasMatch(value)) {
                              return 'Enter valid phone number';
                            }
                          }
                        : null,
                    onSaved: (value) {
                      _authData['contactNumber'] = value;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: () => _submit(context),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
