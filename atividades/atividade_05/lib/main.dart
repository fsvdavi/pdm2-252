import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; // gera palavras aleatórias

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Primeiro App Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int indiceAtual = 0;
  final _favoritos = <WordPair>[]; // lista de palavras favoritas

  @override
  Widget build(BuildContext context) {
    final paginas = [
      PaginaHome(
        favoritos: _favoritos,
        aoAlternarFavorito: _alternarFavorito,
      ),
      PaginaFavoritos(favoritos: _favoritos),
    ];

    return Scaffold(
      body: paginas[indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
        ],
        onTap: (index) {
          setState(() {
            indiceAtual = index;
          });
        },
      ),
    );
  }

  void _alternarFavorito(WordPair palavra) {
    setState(() {
      if (_favoritos.contains(palavra)) {
        _favoritos.remove(palavra);
      } else {
        _favoritos.add(palavra);
      }
    });
  }
}

class PaginaHome extends StatefulWidget {
  final List<WordPair> favoritos;
  final Function(WordPair) aoAlternarFavorito;

  const PaginaHome({
    super.key,
    required this.favoritos,
    required this.aoAlternarFavorito,
  });

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  final _sugestoes = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feito por Davi Viana '),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _sugestoes.length) {
            _sugestoes.addAll(generateWordPairs().take(10));
          }
          final palavra = _sugestoes[index];
          final jaFavorita = widget.favoritos.contains(palavra);

          return ListTile(
            title: Text(palavra.asPascalCase),
            trailing: Icon(
              jaFavorita ? Icons.favorite : Icons.favorite_border,
              color: jaFavorita ? Colors.red : null,
            ),
            onTap: () => widget.aoAlternarFavorito(palavra),
          );
        },
      ),
    );
  }
}

class PaginaFavoritos extends StatelessWidget {
  final List<WordPair> favoritos;

  const PaginaFavoritos({super.key, required this.favoritos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palavras Favoritas '),
        centerTitle: true,
      ),
      body: ListView(
        children: favoritos
            .map((palavra) => ListTile(title: Text(palavra.asPascalCase)))
            .toList(),
      ),
    );
  }
}
