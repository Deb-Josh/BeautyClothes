import 'package:beauty_clothes/presentation/widgets/item_profil.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0x505486AF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                child: Image.asset("assets/images/cover.png", width: double.infinity, fit: BoxFit.cover)
              ),
            ),

            Positioned(
              bottom: -50,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/icons/dj.png", width: 100, fit: BoxFit.fitWidth),
                    ),
                  ),
                  Text(
                    "Deboua Joseph",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                  )
                ],
              ),
            ),

            // AppBar de l'ecran de profil
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0x90000000),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2,
                  children: [
                    Icon(Icons.person),
                    Text("Mon profil"),
                  ],
                ),
                centerTitle: true,
              ),
            )
          ],
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 60, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ItemProfil(
                    icon: Icons.edit,
                    label: "Editer le profile",
                  ),
                  ItemProfil(
                    icon: Icons.notifications,
                    label: "Notifications",
                  ),
                  ItemProfil(
                    icon: Icons.language,
                    label: "Langage",
                  ),
                  ItemProfil(
                    icon: Icons.security,
                    label: "Sécurité",
                  ),
                  ItemProfil(
                    icon: Icons.auto_mode,
                    label: "Thème",
                  ),
                  
                  // Bouton de deconnexion
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.red
                        ),
                        foregroundColor: Colors.red,
                      ),
                      child: Text("Se déconnecter"),
                    )
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}