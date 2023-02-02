import 'package:compras_vita_health/models/produto_model.dart';
import 'dart:convert';

List<UsuarioModel> usuarioFromJson(String str) => List<UsuarioModel>.from(json.decode(str).map((x) => UsuarioModel.fromJson(x)));

class UsuarioModel{
  int idusuario;
  String nome;
  String email;
  String senha;
  String celular;
  String usuarionome;
  String foto;
  List<ProdutoModel> produtos;
  // String perfils;
  // String produtos;
  // String saldos;

  UsuarioModel({
    required this.idusuario,
    required this.nome,
    required this.email,
    required this.senha,
    required this.celular,
    required this.usuarionome,
    required this.foto,
    required this.produtos,
    // required this.perfils,
    // required this.produtos,
    // required this.saldos,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json){
    print('chegou no model ${json}');
    // json['idusuario'];
    return UsuarioModel(
      idusuario: json['idusuario'] ?? 0, 
      nome: json['nome'] ?? '', 
      email: json['email']?? '', 
      senha: json['senha'] ?? '', 
      celular: json['celular'] ?? '', 
      usuarionome: json['usuarionome'] ?? '', 
      foto: json['foto'] ?? '', 
      produtos: List<ProdutoModel>.from(json['produtos']?.map((x) => ProdutoModel.fromJson(x))  ?? [])
    );
  }

  Map<String, dynamic> toJson() =>{
    "idusuario": idusuario,
     "nome" :nome,
     "email" :  email,
     "senha" :  senha,
     "celular" :  celular,
     "usuarionome" :  usuarionome,
     "foto" :  foto,
  };
}