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

// ================= BOSH SAHIFA =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget menu(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Texnik diagnostika tizimi',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kompressor, KIPiA, elektr, avtomatika va '
            'texnologik uskunalar uchun muhandislik yordamchisi.',
          ),
          const SizedBox(height: 22),

          menu(
            context,
            Icons.psychology,
            'AI Diagnostika',
            'Nosozlikni tahlil qilish',
            const DiagnosticPage(),
          ),

          menu(
            context,
            Icons.warning_amber,
            'Signal va Alarm',
            'Alarm, trip va himoya signallari',
            const AlarmPage(),
          ),

          menu(
            context,
            Icons.show_chart,
            'SCADA / Trend',
            'SCADA va trend tahlili',
            const ScadaPage(),
          ),

          menu(
            context,
            Icons.picture_as_pdf,
            'Texnik hujjatlar',
            'Pasport, sxema va reglamentlar',
            const DocumentsPage(),
          ),

          menu(
            context,
            Icons.cable,
            'Signal zanjiri',
            'Datchikdan PLC gacha',
            const SignalChainPage(),
          ),

          menu(
            context,
            Icons.history,
            'Nosozliklar tarixi',
            'Oldingi nosozlik va ta’mirlar',
            const HistoryPage(),
          ),

          menu(
            context,
            Icons.monitor_heart,
            'Sutkalik monitoring',
            'Bosim, sarf, harorat, vibratsiya, RPM',
            const MonitoringPage(),
          ),

          menu(
            context,
            Icons.chat,
            'AI ga savol',
            'Texnik savollar uchun yordamchi',
            const AiQuestionPage(),
          ),
        ],
      ),
    );
  }
}

// ================= AI DIAGNOSTIKA =================

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({super.key});

  @override
  State<DiagnosticPage> createState() =>
      _DiagnosticPageState();
}
class _DiagnosticPageState
    extends State<DiagnosticPage> {
  final equipment = TextEditingController();
  final tag = TextEditingController();
  final problem = TextEditingController();
  final alarm = TextEditingController();
  final pressure = TextEditingController();
  final temperature = TextEditingController();
  final vibration = TextEditingController();

  String result = 'Diagnostika hali bajarilmadi.';

  void diagnose() {
    if (problem.text.trim().isEmpty) {
      setState(() {
        result =
            'Nosozlik yoki kuzatilayotgan holatni kiriting.';
      });
      return;
    }

    setState(() {
      result = '''
DASTLABKI TEXNIK TAHLIL

Uskuna:
${equipment.text.isEmpty ? "Ko‘rsatilmagan" : equipment.text}

TAG:
${tag.text.isEmpty ? "Ko‘rsatilmagan" : tag.text}

Muammo:
${problem.text}

Signal / Alarm:
${alarm.text.isEmpty ? "Kiritilmagan" : alarm.text}

PARAMETRLAR

Bosim:
${pressure.text.isEmpty ? "-" : pressure.text}

Harorat:
${temperature.text.isEmpty ? "-" : temperature.text}

Vibratsiya:
${vibration.text.isEmpty ? "-" : vibration.text}

XULOSA

Hozirgi ma’lumotlar dastlabki tahlil uchun qabul qilindi.

Aniq sababni tasdiqlash uchun tegishli texnik hujjat,
signal zanjiri, trend va o‘lchov natijalari bilan
solishtirish talab qilinadi.

AI yetarli dalilsiz aniq nosozlik nuqtasini
taxmin sifatida ko‘rsatmaydi.

Himoya va blokirovka tizimlari chetlab o‘tilmasligi kerak.
''';
    });
  }

  Widget field(
    TextEditingController controller,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    equipment.dispose();
    tag.dispose();
    problem.dispose();
    alarm.dispose();
    pressure.dispose();
    temperature.dispose();
    vibration.dispose();
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
          field(equipment, 'Uskuna nomi'),
          field(tag, 'TAG / signal nomi'),
          field(problem, 'Muammo nimada?'),
          field(alarm, 'Alarm / Trip'),
          field(pressure, 'Bosim'),
          field(temperature, 'Harorat'),
          field(vibration, 'Vibratsiya'),

          FilledButton.icon(
            onPressed: diagnose,
            icon: const Icon(Icons.psychology),
            label: const Text(
              'TAHLIL QILISH',
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(result),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SIGNAL / ALARM =================

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() =>
      _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final signal = TextEditingController();
  final time = TextEditingController();
  final description = TextEditingController();

  String result = 'Signal kiritilmagan.';

  void analyze() {
    setState(() {
      result = '''
SIGNAL TAHLILI

Signal:
${signal.text.isEmpty ? "-" : signal.text}

Vaqt:
${time.text.isEmpty ? "-" : time.text}

Tavsif:
${description.text.isEmpty ? "-" : description.text}

Keyingi bosqichda ushbu signal:
• hodisalar ketma-ketligi;
• tegishli TAG;
• trend;
• PLC I/O;
• himoya algoritmi

bilan avtomatik solishtiriladi.
''';
    });
  }

  @override
  void dispose() {
    signal.dispose();
    time.dispose();
    description.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signal va Alarm'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: signal,
            decoration: const InputDecoration(
              labelText: 'Signal / Alarm nomi',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: time,
            decoration: const InputDecoration(
              labelText: 'Vaqti',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: description,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Izoh',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: analyze,
            child: const Text('TAHLIL QILISH'),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(result),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SCADA =================

class ScadaPage extends StatelessWidget {
  const ScadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'SCADA / Trend tahlili',
      icon: Icons.show_chart,
      text:
          'Bu bo‘limda SCADA ekran rasmi, trend va '
          'signal hodisalari tahlil qilinadi.\n\n'
          'Keyingi bosqichda rasm yuklash va AI vision '
          'xizmati ulanadi.',
    );
  }
}

// ================= HUJJATLAR =================

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'Texnik hujjatlar',
      icon: Icons.picture_as_pdf,
      text:
          'Bu yerda quyidagilar saqlanadi:\n\n'
          '• Uskuna pasportlari\n'
          '• P&ID sxemalar\n'
          '• Elektr sxemalar\n'
          '• KIPiA sxemalar\n'
          '• PLC I/O\n'
          '• Reglamentlar\n'
          '• Ekspluatatsiya yo‘riqnomalari\n'
          '• Ta’mirlash hujjatlari\n\n'
          'Keyingi bosqichda PDF va boshqa hujjatlarni '
          'yuklash funksiyasi ulanadi.',
    );
  }
}

// ================= SIGNAL ZANJIRI =================

class SignalChainPage extends StatefulWidget {
  const SignalChainPage({super.key});

  @override
  State<SignalChainPage> createState() =>
      _SignalChainPageState();
}

class _SignalChainPageState
    extends State<SignalChainPage> {
  final tag = TextEditingController();

  String result =
      'TAG kiriting va signal zanjirini ko‘ring.';

  void findChain() {
    if (tag.text.trim().isEmpty) {
      setState(() {
        result = 'TAG kiritilmagan.';
      });
      return;
    }

    setState(() {
      result = '''
${tag.text.toUpperCase()}

Datchik
   ↓
Ulanish qutisi (JB)
   ↓
Signal kabeli
   ↓
Terminal
   ↓
Marshalling panel
   ↓
PLC I/O
   ↓
SCADA / HMI

Bu umumiy zanjir namunasi.

Aniq obyekt bo‘yicha zanjir korxonaning haqiqiy
KIPiA va elektr sxemalaridan olinadi.
''';
    });
  }

  @override
  void dispose() {
    tag.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signal zanjiri'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: tag,
            decoration: const InputDecoration(
              labelText: 'TAG, masalan PT-101',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          FilledButton(
            onPressed: findChain,
            child: const Text(
              'ZANJIRNI KO‘RISH',
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(result),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= TARIX =================

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() =>
      _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = TextEditingController();

  final List<String> history = [];

  void add() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      history.insert(0, text);
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosozliklar tarixi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText:
                        'Nosozlik yoki bajarilgan ish',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: add,
                    child: const Text(
                      'TARIXGA QO‘SHISH',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: history.isEmpty
                ? const Center(
                    child: Text(
                      'Hozircha ma’lumot yo‘q.',
                    ),
                  )
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading:
                              const Icon(Icons.history),
                          title: Text(history[index]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ================= MONITORING =================

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() =>
      _MonitoringPageState();
}

class _MonitoringPageState
    extends State<MonitoringPage> {
  final oldIn = TextEditingController();
  final newIn = TextEditingController();

  final oldOut = TextEditingController();
  final newOut = TextEditingController();

  final oldFlow = TextEditingController();
  final newFlow = TextEditingController();

  final oldTemp = TextEditingController();
  final newTemp = TextEditingController();

  final oldVib = TextEditingController();
  final newVib = TextEditingController();

  final oldRpm = TextEditingController();
  final newRpm = TextEditingController();

  String result = 'Hali diagnostika qilinmadi.';

  double? number(TextEditingController c) {
    return double.tryParse(
      c.text.trim().replaceAll(',', '.'),
    );
  }
  String compare(
    String name,
    double oldValue,
    double newValue,
    String unit,
  ) {
    final diff = newValue - oldValue;

    final percent = oldValue == 0
        ? 0.0
        : (diff / oldValue) * 100;

    String status = 'O‘ZGARMAGAN';

    if (diff > 0) {
      status = 'OSHGAN ↑';
    }

    if (diff < 0) {
      status = 'KAMAYGAN ↓';
    }

    return '''
$name
Oldingi: ${oldValue.toStringAsFixed(2)} $unit
Hozirgi: ${newValue.toStringAsFixed(2)} $unit
Farq: ${diff.toStringAsFixed(2)} $unit
O‘zgarish: ${percent.toStringAsFixed(1)} %
Holat: $status
''';
  }

  void diagnose() {
    final values = [
      number(oldIn),
      number(newIn),
      number(oldOut),
      number(newOut),
      number(oldFlow),
      number(newFlow),
      number(oldTemp),
      number(newTemp),
      number(oldVib),
      number(newVib),
      number(oldRpm),
      number(newRpm),
    ];

    if (values.any((value) => value == null)) {
      setState(() {
        result =
            'Barcha oldingi va hozirgi qiymatlarni kiriting.';
      });
      return;
    }

    setState(() {
      result =
          '${compare("KIRISH BOSIMI", values[0]!, values[1]!, "bar")}\n'
          '${compare("CHIQISH BOSIMI", values[2]!, values[3]!, "bar")}\n'
          '${compare("GAZ SARFI", values[4]!, values[5]!, "Nm³/h")}\n'
          '${compare("HARORAT", values[6]!, values[7]!, "°C")}\n'
          '${compare("VIBRATSIYA", values[8]!, values[9]!, "mm/s")}\n'
          '${compare("RPM", values[10]!, values[11]!, "rpm")}';
    });
  }

  void saveDay() {
    final current = [
      number(newIn),
      number(newOut),
      number(newFlow),
      number(newTemp),
      number(newVib),
      number(newRpm),
    ];

    if (current.any((value) => value == null)) {
      setState(() {
        result =
            'Hozirgi sutka qiymatlarini to‘liq kiriting.';
      });
      return;
    }

    setState(() {
      oldIn.text = current[0]!.toString();
      oldOut.text = current[1]!.toString();
      oldFlow.text = current[2]!.toString();
      oldTemp.text = current[3]!.toString();
      oldVib.text = current[4]!.toString();
      oldRpm.text = current[5]!.toString();

      newIn.clear();
      newOut.clear();
      newFlow.clear();
      newTemp.clear();
      newVib.clear();
      newRpm.clear();

      result =
          'Qiymatlar keyingi sutka uchun saqlandi.';
    });
  }

  Widget pair(
    String title,
    String unit,
    TextEditingController oldC,
    TextEditingController newC,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: oldC,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Oldingi sutka',
                suffixText: unit,
                border:
                    const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newC,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Hozirgi sutka',
                suffixText: unit,
                border:
                    const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    for (final c in [
      oldIn,
      newIn,
      oldOut,
      newOut,
      oldFlow,
      newFlow,
      oldTemp,
      newTemp,
      oldVib,
      newVib,
      oldRpm,
      newRpm,
    ]) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sutkalik monitoring'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
