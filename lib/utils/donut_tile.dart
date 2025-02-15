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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: SizedBox(
                    width: 500, // Ancho de la imagen
                    height: 250, // Alto de la imagen
                    child: Image.asset(imageName)),
              ),

              //Tarea: Texto del sabor del producto
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text(
                   donutFlavor,
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
                        print('Icono presionado');
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
