import 'package:flutter_test/flutter_test.dart';

String buildCatalogueUrl({String? filter, String? sort}) {
  final query = <String, String>{};
  if (filter != null && filter != 'Tout') query['filter'] = filter;
  if (sort != null && sort != 'Aléatoire') query['sort'] = sort;
  return Uri(path: '/catalogue', queryParameters: query.isEmpty ? null : query).toString();
}

void main(){
  group("Building des routes", (){
    test('build - sans filtre ni tri = /catalogue', () {
      expect(buildCatalogueUrl(), '/catalogue');
    });

    test('build - avec filtre seulement', () {
      expect(buildCatalogueUrl(filter: 'Robes'), '/catalogue?filter=Robes');
    });

    test('build - avec tri seulement', () {
      expect(buildCatalogueUrl(sort: 'A->Z'), contains('sort='));
    });

    test('build - filtre + tri combinés', () {
      final url = buildCatalogueUrl(filter: 'Robes', sort: 'A->Z');
      expect(url, contains('filter=Robes'));
      expect(url, contains('sort='));
    });
  });
}