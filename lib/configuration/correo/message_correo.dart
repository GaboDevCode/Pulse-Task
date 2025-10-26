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
    final String asunto = Uri.encodeComponent(_asuntoCtrl.text);
    final String mensaje = Uri.encodeComponent(_mensajeCtrl.text);

    final Uri mailto = Uri.parse('xxxxxxxxxxx');

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
      appBar: AppBar(title: const Text('Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _asuntoCtrl,
              decoration: const InputDecoration(labelText: 'Asunto'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _mensajeCtrl,
                decoration: const InputDecoration(labelText: 'Mensaje'),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Enviar'),
              onPressed: _enviarEmail,
            ),
          ],
        ),
      ),
    );
  }
}
