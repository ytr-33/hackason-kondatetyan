import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';

class Test extends ConsumerWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.read(ingredientNotifierProvider.notifier);
    return Text('data');
  }
}
