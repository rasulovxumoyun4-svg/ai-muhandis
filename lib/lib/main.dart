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

  void openPage(
    BuildContext context,
    String title,
    String text,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimplePage(
          title: title,
          text: text,
        ),
      ),
    );
  }

  Widget menu(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String text,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          openPage(context, title, text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI MUHANDIS'),
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
            'Korxona uskunalari uchun aqlli muhandislik yordamchisi',
          ),
          const SizedBox(height: 24),

          menu(
            context,
            Icons.psychology,
            'AI Diagnostika',
            'Nosozlikni aniqlash va tahlil qilish',
            'Uskuna, TAG, signal va parametrlar asosida '
                'nosozlik diagnostikasi shu bo‘limda amalga oshiriladi.',
          ),

          menu(
            context,
            Icons.warning_amber,
            'Signal va Alarm',
            'Alarm va Trip tahlili',
            'Alarm, Trip va himoya signallari vaqt bo‘yicha '
                'tahlil qilinadi.',
          ),

          menu(
            context,
            Icons.show_chart,
            'SCADA / Trend',
            'SCADA va trend tahlili',
            'SCADA ekranlari va trend ma’lumotlarini '
                'tahlil qilish bo‘limi.',
          ),

          menu(
            context,
            Icons.description,
            'Texnik hujjatlar',
            'Pasport, sxema va reglament',
            'Uskuna pasportlari, P&ID, elektr va KIPiA '
                'sxemalari hamda reglamentlar shu yerda saqlanadi.',
          ),

          menu(
            context,
            Icons.cable,
            'Signal zanjiri',
            'Datchikdan PLC gacha',
            'Datchik → JB → kabel → terminal → '
                'marshalling → PLC → SCADA zanjiri tahlil qilinadi.',
          ),

          menu(
            context,
            Icons.history,
            'Nosozliklar tarixi',
            'Oldingi nosozlik va ta’mirlar',
            'Oldingi nosozliklar, sabablar va bajarilgan '
                'ta’mirlash ishlari bazasi.',
          ),

          menu(
            context,
            Icons.monitor_heart,
            'Sutkalik monitoring',
            'Asosiy parametrlarni nazorat qilish',
            'Bosim, gaz sarfi, harorat, vibratsiya va '
                'RPM sutkalik nazorat qilinadi.',
          ),
          menu(
            context,
            Icons.chat,
            'AI ga savol',
            'Texnik savol berish',
            'Muhandis texnik savolini kiritadi. '
                'Keyingi bosqichda AI serveri shu bo‘limga ulanadi.',
          ),
        ],
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final String text;

  const SimplePage({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'AI MUHANDIS — PILOT VERSIYA',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
