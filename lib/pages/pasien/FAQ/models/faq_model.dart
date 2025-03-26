class FaqModel {
  String question;
  String answer;
  FaqModel({
    required this.question,
    required this.answer,
  });
}

List<FaqModel> melanomaFAQs = [
  FaqModel(
      question: 'Apa itu Melanoma?',
      answer:
          'Melanoma adalah jenis kanker kulit yang paling serius. Melanoma terjadi ketika sel-sel pigmentasi kulit yang disebut melanosit berubah menjadi sel-sel kanker. Melanoma dapat terjadi di kulit mana pun, tetapi melanoma yang terjadi di bagian tubuh yang tidak terpapar sinar matahari seringkali lebih serius.'),
  FaqModel(
      question: 'Apa saja gejala Melanoma?',
      answer:
          'Gejala melanoma dapat meliputi munculnya tahi lalat baru atau perubahan pada tahi lalat yang sudah ada. Ciri-ciri tahi lalat yang mencurigakan termasuk bentuk yang tidak simetris, tepi yang tidak rata, warna yang tidak seragam, diameter lebih besar dari 6 mm, dan perubahan bentuk, ukuran, atau warna.'),
  FaqModel(
      question: 'Bagaimana pengobatan untuk melanoma?',
      answer:
          'Pengobatan melanoma tergantung pada stadium dan lokasi kanker. Metode pengobatan yang umum termasuk pembedahan untuk mengangkat kanker, terapi radiasi, imunoterapi, dan terapi target. Pada kasus yang lebih lanjut, kombinasi dari beberapa metode pengobatan mungkin diperlukan, segera hubungi dokter.'),
  FaqModel(
      question: 'Bagaimana cara mencegah melanoma?',
      answer:
          'Pencegahan melanoma meliputi menghindari paparan sinar matahari yang berlebihan, terutama pada jam-jam terik. Gunakan tabir surya dengan SPF tinggi, kenakan pakaian pelindung, dan hindari penggunaan tanning bed. Selain itu, periksa kulit secara rutin untuk mendeteksi perubahan atau tanda-tanda yang mencurigakan.'),
];

List<FaqModel> mySkinFAQs = [
  FaqModel(
      question: 'Apa itu My Skin?',
      answer:
          'My Skin adalah sistem deteksi dini melanoma berbasis web yang menggunakan teknologi AI. Hasil analisis dapat diverifikasi oleh Dokter.'),
  FaqModel(
      question: 'Apakah My Skin Berbayar?',
      answer:
          'My Skin gratis untuk digunakan oleh khalayak umum, dapat diakses dimana saja dan tidak dipungut biaya sepersen pun'),
];
