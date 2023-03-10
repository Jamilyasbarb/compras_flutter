import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:compras_vita_health/controllers/produto_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _keyForm = GlobalKey<FormState>();
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
    (ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if(!isDeviceConnected && isAlertSet == false){
        print('entrei aqui na conexao');
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
     }
  );

 

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProdutoController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Novo Produto'),
        leading: Icon(Icons.menu),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => controller.pickerImage(ImageSource.camera),
                  child: controller.imagem == null ? Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    color: Colors.grey[350],
                    child: Icon(Icons.camera_alt),
                  ): Container(
                    height: 200,
                    width: 200,
                    child: Image.file(controller.imagem!, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if(value == null || value == ''){
                                  return 'Campo obrigat??rio';
                                }else{
                                  controller.nome = value;
                                }
                                 return null;
                              },
                            ),
                            Container(height: 10,),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Descri????o',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if(value == null || value == ''){
                                   return 'Campo obrigat??rio';
                                }else{
                                  controller.descricao = value;
                                }
                                return null;
                              },
                            ),
                            Container(height: 10,),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Valor em WsCoins',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if(value == null || value == ''){
                                  return 'Campo obrigat??rio';
                                }else{
                                  controller.valor = double.parse(value);
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.primary,
                        child: TextButton(
                          onPressed: (){
                            if(_keyForm.currentState!.validate() && controller.imagem != null){
                              controller.addProduto();
                              Navigator.of(context).pushReplacementNamed('/');
                              getConnectivity();
                            }else{
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Aten????o!'),
                                    content: Text('Todos os campos s??o obrigat??rios'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text('Ok entendi'))
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: Text('Voltar',),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  showDialogBox() => showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Conex??o com a internet'),
        content: Text('Falha ao tentar se conectar com a internet'),
        actions: [
          TextButton(
            onPressed: () async{
              Navigator.pop(context, 'Cancel');
              isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if(!isDeviceConnected){
                showDialogBox();
                setState(() {
                  isAlertSet= true;
                });
              }
            }, 
          child: Text('Ok'))
        ],
      );
    },
  );

}

