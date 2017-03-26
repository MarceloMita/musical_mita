# README

Esse projeto trata-se de uma aplicação de demonstração para integração com o meio de pagameto Moip.

## Requisitos Mínimos

* Página com produtos a serem escolhidos;
* Criar página de checkout para entrada de dados de cartão de crédito;
* Ao utilizar um cupom de desconto, o valor original será diminuido em 5%;
* Pagamentos feitos em mais de uma parcela no cartão de crédito, sofrerá um acréscimo de 2,5%;
* Fluxo de checkout:
  1. Criação do Pedido;
  2. Criação do Pagamento;
  3. Confirmação do Pagamento feita de forma assíncrona via webhook;
* Entrega feita via repositório GitHub;
* Deploy feito no heroku com endereço: https://musical-mita.herokuapp.com;

## Outras funcionalidades adicionadas
* Sistema de autenticação;
* Checkout com um carrinho de compras que pode ter mais de 1 produto em diferentes quantidades;
* Adição e remoção de itens do carrinho usando ajax;
