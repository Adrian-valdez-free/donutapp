import 'package:flutter/material.dart';

class PancakeTile extends StatelessWidget {
  final String pancakeFlavor;
  final double pancakePrice;
  final dynamic pancakeColor;
  final String imageName;
    final Function(double) addToCart;

  //Valor fijo del border Radius 24
  final double borderRadius = 24.0;

  const PancakeTile(
      {super.key,
      required this.pancakeFlavor,
      required this.pancakePrice,
      this.pancakeColor, required this.addToCart,
      required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          decoration: BoxDecoration(
              color: pancakeColor[50],
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: pancakeColor[100],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child: Text(
                        pancakePrice % 1 == 0
      ? '\$${pancakePrice.toInt()}'
      : '\$${pancakePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: pancakeColor[800]),
                      ))
                ],
              ),
              //IMAGEN DEL PRODUCTO
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                 // Alto de la imagen
                    child: Image.asset(imageName),
              ),

              //Tarea: Texto del sabor del producto
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text(
                   pancakeFlavor,
                   style: TextStyle(
                       fontSize: 28,
                       fontWeight: FontWeight.bold,
                       color: Colors.black),
                 ),
               ),
              //Tarea: Iconos de "Me encanta" Hacer otro commit luego de terminar esto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Icono presionado');
                      },
                      child: Icon(Icons.favorite, size: 30)
                      ),
                    GestureDetector(
                      onTap: () {
                       addToCart(pancakePrice); 
                      },
                      child: Text(
                        'ADD',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                            
                  ],
                ),
              )
            ],
          )),
    );
  }
}