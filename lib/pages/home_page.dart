import 'package:donutapp/pages/Login.dart';
import 'package:donutapp/pages/perfil.dart';
import 'package:donutapp/utils/my_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../tabs/burguer_tab.dart';
import '../tabs/donut_tab.dart';
import '../tabs/pancake_tab.dart';
import '../tabs/pizza_tab.dart';
import '../tabs/smoothie_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int totalItems = 0;
  double totalPrice = 0.0;

  List<Widget> myTabs = [

    
    //donut tab
    const MyTab(
      iconPath: 'lib/icons/donut.png',
      tabName: 'Donut',
    ),
    const MyTab(iconPath: 'lib/icons/burger.png', tabName: 'Burguer'),
    const MyTab(iconPath: 'lib/icons/smoothie.png', tabName: 'smoothie'),
    const MyTab(iconPath: 'lib/icons/pancakes.png', tabName: 'Pankes'),
    const MyTab(iconPath: 'lib/icons/pizza.png', tabName: 'Pizza'),
  ];
   void addToCart(double price) {
    setState(() {
      totalItems++;
      totalPrice += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.pinkAccent),
          child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
         onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
        ),
           ListTile(
        leading: Icon(Icons.logout),
        title: Text('Cerrar sesión'),
        onTap: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogIn()), // asegúrate de importar esta pantalla
          );
        },
      ),
      ],
    ),
  ),
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.menu, color: Colors.grey[800]),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: IconButton(onPressed: () { Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserPage()));}, icon: Icon(Icons.person)),
      )
    ],
  ),

        body: Column(
          children: [
            //text
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 32)),
                  Text(
                    "ATE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),
            //Tab bar
            TabBar(
              tabs: myTabs,
              labelColor: Colors.grey,
            ),

            Expanded(
                child: TabBarView(children: [
              DonutTab(addToCart: addToCart),
              BurguerTab(addToCart: addToCart),
              SmoothieTab(addToCart: addToCart),
              PancakeTab(addToCart: addToCart),
              PizzaTab(addToCart: addToCart),
            ])),

            //Carrito
  Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalItems Items |  \$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Delivery Charges Included',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: const Text(
                      'View Cart',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
