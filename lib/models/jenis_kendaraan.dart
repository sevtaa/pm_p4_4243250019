import 'kendaraan.dart';
import '../mixins/diskon_member.dart';

class Motor extends Kendaraan {
  Motor(String platNomor, int lamaJam) : super(platNomor, lamaJam);

  @override
  String get jenis => 'Motor';

  @override
  double get tarifPerJam => 2000;
}

class Mobil extends Kendaraan {
  Mobil(String platNomor, int lamaJam) : super(platNomor, lamaJam);

  @override
  String get jenis => 'Mobil';

  @override
  double get tarifPerJam => 5000;
}

class MobilMember extends Kendaraan with DiskonMember {
  MobilMember(String platNomor, int lamaJam) : super(platNomor, lamaJam);

  @override
  String get jenis => 'Mobil (member)';

  @override
  double get tarifPerJam => 5000;

  @override
  double biaya() {
    double totalAsli = super.biaya();
    return hitungDiskon(totalAsli); // Menggunakan mixin diskon
  }
}
