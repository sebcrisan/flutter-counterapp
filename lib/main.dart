import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider scope
void main() {
  runApp(const ProviderScope(
      child: MyApp(),
  ));
}

// state notifier, counter class
class Counter extends StateNotifier<int>{
  Counter(): super(0);
  void incrementCounter(){
    state++;
  }
  int get value => state;
}

// state notifier provider
final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter(),);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super (key:key );
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(counterProvider.notifier).incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
