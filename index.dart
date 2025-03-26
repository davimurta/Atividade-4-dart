import 'dart:io';

void main() {
  Estoque estoque = Estoque();

  while (true) {
    print('\n=== MENU ===');
    print('1. Adicionar Produto');
    print('2. Listar Produtos');
    print('3. Vender Produto');
    print('4. Repor Estoque');
    print('5. Sair');
    stdout.write('Escolha uma opção: ');
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        stdout.write('Nome do produto: ');
        String nome = stdin.readLineSync()!;
        stdout.write('Preço: ');
        double preco = double.parse(stdin.readLineSync()!);
        stdout.write('Quantidade em estoque: ');
        int quantidade = int.parse(stdin.readLineSync()!);
        stdout.write('Descrição (opcional): ');
        String? descricao = stdin.readLineSync();

        estoque.adicionarProduto(Produto(
          nome: nome,
          preco: preco,
          quantidadeEmEstoque: quantidade,
          descricao: descricao?.isEmpty ?? true ? null : descricao,
        ));
        print('Produto adicionado com sucesso!');
        break;

      case '2':
        estoque.listarProdutos();
        break;

      case '3':
        stdout.write('Nome do produto para vender: ');
        String nomeProduto = stdin.readLineSync()!;
        stdout.write('Quantidade a vender: ');
        int quantidadeVenda = int.parse(stdin.readLineSync()!);
        estoque.venderProduto(nomeProduto, quantidadeVenda);
        break;

      case '4':
        stdout.write('Nome do produto para repor: ');
        String nomeProduto = stdin.readLineSync()!;
        stdout.write('Quantidade a repor: ');
        int quantidadeRepor = int.parse(stdin.readLineSync()!);
        estoque.reporProduto(nomeProduto, quantidadeRepor);
        break;

      case '5':
        print('Saindo do programa...');
        return;

      default:
        print('Opção inválida. Tente novamente.');
    }
  }
}

class Produto {
  String _nome;
  double _preco;
  int _quantidadeEmEstoque;
  String? _descricao;

  Produto({
    required String nome,
    required double preco,
    required int quantidadeEmEstoque,
    String? descricao,
  })  : _nome = nome,
        _preco = preco,
        _quantidadeEmEstoque = quantidadeEmEstoque,
        _descricao = descricao;

  String get nome => _nome;
  double get preco => _preco;
  int get quantidadeEmEstoque => _quantidadeEmEstoque;
  String? get descricao => _descricao;

  set nome(String nome) => _nome = nome;
  set preco(double preco) => _preco = preco;
  set quantidadeEmEstoque(int quantidade) => _quantidadeEmEstoque = quantidade;
  set descricao(String? descricao) => _descricao = descricao;

  bool vender(int quantidade) {
    if (quantidade > 0 && _quantidadeEmEstoque >= quantidade) {
      _quantidadeEmEstoque -= quantidade;
      return true;
    }
    return false;
  }

  void reporEstoque(int quantidade) {
    if (quantidade > 0) {
      _quantidadeEmEstoque += quantidade;
    }
  }

  void exibirInformacoes() {
    print('Nome: $_nome');
    print('Preço: R\$ ${_preco.toStringAsFixed(2)}');
    print('Estoque: $_quantidadeEmEstoque');
    print('Descrição: ${_descricao ?? 'Nenhuma'}');
    print('---------------------------');
  }
}

class Estoque {
  List<Produto> produtos = [];

  void adicionarProduto(Produto produto) {
    produtos.add(produto);
  }

  void listarProdutos() {
    if (produtos.isEmpty) {
      print('Nenhum produto cadastrado.');
    } else {
      for (var produto in produtos) {
        produto.exibirInformacoes();
      }
    }
  }

  void venderProduto(String nome, int quantidade) {
    for (var produto in produtos) {
      if (produto.nome.toLowerCase() == nome.toLowerCase()) {
        if (produto.vender(quantidade)) { 
          print('Venda realizada com sucesso!');
        } else {
          print('Estoque insuficiente ou quantidade inválida.');
        }
        return;
      }
    }
    print('Produto não encontrado.');
  }

  void reporProduto(String nome, int quantidade) {
    for (var produto in produtos) {
      if (produto.nome.toLowerCase() == nome.toLowerCase()) {
        produto.reporEstoque(quantidade);
        print('Estoque reposto com sucesso!');
        return;
      }
    }
    print('Produto não encontrado.');
  }
}
