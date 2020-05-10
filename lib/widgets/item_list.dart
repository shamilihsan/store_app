import 'package:store_app/providers/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/widgets/item_list_tile.dart';

class ItemList extends StatelessWidget {
  final String selectedCategory;

  ItemList(this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    List<Item> filteredItemList = [];
    final items = Provider.of<List<Item>>(context);

    if (selectedCategory == 'All') {
      filteredItemList = items;
    }

    if (items != null) {
      if (filteredItemList.length == 0) {
        return Text('No results');
      } else {
        return ListView.builder(
          // Set individual providers for each item which can then accessed in the child widget being built on it (i.e. ItemListTile)
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            // Value should be used in grids or lists because of the widget being destroyed and reference being empty issue
            // Value is replace by the default builder arg that needs to be passed if ChangeNotifierProvider(builder => ) is used
            value: filteredItemList[index],
            child: ItemListTile(),
          ),
          itemCount: items.length,
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
