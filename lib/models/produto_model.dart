import 'dart:convert';

List<ProdutoModel> produtoFromJson(String str) => List<ProdutoModel>.from(json.decode(str).map((x) => ProdutoModel.fromJson(x)));
String produtoToJson(List<ProdutoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    // print('----------produtoooooo $json');
    return ProdutoModel(
      idproduto: json['idproduto'], 
      nome: json['nome'], 
      descricao: json['descricao'], 
      valor: json['valor'], 
      foto: json['foto'], 
      usuarioIdusuario: json['usuarioIdusuario']
    );
  }

  Map<String, dynamic> toJson() =>{
    'idproduto' : idproduto,
    'nome': nome,
    'descricao': descricao,
    'valor': valor,
    'foto': foto,
    'usuarioIdUsuario': usuarioIdusuario
  };
}