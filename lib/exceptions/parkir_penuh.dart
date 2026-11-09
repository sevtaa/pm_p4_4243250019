class ParkirPenuh implements Exception {
  final String pesan;
  ParkirPenuh([this.pesan = 'Ditolak: Parkiran penuh']);

  @override
  String toString() => pesan;
}
