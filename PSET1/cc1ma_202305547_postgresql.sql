/*criação do usuario do database*/
DROP USER if EXISTS rian;
CREATE USER rian WITH
SUPERUSER
CREATEDB
CREATEROLE
REPLICATION
PASSWORD 'computacaoraiz';

/*criação do database*/
DROP DATABASE if EXISTS uvv;
CREATE DATABASE uvv  WITH
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE;





/*criação da tabela produtos*/
CREATE TABLE public.produtos (
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
COMMENT ON TABLE public.produtos IS 'tabela de produtos';
COMMENT ON COLUMN public.produtos.produto_id IS 'id do produto';
COMMENT ON COLUMN public.produtos.preco_unitario IS 'preco unitario dos produtos';
COMMENT ON COLUMN public.produtos.detalhes IS 'detalhes dos produtos';
COMMENT ON COLUMN public.produtos.imagem IS 'imagem dos produtos';
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'arquivo das imagens dos produtos';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'ultima atualizacao das imagens dos produtos';


/*criação da tabela lojas*/
CREATE TABLE public.lojas (
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
COMMENT ON TABLE public.lojas IS 'Tabelas das lojas';
COMMENT ON COLUMN public.lojas.loja_id IS 'id da loja';
COMMENT ON COLUMN public.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN public.lojas.endereco_web IS 'endereço na web/internet';
COMMENT ON COLUMN public.lojas.endereco_fisico IS 'endereço real/concreto';
COMMENT ON COLUMN public.lojas.latitude IS 'descreve a latitude do endereço';
COMMENT ON COLUMN public.lojas.longitude IS 'longitude do endereço da loja';
COMMENT ON COLUMN public.lojas.logo IS 'logo da loja';
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'arquivo do logo da loja';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'ultima atualizacao do logo das lojas';


/*criação da tabela estoques e suas colunas*/
CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

/*comentarios acerca da tabela estoques e suas colunas*/
COMMENT ON TABLE public.estoques IS 'tabela de estoques';
COMMENT ON COLUMN public.estoques.estoque_id IS 'id dos estoques';
COMMENT ON COLUMN public.estoques.loja_id IS 'id da loja';
COMMENT ON COLUMN public.estoques.produto_id IS 'id do produto';
COMMENT ON COLUMN public.estoques.quantidade IS 'estocagem disponivel';


/*criação da tabela clientes e suas colunas*/
CREATE TABLE public.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

/*comentarios acerca da tabela clientes e suas colunas*/
COMMENT ON TABLE public.clientes IS 'tabela que identifica os clientes.';
COMMENT ON COLUMN public.clientes.cliente_id IS 'Coluna que identifica os clientes';
COMMENT ON COLUMN public.clientes.email IS 'email do cliente';
COMMENT ON COLUMN public.clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN public.clientes.telefone1 IS 'Telefone do cliente';
COMMENT ON COLUMN public.clientes.telefone2 IS 'telefone do cliente';
COMMENT ON COLUMN public.clientes.telefone3 IS 'telefone do cliente';


/*criação da tabela envios e suas colunas*/
CREATE TABLE public.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

/*comentarios acerca da tabela envios e suas colunas*/
COMMENT ON TABLE public.envios IS 'tabela de envios';
COMMENT ON COLUMN public.envios.envio_id IS 'id de envio';
COMMENT ON COLUMN public.envios.loja_id IS 'id da loja';
COMMENT ON COLUMN public.envios.cliente_id IS 'id do cliente';
COMMENT ON COLUMN public.envios.endereco_entrega IS 'endereco para envio';
COMMENT ON COLUMN public.envios.status IS 'status do envio';


/*Criação da tabela pedidos e suas colunas*/
CREATE TABLE public.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

/*comentarios acerca da tabela pedidos e suas colunas*/
COMMENT ON TABLE public.pedidos IS 'Tabela que identifica os pedidos';
COMMENT ON COLUMN public.pedidos.pedido_id IS 'id dos pedidos';
COMMENT ON COLUMN public.pedidos.data_hora IS 'descreve a data e a hora dos pedidos';
COMMENT ON COLUMN public.pedidos.cliente_id IS 'identifica o cliente do pedido';
COMMENT ON COLUMN public.pedidos.status IS 'status dos pedidos';
COMMENT ON COLUMN public.pedidos.loja_id IS 'id da loja';


/*criação da tabela pedidos_itens e suas colunas*/
CREATE TABLE public.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT itens_id PRIMARY KEY (pedido_id, produto_id)
);

/*comentarios acerca da tabela pedidos_itens e suas colunas*/
COMMENT ON TABLE public.pedidos_itens IS 'tabela de pedidos_itens';
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'id do pedido';
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'id do produto';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'numero_da_linha';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'preco unitario dos pedidos_itens';
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'quantidade de pedidos_itens';
COMMENT ON COLUMN public.pedidos_itens.envio_id IS 'id de envio dos pedidos_itens';


ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

