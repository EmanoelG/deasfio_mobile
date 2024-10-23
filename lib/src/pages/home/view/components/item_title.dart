import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/datasources/item_local_data_source.dart';
import '../../../../../data/domain/usecases/save_item.dart';
import '../../../../../data/repositories/item_repository_impl.dart';
import '../../../../models/item_model.dart';
import '../controller/view_controller.dart';

class ItemTitle extends StatefulWidget {
  final ItemModel item;
  const ItemTitle({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemTitle> createState() => _ItemTitleState();
}

class _ItemTitleState extends State<ItemTitle> {
  IconData titleIcon = Icons.add_shopping_cart_outlined;
  Timer? _timer;
  final SaveItem _saveItem =
      SaveItem(ItemRepositoryImpl(ItemLocalDataSource()));
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void switchIcon(ViewController controller, ItemModel item) async {
    if (_timer != null) {
      _timer!.cancel();
    }
    controller.addItem(item, context);
    controller.setIsAddToCart(values: true);
    _timer = Timer(
      const Duration(milliseconds: 1000),
      () {
        if (mounted) {
          controller.setIsAddToCart(values: false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemStack(context);
  }

  Stack itemStack(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Material(
            child: InkWell(
              onTap: () {
                //   Get.toNamed(RoutesName.productRoute, arguments: widget.item);
              },
              child: Ink(
                color: const Color.fromARGB(255, 255, 254, 254),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: theme.cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Image(
                            image: ResizeImage(
                              CachedNetworkImageProvider(
                                widget.item.imageUrl,
                                cacheKey:
                                    widget.item.recipeId + widget.item.imageUrl,
                              ),
                              width: constraints.maxWidth.toInt(),
                              height: (constraints.maxWidth * 1).toInt(),
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons
                                  .error); // Exibe um ícone de erro caso a imagem falhe
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.item.title,
                        maxLines: 1,
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        GetBuilder<ViewController>(
          init: ViewController(),
          global: false,
          builder: (controller) {
            return Positioned(
              top: 4,
              right: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      // cartController.addItemToCart(item: widget.item);
                      switchIcon(controller, widget.item);
                    },
                    child: Ink(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                      ),
                      child: Icon(
                        controller.isAddToCart.value
                            ? Icons.check
                            : Icons.favorite,
                        color: theme.cardColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
