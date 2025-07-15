import 'package:flutter/material.dart';
import 'package:flutter_shtrih_fr_ffi/flutter_shtrih_fr_ffi.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Strih-FR Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StrihFrDemoScreen(),
    ),
  );
}

class StrihFrDemoScreen extends StatefulWidget {
  const StrihFrDemoScreen({super.key});

  @override
  State<StrihFrDemoScreen> createState() => _StrihFrDemoScreenState();
}

class _StrihFrDemoScreenState extends State<StrihFrDemoScreen> {
  final FlutterStrihFrFFI _strihFr = FlutterStrihFrFFI();

  static const int _comNumber = 8;
  static const int _baudRate = 115200;
  static const int _timeout = 1000;
  static const int _operatorPassword = 30;

  String _status = 'Ready';

  ConnectionParams get _reportParams => ConnectionParams(
    comNumber: _comNumber,
    baudRate: _baudRate,
    timeout: _timeout,
    operatorPassword: _operatorPassword,
  );

  List<ItemModel> get _examplePositions => [
    ItemModel(name: 'Child', price: 100, quantity: 3),
    ItemModel(name: 'Adult', price: 150, quantity: 4),
    ItemModel(name: 'Student', price: 300, quantity: 5),
  ];

  int get _totalSum => _examplePositions.fold<int>(
    0,
    (sum, item) => sum + item.price * item.quantity,
  );

  Future<void> _run(
    Future<void> Function() action,
    String successMessage,
  ) async {
    setState(() => _status = 'Running...');
    try {
      await action();
      setState(() => _status = successMessage);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    } catch (e) {
      final msg = 'Error: ${e.toString()}';
      setState(() => _status = msg);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Strih-FR Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Status: $_status', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  () => _run(
                    () => _strihFr.printReportWithoutCleaning(
                      reportParams: _reportParams,
                    ),
                    'Report without cleaning printed',
                  ),
              child: const Text('Report without cleaning'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => _run(
                    () => _strihFr.printReportWithCleaning(
                      reportParams: _reportParams,
                    ),
                    'Report with cleaning printed',
                  ),
              child: const Text('Report with cleaning'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => _run(
                    () => _strihFr.saleAndCloseCheck(
                      reportParams: _reportParams,
                      discounts: _examplePositions,
                      totalSumm1: _totalSum,
                      totalSumm2: 0,
                      totalSumm3: 0,
                      totalSumm4: 0,
                      department: 1,
                      tax1: 0,
                      tax2: 0,
                      tax3: 0,
                      tax4: 0,
                      discountOnCheck: 0.0,
                    ),
                    'Sale & CloseCheck done',
                  ),
              child: const Text('Sale + CloseCheck'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => _run(
                    () => _strihFr.returnSale(
                      reportParams: _reportParams,
                      discounts: _examplePositions,
                      totalSumm1: _totalSum,
                      totalSumm2: 0,
                      totalSumm3: 0,
                      totalSumm4: 0,
                      department: 1,
                      tax1: 0,
                      tax2: 0,
                      tax3: 0,
                      tax4: 0,
                      discountOnCheck: 0.0,
                    ),
                    'ReturnSale done',
                  ),
              child: const Text('Return Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
