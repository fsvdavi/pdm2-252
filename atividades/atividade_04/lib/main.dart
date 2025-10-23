import 'package:flutter/material.dart';

void main() {
  runApp(const AppTarefas());
}

class AppTarefas extends StatelessWidget {
  const AppTarefas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<String> _tarefas = [];
  final TextEditingController _controlador = TextEditingController();

  void _adicionarTarefa() {
    if (_controlador.text.trim().isEmpty) return;
    setState(() {
      _tarefas.add(_controlador.text.trim());
      _controlador.clear();
    });
  }

  void _editarTarefa(int index) async {
    final textoAntigo = _tarefas[index];
    final novoTexto = await showDialog<String>(
      context: context,
      builder: (context) {
        final ctrl = TextEditingController(text: textoAntigo);
        return AlertDialog(
          title: const Text('Editar tarefa'),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nova descrição'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(onPressed: () => Navigator.pop(context, ctrl.text), child: const Text('Salvar')),
          ],
        );
      },
    );

    if (novoTexto != null && novoTexto.trim().isNotEmpty) {
      setState(() {
        _tarefas[index] = novoTexto.trim();
      });
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controlador,
                    decoration: const InputDecoration(
                      labelText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                return Card(
                  child: ListTile(
                    title: Text(tarefa),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => _editarTarefa(index), icon: const Icon(Icons.edit)),
                        IconButton(onPressed: () => _removerTarefa(index), icon: const Icon(Icons.delete)),
                      ],
                    ),
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
