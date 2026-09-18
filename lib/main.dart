import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        fontFamily: 'Roboto',
      ),
      home: const BerandaScreen(),
    );
  }
}

// =========================================================
// MODEL DATA KATALOG
// =========================================================
class KatalogItem {
  final String nama;
  final String subjudul;
  final String harga;
  final String satuan;
  final IconData icon;
  final Color warna;
  final String deskripsi;
  final List<String> fitur;
  final String? badge; // null jika tidak ada badge

  const KatalogItem({
    required this.nama,
    required this.subjudul,
    required this.harga,
    required this.satuan,
    required this.icon,
    required this.warna,
    required this.deskripsi,
    required this.fitur,
    this.badge,
  });
}

final List<KatalogItem> daftarKatalog = [
  const KatalogItem(
    nama: 'Paket Basic',
    subjudul: 'Cocok untuk kebutuhan dasar seperti landing page sederhana.',
    harga: 'Rp 1.500.000',
    satuan: '/ proyek',
    icon: Icons.laptop_chromebook,
    warna: Colors.lightBlue,
    deskripsi:
        'Cocok untuk kebutuhan dasar seperti landing page sederhana dengan '
        'satu halaman utama dan desain responsif standar.',
    fitur: ['Desain 1 Halaman', 'Domain Gratis 1 Tahun', 'Responsif Mobile'],
  ),
  const KatalogItem(
    nama: 'Paket Profesional',
    subjudul: 'Solusi lengkap untuk kebutuhan bisnis digital Anda.',
    harga: 'Rp 5.000.000',
    satuan: '/ proyek',
    icon: Icons.laptop_mac,
    warna: Colors.blueAccent,
    deskripsi:
        'Solusi lengkap untuk kebutuhan bisnis digital Anda, termasuk desain '
        'UI/UX khusus, integrasi API pembayaran, dan dukungan teknis 24/7.',
    fitur: [
      'Desain UI/UX Khusus',
      'Setup Database',
      'Integrasi API Payment',
      'Dukungan Teknis 24/7',
    ],
    badge: 'Rekomendasi',
  ),
  const KatalogItem(
    nama: 'Paket Enterprise',
    subjudul: 'Dirancang untuk skala besar dengan arsitektur khusus.',
    harga: 'Rp 15.000.000',
    satuan: '/ proyek',
    icon: Icons.business_center,
    warna: Colors.teal,
    deskripsi:
        'Dirancang untuk skala besar dengan arsitektur khusus, keamanan '
        'tingkat lanjut, serta konsultasi dan pendampingan tim developer.',
    fitur: [
      'Arsitektur Khusus',
      'Keamanan Tingkat Lanjut',
      'Konsultasi Tim Developer',
      'SLA Prioritas',
    ],
  ),
];

// =========================================================
// SCREEN 1 - BERANDA (StatelessWidget)
// =========================================================
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda - Katalog Produk'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarKatalog.length,
        itemBuilder: (context, index) {
          final item = daftarKatalog[index];
          return PricingListCard(
            item: item,
            onTap: () {
              // Navigasi Screen 1 -> Screen 2 (Stack Navigation)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailKatalogScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Kartu list bergaya mirip referensi (card putih, shadow, badge melayang)
class PricingListCard extends StatelessWidget {
  final KatalogItem item;
  final VoidCallback onTap;

  const PricingListCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 6),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: item.warna.withOpacity(0.12),
                      child: Icon(item.icon, size: 28, color: item.warna),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.nama,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.subjudul,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                item.harga,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: item.warna,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.satuan,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),

          // Badge melayang seperti referensi (hanya jika item punya badge)
          if (item.badge != null)
            Positioned(
              top: -10,
              right: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =========================================================
// SCREEN 2 - DETAIL KATALOG (StatefulWidget)
// =========================================================
class DetailKatalogScreen extends StatefulWidget {
  final KatalogItem item;

  const DetailKatalogScreen({super.key, required this.item});

  @override
  State<DetailKatalogScreen> createState() => _DetailKatalogScreenState();
}

class _DetailKatalogScreenState extends State<DetailKatalogScreen> {
  bool isFavorite = false;
  int jumlahPesanan = 1;

  void toggleFavorite() => setState(() => isFavorite = !isFavorite);

  void tambahJumlah() => setState(() => jumlahPesanan++);

  void kurangiJumlah() =>
      setState(() => jumlahPesanan > 1 ? jumlahPesanan-- : null);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      // AppBar otomatis menyediakan tombol kembali bawaan
      appBar: AppBar(
        title: const Text('Detail Katalog'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon back manual tambahan (selain back bawaan AppBar)
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: 20),
                    SizedBox(width: 6),
                    Text('Kembali ke Beranda'),
                  ],
                ),
              ),
            ),

            // Kartu utama bergaya sama seperti referensi (Stack + badge)
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // Header paket
                        Center(
                          child: Column(
                            children: [
                              Icon(item.icon, size: 50, color: item.warna),
                              const SizedBox(height: 8),
                              Text(
                                item.nama,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.subjudul,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Harga & satuan
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              item.harga,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: item.warna,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.satuan,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Daftar fitur (checklist)
                        Column(
                          children: item.fitur
                              .map(
                                (f) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check, size: 18, color: Colors.green),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          f,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 8),

                        // Tombol CTA
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '$jumlahPesanan x "${item.nama}" ditambahkan ke keranjang',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: item.warna,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Pilih Paket',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Badge melayang
                  if (item.badge != null)
                    Positioned(
                      top: -10,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          item.badge!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Container pastel berisi deskripsi lengkap (wajib sesuai kriteria)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: item.warna.withOpacity(0.10),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: item.warna.withOpacity(0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: item.warna,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.deskripsi,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Jumlah pesanan (fitur tambahan StatefulWidget)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jumlah Pesanan',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: kurangiJumlah,
                      ),
                      Text(
                        '$jumlahPesanan',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: tambahJumlah,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}