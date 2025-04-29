import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});
  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _asuntoCtrl = TextEditingController();
  final _mensajeCtrl = TextEditingController();

  Future<void> _enviarEmail() async {
    final mailto = Uri(
      scheme: 'mailto',
      path: 'kr4v3n27@gmail.com',
      queryParameters: {'subject': _asuntoCtrl.text, 'body': _mensajeCtrl.text},
    );
    if (!await launchUrl(mailto, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir la app de correo.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _asuntoCtrl,
              decoration: InputDecoration(labelText: 'Asunto'),
            ),
            SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _mensajeCtrl,
                decoration: InputDecoration(labelText: 'Mensaje'),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Enviar'),
              onPressed: _enviarEmail,
            ),
          ],
        ),
      ),
    );
  }
}
