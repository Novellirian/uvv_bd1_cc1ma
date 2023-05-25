/*excluindo caso ja existam*/
DROP USER if EXISTS rian;
DROP DATABASE if EXISTS uvv;
DROP SCHEMA if EXISTS lojas CASCADE;


/*criação do usuario do database*/
CREATE USER rian WITH
CREATEDB
SUPERUSER
CREATEROLE
LOGIN
PASSWORD '12345';

/*criação do database*/
CREATE DATABASE uvv  WITH
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE
OWNER = rian;

/*conexão com o banco de dados*/
\c uvv rian;

/*criação do schema*/

CREATE SCHEMA lojas
AUTHORIZATION "rian";

ALTER USER "rian"
SET SEARCH_PATH to lojas, "$rian", public;




/*criação da tabela produtos*/
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
/*Comentários acerca da tabela produtos e suas colunas*/
COMMENT ON TABLE lojas.produtos IS 'tabela de produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'id do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preco unitario dos produtos';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'arquivo das imagens dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'ultima atualizacao das imagens dos produtos';


/*criação da tabela lojas*/
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

/*comentarios acerca da tabela lojas e suas colunas*/
COMMENT ON TABLE lojas.lojas IS 'Tabelas das lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id da loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereço na web/internet';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereço real/concreto';
COMMENT ON COLUMN lojas.lojas.latitude IS 'descreve a latitude do endereço';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude do endereço da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo do logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'ultima atualizacao do logo das lojas';


/*criação da tabela estoques e suas colunas*/
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

/*comentarios acerca da tabela estoques e suas colunas*/
COMMENT ON TABLE lojas.estoques IS 'tabela de estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'id dos estoques';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'id da loja';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'id do produto';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'estocagem disponivel';


/*criação da tabela clientes e suas colunas*/
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

/*comentarios acerca da tabela clientes e suas colunas*/
COMMENT ON TABLE lojas.clientes IS 'tabela que identifica os clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna que identifica os clientes';
COMMENT ON COLUMN lojas.clientes.email IS 'email do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone do cliente';


/*criação da tabela envios e suas colunas*/
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

/*comentarios acerca da tabela envios e suas colunas*/
COMMENT ON TABLE lojas.envios IS 'tabela de envios';
COMMENT ON COLUMN lojas.envios.envio_id IS 'id de envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'id da loja';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'id do cliente';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereco para envio';
COMMENT ON COLUMN lojas.envios.status IS 'status do envio';


/*Criação da tabela pedidos e suas colunas*/
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

/*comentarios acerca da tabela pedidos e suas colunas*/
COMMENT ON TABLE lojas.pedidos IS 'Tabela que identifica os pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'id dos pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'descreve a data e a hora dos pedidos';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'identifica o cliente do pedido';
COMMENT ON COLUMN lojas.pedidos.status IS 'status dos pedidos';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'id da loja';


/*criação da tabela pedidos_itens e suas colunas*/
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT itens_id PRIMARY KEY (pedido_id, produto_id)
);

/*comentarios acerca da tabela pedidos_itens e suas colunas*/
COMMENT ON TABLE lojas.pedidos_itens IS 'tabela de pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'id do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'id do produto';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'numero_da_linha';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preco unitario dos pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidade de pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'id de envio dos pedidos_itens';


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
