import 'package:compras_vita_health/models/produto_model.dart';
import 'package:compras_vita_health/services/produto_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ProdutoModel>? produtos;
  bool sucessConection = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaProduto();
  }

  getListaProduto()async{
    produtos = await ProdutoService().getProdutos();
    if(produtos != null){
      setState(() {
        sucessConection = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
                        Navigator.of(context).pushReplacementNamed('cadastro');
                      }, 
                      child: Text('Adicionar'))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: produtos?.length,
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
                                            Text('${produtos?[index].nome}', style: Theme.of(context).textTheme.titleLarge),
                                            Text('${produtos?[index].descricao}', textAlign: TextAlign.center,),
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
                                    child: Text('Adquirir por: w\$${produtos?[index].valor.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}