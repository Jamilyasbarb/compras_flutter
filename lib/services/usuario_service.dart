import 'package:compras_vita_health/models/usuario_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioService{

  Future<UsuarioModel> getUsuario() async{
    var response = await http.get(Uri.parse('https://apivitahealth.azurewebsites.net/api/Usuarios/1'));
    if(response.statusCode == 200){
      var json = response.body;
      print('json normal$json');
      print('json decode${jsonDecode(json)}');
      return UsuarioModel.fromJson(jsonDecode(json));
    }else{
      throw Exception('Falha ao carregar api usuario');
    }
  }
}