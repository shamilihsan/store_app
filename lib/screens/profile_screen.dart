import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/user.dart';
import 'package:store_app/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  Map<String, String> _profileData = {
    'email': '',
    'name': '',
    'address': '',
  };

  submitProfile() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final GlobalKey<FormState> _formKey = GlobalKey();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: mediaQuery.size.height * 1 / 4,
              padding: EdgeInsets.only(top: mediaQuery.padding.top),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: mediaQuery.size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              onPressed: () => Navigator.of(context).pop(),
                              // onPressed: () =>
                              //     _scaffoldKey.currentState.openDrawer(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Your',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Profile',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Render body
            Container(
              padding: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 3 / 4 - 50,
                child: Wrap(children: <Widget>[
                  FutureBuilder(
                    future:
                        Provider.of<Users>(context, listen: false).getUser(),
                    builder: (ctx, userSnapshot) {
                      //print('userSnapshot$userSnapshot');
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (userSnapshot.error != null) {
                        return Center(
                          child: Text(
                              'Something went wrong. Check your connection'),
                        );
                      }
                      return Consumer<Users>(
                        builder: (ctx, userData, child) {
                          print(userData.user);
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  initialValue: userData.user.email,
                                  decoration:
                                      InputDecoration(labelText: 'E-Mail'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty || !value.contains('@')) {
                                      return 'Invalid email!';
                                    }
                                  },
                                  onSaved: (value) {
                                    _profileData['email'] = value;
                                  },
                                ),
                                TextFormField(
                                  initialValue: userData.user.name,
                                  decoration:
                                      InputDecoration(labelText: 'Name'),
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Invalid name!';
                                    }
                                  },
                                  onSaved: (value) {},
                                ),
                                TextFormField(
                                  initialValue: userData.user.address,
                                  decoration: InputDecoration(
                                      labelText: 'Your Address'),
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  maxLines: 3,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter an address!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      elevation: 3.0,
                                      textColor: Colors.white,
                                      color: Theme.of(context).accentColor,
                                      onPressed: () {
                                        submitProfile();
                                      },
                                      child: Text(
                                        'Update Profile',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
