import 'package:flutter/material.dart';
import 'package:helloworld/service/poli_service.dart';
import 'package:helloworld/ui/Poli/poli_form.dart';
import '/../model/poli.dart';
import '/../widget/sidebar.dart';
// import 'poli_detail.dart';
import 'poli_item.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Poli"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PoliForm()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Kosong');
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PoliItem(poli: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
