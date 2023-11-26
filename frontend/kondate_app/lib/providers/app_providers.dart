// app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editModeProvider = StateProvider<bool>((ref) => false);
final currentPageIndexProvider = StateProvider<int>((ref) => 0);
final selectedIngredientsProvider = StateProvider<List<String>>((ref) => []);
