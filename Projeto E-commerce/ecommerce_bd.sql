-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;

use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment,
        Fname varchar(15),
        Mname char(3),
        Lname varchar(20),
        clientCPF char(11) NOT NULL,
        clientAdress varchar(45),
        clientBday DATE NOT NULL,
        clientContact varchar(15) NOT NULL,
        primary key (idClient),
        constraint unique_cliente_cpf unique (clientCPF),
        constraint unique_full_name unique (Fname, Mname, Lname)
);

desc clients;

-- criar tabela produto
create table product(
		idProduct int auto_increment NOT NULL,
        productName varchar(45),
        productCategory varchar(45) NOT NULL,
        productDescription varchar(45),
        productPrice float NOT NULL,
        primary key (idProduct),
        constraint unique_id_product unique (idProduct)
);

desc product;

-- criar tabela ordered
create table ordered(
		idOrder int auto_increment,
        orderStatus enum('confirmed', 'canceled', 'processing') default 'processing',
        orderShipment float default 10,
        idOrderClient int,
        primary key (idOrder),
        constraint unique_id_order unique (idOrder),
        constraint fk_order_client foreign key 
					(idOrderClient) references clients(idClient)
);

desc ordered;

-- criar tabela estoque
create table stock(
		idStock int NOT NULL,
        stockLocal varchar(45) NOT NULL,
        amount int(45) NOT NULL,
        productDescription varchar(45),
        price float not null,
        primary key (idStock),
        constraint unique_id_stock unique (idStock)
);

desc stock;

-- criar tablela fornecedor
create table supplier(
		idSupplier int NOT NULL,
        supplierName varchar(45),
        supplierCNPJ char(15) NOT NULL,
        supplierContact varchar(15) NOT NULL,
        primary key (idSupplier),
        constraint unique_id_supplier unique (idSupplier),
        constraint unique_CNPJ_supplier unique (supplierCNPJ)
);

desc supplier;

-- criar tabela vendedor
   create table seller(
		idSeller int auto_increment ,
        sellerName varchar(15),
        sellerLocal varchar(45),
        sellerCNPJ char(11) NOT NULL,
        sellerAdress varchar(45),
        primary key (idSeller),
        constraint unique_seller_name unique (sellerName),
        constraint unique_seller_CNPJ unique (sellerCNPJ),
		constraint unique_id_seller unique (idSeller)
);     

desc seller;

-- criar tabela produto vendedor
   create table productSeller(
		idPseller int auto_increment NOT NULL,
        Product_idProduct int NOT NULL,
        Qnt int NOT NULL,
        primary key (idPseller, Product_idProduct),
        constraint unique_id_idPseller unique (idPseller),
        constraint unique_id_sellerProduct unique (Product_idProduct),
        constraint fk_product_productId foreign key 
					(Product_idProduct) references product(idProduct),
		constraint fk_product_seller foreign key 
					(idPseller) references seller(idSeller)
);  

-- criar tabela produto fornecedor
   create table productSupplier(
		Product_idProduct int NOT NULL,
        Supplier_idSupplier int NOT NULL,
        Qnt int NOT NULL,
        primary key (Supplier_idSupplier, Product_idProduct),
        constraint unique_id_Supplier_idSupplier unique (Supplier_idSupplier),
        constraint unique_id_supplierProduct unique (Product_idProduct),
        constraint fk_supplier_productId foreign key 
					(Product_idProduct) references product(idProduct),
		constraint fk_product_supplier foreign key 
					(Supplier_idSupplier) references supplier(idSupplier)
);  

-- criar tabela produto estoque
   create table productStock(
		Product_idProduct int NOT NULL,
        Stock_idStock int NOT NULL,
        locaton int,
        primary key (Stock_idStock, Product_idProduct),
        constraint unique_id_Supplier_Stock_idStock unique (Stock_idStock),
        constraint unique_id_stockProduct unique (Product_idProduct),
        constraint fk_stock_productId foreign key 
					(Product_idProduct) references product(idProduct),
		constraint fk_product_stock foreign key 
					(Stock_idStock) references stock(idStock)
);     

-- criar tabela produto produto
	create table productOrder(
		Product_idProduct int NOT NULL,
        Order_idOrder int NOT NULL,
        Qnt int NOT NULL,
        availability enum('available', 'unavailable') default 'unavailable',
        primary key (Order_idOrder, Product_idProduct),
        constraint unique_id_Supplier_Order_idOrder unique (Order_idOrder),
        constraint unique_id_orderProduct unique (Product_idProduct),
        constraint fk_order_productId foreign key 
					(Product_idProduct) references product(idProduct),
		constraint fk_product_order foreign key 
					(Order_idOrder) references ordered(idOrder)
	);
    
    desc productOrder;
        