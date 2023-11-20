import 'package:rpapp/data.dart';
import 'package:rpapp/data_provider.dart';
import 'package:rpapp/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('R E C O R D A T O R I O S !!!!!!'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.dataList.length,
                  itemBuilder: (context, index) {
                    final Data data = dataProvider.dataList[index];
                    return Item(
                      data: data,
                      onEditPressed: () => _editContact(data, context, dataProvider),
                      onDeletePressed: () => dataProvider.delete(data.id!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addContact(context, dataProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addContact(BuildContext context, DataProvider dataProvider) {
    showDialog(
        context: context,
        builder: (context) {
          String title = "";
          String descrip = "";
          return AlertDialog(
            title: const Text('Nuevo Recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(labelText: "T I T U L O"),
                ),
                TextField(
                  onChanged: (value) {
                    descrip = value;
                  },
                  decoration: const InputDecoration(labelText: "D E S C R I P C I O N"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.add(Data(title: title, descrip: descrip));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Agregar')),
            ],
          );
        });
  }

  void _editContact(Data data, BuildContext context, DataProvider dataProvider) {
    final TextEditingController titleController = TextEditingController(text: data.title);
    final TextEditingController descripController = TextEditingController(text: data.descrip);
    showDialog(
        context: context,
        builder: (context) {
          String title = data.title;
          String descrip = data.descrip;
          return AlertDialog(
            title: const Text('Actualizar Recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(labelText: "Titulo"),
                ),
                TextField(
                  controller: descripController,
                  onChanged: (value) {
                    descrip = value;
                  },
                  decoration: const InputDecoration(labelText: "Descripcion"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.edit(Data(id: data.id, title: title, descrip: descrip));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar')),
            ],
          );
        });
  }
}
