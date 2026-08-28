import 'package:beauty_clothes/presentation/providers/sort_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('urlSortProvider default = Aléatoire', () {
    final container = ProviderContainer();
    expect(container.read(urlSortProvider), 'Aléatoire');
  });
}