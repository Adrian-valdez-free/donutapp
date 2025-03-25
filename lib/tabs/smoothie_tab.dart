import 'package:donutapp/utils/smoothie_tile.dart';
import 'package:flutter/material.dart';

class SmoothieTab extends StatelessWidget {
  final List smoothiessOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["MILK", 26.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Fruits taste", 50.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Yogurt Griego", 45.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Chia", 20.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Generic water", 10.0, Colors.brown, "lib/images/chocolate_donut.png"],
  ];

      final Function(double) addToCart;

   SmoothieTab({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return SmoothieTile(
          smoothieFlavor: smoothiessOnSale[index][0],
          smoothiePrice: smoothiessOnSale[index][1],
          smoothieColor: smoothiessOnSale[index][2],
          imageName: smoothiessOnSale[index][3],
          addToCart: addToCart,

        );
      },
      itemCount: smoothiessOnSale.length,
    );
  }
}