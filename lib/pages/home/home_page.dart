import 'package:compras_vita_health/controllers/produto_controller.dart';
import 'package:compras_vita_health/models/produto_model.dart';
import 'package:compras_vita_health/models/usuario_model.dart';
import 'package:compras_vita_health/services/produto_service.dart';
import 'package:compras_vita_health/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<ProdutoModel>? produtos;
  List<UsuarioModel>? usuario;
  // UsuarioModel? usuario;
  bool sucessConection = false;
  bool cadastrado = false;

  @override
  void initState() {
    super.initState();
    getListaProduto();
    getUsuario();
  }

  getListaProduto()async{
    produtos = await ProdutoService().getProdutos();
    if(produtos != null){
      for (var i = 0; i < produtos!.length; i++) {
        listaProdutos.add(produtos![i]);
      }
      setState(() {
        sucessConection = true;
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
  
  @override
  Widget build(BuildContext context) {
  final controller = context.watch<ProdutoController>();
  print(listaProdutos.isEmpty);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Loja de Produtos'),
      ),
      body: Visibility(
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
                    Text('Disponivel: W\$ 368'),
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
                ):Expanded(
                  child: ListView.builder(
                    itemCount: listaProdutos.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                                        child: Image.asset('assets/images/fogao.jpeg'),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          children: [
                                            Text('${listaProdutos[index].nome}${usuario?[0].nome}', style: Theme.of(context).textTheme.titleLarge),
                                            Text('${listaProdutos[index].descricao}', textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
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
                                            onPressed: (){}, 
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
    );
  }
}