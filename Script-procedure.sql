/*BD- Eduarda Belles e Takeshi Bezerra - 2MD2*/

create database bd_venda;
use bd_venda;

create table tb_produto(
cd_produto int auto_increment primary key,
nm_produto varchar(30) not null,
ds_produto varchar(130),
vl_custo decimal(5,2),
vl_venda decimal(5,2)
);

/*1- inserir novos registros na tabela verificando se o valor 
de custo é menor que o valor de de venda e caso isso aconteça 
o registro não deve ser efetuado e sim exibido um select 
avisando "Valor de Custo superior ao de venda_registro negado".*/

delimiter //
Create procedure inserirProduto(IN  nm_produto varchar(30), ds_produto longtext, vl_custo decimal (5,2), vl_venda decimal (5,2)) 
begin
insert into tb_produto values(null, nm_produto, ds_produto, vl_custo, vl_venda);
end//
delimiter ; 

call inserirProduto("Molho de Tomate", "Ao sugo", 7.50, 10.00);
call inserirProduto("Macarrão", "Tradicional", 8.50, 15.00);
call inserirProduto("Arroz", "Integral", 10.50, 50.00);

select * from tb_produto;


/*2 - atualizar os dados do registro verificando se o valor do
 código informado é maior que zero e se os demais campos são
 diferente de vazio somente se todas essa condicionais forem 
 verdadeiras deve ser feita a alteração.*/
 
 delimiter //

create procedure AtualizarProduto(
    in cd_produto int,
    in nm_produto varchar(30),
    in ds_produto varchar(130),
    in vl_custo decimal(5,2),
	in vl_venda decimal(5,2)
)
begin
    if cd_produto > 0 then
        if  nm_produto <> '' and ds_produto <> '' and vl_custo <> '' and vl_venda <> '' then
            update tb_produto
            set nm_produto = "Feijão",
                ds_produto = "Carioca",
                vl_custo= 10.00,
                 vl_venda= 18.00
            where cd_produto = cd_produto;
            
            select "Registro atualizado com sucesso." as Mensagem;
        else
            select "Todos os campos devem ser preenchidos." as Mensagem;
        end if;
    else
        select "O código informado deve ser maior que zero." as Mensagem;
    end if;
end //

delimiter ;


call AtualizarProduto(null, "Feijão", "Carioca", 10.00,18.00);

/*3- exibir os registros da tabela de todos os produtos com o valor 
de venda maior ou igual ao determinado pelo parâmetro passado na 
procedure.*/

delimiter //

create procedure ExibirProduto(
    in valorMinimo decimal(10,2)
)
begin
    select *
    from tb_produto
    where vl_venda >= valorMinimo;
end //

delimiter ;
call ExibirProduto(50.00);

/*4 - criar uma procedure que delete um registro dessa tabela verificando 
se o o parâmetro representando o id é maior que zero e somente dessa 
forma remova o registro, caso contrário informe que o parâmetro é menor 
que zero.*/

delimiter //

create procedure DeletarProduto(
    in  id int
)
begin
   
    if id > 0 then
        delete from  tb_produto  where cd_produto = id;
        select 'Registro removido com sucesso.' as Mensagem;
    else
        select 'O parâmetro id deve ser maior que zero.' as Mensagem;
    end if;
end //

delimiter ;
call DeletarProduto(1);