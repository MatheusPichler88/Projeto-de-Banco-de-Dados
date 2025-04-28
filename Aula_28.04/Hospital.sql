#msotra todas as bases de dados do SGBD
show databases;
drop database mydb;

#invoca ou chama um banco de dados específico
use perfomace_schema;

#mostra as tabelas do banco de dados invocado oou em uso
show tables;

#criar a base de dados desejada - consulta

#invocar a base de dados criada

#criar as tabelas
	#para cada tabela:
		#criar atributo com seu tipo
        #definir restrições
			#atributo
            #chave primária
            #chave estrangeira
            
 -- exercicio sobre a base criada...alter
 show databases;
 use mydb;
 show tables;
 
 -- na tabela medico preciso alterar o tamanho do nome... de 45 caracteres para 100 caracteres
 -- na tabela consulta preciso adicionar um atributo chamado convenio
 -- usar o alter table