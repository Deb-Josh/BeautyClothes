import 'package:beauty_clothes/presentation/screens/cart_list_screen.dart';
import 'package:beauty_clothes/presentation/screens/catalogue_screen.dart';
import 'package:beauty_clothes/presentation/screens/details_screen.dart';
import 'package:beauty_clothes/presentation/screens/favorite_screen.dart';
import 'package:beauty_clothes/presentation/screens/profile_screen.dart';
import 'package:beauty_clothes/presentation/widgets/scaffold_nav_bar.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/catalogue",
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldNavBar(screen: child),

      routes: [
        GoRoute(
          path: "/catalogue",
          builder: (context, state){
            String valueFilter = state.uri.queryParameters["filter"] ?? "Tout";
            String valueSort = state.uri.queryParameters["sort"] ?? "Aléatoire";
            return CatalogueScreen(filter: valueFilter, sort: valueSort);
          },
        ),

        GoRoute(
          path: "/favoris",
          builder: (context, state) => const FavoriteScreen(),
        ),

        GoRoute(
          path: "/panier",
          builder: (context, state) => const CartListScreen(),
        ),

        GoRoute(
          path: "/profil",
          builder: (context, state) => const ProfileScreen(),
        ),
      ]
    ),

    GoRoute(
      path: "/details/:id",
      builder: (context, state){
        final int? id = int.tryParse(state.pathParameters["id"]!);
        if(id != null) return DetailsScreen(id: id);
        return const CatalogueScreen();
      },
    ),
  ],
);