import 'package:compras_vita_health/models/produto_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

List<ProdutoModel> listaProdutos = [];

class ProdutoController extends ChangeNotifier{
  int id = 0;
  String nome = '';
  String descricao = '';
  double valor = 0;
  String foto = '';
  double wsCoins = 400;
  File? imagem;
  

  addProduto(){
    ProdutoModel produto = ProdutoModel(idproduto: id, nome: nome, descricao: descricao, valor: valor, foto: foto, usuarioIdusuario: 2);
    id++;
    listaProdutos.add(produto);
    notifyListeners();
  }


  Future pickerImage(ImageSource source)async{
    final imagem = await ImagePicker().pickImage(source: source);
    try {
      if(imagem == null) return;
    
      final imagemTemporaria = File(imagem.path);
      print(imagemTemporaria);
      this.imagem = imagemTemporaria;
      notifyListeners();
    } catch (e) {
      print('Falha ao carregar a imagem: $e');
    }
  }

  adquirirProduto(int index){
    wsCoins-=listaProdutos[index].valor;
    listaProdutos.removeAt(index);
    notifyListeners();
  }

  excluirProduto(int index){
    listaProdutos.removeAt(index);
    wsCoins+=listaProdutos[index].valor;
    notifyListeners();
  }
}