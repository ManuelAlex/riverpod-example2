import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

testIt() {
  final int? int1 = null;
  final int? int2 = 1;
  final result = int1 + int2;
  print(result);
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increament() => state = state == null ? 1 : state + 1;
  int? get value => state;
}

final couterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'River pod example',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final counter = ref.watch(couterProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(couterProvider);
            final text = count == null ? 'press the Button' : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: ref.read(couterProvider.notifier).increament,
              child: const Text('Increment counter'))
        ],
      ),
    );
  }
}
