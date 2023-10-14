import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ItemListScreen(),
  ));
}

class ListItem {
  final String title;
  final String subtitle;

  ListItem({required this.title, required this.subtitle});
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final List<ListItem> items = <ListItem>[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment10'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].subtitle),
            onLongPress: () {
              _showOptionsDialog(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _showEditItemDialog(index);
                Navigator.of(context).pop();
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _addItem();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditItemDialog(int index) {
    titleController.text = items[index].title;
    subtitleController.text = items[index].subtitle;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text('Edit Item'),
            ),
            ListTile(
              title: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
            ListTile(
              title: TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
            ),
            ListTile(
              title: TextButton(
                onPressed: () {
                  _editItem(index);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addItem() {
    setState(() {
      items.add(ListItem(
        title: titleController.text,
        subtitle: subtitleController.text,
      ));
      titleController.clear();
      subtitleController.clear();
    });
  }

  void _editItem(int index) {
    setState(() {
      items[index] = ListItem(
        title: titleController.text,
        subtitle: subtitleController.text,
      );
      titleController.clear();
      subtitleController.clear();
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
