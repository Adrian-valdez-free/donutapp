import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final dynamic donutColor;
  final String imageName;
  //Valor fijo del border Radius 24
  final double borderRadius = 24.0;

  const DonutTile(
      {super.key,
      required this.donutFlavor,
      required this.donutPrice,
      this.donutColor,
      required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          decoration: BoxDecoration(
              color: donutColor[50],
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: donutColor[100],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child: Text(
                        '\$$donutPrice',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: donutColor[800]),
                      ))
                ],
              ),
              //IMAGEN DEL PRODUCTO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Image.asset(imageName),
                )

              //Tarea: Texto del sabor del producto

              //Tarea: Iconos de "Me encanta"
            ],
          )),
    );
  }
}
