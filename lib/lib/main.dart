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
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
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
  // KIRISH BOSIMI
  final oldInPressure = TextEditingController();
  final newInPressure = TextEditingController();

  // CHIQISH BOSIMI
  final oldOutPressure = TextEditingController();
  final newOutPressure = TextEditingController();

  // GAZ SARFI
  final oldGasFlow = TextEditingController();
  final newGasFlow = TextEditingController();

  // HARORAT
  final oldTemp = TextEditingController();
  final newTemp = TextEditingController();

  // VIBRATSIYA
  final oldVibration = TextEditingController();
  final newVibration = TextEditingController();

  // RPM
  final oldRpm = TextEditingController();
  final newRpm = TextEditingController();

  String natija = 'Hali diagnostika qilinmadi';

  double? qiymat(TextEditingController c) {
    return double.tryParse(c.text.trim().replaceAll(',', '.'));
  }

  String tahlil(
    String nom,
    double oldValue,
    double newValue,
    String birlik,
  ) {
    final farq = newValue - oldValue;

    double foiz = 0;
    if (oldValue != 0) {
      foiz = (farq / oldValue) * 100;
    }

    String holat;

    if (farq > 0) {
      holat = 'OSHDI ↑';
    } else if (farq < 0) {
      holat = 'KAMAYDI ↓';
    } else {
      holat = 'O‘ZGARMADI';
    }

    return '''
$nom
Oldingi: ${oldValue.toStringAsFixed(2)} $birlik
Hozirgi: ${newValue.toStringAsFixed(2)} $birlik
Farq: ${farq.toStringAsFixed(2)} $birlik
O‘zgarish: ${foiz.toStringAsFixed(1)} %
Holat: $holat
''';
  }

  void diagnostika() {
    final inOld = qiymat(oldInPressure);
    final inNew = qiymat(newInPressure);

    final outOld = qiymat(oldOutPressure);
    final outNew = qiymat(newOutPressure);

    final gasOld = qiymat(oldGasFlow);
    final gasNew = qiymat(newGasFlow);

    final tempOld = qiymat(oldTemp);
    final tempNew = qiymat(newTemp);

    final vibOld = qiymat(oldVibration);
    final vibNew = qiymat(newVibration);

    final rpmOld = qiymat(oldRpm);
    final rpmNew = qiymat(newRpm);

    if (inOld == null ||
        inNew == null ||
        outOld == null ||
        outNew == null ||
        gasOld == null ||
        gasNew == null ||
        tempOld == null ||
        tempNew == null ||
        vibOld == null ||
        vibNew == null ||
        rpmOld == null ||
        rpmNew == null) {
      setState(() {
        natija = 'Barcha qiymatlarni to‘liq kiriting.';
      });
      return;
    }

    setState(() {
      natija =
          '${tahlil("KIRISH BOSIMI", inOld, inNew, "bar")}\n'
          '${tahlil("CHIQISH BOSIMI", outOld, outNew, "bar")}\n'
          '${tahlil("GAZ SARFI", gasOld, gasNew, "Nm³/h")}\n'
          '${tahlil("HARORAT", tempOld, tempNew, "°C")}\n'
          '${tahlil("VIBRATSIYA", vibOld, vibNew, "mm/s")}\n'
          '${tahlil("AYLANISH TEZLIGI", rpmOld, rpmNew, "RPM")}';
    });
  }

  void saqlash() {
    final inValue = qiymat(newInPressure);
    final outValue = qiymat(newOutPressure);
    final gasValue = qiymat(newGasFlow);
    final tempValue = qiymat(newTemp);
    final vibValue = qiymat(newVibration);
    final rpmValue = qiymat(newRpm);

    if (inValue == null ||
        outValue == null ||
        gasValue == null ||
        tempValue == null ||
        vibValue == null ||
        rpmValue == null) {
      setState(() {
        natija = 'Hozirgi sutka qiymatlarini to‘liq kiriting.';
      });
      return;
    }
setState(() {
      oldInPressure.text = inValue.toString();
      oldOutPressure.text = outValue.toString();
      oldGasFlow.text = gasValue.toString();
      oldTemp.text = tempValue.toString();
      oldVibration.text = vibValue.toString();
      oldRpm.text = rpmValue.toString();

      newInPressure.clear();
      newOutPressure.clear();
      newGasFlow.clear();
      newTemp.clear();
      newVibration.clear();
      newRpm.clear();

      natija =
          'QIYMATLAR SAQLANDI ✓\n\n'
          'Saqlangan qiymatlar keyingi sutka uchun '
          'oldingi qiymat sifatida o‘tkazildi.';
    });
  }

  Widget input(
    TextEditingController controller,
    String label,
    String birlik,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: label,
          suffixText: birlik,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget parametr(
    String nom,
    String birlik,
    TextEditingController oldController,
    TextEditingController newController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Text(
          nom,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        input(
          oldController,
          'Oldingi sutka',
          birlik,
        ),
        input(
          newController,
          'Hozirgi sutka',
          birlik,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI MUHANDIS'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Sutkalik diagnostika',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Sana: ${now.day}.${now.month}.${now.year}',
            style: const TextStyle(fontSize: 16),
          ),

          parametr(
            'Kirish bosimi',
            'bar',
            oldInPressure,
            newInPressure,
          ),

          parametr(
            'Chiqish bosimi',
            'bar',
            oldOutPressure,
            newOutPressure,
          ),

          parametr(
            'Gaz sarfi',
            'Nm³/h',
            oldGasFlow,
            newGasFlow,
          ),

          parametr(
            'Harorat',
            '°C',
            oldTemp,
            newTemp,
          ),

          parametr(
            'Vibratsiya',
            'mm/s',
            oldVibration,
            newVibration,
          ),

          parametr(
            'Aylanish tezligi',
            'RPM',
            oldRpm,
            newRpm,
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: FilledButton.icon(
              onPressed: diagnostika,
              icon: const Icon(Icons.analytics),
              label: const Text(
                'DIAGNOSTIKA QILISH',
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 55,
            child: OutlinedButton.icon(
              onPressed: saqlash,
              icon: const Icon(Icons.save),
              label: const Text(
                'QIYMATLARNI SAQLASH',
              ),
            ),
          ),

          const SizedBox(height: 25),
Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                natija,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
