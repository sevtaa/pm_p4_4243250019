abstract class Kendaraan {
  final String platNomor;
  final int lamaJam; // Simulasi lama parkir dalam jam

  Kendaraan(this.platNomor, this.lamaJam);

  String get jenis;
  double get tarifPerJam;

  double biaya() {
    return lamaJam * tarifPerJam;
  }
}
