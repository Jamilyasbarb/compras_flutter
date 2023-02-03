import 'package:compras_vita_health/models/produto_model.dart';
import 'package:compras_vita_health/models/usuario_model.dart';
import 'package:compras_vita_health/services/usuario_service.dart';
import 'package:flutter/cupertino.dart';

List<ProdutoModel> listaProdutos = [];

class ProdutoController extends ChangeNotifier{
  int id = 0;
  String nome = '';
  String descricao = '';
  double valor = 0;
  String foto = '';
  List filtrada = [];
  List<UsuarioModel>?usuario;
  List<bool> registrado = List<bool>.filled(listaProdutos.length, false);
  
  ProdutoController(){
    getUsuario();
  }

  addProduto(){
    ProdutoModel produto = ProdutoModel(idproduto: id, nome: nome, descricao: descricao, valor: valor, foto: foto, usuarioIdusuario: 1);
    id++;
    listaProdutos.add(produto);
    print(listaProdutos[0]);
    notifyListeners();
  }

  getUsuario()async{
    usuario = await UsuarioService().getUsuario();
  }
  produtoRegistrado(){
    // filtrada = listaProdutos.where((element) => element.idproduto == usuario![0].produtos[0].idproduto);
  }

}