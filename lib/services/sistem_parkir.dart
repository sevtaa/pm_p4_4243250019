import 'dart:async';

import '../models/kendaraan.dart';
import '../exceptions/parkir_penuh.dart';

class SistemParkir {
  final int _kapasitasMaksimal;
  final List<Kendaraan> _daftarParkir = [];
  double _totalPendapatan = 0;

  // Stream Controller bertipe broadcast untuk layar pos jaga
  final StreamController<String> _logController =
      StreamController<String>.broadcast();

  SistemParkir(this._kapasitasMaksimal);

  // Getter Enkapsulasi
  int get sisaSlot => _kapasitasMaksimal - _daftarParkir.length;
  double get pendapatan => _totalPendapatan;
  Stream<String> get streamLog => _logController.stream;

  // Method Asinkron Kendaraan Masuk
  Future<void> kendaraanMasuk(Kendaraan k) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulasi proses async

    if (_daftarParkir.length >= _kapasitasMaksimal) {
      _logController.add('Ditolak: Parkiran penuh');
      throw ParkirPenuh();
    }

    _daftarParkir.add(k);
    _logController.add('MASUK ${k.jenis} ${k.platNomor} (sisa $sisaSlot)');
  }

  // Method Asinkron Kendaraan Keluar
  Future<void> kendaraanKeluar(String platNomor) async {
    await Future.delayed(const Duration(milliseconds: 500));

    Kendaraan? k;
    try {
      k = _daftarParkir.firstWhere((item) => item.platNomor == platNomor);
    } catch (_) {
      k = null;
    }

    if (k != null) {
      _daftarParkir.remove(k);
      double totalBayar = k.biaya();
      _totalPendapatan += totalBayar;
      _logController.add('KELUAR ${k.jenis} ... bayar Rp${totalBayar.toInt()}');
    }
  }

  void tutupSistem() {
    _logController.close();
  }
}
