import 'package:flutter/material.dart';
import 'package:minatoko/widgets/left_drawer.dart';
import 'package:minatoko/widgets/itemhomepage.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<ItemHomePage> items = [
    ItemHomePage("All Products", Icons.store, Colors.blue),
    ItemHomePage("My Products", Icons.inventory_2_outlined, Colors.green),
    ItemHomePage("Create Products", Icons.add_circle_outline, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text(
          "Minatoko", 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold)),
        backgroundColor: Colors.yellow,

      ),
      drawer: LeftDrawer(),
      body : Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Welcome to Minatoko",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.count(
                    primary:true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,

                    children: items.map((ItemHomePage item){
                      return ItemCard(item);
                    }).toList(),
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}

