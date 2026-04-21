import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String email; 
  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      "assets/images/WizzardTree.jpg",
      "assets/images/Portal.jpg",
      "assets/images/mushroom.jpg",
      "assets/images/Portal.jpg",
      "assets/images/RobotTree.jpg",
      "assets/images/SeeLand.jpg",
      "assets/images/Tree.jpg",
      "assets/images/sakura.jpg",
      "assets/images/builder.jpg",
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to EvereJ, $email",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          CarouselSlider(
            items: banners.map((url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
          ),

          const SizedBox(height: 25),
          const Text(
            "About EvereJ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text(
            "EvereJ is a centralized NFT marketplace from Jambi where users can discover, collect, and sell extraordinary digital assets secured by EverejBlockChain technology.",
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 25),
          const Text(
            "Platform Statistics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              InfoCard(title: "666K+", subtitle: "NFT Minted"),
              InfoCard(title: "666K+", subtitle: "Artists"),
              InfoCard(title: "1Million++", subtitle: "Transactions"),
            ],
          ),

          const SizedBox(height: 25),
          const Text(
            "Why Choose Us?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          const FeatureTile(icon: Icons.security, text: "Secure Blockchain Ownership"),
          const FeatureTile(icon: Icons.flash_on, text: "Fast Transactions"),
          const FeatureTile(icon: Icons.verified, text: "Verified by Otoritas Jasa Kebersihan"),

        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(subtitle),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text),
    );
  }
}
