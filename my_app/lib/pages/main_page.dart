import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/pages/item_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/home_page.dart';

class MainPage extends StatefulWidget {
  final String email;
  const MainPage({super.key, required this.email});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [HomePage(email: widget.email), 
            ItemPage(email:widget.email)];
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.email}"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "theme") {
                setState(() {
                  MyApp.toggle(context);
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "theme", child: Text("Change Theme")),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                "Hello ${widget.email} Welcome to EvereJ",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Image.asset("assets/images/logo_ej.png", height: 150),
            
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text("Items"),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),


            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),

              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: "Items",
          ),
        ],
      ),
    );
  }
}
