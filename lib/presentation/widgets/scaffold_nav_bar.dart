import 'package:beauty_clothes/presentation/widgets/quantity_cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavBar extends StatefulWidget {
  const ScaffoldNavBar({super.key, required this.screen});

  final Widget screen;

  @override
  State<ScaffoldNavBar> createState() => _ScaffoldNavBarState();
}

class _ScaffoldNavBarState extends State<ScaffoldNavBar> {
  int _currentIndex(BuildContext context){
    final location = GoRouterState.of(context).uri.path;
    if(location.startsWith("/favoris")) return 1;
    if(location.startsWith("/panier")) return 2;
    if(location.startsWith("/profil")) return 3;
    return 0;
  }

  void _navigateToScreen(BuildContext context, int index){
    switch(index){
      case 0: context.go("/catalogue"); break;
      case 1: context.go("/favoris"); break;
      case 2: context.go("/panier"); break;
      case 3: context.go("/profil"); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.screen),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(100),
                blurRadius: 5,
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xFF0066B9),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              
              // sel
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              showUnselectedLabels: false,
              
              currentIndex: _currentIndex(context),
              onTap: (index) => _navigateToScreen(context, index),
            
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Catalogue"
                ),
            
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  activeIcon: Icon(Icons.favorite),
                  label: "Favoris"
                ),
            
                BottomNavigationBarItem(
                  icon: QuantityCart(
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                  activeIcon: QuantityCart(
                    icon: Icon(Icons.shopping_cart),
                  ),
                  label: "Panier"
                ),
            
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: "Profil"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}