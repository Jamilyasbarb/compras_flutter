import 'dart:convert';

List<ProdutoModel> produtoFromJson(String str) => List<ProdutoModel>.from(json.decode(str).map((x) => ProdutoModel.fromJson(x)));

class ProdutoModel{
  int idproduto;
  String nome;
  String descricao;
  double valor;
  String foto;
  int usuarioIdusuario;
  // String usuarioIdusuarioNavigation;

  ProdutoModel({
    required this.idproduto,
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.foto,
    required this.usuarioIdusuario,
    // required this.usuarioIdusuarioNavigation,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json){
    return ProdutoModel(
      idproduto: json['idproduto'], 
      nome: json['nome'], 
      descricao: json['descricao'], 
      valor: json['valor'], 
      foto: json['foto'], 
      usuarioIdusuario: json['usuarioIdusuario']
    );
  }
}