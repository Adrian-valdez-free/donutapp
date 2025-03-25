import 'package:donutapp/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class DonutTab extends StatelessWidget {
  final List donutsOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["Ice Cream", 36.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", 45.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", 36.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", 36.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Choco", 36.0, Colors.brown, "lib/images/chocolate_donut.png"],
  ];

    final Function(double) addToCart;

  DonutTab({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutsOnSale[index][0],
          donutPrice: donutsOnSale[index][1],
          donutColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
          addToCart: addToCart,

        );
      },
      itemCount: donutsOnSale.length,
    );
  }
}
