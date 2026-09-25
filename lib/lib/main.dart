import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'PROJECT_URL_SHU_YERGA',
    https://wuyfzsbrlicsklhizpeo.supabase.co/rest/v1/
  );

  runApp(const AiMuhandisApp());
}
    anonKey: 'PUBLISHABLE_KEY_SHU_YERGA',
  );

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

  Widget menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
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

          menuCard(
            context,
            icon: Icons.psychology,
            title: 'AI Diagnostika',
            subtitle: 'Nosozlikni aniqlash va tahlil qilish',
            page: const DiagnosticPage(),
          ),

          menuCard(
            context,
            icon: Icons.warning_amber,
            title: 'Signal va Alarm',
            subtitle: 'Alarm va Trip tahlili',
            page: const InfoPage(
              title: 'Signal va Alarm',
              description:
                  'Alarm, Trip va himoya signallarini tahlil qilish bo‘limi.',
            ),
          ),

          menuCard(
            context,
            icon: Icons.show_chart,
            title: 'SCADA / Trend',
            subtitle: 'SCADA va trend tahlili',
            page: const InfoPage(
              title: 'SCADA / Trend',
              description:
                  'SCADA ekranlari va trend maʼlumotlarini tahlil qilish bo‘limi.',
            ),
          ),

          menuCard(
            context,
            icon: Icons.description,
            title: 'Texnik hujjatlar',
            subtitle: 'Pasport, sxema va reglament',
            page: const InfoPage(
              title: 'Texnik hujjatlar',
              description:
                  'Pasportlar, P&ID, elektr, KIPiA, avtomatika sxemalari va reglamentlar.',
            ),
          ),

          menuCard(
            context,
            icon: Icons.cable,
            title: 'Signal zanjiri',
            subtitle: 'Datchikdan PLC gacha',
            page: const InfoPage(
              title: 'Signal zanjiri',
              description:
                  'Datchik → JB → kabel → terminal → marshalling → PLC → SCADA.',
            ),
          ),

          menuCard(
            context,
            icon: Icons.history,
            title: 'Nosozliklar tarixi',
            subtitle: 'Oldingi nosozlik va taʼmirlar',
            page: const HistoryPage(),
          ),

          menuCard(
            context,
            icon: Icons.monitor_heart,
            title: 'Sutkalik monitoring',
            subtitle: 'Asosiy parametrlarni nazorat qilish',
            page: const InfoPage(
              title: 'Sutkalik monitoring',
              description:
                  'Bosim, gaz sarfi, harorat, vibratsiya va RPM monitoringi.',
            ),
          ),

          menuCard(
            context,
            icon: Icons.chat,
            title: 'AI ga savol',
            subtitle: 'Texnik savol berish',
            page: const InfoPage(
              title: 'AI ga savol',
              description:
                  'Texnik savollarni AI muhandisga yuborish bo‘limi.',
            ),
          ),

          const Divider(height: 32),

          menuCard(
            context,
            icon: Icons.admin_panel_settings,
            title: 'Rahbar paneli',
            subtitle: 'Ishlar va nosozliklarni nazorat qilish',
            page: const ManagerPage(),
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
  final equipmentController = TextEditingController();
  final tagController = TextEditingController();
  final alarmController = TextEditingController();

  final inletController = TextEditingController();
  final outletController = TextEditingController();
  final flowController = TextEditingController();
  final temperatureController = TextEditingController();
  final vibrationController = TextEditingController();
  final rpmController = TextEditingController();

  final problemController = TextEditingController();

  String result = '';

  Widget inputField(
    String label,
    TextEditingController controller, {
    bool number = false,
    int lines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: lines,
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
    if (equipmentController.text.trim().isEmpty &&
        tagController.text.trim().isEmpty &&
        alarmController.text.trim().isEmpty &&
        problemController.text.trim().isEmpty) {
      setState(() {
        result =
            'Tahlil qilish uchun uskuna, TAG, signal/alarm yoki '
            'nosozlik tavsifidan kamida bittasini kiriting.';
      });
      return;
    }

    setState(() {
      result =
          'DIAGNOSTIKA SO‘ROVI QABUL QILINDI\n\n'
          'Uskuna: ${equipmentController.text.isEmpty ? "-" : equipmentController.text}\n'
          'TAG: ${tagController.text.isEmpty ? "-" : tagController.text}\n'
          'Signal/Alarm: ${alarmController.text.isEmpty ? "-" : alarmController.text}\n\n'
          'Kirish bosimi: ${inletController.text.isEmpty ? "-" : inletController.text}\n'
          'Chiqish bosimi: ${outletController.text.isEmpty ? "-" : outletController.text}\n'
          'Gaz sarfi: ${flowController.text.isEmpty ? "-" : flowController.text}\n'
          'Harorat: ${temperatureController.text.isEmpty ? "-" : temperatureController.text}\n'
          'Vibratsiya: ${vibrationController.text.isEmpty ? "-" : vibrationController.text}\n'
          'RPM: ${rpmController.text.isEmpty ? "-" : rpmController.text}\n\n'
          'Keyingi bosqichda bu so‘rov AI serveriga yuboriladi va '
          'texnik hujjatlar, sxemalar, reglamentlar, SCADA/trend '
          'hamda nosozliklar tarixi bilan solishtiriladi.';
    });
  }
  @override
  void dispose() {
    equipmentController.dispose();
    tagController.dispose();
    alarmController.dispose();
    inletController.dispose();
    outletController.dispose();
    flowController.dispose();
    temperatureController.dispose();
    vibrationController.dispose();
    rpmController.dispose();
    problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diagnostika'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Nosozlik diagnostikasi',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Uskuna, signal va mavjud parametrlarni kiriting.',
          ),

          const SizedBox(height: 22),

          inputField(
            'Uskuna nomi (masalan: NOVA LT16)',
            equipmentController,
          ),

          inputField(
            'TAG raqami',
            tagController,
          ),

          inputField(
            'Signal / Alarm / Trip',
            alarmController,
          ),

          const SizedBox(height: 8),

          const Text(
            'TEXNOLOGIK PARAMETRLAR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 12),

          inputField(
            'Kirish bosimi',
            inletController,
            number: true,
          ),

          inputField(
            'Chiqish bosimi',
            outletController,
            number: true,
          ),

          inputField(
            'Gaz sarfi',
            flowController,
            number: true,
          ),

          inputField(
            'Harorat',
            temperatureController,
            number: true,
          ),

          inputField(
            'Vibratsiya',
            vibrationController,
            number: true,
          ),

          inputField(
            'RPM / aylanish tezligi',
            rpmController,
            number: true,
          ),

          inputField(
            'Nosozlik haqida maʼlumot',
            problemController,
            lines: 4,
          ),

          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: analyze,
              icon: const Icon(Icons.psychology),
              label: const Text(
                'AI TAHLIL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          if (result.isNotEmpty) ...[
            const SizedBox(height: 24),

            const Text(
              'TAHLIL NATIJASI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.engineering),
                label: const Text('ISH YAKUNINI KIRITISH'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkResultPage(
                        equipment: equipmentController.text,
                        tag: tagController.text,
                        alarm: alarmController.text,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// =====================================================
// ISH YAKUNI
// =====================================================

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
  final causeController = TextEditingController();
  final workController = TextEditingController();
  final partController = TextEditingController();
  final resultController = TextEditingController();

  final engineerController = TextEditingController();
  final departmentController = TextEditingController();

  bool completed = false;

  Widget field(
    String label,
    TextEditingController controller, {
    int lines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void finishWork() {
    if (workController.text.trim().isEmpty ||
        resultController.text.trim().isEmpty ||
        engineerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bajarilgan ishlar, yakuniy natija va mutaxassis nomini kiriting.',
          ),
        ),
      );
      return;
    }

    setState(() {
      completed = true;
    });
  }

  @override
  void dispose() {
    causeController.dispose();
    workController.dispose();
    partController.dispose();
    resultController.dispose();
    engineerController.dispose();
    departmentController.dispose();
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
            'Yakuniy texnik hisobot',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Uskuna: ${widget.equipment.isEmpty ? "-" : widget.equipment}\n'
                'TAG: ${widget.tag.isEmpty ? "-" : widget.tag}\n'
                'Signal/Alarm: ${widget.alarm.isEmpty ? "-" : widget.alarm}',
              ),
            ),
          ),

          const SizedBox(height: 16),

          field(
            'Aniqlangan haqiqiy sabab',
            causeController,
            lines: 3,
          ),

          field(
            'Bajarilgan ishlar',
            workController,
            lines: 5,
          ),

          field(
            'Taʼmirlangan yoki almashtirilgan qism',
            partController,
            lines: 3,
          ),

          field(
            'Taʼmirdan keyingi natija',
            resultController,
            lines: 4,
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
            engineerController,
            lines: 3,
          ),
          field(
            'Bo‘lim: KIPiA, Elektr, Mexanika, Texnolog...',
            departmentController,
          ),

          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: finishWork,
              icon: const Icon(Icons.check_circle),
              label: const Text('ISHNI YAKUNLASH'),
            ),
          ),

          if (completed) ...[
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'ISH YAKUNLANDI ✓\n\n'
                  'Haqiqiy sabab:\n${causeController.text}\n\n'
                  'Bajarilgan ishlar:\n${workController.text}\n\n'
                  'Natija:\n${resultController.text}\n\n'
                  'Bajargan mutaxassislar:\n${engineerController.text}\n\n'
                  'Keyingi bosqichda ushbu hisobot serverdagi '
                  'Nosozliklar tarixi bazasiga yuboriladi va '
                  'rahbar panelida ko‘rinadi.',
                  style: const TextStyle(height: 1.5),
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
// RAHBAR PANELI
// =====================================================

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  Widget statCard(
    IconData icon,
    String number,
    String title,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 34),
        title: Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rahbar paneli'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Texnik holat nazorati',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Korxonadagi diagnostika va bajarilgan ishlarni kuzatish.',
          ),

          const SizedBox(height: 20),

          statCard(
            Icons.warning_amber,
            '0',
            'Ochiq nosozliklar',
          ),

          statCard(
            Icons.build_circle,
            '0',
            'Jarayondagi ishlar',
          ),

          statCard(
            Icons.check_circle,
            '0',
            'Yakunlangan ishlar',
          ),

          statCard(
            Icons.engineering,
            '0',
            'Faol mutaxassislar',
          ),

          const SizedBox(height: 20),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'SERVER ULANISHI KUTILMOQDA\n\n'
                'Keyingi bosqichda rahbar o‘z akkaunti orqali '
                'boshqa telefon yoki planshetdan tizimga kirib, '
                'ochiq nosozliklar, bajarilayotgan ishlar, '
                'muhandislar va yakuniy natijalarni ko‘ra oladi.\n\n'
                'Bu faqat AI Muhandis tizimidagi xizmat '
                'maʼlumotlarini ko‘rsatadi.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// NOSOZLIKLAR TARIXI
// =====================================================

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosozliklar tarixi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Hozircha saqlangan nosozliklar mavjud emas.\n\n'
              'Database ulangandan keyin bu yerda uskuna, TAG, '
              'signal, haqiqiy sabab, bajarilgan ishlar, natija, '
              'sana va ishni bajargan mutaxassislar ko‘rinadi.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// ODDIY BO'LIMLAR
// =====================================================

class InfoPage extends StatelessWidget {
  final String title;
  final String description;

  const InfoPage({
    super.key,
    required this.title,
    required this.description,
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
                description,
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
