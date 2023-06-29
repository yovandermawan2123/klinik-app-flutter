import 'package:flutter/material.dart';
import 'package:helloworld/service/pasien_service.dart';
import '/../model/pasien.dart';
import '/ui/Pasien/pasien_detail.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRMPasienCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tglPasienCtrl = TextEditingController();
  final _telponPasienCtrl = TextEditingController();
  final _alamatPasienCtrl = TextEditingController();

  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      _nomorRMPasienCtrl.text = data.nomor_rm;
      _namaPasienCtrl.text = data.nama;
      _tglPasienCtrl.text = data.tanggal_lahir;
      _telponPasienCtrl.text = data.nomor_telepon;
      _alamatPasienCtrl.text = data.alamat;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Data Pasien")),
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
      decoration: const InputDecoration(labelText: "nomorRM Pasien"),
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
      decoration: const InputDecoration(labelText: "alamat Pasien"),
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
          String id = widget.pasien.id.toString();
          await PasienService().ubah(pasien, id).then((value) {
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
