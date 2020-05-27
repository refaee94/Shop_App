import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/Cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum options { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // Products productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Favorite'), value: options.favorite),
              PopupMenuItem(
                child: Text('All'),
                value: options.all,
              )
            ],
            onSelected: (options value) {
              setState(() {
                value == options.all
                    ? showFavoriteOnly = false
                    : showFavoriteOnly = true;
              });
            },
          ),
          Consumer<Cart>(
              child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CartScreen.routeName),
                icon: Icon(Icons.shopping_cart),
              ),
              builder: (_, value, ch) =>
                  Badge(child: ch, value: value.itemsCount.toString()))
        ],
      ),
      body: ProductsGrid(showFavoriteOnly),drawer: AppDrawer(),
    );
  }
}
