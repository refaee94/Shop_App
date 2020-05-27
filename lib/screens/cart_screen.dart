import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/Cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as CI;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.itemsPrice}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.itemsPrice);
                        cart.clearCart();
                      },
                      child: Text('submit order',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          )))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => CI.CartItem(
              cart.items.values.toList()[index].id,
              cart.items.values.toList()[index].title,
              cart.items.values.toList()[index].price,
              cart.items.values.toList()[index].quantity,
              cart.items.keys.toList()[index],
            ),
            itemCount: cart.itemsCount,
          ))
        ],
      ),
    );
  }
}
