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

// =====================================================
// BOSH SAHIFA
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openSimplePage(
    BuildContext context,
    String title,
    String text,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SimplePage(
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
    VoidCallback onTap,
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
        onTap: onTap,
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
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DiagnosticPage(),
                ),
              );
            },
          ),

          menu(
            context,
            Icons.warning_amber,
            'Signal va Alarm',
            'Alarm va Trip tahlili',
            () => openSimplePage(
              context,
              'Signal va Alarm',
              'Alarm, Trip va himoya signallari vaqt bo‘yicha '
                  'tahlil qilinadi.',
            ),
          ),

          menu(
            context,
            Icons.show_chart,
            'SCADA / Trend',
            'SCADA va trend tahlili',
            () => openSimplePage(
              context,
              'SCADA / Trend',
              'SCADA ekranlari, real parametrlar va trend '
                  'maʼlumotlarini tahlil qilish bo‘limi.',
            ),
          ),

          menu(
            context,
            Icons.description,
            'Texnik hujjatlar',
            'Pasport, sxema va reglament',
            () => openSimplePage(
              context,
              'Texnik hujjatlar',
              'Uskuna pasportlari, P&ID, elektr, KIPiA va '
                  'avtomatika sxemalari hamda reglamentlar.',
            ),
          ),

          menu(
            context,
            Icons.cable,
            'Signal zanjiri',
            'Datchikdan PLC va SCADA gacha',
            () => openSimplePage(
              context,
              'Signal zanjiri',
              'Datchik → JB → kabel → terminal → marshalling → '
                  'PLC → SCADA signal zanjiri.',
            ),
          ),
          menu(
            context,
            Icons.history,
            'Nosozliklar tarixi',
            'Oldingi nosozlik va bajarilgan ishlar',
            () => openSimplePage(
              context,
              'Nosozliklar tarixi',
              'Oldingi nosozliklar, haqiqiy sabablar, bajarilgan '
                  'ishlar va muhandislar maʼlumotlari shu yerda saqlanadi.',
            ),
          ),

          menu(
            context,
            Icons.monitor_heart,
            'Sutkalik monitoring',
            'Asosiy parametrlarni nazorat qilish',
            () => openSimplePage(
              context,
              'Sutkalik monitoring',
              'Bosim, gaz sarfi, harorat, vibratsiya va RPM '
                  'bo‘yicha monitoring.',
            ),
          ),

          menu(
            context,
            Icons.chat,
            'AI ga savol',
            'Texnik savol berish',
            () => openSimplePage(
              context,
              'AI ga savol',
              'Texnik savollarni AI muhandisga yuborish bo‘limi.',
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// AI DIAGNOSTIKA
// =====================================================

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({super.key});

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> {
  final equipment = TextEditingController();
  final tag = TextEditingController();
  final alarm = TextEditingController();

  final inletPressure = TextEditingController();
  final outletPressure = TextEditingController();
  final gasFlow = TextEditingController();
  final temperature = TextEditingController();
  final vibration = TextEditingController();
  final rpm = TextEditingController();

  final problem = TextEditingController();

  String analysisResult = '';

  Widget field(
    String label,
    TextEditingController controller, {
    bool number = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType:
            number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void analyze() {
    if (equipment.text.trim().isEmpty &&
        tag.text.trim().isEmpty &&
        alarm.text.trim().isEmpty &&
        problem.text.trim().isEmpty) {
      setState(() {
        analysisResult =
            'Tahlil uchun kamida uskuna, TAG, signal/alarm '
            'yoki nosozlik tavsifini kiriting.';
      });
      return;
    }

    setState(() {
      analysisResult =
          'DIAGNOSTIKA SO‘ROVI QABUL QILINDI\n\n'
          'Uskuna: ${equipment.text.isEmpty ? "Kiritilmagan" : equipment.text}\n'
          'TAG: ${tag.text.isEmpty ? "Kiritilmagan" : tag.text}\n'
          'Signal/Alarm: ${alarm.text.isEmpty ? "Kiritilmagan" : alarm.text}\n\n'
          'Kirish bosimi: ${inletPressure.text.isEmpty ? "-" : inletPressure.text}\n'
          'Chiqish bosimi: ${outletPressure.text.isEmpty ? "-" : outletPressure.text}\n'
          'Gaz sarfi: ${gasFlow.text.isEmpty ? "-" : gasFlow.text}\n'
          'Harorat: ${temperature.text.isEmpty ? "-" : temperature.text}\n'
          'Vibratsiya: ${vibration.text.isEmpty ? "-" : vibration.text}\n'
          'RPM: ${rpm.text.isEmpty ? "-" : rpm.text}\n\n'
          'Hozir bu pilot interfeys. Keyingi bosqichda ushbu '
          'maʼlumotlar AI serveriga yuborilib, texnik hujjatlar, '
          'sxemalar, reglamentlar, SCADA/trend va nosozliklar '
          'tarixi bilan solishtiriladi.';
    });
  }
  class WorkResultPage extends StatefulWidget {
  final String equipment;
  final String tag;
  final String alarm;

  const WorkResultPage({
    super.key,
    required this.equipment,
    required this.tag,
    required this.alarm,
  });

  @override
  State<WorkResultPage> createState() => _WorkResultPageState();
}

class _WorkResultPageState extends State<WorkResultPage> {
  final realCause = TextEditingController();
  final completedWork = TextEditingController();
  final repairedPart = TextEditingController();
  final finalResult = TextEditingController();

  final engineers = TextEditingController();
  final department = TextEditingController();

  bool saved = false;

  Widget field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void saveResult() {
    if (completedWork.text.trim().isEmpty ||
        finalResult.text.trim().isEmpty ||
        engineers.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bajarilgan ish, yakuniy natija va muhandis nomini kiriting.',
          ),
        ),
      );
      return;
    }

    setState(() {
      saved = true;
    });
  }

  @override
  void dispose() {
    realCause.dispose();
    completedWork.dispose();
    repairedPart.dispose();
    finalResult.dispose();
    engineers.dispose();
    department.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ish yakuni'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Nosozlik bo‘yicha yakuniy hisobot',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Uskuna: ${widget.equipment.isEmpty ? "-" : widget.equipment}\n'
                'TAG: ${widget.tag.isEmpty ? "-" : widget.tag}\n'
                'Signal/Alarm: ${widget.alarm.isEmpty ? "-" : widget.alarm}',
              ),
            ),
          ),

          const SizedBox(height: 18),

          field(
            'Aniqlangan haqiqiy sabab',
            realCause,
            maxLines: 3,
          ),

          field(
            'Bajarilgan ishlar',
            completedWork,
            maxLines: 5,
          ),

          field(
            'Taʼmirlangan / almashtirilgan qism',
            repairedPart,
            maxLines: 3,
          ),

          field(
            'Taʼmirdan keyingi yakuniy natija',
            finalResult,
            maxLines: 4,
          ),

          const SizedBox(height: 8),

          const Text(
            'ISHNI BAJARGAN MUTAXASSISLAR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          field(
            'Muhandis / mutaxassislar F.I.Sh.',
            engineers,
            maxLines: 3,
          ),

          field(
            'Bo‘lim (KIPiA, Elektr, Mexanika, Texnolog...)',
            department,
          ),

          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: saveResult,
              icon: const Icon(Icons.save),
              label: const Text(
                'NOSOZLIKLAR TARIXIGA SAQLASH',
              ),
            ),
          ),

          if (saved) ...[
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '✓ Hisobot tayyor.\n\n'
                  'Bajargan mutaxassislar:\n${engineers.text}\n\n'
                  'Bajarilgan ishlar:\n${completedWork.text}\n\n'
                  'Yakuniy natija:\n${finalResult.text}\n\n'
                  'Keyingi bosqichda bu maʼlumotlar doimiy '
                  'maʼlumotlar bazasiga saqlanadi.',
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// =====================================================
// QOLGAN BO'LIMLAR
// =====================================================

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
  
