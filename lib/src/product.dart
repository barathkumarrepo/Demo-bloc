
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/color_resource.dart';
import '../utils/custom_text.dart';
import '../utils/fonts.dart';
import '../utils/string_resource.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductBloc? productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc?.add(productPageInitialEvent());

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: productBloc,
      builder: (BuildContext context, ProductPageState state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
              onPressed: () => Navigator.pop(context),
            ),
            title: CustomText(
              StringResource.MY_PRODUCTS,
              font: Font.LatoSemiBold,
              color: ColorResource.PURPLE,
              fontSize: 20.0,
            ),
            backgroundColor: Color(0xFF9575CD),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Flexible(child: _buildList())
            ],
          ),
        );
      },
    );
  }

  //---------------------------------------------------------------------------------------------------------------->
  Widget _buildList() {
    return BlocBuilder(
      bloc: productBloc,
      builder: (BuildContext context, ProductPageState state) {
        if (state is ProductPageLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (productBloc!.products!.length == 0) {
            return Center(
              child: CustomText(
                StringResource.NO_FAVOURITES_FOUND,
                color: ColorResource.INSTRUCTOR_BLUE_GRAY,
                fontSize: 18,
              ),
            );
          } else {
            return RefreshIndicator(

              onRefresh: () async => productBloc?.add(productPageInitialEvent()),

              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: productBloc!.products!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              productBloc!.products![index].title.toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Image.network(productBloc!.products![index].images![0],),
                            ),
                            trailing: Text("\$ ${productBloc!.products![index].price}"),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
