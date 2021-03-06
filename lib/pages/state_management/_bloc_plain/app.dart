import 'package:flutter/material.dart';
import 'package:hello/pages/state_management/item.dart';

import '_bloc.dart';
import '_provider.dart';

class App extends StatelessWidget {
  final ItemsBloc itemsBloc = ItemsBloc();

  @override
  Widget build(BuildContext context) {
    return ItemsBlocProvider(
      bloc: itemsBloc,
      child: MaterialApp(
        title: 'BLoC Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Page(title: 'BLoC Sample'),
      ),
    );
  }
}

class Page extends StatelessWidget {
  Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListViewWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemsBloc.addItem(Item(title: DateTime.now().toString()));
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsBlocProvider.of(context);

    return StreamBuilder<List<Item>>(
      stream: itemsBloc.items,
      builder: (context, snapshot) {
        final items = snapshot.data;

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          itemCount: items is List<Item> ? items.length : 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].title),
            );
          },
        );
      },
    );
  }
}
