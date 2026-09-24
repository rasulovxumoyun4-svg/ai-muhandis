import 'package:flutter/material.dart';

void main() {
  runApp(const AiMuhandisApp());
}

class AiMuhandisApp extends StatelessWidget {
  const AiMuhandisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Muhandis',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget menu(
    BuildContext context,
    IconData icon,
    String nom,
    String izoh,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          nom,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(izoh),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BolimPage(nom: nom),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI MUHANDIS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Texnik diagnostika tizimi',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Uskuna va texnologik jarayonlarni tahlil qilish uchun '
            'yagona muhandislik yordamchisi.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          menu(
            context,
            Icons.psychology,
            'AI Diagnostika',
            'Nosozlik va signalni tahlil qilish',
          ),

          menu(
            context,
            Icons.warning_amber,
            'Signal va Alarm',
            'Alarm, trip va himoya signallarini tekshirish',
          ),

          menu(
            context,
            Icons.image_search,
            'SCADA / Trend tahlili',
            'SCADA ekrani va trend ma’lumotlarini tahlil qilish',
          ),

          menu(
            context,
            Icons.picture_as_pdf,
            'Texnik hujjatlar',
            'Pasport, sxema, reglament va yo‘riqnomalar',
          ),

          menu(
            context,
            Icons.electrical_services,
            'Signal zanjiri',
            'Datchikdan PLC gacha bo‘lgan signal yo‘lini ko‘rish',
          ),

          menu(
            context,
            Icons.history,
            'Nosozliklar tarixi',
            'Oldingi nosozlik va ta’mirlash ma’lumotlari',
          ),

          menu(
            context,
            Icons.monitor_heart,
            'Sutkalik monitoring',
            'Bosim, sarf, harorat, vibratsiya va RPM',
          ),

          menu(
            context,
            Icons.chat,
            'AI ga savol',
            'Texnik savol va maslahatlar',
          ),
        ],
      ),
    );
  }
}

class BolimPage extends StatelessWidget {
  final String nom;

  const BolimPage({
    super.key,
    required this.nom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nom),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            '$nom\n\nBu bo‘lim keyingi bosqichda ishga tushiriladi.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
