import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/user.dart';

class OrderDialog extends StatefulWidget {
  @override
  _OrderDialogState createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  static final GlobalKey<FormState> _formKey = GlobalKey();
  var address = '';
  var _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return _isUpdating
        ? Center(
            child: CircularProgressIndicator(),
          )
        : AlertDialog(
            title: Text('Enter your address'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Your Address'),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter an address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                ],
              ),
            ),
            elevation: 10,
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    // Invalid!
                    return null;
                  }
                  setState(() {
                    _isUpdating = true;
                    _formKey.currentState.save();
                    Provider.of<Users>(context, listen: false)
                        .updateAddress(address)
                        .then((_) {
                      _isUpdating = false;
                      Navigator.of(context).pop();
                    });
                  });
                },
                child: Text('Update'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          );
  }
}
