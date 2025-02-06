class SuiteModel {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<ItemModel> itens;
  final List<CategoriaItemModel> categoriaItens;
  final List<PeriodoModel> periodos;

  SuiteModel({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      nome: json['nome'] ?? '',
      qtd: json['qtd'] ?? 0,
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: (json['itens'] as List?)?.map((item) => ItemModel.fromJson(item)).toList() ?? [],
      categoriaItens: (json['categoriaItens'] as List?)?.map((item) => CategoriaItemModel.fromJson(item)).toList() ?? [],
      periodos: (json['periodos'] as List?)?.map((periodo) => PeriodoModel.fromJson(periodo)).toList() ?? [],
    );
  }
}

class ItemModel {
  final String nome;

  ItemModel({required this.nome});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(nome: json['nome'] ?? '');
  }
}

class CategoriaItemModel {
  final String nome;
  final String icone;

  CategoriaItemModel({required this.nome, required this.icone});

  factory CategoriaItemModel.fromJson(Map<String, dynamic> json) {
    return CategoriaItemModel(
      nome: json['nome'] ?? '',
      icone: json['icone'] ?? '',
    );
  }
}

class PeriodoModel {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final DescontoModel? desconto;

  PeriodoModel({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory PeriodoModel.fromJson(Map<String, dynamic> json) {
    return PeriodoModel(
      tempoFormatado: json['tempoFormatado'] ?? '',
      tempo: json['tempo'] ?? '',
      valor: (json['valor'] ?? 0.0).toDouble(),
      valorTotal: (json['valorTotal'] ?? 0.0).toDouble(),
      temCortesia: json['temCortesia'] ?? false,
      desconto: json['desconto'] != null ? DescontoModel.fromJson(json['desconto']) : null,
    );
  }
}

class DescontoModel {
  final double desconto;

  DescontoModel({required this.desconto});

  factory DescontoModel.fromJson(Map<String, dynamic> json) {
    return DescontoModel(desconto: (json['desconto'] ?? 0.0).toDouble());
  }
} 