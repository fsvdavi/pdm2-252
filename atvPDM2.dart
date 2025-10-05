import 'dart:convert';

// Classes com toJson implementado
class Dependente {
  final String _nome;
  Dependente(this._nome);

  Map<String, dynamic> toJson() => {'nome': _nome};

  @override
  String toString() => 'Dependente(nome: $_nome)';
}

class Funcionario {
  final String _nome;
  final List<Dependente> _dependentes;
  Funcionario(this._nome, this._dependentes);

  Map<String, dynamic> toJson() => {
        'nome': _nome,
        'dependentes': _dependentes.map((d) => d.toJson()).toList(),
      };

  @override
  String toString() =>
      'Funcionario(nome: $_nome, dependentes: ${_dependentes.length})';
}

class EquipeProjeto {
  final String _nomeProjeto;
  final List<Funcionario> _funcionarios;
  EquipeProjeto(this._nomeProjeto, this._funcionarios);

  Map<String, dynamic> toJson() => {
        'nomeProjeto': _nomeProjeto,
        'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
      };

  @override
  String toString() =>
      'EquipeProjeto(nomeProjeto: $_nomeProjeto, funcionarios: ${_funcionarios.length})';
}

void main() {
  // Criando dependentes
  var dep1 = Dependente('Angelo');
  var dep2 = Dependente('Fabio');
  var dep3 = Dependente('Franco');
  var dep4 = Dependente('Gusta');

  // Funcionários e associação de dependentes
  var func1 = Funcionario('Enzo', [dep1, dep2]);
  var func2 = Funcionario('Viana', [dep3, dep4]);

  var funcionarios = [func1, func2];
  var equipe = EquipeProjeto('DuplaEnzoViana', funcionarios);

  // Print JSON bonitinho
  var encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert(equipe.toJson()));
}