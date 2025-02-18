import 'package:flutter/material.dart';
import 'package:donutapp/utils/donut_tile.dart';


class BurguerTab extends StatelessWidget {
   final List donutsOnSale = [
    //burguer_tab.dart
    //[donutFlavor, donutPrice, donutColor, imageName]
    ["Ice Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "45", Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "36", Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "36", Colors.brown, "lib/images/chocolate_donut.png"],
    ["Choco", "36", Colors.brown, "lib/images/chocolate_donut.png"],
  ]; 
   BurguerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return BurguerTile(
          donutFlavor: donutsOnSale[index][0],
          donutPrice: donutsOnSale[index][1],
          donutColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
        );
      },
      itemCount: donutsOnSale.length,
    );;
  }
}