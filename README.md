# projeto-banco-dados-ecommerce
Projeto conceitual de banco de dados para um sistema de e-commerce.
# Projeto Conceitual de Banco de Dados: E-COMMERCE

## 1. Descrição do Projeto

Este projeto consiste na modelagem e implementação do esquema de um Banco de Dados Relacional para um sistema de **E-commerce**. O objetivo principal é gerenciar as principais entidades envolvidas no processo de vendas online: clientes, produtos, categorias e pedidos.

---

## 2. Cenário e Narrativa

O sistema foi desenhado para suportar o gerenciamento de uma loja virtual, abrangendo as seguintes funcionalidades:

* **Clientes:** Permite o cadastro e a gestão de múltiplos **Endereços** para cada cliente (cobrança e entrega).
* **Produtos e Categorias:** Produtos são classificados por **Categorias** (ex: Informática, Esportes) para facilitar a organização e buscas. O estoque e o preço são controlados.
* **Pedidos:** A tabela **Pedidos** registra o histórico de compras de cada cliente, enquanto a tabela **Itens\_Pedido** faz a ligação entre o pedido e os produtos comprados, incluindo a quantidade e o preço unitário da época da compra.

---

## 3. Modelo e Estrutura do Banco de Dados

O projeto é composto por **6 Tabelas** principais, interligadas por Chaves Estrangeiras (Foreign Keys - FK):

| Tabela | Chave Primária (PK) | Chaves Estrangeiras (FK) |
| :--- | :--- | :--- |
| **Clientes** | `cliente_id` | N/A |
| **Categorias** | `categoria_id` | N/A |
| **Produtos** | `produto_id` | `categoria_id` (FK para Categorias) |
| **Pedidos** | `pedido_id` | `cliente_id` (FK para Clientes) |
| **Itens\_Pedido** | `item_id` | `pedido_id` (FK para Pedidos), `produto_id` (FK para Produtos) |
| **Enderecos** | `endereco_id` | `cliente_id` (FK para Clientes) |

### Diagrama Entidade-Relacionamento (DER)

*Insira a imagem do seu Diagrama Entidade-Relacionamento (DER/MER) aqui.*

Exemplo:
https://github.com/nahfiore02/projeto-banco-dados-ecommerce/blob/main/Ecommerce.jpeg


---

## 4. Arquivo de Implementação

O arquivo **`ecommerce_projeto.sql`** contém todo o código necessário para a implementação do banco de dados.

**Conteúdo do arquivo SQL:**

1.  Comando `CREATE DATABASE` para criar o banco de dados `db_ecommerce_projeto`.
2.  Instruções `CREATE TABLE` para construir todas as 6 tabelas com suas respectivas colunas, chaves primárias (`PRIMARY KEY`) e chaves estrangeiras (`FOREIGN KEY`).
3.  Comandos `INSERT INTO` para popular as tabelas com dados de exemplo (clientes, produtos, pedidos, etc.).

---

## 5. Ferramentas Utilizadas

* **SGBD:** MySQL / MariaDB
* **Ferramenta de Design:** [**Mencione a ferramenta que você usou, por exemplo: Draw.io**]

*--- Fim do README.md ---*
