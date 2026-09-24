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
      title: 'AI Muhandis',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const AiMuhandis(),
    );
  }
}

class AiMuhandis extends StatefulWidget {
  const AiMuhandis({super.key});

  @override
  State<AiMuhandis> createState() => _AiMuhandisState();
}

class _AiMuhandisState extends State<AiMuhandis> {
  final kirishOld = TextEditingController();
  final kirishNew = TextEditingController();

  final chiqishOld = TextEditingController();
  final chiqishNew = TextEditingController();

  final gazOld = TextEditingController();
  final gazNew = TextEditingController();

  String natija = 'Hali diagnostika qilinmadi';

  double? son(TextEditingController c) {
    return double.tryParse(c.text.replaceAll(',', '.'));
  }

  String holat(double farq) {
    if (farq > 0) return 'OSHGАN ↑';
    if (farq < 0) return 'KAMAYGAN ↓';
    return 'O‘ZGARMAGAN';
  }

  void diagnostika() {
    final a = son(kirishOld);
    final b = son(kirishNew);
    final c = son(chiqishOld);
    final d = son(chiqishNew);
    final e = son(gazOld);
    final f = son(gazNew);

    if (a == null ||
        b == null ||
        c == null ||
        d == null ||
        e == null ||
        f == null) {
      setState(() {
        natija = 'Barcha qiymatlarni kiriting.';
      });
      return;
    }

    final kirishFarq = b - a;
    final chiqishFarq = d - c;
    final gazFarq = f - e;

    setState(() {
      natija =
          'KIRISH BOSIMI\n'
          '${a.toStringAsFixed(2)} → ${b.toStringAsFixed(2)} bar\n'
          '${holat(kirishFarq)}\n\n'
          'CHIQISH BOSIMI\n'
          '${c.toStringAsFixed(2)} → ${d.toStringAsFixed(2)} bar\n'
          '${holat(chiqishFarq)}\n\n'
          'GAZ SARFI\n'
          '${e.toStringAsFixed(0)} → ${f.toStringAsFixed(0)} Nm³/h\n'
          '${holat(gazFarq)}';
    });
  }

  Widget maydon(
    TextEditingController controller,
    String nom,
    String birlik,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: nom,
          suffixText: birlik,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    kirishOld.dispose();
    kirishNew.dispose();
    chiqishOld.dispose();
    chiqishNew.dispose();
    gazOld.dispose();
    gazNew.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI MUHANDIS'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Sutkalik diagnostika',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sana: ${now.day}.${now.month}.${now.year}',
          ),
          const SizedBox(height: 25),

          const Text(
            'Kirish bosimi',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          maydon(kirishOld, 'Oldingi sutka', 'bar'),
          maydon(kirishNew, 'Hozirgi sutka', 'bar'),

          const SizedBox(height: 15),
          const Text(
            'Chiqish bosimi',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          maydon(chiqishOld, 'Oldingi sutka', 'bar'),
          maydon(chiqishNew, 'Hozirgi sutka', 'bar'),

          const SizedBox(height: 15),

          const Text(
            'Gaz sarfi',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          maydon(gazOld, 'Oldingi sutka', 'Nm³/h'),
          maydon(gazNew, 'Hozirgi sutka', 'Nm³/h'),

          const SizedBox(height: 15),

          FilledButton(
            onPressed: diagnostika,
            child: const Text('DIAGNOSTIKA QILISH'),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                natija,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
