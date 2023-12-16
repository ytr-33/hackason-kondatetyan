import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/providers/is_loading_provider.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(isLoadingNotifierProvider);

    return isLoading
        ? Container(
          color: Colors.grey.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        )
        : Container();
  }
}