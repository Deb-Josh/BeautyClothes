import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Logique des routes", (){
    test('logic - Tout ne doit pas apparaitre dans URL', () {
      final query = <String, String>{};
      final filter = 'Tout';
      if (filter != 'Tout') query['filter'] = filter;
      expect(query.containsKey('filter'), false);
    });

    test('logic - Aléatoire ne doit pas apparaitre dans URL', () {
      final query = <String, String>{};
      final sort = 'Aléatoire';
      if (sort != 'Aléatoire') query['sort'] = sort;
      expect(query.containsKey('sort'), false);
    });

    test('logic - une URL vide redirige bien vers valeurs par défaut', () {
      const defaultFilter = 'Tout';
      const defaultSort = 'Aléatoire';
      final uri = Uri.parse('/catalogue');
      final filter = uri.queryParameters['filter'] ?? defaultFilter;
      final sort = uri.queryParameters['sort'] ?? defaultSort;
      expect(filter, defaultFilter);
      expect(sort, defaultSort);
    });
  });
}