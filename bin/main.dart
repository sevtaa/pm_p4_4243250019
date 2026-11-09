import 'dart:async';

import '../lib/models/kendaraan.dart';
import '../lib/models/jenis_kendaraan.dart';
import '../lib/services/sistem_parkir.dart';
import '../lib/exceptions/parkir_penuh.dart';

void main() async {
  // Kapasitas maksimal parkiran adalah 2 kendaraan
  final parkir = SistemParkir(2);

  // Menyimak event log secara real-time dari Stream (Layar Pos Jaga)
  parkir.streamLog.listen((event) {
    print(event);
  });

  try {
    // Kendaraan 1 Masuk
    final m1 = Motor('BK 1234 AB', 3);
    await parkir.kendaraanMasuk(m1);

    // Kendaraan 2 Masuk
    final m2 = Mobil('BK 88 UN', 3);
    await parkir.kendaraanMasuk(m2);

    // Kendaraan 3 Masuk (Penuh -> Memicu Exception ParkirPenuh)
    final m3 = MobilMember('BK 7 MIPA', 3);
    await parkir.kendaraanMasuk(m3);
  } on ParkirPenuh catch (e) {
    print(e);
  }

  // Jeda sebentar
  await Future.delayed(const Duration(seconds: 1));

  // Kendaraan keluar untuk mengosongkan slot
  await parkir.kendaraanKeluar('BK 1234 AB');
  await parkir.kendaraanKeluar('BK 88 UN');

  // Slot kosong, masukkan kembali Mobil Member
  try {
    final m3 = MobilMember('BK 7 MIPA', 3);
    await parkir.kendaraanMasuk(m3);

    await Future.delayed(const Duration(milliseconds: 500));
    await parkir.kendaraanKeluar('BK 7 MIPA');
  } catch (e) {
    print(e);
  }

  // Menampilkan Total Pendapatan Akhir
  await Future.delayed(const Duration(milliseconds: 500));
  print('Pendapatan: Rp${parkir.pendapatan.toInt()}');

  parkir.tutupSistem();
}
