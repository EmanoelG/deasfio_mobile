import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/datasources/item_local_data_source.dart';
import '../../../data/domain/usecases/delete_item.dart';
import '../../../data/domain/usecases/get_items.dart';
import '../../../data/repositories/item_repository_impl.dart';
import '../../models/item_model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GetItems _getItems =
      GetItems(ItemRepositoryImpl(ItemLocalDataSource()));
  final DeleteItem _deleteItem =
      DeleteItem(ItemRepositoryImpl(ItemLocalDataSource()));
  List<ItemModel> _items = [];
  List<ItemModel> _filteredItems = [];
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _getItems.call();
    setState(() {
      _items = items;
      _filteredItems = _items;
    });
  }

  Future<void> _deleteItemById(String id) async {
    await _deleteItem.call(id);
    _loadItems(); // Recarrega os itens após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text('Sub: ${item.publisher}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteItemById(item.recipeId);
              },
            ),
            // onTap: () => {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ItemFormPage(
            //         item: item,
            //         onItemAdded: _loadItems,
            //       ),
            //     ),
            //   ),
            // },
          );
        },
      ),
    );
  }
}
