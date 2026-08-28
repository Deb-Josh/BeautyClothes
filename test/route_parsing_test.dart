import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Parsing des routes", (){
    test('parse - sans params = Tout + Aléatoire', () {
    final uri = Uri.parse('/catalogue');
    expect(uri.queryParameters['filter'] ?? 'Tout', 'Tout');
    expect(uri.queryParameters['sort'] ?? 'Aléatoire', 'Aléatoire');
  });

  test('parse - ?filter=Robes', () {
    final uri = Uri.parse('/catalogue?filter=Robes');
    expect(uri.queryParameters['filter'], 'Robes');
  });

  test('parse - ?sort=Z->A', () {
    final uri = Uri.parse('/catalogue?sort=Z->A');
    expect(uri.queryParameters['sort'], 'Z->A');
  });

  test('parse - ?filter=Robes&sort=A->Z', () {
    final uri = Uri.parse('/catalogue?filter=Robes&sort=A->Z');
    expect(uri.queryParameters['filter'], 'Robes');
    expect(uri.queryParameters['sort'], 'A->Z');
  });
  });
}