import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String heroTag;
  final String itemName;
  final int itemPrice;
  final String imageUrl;

  ItemDetailsScreen(
      {this.heroTag, this.itemName, this.itemPrice, this.imageUrl});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var selectedCard = 'WEIGHT';
  var numberOfItems = 1;
  var total = 0;

  _selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  _increaseQuantity() {
    setState(() {
      numberOfItems++;
      _updateTotal();
    });
  }

  _decreaseQuantity() {
    setState(() {
      numberOfItems--;
      _updateTotal();
    });
  }

  _updateTotal() {
    total = widget.itemPrice * numberOfItems;
  }

  @override
  void initState() {
    setState(() {
      _updateTotal();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(fontSize: 18.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
              top: 30.0,
              left: (MediaQuery.of(context).size.width / 2) - 100.0,
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover),
                    ),
                    height: 200.0,
                    width: 200.0),
              ),
            ),
            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.itemName,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.itemPrice.toString(),
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey)),
                        Container(height: 25.0, color: Colors.grey, width: 1.0),
                        Container(
                          width: 125.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              color: Color(0xFF7A9BEE)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () => _decreaseQuantity(),
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Color(0xFF7A9BEE)),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Text(numberOfItems.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0)),
                              InkWell(
                                onTap: () => _increaseQuantity(),
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Colors.white),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF7A9BEE),
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard('WEIGHT', '300', 'G'),
                            SizedBox(width: 10.0),
                            _buildInfoCard('CALORIES', '267', 'CAL'),
                            SizedBox(width: 10.0),
                            _buildInfoCard('VITAMINS', 'A, B6', 'VIT'),
                            SizedBox(width: 10.0),
                            _buildInfoCard('AVAIL', 'NO', 'AV')
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            color: Colors.black),
                        height: 50.0,
                        child: Center(
                          child: Text('Rs. ${total.toString()}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    )
                  ],
                ))
          ])
        ]));
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
      onTap: () {
        _selectCard(cardTitle);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
              color: cardTitle == selectedCard
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 0.75),
        ),
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0),
              child: Text(cardTitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: cardTitle == selectedCard
                        ? Colors.white
                        : Colors.grey.withOpacity(0.7),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text(unit,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.black,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
