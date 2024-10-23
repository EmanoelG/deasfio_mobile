import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/datasources/item_local_data_source.dart';
import '../../../../data/domain/usecases/get_items.dart';
import '../../../../data/repositories/item_repository_impl.dart';
import '../../../models/item_model.dart';
import '../controller/home_controller.dart';
import 'components/item_title.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final GetItems _getItems =
      GetItems(ItemRepositoryImpl(ItemLocalDataSource()));

  final searchController = TextEditingController();
  late Function(GlobalKey) runAddToCardAnimation;
  final GlobalKey<_HomeTabState> mainAppKey = GlobalKey<_HomeTabState>();
  List<ItemModel> _items = [];
  List<ItemModel> _filteredItems = [];
  final controllerGlob = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 20,
        centerTitle: true,
        actions: [
          _searchproduto(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Navega para a página de favoritos usando GetX
          Get.toNamed('/favorites');
        },
        child: Text('Favoritos'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        child: Column(
          children: [_griditens(context)],
        ),
      ),
    );
  }

  Future<void> _refreshProduct() async {
    final controller = Get.find<HomeController>();
    controller.getAllProducts(canLoading: true);
  }

  void _applyFilter(String filter) {
    setState(() {
      _filteredItems = _items
          .where((item) =>
              item.publisher.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  _griditens(context) {
    return GetBuilder<HomeController>(
      autoRemove: true,
      builder: (controllerItens) {
        return !controllerItens.isProductLoading
            ? Expanded(
                child: Visibility(
                  visible: (controllerItens.allProducts).isNotEmpty,
                  replacement:const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                       Icon(
                        Icons.search_off,
                        size: 40,
                        color: Colors.black12,
                      ),
                      Text(
                     'Não há items para apresentar',
                      ),
                    ],
                  ),
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: _refreshProduct,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.7,
                        maxCrossAxisExtent: 200,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: controllerItens.allProducts.length,
                      key: PageStorageKey('gridViewKey'),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ItemTitle(
                            item: controllerItens.allProducts[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                    children: List.generate(
                      10,
                      (index) => CustomShimmer(
                        height: double.infinity,
                        width: double.infinity,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  _searchproduto() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        String? filter = await showSearch(
          context: context,
          delegate: ItemSearchDelegate(
            '',
            _items,
          ),
        );
        if (filter != null) {
          _applyFilter(filter);
        }
      },
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  CustomShimmer({
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class ItemSearchDelegate extends SearchDelegate<String> {
  final List<ItemModel?> items;
  final String filterName;
  ItemSearchDelegate(this.filterName, this.items);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Constrói os resultados da pesquisa com base na consulta.
    return _buildItemList(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Constrói as sugestões com base na consulta atual.
    return _buildItemList(query);
  }

  Widget _buildItemList(String filter) {
    // Filtra os itens com base na consulta.
    final filteredItems = items
        .where((item) =>
            item!.publisher.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          title: Text(item!.publisher),
          onTap: () {
            query = item.publisher;
          },
        );
      },
    );
  }
}
