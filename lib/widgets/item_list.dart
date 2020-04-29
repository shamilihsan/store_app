import 'package:store_app/providers/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/widgets/item_grid_tile.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);

    if (items != null) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          // Value should be used in grids or lists because of the widget being destroyed and reference being empty issue
          value: items[index],
          child: ItemGridTile(),
        ),
        itemCount: items.length,
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
