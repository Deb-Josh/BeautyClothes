import 'package:beauty_clothes/presentation/providers/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('urlFilterProvider default = Tout', () {
    final container = ProviderContainer();
    expect(container.read(urlFilterProvider), 'Tout');
  });
}