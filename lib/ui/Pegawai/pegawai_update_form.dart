import 'package:flutter/material.dart';
import 'package:helloworld/service/pegawai_service.dart';
import 'package:helloworld/service/poli_service.dart';
import '/../model/pegawai.dart';
import '/ui/Pegawai/pegawai_detail.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipPegawaiCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tglPegawaiCtrl = TextEditingController();
  final _telponPegawaiCtrl = TextEditingController();
  final _emailPegawaiCtrl = TextEditingController();
  final _passwordPegawaiCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      _nipPegawaiCtrl.text = data.nip;
      _namaPegawaiCtrl.text = data.nama;
      _tglPegawaiCtrl.text = data.tanggal_lahir;
      _telponPegawaiCtrl.text = data.nomor_telepon;
      _emailPegawaiCtrl.text = data.email;
      _passwordPegawaiCtrl.text = data.password;
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
      appBar: AppBar(title: const Text("Ubah Data Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNipPegawai(),
              SizedBox(height: 10),
              _fieldNamaPegawai(),
              SizedBox(height: 10),
              _fieldtglPegawai(),
              SizedBox(height: 10),
              _fieldtelponPegawai(),
              SizedBox(height: 10),
              _fieldemailPegawai(),
              SizedBox(height: 10),
              _fieldpasswordPegawai(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPegawai() {
    return TextField(
      decoration: InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }

  _fieldNipPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nip Pegawai"),
      controller: _nipPegawaiCtrl,
    );
  }

  _fieldtglPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir Pegawai"),
      controller: _tglPegawaiCtrl,
    );
  }

  _fieldtelponPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "No. Telephone Pegawai"),
      controller: _telponPegawaiCtrl,
    );
  }

  _fieldemailPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Email Pegawai"),
      controller: _emailPegawaiCtrl,
    );
  }

  _fieldpasswordPegawai() {
    return TextField(
      obscureText: true,
      decoration: const InputDecoration(labelText: "Password Pegawai"),
      controller: _passwordPegawaiCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pegawai pegawai = new Pegawai(
              nip: _nipPegawaiCtrl.text,
              nama: _namaPegawaiCtrl.text,
              tanggal_lahir: _tglPegawaiCtrl.text,
              nomor_telepon: _telponPegawaiCtrl.text,
              email: _emailPegawaiCtrl.text,
              password: _passwordPegawaiCtrl.text);
          String id = widget.pegawai.id.toString();
          await PegawaiService().ubah(pegawai, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PegawaiDetail(pegawai: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
