import 'package:beauty_clothes/presentation/providers/sort_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('sort set change la valeur', () {
    final container = ProviderContainer();
    container.read(urlSortProvider.notifier).set('Z->A');
    expect(container.read(urlSortProvider), 'Z->A');
  });
}