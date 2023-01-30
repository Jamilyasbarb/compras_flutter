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
      sucessConection = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Loja de Produtos'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Visibility(
            replacement: CircularProgressIndicator(),
            visible: sucessConection,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.amber
                                    ),
                                    child: Image.asset('assets/images/fogao.jpeg'),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text('${produtos?[index].nome}', style: Theme.of(context).textTheme.titleLarge),
                                      Text('${produtos?[index].descricao}')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){}, 
                            child: Text('Adquirir por: w\$ 368')
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}