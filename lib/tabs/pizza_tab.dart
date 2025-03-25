import 'package:donutapp/utils/pizza_tile.dart';
import 'package:flutter/material.dart';

class PizzaTab extends StatelessWidget {
  final List pizzasOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["Mushroom", 69.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Peperoni", 45.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Italian", 69.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Mexican", 59.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["3 meats", 79.0, Colors.brown, "lib/images/chocolate_donut.png"],
  ];

  final Function(double) addToCart;

  PizzaTab({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return PizzaTile(
          pizzaFlavor: pizzasOnSale[index][0],
          pizzaPrice: pizzasOnSale[index][1],
          pizzaColor: pizzasOnSale[index][2],
          imageName: pizzasOnSale[index][3],
          addToCart: addToCart,
        );
      },
      itemCount: pizzasOnSale.length,
    );
  }
}
