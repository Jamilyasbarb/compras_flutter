import 'package:compras_vita_health/models/produto_model.dart';
import 'package:http/http.dart' as http;

class ProdutoService{
  Future<List<ProdutoModel>> getProdutos() async{
    var response = await http.get(Uri.parse('https://apivitahealth.azurewebsites.net/api/Produtos'));
     if(response.statusCode == 200){
      return produtoFromJson(response.body);
     }else{
      throw Exception('Failed to load produto');
     }
  }
}