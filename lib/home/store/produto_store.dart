import 'package:api_rest/data/http/exceptions.dart';
import 'package:api_rest/data/models/produto_model.dart';
import 'package:api_rest/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  // variavel reativa o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // variavel para  o state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  // variavel reativa para o erro

  final ValueNotifier<String> erro = ValueNotifier<String>('');
  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundExceptions catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
