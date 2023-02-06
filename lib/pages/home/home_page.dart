import 'dart:async';

import 'package:compras_vita_health/controllers/produto_controller.dart';
import 'package:compras_vita_health/models/produto_model.dart';
import 'package:compras_vita_health/models/usuario_model.dart';
import 'package:compras_vita_health/services/produto_service.dart';
import 'package:compras_vita_health/services/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<ProdutoModel>? produtos;
  List<UsuarioModel>? usuario;
  // UsuarioModel? usuario;
  List<ProdutoModel> produtosCadastrados = [];
  bool sucessConection = false;
  List<bool> cadastrado = [];

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getListaProduto();
    getUsuario();
    getConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  getListaProduto()async{
    produtos = await ProdutoService().getProdutos();
    if(produtos != null){
      if(listaProdutos.isEmpty){
        for (var i = 0; i < produtos!.length; i++) {
          listaProdutos.add(produtos![i]);
        }
      }
      setState(() {
        sucessConection = true;
        cadastrado = List<bool>.filled(listaProdutos.length, false);
      });
    }
  }
  getUsuario()async{
    usuario = await UsuarioService().getUsuario();
    if(usuario != null){
      setState(() {
        sucessConection = true;
      });
    }
  }

  usuarioCadastrou(){
    for (var i = 0; i < listaProdutos.length; i++) {
      if(listaProdutos[i].usuarioIdusuario == usuario![0].idusuario){
        cadastrado[i] = true;
      }
    }
  }

  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
    (ConnectivityResult result) async{
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if(!isDeviceConnected && isAlertSet ==false){
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    }
  );

  showDialogBox() => showCupertinoDialog(
    context: context, 
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('Falha ao se conectar com a internet'),
        actions: [
          TextButton(
            onPressed: () async{
              Navigator.pop(context, 'cu');
              isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                setState(() {
                  isAlertSet = true;
                });
              }
            }, 
            child: Text('Ok')
          ),
        ],
      );
    },
  ); 
  
  @override
  Widget build(BuildContext context) {

  final controller = context.watch<ProdutoController>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Loja de Produtos'),
      ),
      body: Center(
        child: Visibility(
          visible: sucessConection,
          replacement: CircularProgressIndicator(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Disponivel: W\$ ${controller.wsCoins}'),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('cadastro');
                        }, 
                        child: Text('Adicionar'))
                    ],
                  ),
                  listaProdutos.isEmpty ? 
                  Container(color: Colors.purple, 
                    child:Text('jajdi'),
                  ): Expanded(
                    child: ListView.builder(
                      itemCount: listaProdutos.length,
                      itemBuilder: (context, index) {
                        print(usuarioCadastrou());
                        return Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              elevation: 7,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Image.asset('assets/images/icone.png', width: 150, )
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            children: [
                                              Text('${listaProdutos[index].nome}', style: Theme.of(context).textTheme.titleLarge),
                                              Text('${listaProdutos[index].descricao}', textAlign: TextAlign.center,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  cadastrado[index] ? Container(
                                    margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red
                                    ),
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () => showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirma a exclusão deste produto?'),
                                          actions: [
                                            TextButton(
                                              onPressed: ()=> Navigator.pop(context), 
                                              child: Text('Cancelar')
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                controller.excluirProduto(index);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Produto excluido com sucesso'), backgroundColor: Colors.green,)
                                                );
                                                Navigator.pop(context);
                                              }, 
                                              child: Text('Sim')
                                            ),
                                          ],
                                        );
                                      },), 
                                      child: Text('Exluir por: w\$${listaProdutos[index].valor.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),)
                                    ),
                                  ) : Container(
                                    margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green[400]
                                    ),
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () => showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirma a aquisição deste produto?'),
                                          actions: [
                                            TextButton(
                                              onPressed: ()=> Navigator.pop(context), 
                                              child: Text('Cancelar')
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                controller.adquirirProduto(index);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Adquirido com Sucesso'),backgroundColor: Colors.green,),
                                                );
                                                Navigator.pop(context);
                                              }, 
                                              child: Text('Sim')
                                            ),
                                          ],
                                        );
                                      },), 
                                      child: Text('Adquirir por: w\$${listaProdutos[index].valor.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}