import 'package:flutter/material.dart';
import 'package:my_app/models/produk_nft.dart';
import 'package:my_app/pages/detail_page.dart';

class ItemPage extends StatelessWidget {
  final String email;
  const ItemPage({super.key, required this.email});

  List<Product> products() {
    return [
      Product(
        id: 1,
        name: "Mushroom",
        image: "assets/images/mushroom.jpg",
        price: 2.4,
        description: "Unique Mushroom",
      ),
      Product(
        id: 2,
        name: "Sakura",
        image: "assets/images/sakura.jpg",
        price: 1.2,
        description: "Limited Sakura NFT",
      ),
      Product(
        id: 3,
        name: "Tree",
        image: "assets/images/Tree.jpg",
        price: 3.8,
        description: "Epic galaxy Tree NFT",
      ),
      Product(
        id: 4,
        name: "Wizard Tree",
        image: "assets/images/WizzardTree.jpg",
        price: 3.8,
        description: "Epic galaxy Wizard Tree NFT",
      ),
      Product(
        id: 5,
        name: "See Land",
        image: "assets/images/SeeLand.jpg",
        price: 3.8,
        description: "Seeland NFT",
      ),
      Product(
        id: 6,
        name: "Portal",
        image: "assets/images/Portal.jpg",
        price: 3.8,
        description: "Portal NFT",
      ),
      Product(
        id: 7,
        name: "Builders",
        image: "assets/images/builder.jpg",
        price: 3.8,
        description: "Jakarta Building NFT",
      ),
      Product(
        id: 8,
        name: "Robot Tree",
        image: "assets/images/RobotTree.jpg",
        price: 3.8,
        description: "Robott Tree NFT",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final allitems = products();

    return ListView.builder(
      itemCount: allitems.length,
      itemBuilder: (context, index) {
        final product = allitems[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(product.image, width: 60, fit: BoxFit.cover),

            title: Text(product.name),
            subtitle: Text("${product.price} ETH"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(product: product, email: email,)),
              );
            },
          ),
        );
      },
    );
  }
}
