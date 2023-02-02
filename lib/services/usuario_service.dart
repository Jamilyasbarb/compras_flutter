import 'package:compras_vita_health/models/usuario_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioService{

  Future<List<UsuarioModel>> getUsuario() async{
    var response = await http.get(Uri.parse('https://apivitahealth.azurewebsites.net/api/Usuarios/1'));
    if(response.statusCode == 200){
      var json = response.body;
      print('KGe: json array ${jsonDecode(json)['value']}');
      var agoraVai = jsonDecode(json)['value'];
      var sera = jsonEncode(agoraVai);
      print('----milyyyyyy $sera');
      return usuarioFromJson(sera);
    }else{
      throw Exception('Falha ao carregar api usuario');
    }
  }
}