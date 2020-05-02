import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List picked = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Stack(children: [
            Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
              ),
              Container(
                height: 250.0,
                width: double.infinity,
                color: Color(0xFFFDD148),
              ),
              Positioned(
                bottom: 450.0,
                right: 100.0,
                child: Container(
                  height: 400.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Color(0xFFFEE16D),
                  ),
                ),
              ),
              Positioned(
                bottom: 500.0,
                left: 150.0,
                child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.0),
                        color: Color(0xFFFEE16D).withOpacity(0.5))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {}),
              ),
              Positioned(
                  top: 75.0,
                  left: 15.0,
                  child: Text(
                    'Shopping Cart',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
              Positioned(
                top: 150.0,
                child: Column(
                  children: <Widget>[
                    itemCard('Finn Navian-Sofa', 'gray', '248',
                        'assets/images/breakfast.jpg', true, 0),
                    itemCard('Finn Navian-Sofa', 'gray', '248',
                        'assets/images/breakfast.jpg', true, 1),
                    itemCard('Finn Navian-Sofa', 'gray', '248',
                        'assets/images/breakfast.jpg', false, 2)
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 600.0, bottom: 15.0),
                  child: Container(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Total: 100'),
                          SizedBox(width: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {},
                              elevation: 0.5,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  'Pay Now',
                                ),
                              ),
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      )))
            ])
          ])
        ])
      ]),
    );
  }

  Widget itemCard(itemName, color, price, imgPath, available, i) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 3.0,
          child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 10.0),
            width: MediaQuery.of(context).size.width - 20.0,
            height: 150.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          color: available
                              ? Colors.grey.withOpacity(0.4)
                              : Colors.red.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12.5),
                        ),
                        child: Center(
                            child: available
                                ? Container(
                                    height: 12.0,
                                    width: 12.0,
                                    decoration: BoxDecoration(
                                        color: picked[i]
                                            ? Colors.yellow
                                            : Colors.grey.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  )
                                : Container()))
                  ],
                ),
                SizedBox(width: 10.0),
                Container(
                  height: 150.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgPath), fit: BoxFit.contain)),
                ),
                SizedBox(width: 4.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          itemName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 7.0),
                        available
                            ? picked[i]
                                ? Text(
                                    'x1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.grey),
                                  )
                                : Container()
                            : Container()
                      ],
                    ),
                    SizedBox(height: 7.0),
                    available
                        ? Text(
                            'Color: ' + color,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.grey),
                          )
                        : OutlineButton(
                            onPressed: () {},
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                                style: BorderStyle.solid),
                            child: Center(
                              child: Text('Find Similar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.red)),
                            ),
                          ),
                    SizedBox(height: 7.0),
                    available
                        ? Text(
                            '\$' + price,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFFFDD34A)),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
