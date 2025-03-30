import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  ///*************  ✨ Codeium Command ⭐  *************/
  /// The main entrypoint for the application.
  ///
  /// This function is called when the application is started, and it sets up
  /// the application's UI and starts the application.
  ///******  4ea61c1b-c865-4361-afa1-3425c4050c67  *******/
void main() {
  /// Run the application.
  ///
  /// This function is called when the application is started, and it sets up
  /// the application's UI and starts the application.
  runApp(const CBCCalcApp());
}

class CBCCalcApp extends StatelessWidget {
  const CBCCalcApp({super.key});

  @override
///*************  ✨ Codeium Command ⭐  *************/
  /// Builds the application's UI.
  ///
  /// This function is called when the application is started, and it sets up
  /// the application's UI and starts the application.
  ///
  /// The application is a [MaterialApp] with a red color scheme and a light
  /// theme. The home page is a [CBCForm].
  ///
  /// The [MaterialApp] is the root widget of the application, and it contains
  /// the application's UI. The [CBCForm] is the home page of the application,
  /// and it contains the UI for the CBC calculator.
///******  4ea61c1b-c865-4361-afa1-3425c4050c67  *******/
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBC-Calc',
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
  ///
  /// The dialog is built using the [AlertDialog] widget, which provides a
  /// standard dialog layout with a title, content and actions.
  ///
  /// The dialog is shown using the [showDialog] function, which takes the
  /// context and the builder function as parameters. The builder function
  /// returns the [AlertDialog] widget to be displayed.
void _showInfoDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('ℹ️ Über CBC-Calc'),
      content: const Text(
        'Diese App dient der unterstützenden Berechnung hämatologischer Parameter bei schwierigen Proben.\n\n'
        '⚠️ Disclaimer: Kein Medizinprodukt! Kein Ersatz für Diagnose, Labor oder Fachmeinung. ⚠️\n\n'
        '🔐 Diese App verarbeitet eingegebene Werte ausschließlich lokal auf dem Gerät. \n'
        'Es werden keine Daten an Dritte weitergegeben oder gespeichert.\n'
        'Es werden keine personenbezogenen Daten erfasst.🔐\n'
        'Version: 1.0.2\n'
        'GitHub: github.com/Sierra-Bravo-ger/CBC-Calc\n'
        'Entwickler: Bride, Sebastian',
        textAlign: TextAlign.start,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Schließen'),
        ),
      ],
    ),
  );
}

  final _rbcController = TextEditingController();
  final _hktController = TextEditingController();
  final _hbController = TextEditingController();

  double? mcv;
  double? mch;
  double? mchc;

///*************  ✨ Codeium Command ⭐  *************///
  /// Calculates the mean corpuscular volume (MCV), mean corpuscular hemoglobin
  /// (MCH) and mean corpuscular hemoglobin concentration (MCHC) based on the
  /// input values for red blood cells (RBCs), hemoglobin (Hb) and hematocrit
  /// (Hct).
  ///
  /// The calculations are performed as follows:
  ///
  /// MCV = (Hct * 10) / RBC
  /// MCH = (Hb * 10) / RBC
  /// MCHC = (Hb * 100) / Hct
  ///
  /// The results are stored in the state variables [mcv], [mch] and [mchc].
///******  575e28ac-bf87-4a5c-9c88-6080ee12674a  *******///
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

///*************  ✨ Codeium Command ⭐  *************/
  /// Resets all input fields and state variables to their initial state.
  ///
  /// This method is called when the user clicks the "Zurücksetzen" button.
///******  b80c3f3a-aedd-47a3-b062-922bee5452a6  *******/
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
///*************  ✨ Codeium Command ⭐  *************/
  /// Releases the resources used by the [_CBCFormState].
  ///
  /// This method is called when the [StatefulWidget] is removed from the
  /// widget tree.
  ///
  /// It disposes of the [TextEditingController]s used by the input fields,
  /// and then calls [State.dispose].
///******  c9bece9b-25f2-4939-8267-1eda2da0a2e0  *******/
  void dispose() {
    _rbcController.dispose();
    _hktController.dispose();
    _hbController.dispose();
    super.dispose();
  }

///*************  ✨ Codeium Command ⭐  *************/
  /// Returns a color to highlight the MCHC value in the result box based on
  /// the value of [mchc].
  ///
  /// If [mchc] is null, returns null. Otherwise, returns a color based on the
  /// value of [mchc]:
  ///
  /// - `Colors.red.shade100` if [mchc] is 38 or greater.
  /// - `Colors.orange.shade100` if [mchc] is greater than 36.5 but less than
  ///   38.
  /// - null otherwise.
//******  1d6acafb-007a-4946-ac2f-b38be6f6180f  *******/
  Color? _getHighlightColor() {
    if (mchc != null) {
      if (mchc! >= 38) return Colors.red.shade100;
      if (mchc! > 36.5) return Colors.orange.shade100;
    }
    return null;
  }

///*************  ✨ Codeium Command ⭐  *************/
  /// Returns a legend explaining the colors used to highlight the MCHC value
  /// in the result box.
  ///
  /// The legend consists of a column with two rows. The first row shows a
  /// square with `Colors.orange.shade100` color and the text 'MCHC > 36,5'.
  /// The second row shows a square with `Colors.red.shade100` color and the
  /// text 'MCHC ≥ 38'.
  ///
  /// The legend is used in the information box in the result page.
///******  3beb74b4-9c67-408e-90f4-55a6e68d3318  *******/
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

///*************  ✨ Codeium Command ⭐  *************/
  /// Builds the information box that is displayed below the result box.
  ///
  /// The box contains a list of potential causes for a high MCHC value and
  /// a description of strategies for identifying the cause.
  ///
  /// It is displayed in the result page.
///******  8b10cd66-f6d9-4354-9066-8107cce4fd91  *******/
  ///
  /// The box is built using a [Column] widget with a [SingleChildScrollView]
  /// to allow scrolling if the content is too long to fit on the screen.
  /// The box contains two sections: "mögliche Ursachen" and "Strategien zur
  /// Identifikation der Ursache". Each section contains a list of items with
  /// explanations.
  /// The items are displayed using a [RichText] widget with [TextSpan]s to
  /// apply different styles to the text.
Widget _buildInfoBox() {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'mögliche Ursachen:📰',
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
              textAlign: TextAlign.start,
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
            'Strategien zur Identifikation der Ursache:🔍',
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
              textAlign: TextAlign.start,
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
                  TextSpan(text: '• Vorverdünnung der Probe 1:7', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' führt ebenfalls zu Reduktion der HIL-Interferenzen\n'),
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
///*************  ✨ Codeium Command ⭐  *************/
  /// Builds the user interface of the application.
  ///
  /// This function is called when the application is started, and it sets up
  /// the application's UI and starts the application.
  ///
  /// The application is a [MaterialApp] with a red color scheme and a light
  /// theme. The home page is a [Scaffold] with an [AppBar] and a [Column]
  /// containing the input fields, the result fields, and the buttons.
  ///
  /// The input fields are [TextField]s with [TextEditingController]s, which
  /// are used to update the values of the input fields when the user enters
  /// text. The result fields are also [TextField]s with [TextEditingController]s,
  /// but they are read-only and are updated when the user presses the "Berechnen"
  /// button. The buttons are [ElevatedButton]s with an [onPressed] callback that
  /// is called when the button is pressed.
  ///
  /// The [KeyboardListener] is used to detect when the user presses the Enter
  /// key, which triggers the "Berechnen" button's [onPressed] callback.
  ///
  /// The [Padding] is used to add a margin around the [Column] to prevent the
  /// input fields and buttons from being too close to the edge of the screen.
///******  517574e1-d477-40c1-85b0-274828756e7a  *******/
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: 'Info',
          onPressed: _showInfoDialog,
        ),
      ],
      title: Row(
        children: [
          Image.asset(
            'assets/icon.png',
            height: 28,
          ),
          const SizedBox(width: 8),
          const Text('CBC-Calc'),
        ],
      ),
    ),
    body: KeyboardListener(
      focusNode: FocusNode(), // FocusNode für den KeyboardListener
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
          _calculate(); // Berechnung auslösen, wenn Enter gedrückt wird
        }
      },
      child: Padding(
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
                          labelText: '🩸 RBC (Mio/µl)',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _calculate(), // Berechnung bei Enter
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _hbController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: '💉 HB (g/dl)',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _calculate(), // Berechnung bei Enter
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _hktController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: '🧪 HKT (%)',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _calculate(), // Berechnung bei Enter
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
                        focusNode: FocusNode(skipTraversal: true), // FocusNode für den TextField
                        controller: TextEditingController(
                          text: mcv != null ? mcv!.toStringAsFixed(2) : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: '↔ MCV (fl)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        focusNode: FocusNode(skipTraversal: true), // FocusNode für den TextField
                        controller: TextEditingController(
                          text: mch != null ? mch!.toStringAsFixed(2) : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: '⚖ MCH (pg)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        focusNode: FocusNode(skipTraversal: true), // FocusNode für den TextField
                        controller: TextEditingController(
                          text: mchc != null
                              ? (mchc! >= 38 ? '⚠️ ${mchc!.toStringAsFixed(2)}' : mchc!.toStringAsFixed(2))
                              : '',
                        ),
                        decoration: InputDecoration(
                          labelText: '📊 MCHC (g/dl)',
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
                  child: const Text('🧮 Berechnen'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(140, 48)),
                  child: const Text('🔄 Zurücksetzen'),
                ),
              ],
            ),
            _buildInfoBox(),
          ],
        ),
      ),
    ),
  );
}
}
// This is a simple Flutter app that calculates and displays hematological parameters based on user input.