import 'package:donutapp/utils/pancake_tile.dart';
import 'package:flutter/material.dart';

class PancakeTab extends StatelessWidget {
  final List pancakesOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["Hotcakes", 45.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Hershey", 45.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Blueberry", 50.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Waffles", 40.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Cinnamon", 38.0, Colors.brown, "lib/images/chocolate_donut.png"],
  ];
  final Function(double) addToCart;

  PancakeTab({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return PancakeTile(
          pancakeFlavor: pancakesOnSale[index][0],
          pancakePrice: pancakesOnSale[index][1],
          pancakeColor: pancakesOnSale[index][2],
          imageName: pancakesOnSale[index][3],
          addToCart: addToCart,
        );
      },
      itemCount: pancakesOnSale.length,
    );
  }
}
