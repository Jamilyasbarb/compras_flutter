import 'package:compras_vita_health/models/produto_model.dart';
import 'package:flutter/cupertino.dart';

List<ProdutoModel> listaProdutos = [
  ProdutoModel(idproduto: 0, nome: 'Geladeira', descricao: 'Gela muito bem, é de inox ', valor: 2500, foto: 'foto.jpg', usuarioIdusuario: 2),
  ProdutoModel(idproduto: 0, nome: 'Microondas', descricao: 'Bem espaçosa, é de inox ', valor: 500, foto: 'foto.jpg', usuarioIdusuario: 2),
  ProdutoModel(idproduto: 0, nome: 'Garrafa', descricao: 'Bem pequena para caber na sua bolsa', valor: 50, foto: 'foto.jpg', usuarioIdusuario: 2),
  ProdutoModel(idproduto: 0, nome: 'Teclado', descricao: 'Teclado mecânico, switch red', valor: 2500, foto: 'foto.jpg', usuarioIdusuario: 2),
  ProdutoModel(idproduto: 0, nome: 'Mouse', descricao: 'Muito rápido', valor: 2500, foto: 'foto.jpg', usuarioIdusuario: 2),
];

class ProdutoController extends ChangeNotifier{
  int id = 0;
  String nome = '';
  String descricao = '';
  double valor = 0;
  String foto = '';
  

  addProduto(){
    print('---------- passei no controller');
    ProdutoModel produto = ProdutoModel(idproduto: id, nome: nome, descricao: descricao, valor: valor, foto: foto, usuarioIdusuario: 1);
    id++;
    listaProdutos.add(produto);
    print(listaProdutos[0]);
    notifyListeners();
  }
}