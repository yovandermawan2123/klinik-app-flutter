import 'package:flutter/material.dart';
import 'package:helloworld/model/pasien.dart';
import 'package:helloworld/service/pasien_service.dart';
import 'package:helloworld/ui/Pasien/pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRMPasienCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tglPasienCtrl = TextEditingController();
  final _telponPasienCtrl = TextEditingController();
  final _alamatPasienCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldnomorRMPasien(),
              SizedBox(height: 10),
              _fieldNamaPasien(),
              SizedBox(height: 10),
              _fieldtglPasien(),
              SizedBox(height: 10),
              _fieldtelponPasien(),
              SizedBox(height: 10),
              _fieldalamatPasien(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: InputDecoration(labelText: "Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }

  _fieldnomorRMPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor RM Pasien"),
      controller: _nomorRMPasienCtrl,
    );
  }

  _fieldtglPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir Pasien"),
      controller: _tglPasienCtrl,
    );
  }

  _fieldtelponPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "No. Telephone Pasien"),
      controller: _telponPasienCtrl,
    );
  }

  _fieldalamatPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Alamat Pasien"),
      controller: _alamatPasienCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pasien pasien = new Pasien(
              nomor_rm: _nomorRMPasienCtrl.text,
              nama: _namaPasienCtrl.text,
              tanggal_lahir: _tglPasienCtrl.text,
              nomor_telepon: _telponPasienCtrl.text,
              alamat: _alamatPasienCtrl.text);
          await PasienService().simpan(pasien).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PasienDetail(pasien: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
