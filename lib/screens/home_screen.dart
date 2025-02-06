import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/motel_provider.dart';
import 'motel_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motelAsync = ref.watch(motelProvider);

    return Scaffold(
      body: motelAsync.when(
        data: (motel) {
          if (motel == null) {
            return const Center(child: Text('Nenhum dado encontrado'));
          }
          return MotelDetailsScreen(motel: motel);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erro: $error')),
      ),
    );
  }
} 