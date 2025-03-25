import 'package:flutter/material.dart';

class SmoothieTile extends StatelessWidget {
  final String smoothieFlavor;
  final double smoothiePrice;
  final dynamic smoothieColor;
  final String imageName;
  final Function(double) addToCart;

  //Valor fijo del border Radius 24
  final double borderRadius = 24.0;

  const SmoothieTile(
      {super.key,
      required this.smoothieFlavor,
      required this.smoothiePrice,
      this.smoothieColor, required this.addToCart,
      required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          decoration: BoxDecoration(
              color: smoothieColor[50],
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: smoothieColor[100],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child: Text(
                        smoothiePrice % 1 == 0
      ? '\$${smoothiePrice.toInt()}'
      : '\$${smoothiePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: smoothieColor[800]),
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
                   smoothieFlavor,
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
                       addToCart(smoothiePrice); 
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