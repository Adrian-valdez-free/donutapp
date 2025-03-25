import 'package:donutapp/utils/burguer_tile.dart';
import 'package:flutter/material.dart';

class BurguerTab extends StatelessWidget {
  final List burguersOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["Mushroom", 36.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Bacon", 45.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Chesse Burguer", 40.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Mexican", 45.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Chicken", 31.0, Colors.brown, "lib/images/chocolate_donut.png"],
  ]; 
  final Function(double) addToCart;

  BurguerTab({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return BurguerTile(
          burguerFlavor: burguersOnSale[index][0],
          burguerPrice: burguersOnSale[index][1],
          burguerColor: burguersOnSale[index][2],
          imageName: burguersOnSale[index][3],
           addToCart: addToCart,
        );
      },
      itemCount: burguersOnSale.length,
    );
  }
}