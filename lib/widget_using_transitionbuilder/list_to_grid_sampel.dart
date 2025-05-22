import 'package:flutter/material.dart';

class ToggleListGridDemo extends StatefulWidget {
  const ToggleListGridDemo({super.key});

  @override
  State<ToggleListGridDemo> createState() => _ToggleListGridDemoState();
}

class _ToggleListGridDemoState extends State<ToggleListGridDemo> {
  bool isGrid = false;

  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView ⇄ GridView'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), // dari bawah ke atas
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: isGrid
            ? GridView.builder(
                key: const ValueKey('grid'),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 5 / 2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(18)),
                      alignment: Alignment.center,
                      child: Text(items[index]),
                    ),
                  );
                },
              )
            : ListView.builder(
                key: const ValueKey('list'),
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.label),
                      title: Text(items[index]),
                      tileColor: index.isEven ? Colors.grey[200] : null,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
