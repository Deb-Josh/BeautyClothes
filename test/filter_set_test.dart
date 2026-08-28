import 'package:beauty_clothes/presentation/providers/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('filter set change la valeur', () {
    final container = ProviderContainer();
    container.read(urlFilterProvider.notifier).set('Robes');
    expect(container.read(urlFilterProvider), 'Robes');
  });
}