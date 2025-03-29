import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CBCCalcApp());
}

class CBCCalcApp extends StatelessWidget {
  const CBCCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBC Calc',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        brightness: Brightness.light,
      ),
      home: const CBCForm(),
    );
  }
}

class CBCForm extends StatefulWidget {
  const CBCForm({super.key});

  @override
  State<CBCForm> createState() => _CBCFormState();
}

class _CBCFormState extends State<CBCForm> {
  final _rbcController = TextEditingController();
  final _hktController = TextEditingController();
  final _hbController = TextEditingController();

  double? mcv;
  double? mch;
  double? mchc;

  void _calculate() {
    final rbc = double.tryParse(_rbcController.text.replaceAll(',', '.'));
    final hkt = double.tryParse(_hktController.text.replaceAll(',', '.'));
    final hb = double.tryParse(_hbController.text.replaceAll(',', '.'));

    if (rbc != null && hkt != null && hb != null && rbc != 0 && hkt != 0) {
      setState(() {
        mcv = (hkt * 10) / rbc;
        mch = (hb * 10) / rbc;
        mchc = (hb * 100) / hkt;
      });
    }
  }

  void _reset() {
    _rbcController.clear();
    _hktController.clear();
    _hbController.clear();
    setState(() {
      mcv = null;
      mch = null;
      mchc = null;
    });
  }

  @override
  void dispose() {
    _rbcController.dispose();
    _hktController.dispose();
    _hbController.dispose();
    super.dispose();
  }

  Color? _getHighlightColor() {
    if (mchc != null) {
      if (mchc! >= 38) return Colors.red.shade100;
      if (mchc! > 36.5) return Colors.orange.shade100;
    }
    return null;
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Legende MCHC:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(children: [
          Container(width: 16, height: 16, color: Colors.orange.shade100),
          const SizedBox(width: 8),
          const Text('MCHC > 36,5')
        ]),
        const SizedBox(height: 4),
        Row(children: [
          Container(width: 16, height: 16, color: Colors.red.shade100),
          const SizedBox(width: 8),
          const Text('MCHC ≥ 38')
        ]),
      ],
    );
  }

Widget _buildInfoBox() {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Ursachen:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: Colors.black, height: 2),
                children: [
                  TextSpan(text: '• '),
                  TextSpan(text: 'Kälteagglutinine', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' (Artefakt durch Zellaggregation)\n'),
                  TextSpan(text: '• '),
                  TextSpan(text: 'Hämolyse, Ikterus, Lipämie\n', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   Farbumschlag der Probe → photometrische Interferenz\n'),
                  TextSpan(text: '• Dehydratation (selten, führt eher zu relativer Erhöhung)\n'),
                  TextSpan(text: '• Technische Fehler oder Probenfehler (z. B. Hämolyse in vitro, falsche Probevolumen)\n'),
                  TextSpan(text: '• RBC verändert aufgrund besonderer Bedingungen (z.B. osmotische) in der Probe durch: Hyponatriämie, Glucosämie, Chemo-Therapie, Alkohole, großflächige Verbrennungen\n'),
                  TextSpan(text: '• '),
                  TextSpan(text: 'Sphärozytose (hereditär)', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' ← Erhöhter MCHC Wert ist tatsächlich korrekt, Bestätigung per Ausstrich\n'),
                  TextSpan(text: '• '),
                  TextSpan(text: 'Sichelzellen', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' ← Erhöhter MCHC Wert ist tatsächlich korrekt, Bestätigung per Ausstrich'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Strategien zur Identifikation der Ursache:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: Colors.black, height: 2),
                children: [
                  TextSpan(text: '• Kälteagglutinine ausschließen\n'),
                  TextSpan(text: '    → Probe bis zu 1h bei 37°C erwärmen und warm messen\n'),
                  TextSpan(text: '          + Normales Plasma → '),
                  TextSpan(text: 'RBC-O', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' verwenden\n'),
                  TextSpan(text: '          + Abnormales Plasma → '),
                  TextSpan(text: 'RBC-O, HB-O, MCHC-O', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' verwenden\n'),
                  TextSpan(text: '• Neue Blutprobe anfordern\n'),
                  TextSpan(text: '   → bei Verdacht auf Präanalytikfehler\n'),
                  TextSpan(text: '• Wenn Plasma abnormal kann Plasmaersatz verwendet werden → Waschmedium NaCl oder DCL,\n'),
                  TextSpan(text: '   bei starker Lipämie sinnvoll, Ikterus schwer waschbar\n'),
                  TextSpan(text: '   Zusätzlich '),
                  TextSpan(text: 'HB-O', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' verwenden \n'),
                  TextSpan(text: '• Hämolyse-Diagnostik ergänzen\n'),
                  TextSpan(text: '    → z. B. LDH, Haptoglobin, FRC% aus dem RET-Kanal\n'),
                  TextSpan(text: '     Zusätzlich '),
                  TextSpan(text: 'HB-O', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' verwenden \n'),
                  TextSpan(text: '• Nachweis einer RBC-Erkrankung per Blutausstrich\n'),
                  TextSpan(text: '• Messgerät kalibrieren/prüfen → bei systematisch erhöhten Werten\n'),
                  TextSpan(text: '• Ergebnisse im Kontext beurteilen → Vergleich mit WBC-Zahl (extrem hoch oder extrem niedrig?), Station (Onkologie?) Grunderkrankung mit Auswirkung auf die Proteinzusammensetzung im Blut?'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CBC Calc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _rbcController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'RBC (Mio/µl)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _hbController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'HB (g/dl)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _hktController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'HKT (%)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 180,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: mcv != null ? mcv!.toStringAsFixed(2) : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'MCV (fl)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: mch != null ? mch!.toStringAsFixed(2) : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'MCH (pg)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: mchc != null ? mchc!.toStringAsFixed(2) : '',
                        ),
                        decoration: InputDecoration(
                          labelText: 'MCHC (g/dl)',
                          border: const OutlineInputBorder(),
                          fillColor: _getHighlightColor(),
                          filled: _getHighlightColor() != null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildLegend(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(140, 48)),
                  child: const Text('Berechnen'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(140, 48)),
                  child: const Text('Zurücksetzen'),
                ),
              ],
            ),
            _buildInfoBox(),
          ],
        ),
      ),
    );
  }
}
