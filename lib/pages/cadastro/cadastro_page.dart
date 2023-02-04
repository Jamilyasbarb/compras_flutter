import 'package:compras_vita_health/controllers/produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _keyForm = GlobalKey<FormState>();

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
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _keyForm,
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
                                  return 'Campo obrigatório';
                                }else{
                                  controller.nome = value;
                                }
                                 return null;
                              },
                            ),
                            Container(height: 10,),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if(value == null || value == ''){
                                   return 'Campo obrigatório';
                                }else{
                                  controller.descricao = value;
                                }
                                return null;
                              },
                            ),
                            Container(height: 10,),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Valor em WsCoins',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if(value == null || value == ''){
                                  return 'Campo obrigatório';
                                }else{
                                  controller.valor = double.parse(value);
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
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
                          if(_keyForm.currentState!.validate()){
                            controller.addProduto();
                            Navigator.of(context).pushReplacementNamed('/');
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
    );
  }
}