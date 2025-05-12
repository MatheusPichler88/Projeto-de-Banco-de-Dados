Projeto de banco de dados
    - Modelagem
        - modelos: conceitual (diagramas), lógico (chave estrangeira), físico (tipos e restrições)
        - regra do negócio
    - Sistema Gerenciador de Banco de Dados - SGBD: coleção de serviços (manipulaçã de dados, segurança, backup, integridade -> transação: isolamento, consistência, atomicidade, ...)
        - Transações (ACID: atomicidade, consistência, isolamento e durabilidade): ato de manipular dados: inserir, selecionar, atualizar, deletar
        - Linguagem SQL
            - QUEM OPERACIONALIZA AS TRANSAÇÕES É A LINGUAGEM SQL
                - DML (Data Manipulation Language)
                    - criar databases/esquemas, tabelas (restrições), visões
                - DDL (Data Definition Language)
                    - inserir, atualizar, selecionar e deletar

# Mysql
    show databases;
    use nomeDataBaseDesejado;
    show tables;

    aluno n ----- 1 curso

    aluno(alunoId, nome, curso)
        curso referencia curso

    curso(cursoId, nome)

    create table curso (
        cursoId int auto_increment,
        nome varchar(50) not null,
        primary key (cursoId),
        index 'nomeCurso' (nome) asc
    );

    insert into curso (cursoId, nome) values (1, "Ciência da Computação")
    insert into curso (cursoId, nome) values (2, "Sistemas de Informação")
    insert into curso (cursoId, nome) values (3, "Jogos Digitais")

    create table aluno (
        alunoId int auto_increment,
        nome varchar(50) not null,
        curso int,
        primary key (alunoId),
        index 'nomeAluno' (nome) asc,
        foreign key curso references curso(cursoId)
    );

    insert into aluno (alunoId, nome, curso) values (1000,"Bernardo Ries", 1)
    insert into aluno (alunoId, nome, curso) values (1001,"João Giovelli", 1)
    insert into aluno (alunoId, nome, curso) values (1002,"Matheus Rossatto", 2)
    insert into aluno (alunoId, nome, curso) values (1003,"Leo Brum", 2)
    insert into aluno (alunoId, nome, curso) values (1004,"Silvio Andrade", 3)
    insert into aluno (alunoId, nome, curso) values (1005,"Anne Martins", NULL)
    insert into aluno (alunoId, nome, curso) values (1006,"Dante Zamberlan", NULL)


SQL em SGBD 
    - Álgebra relacional
        - projeção - isolar coluna(s) de uma ou mais tabelas
            select alunoId
            from aluno;

            select nome, curso
            from aluno;
        
        - seleção - projetar com condição
            select nome
            from aluno
            where curso == 1;

            select nome, alunoId
            from aluno
            where curso == NULL;

            select nome, alunoId
            from aluno
            where curso == 1 and curso == 3;

        - produto cartesiano -> essência da junção (join)
            %listar todos os alunos e os nomes de seus respectivos cursos
            select aluno.nome, curso.nome
            from aluno, curso
            where curso.cursoId = aluno.curso;

            %listar todos os alunos do curso Ciência da Computação
            select aluno.nome
            from aluno, curso
            where curso.nome = "Ciência da Computação" and curso.cursoId = aluno.curso;

            %quantos alunos são do curso Ciência da Computação
            select count(*)
            from aluno, curso
            where curso.nome = "Ciência da Computação" and curso.cursoId = aluno.curso;

            %listar todos os cursos cadastradis e sua relação com a instituição (id)
            select curso.nome, curso.Instituicao_idInstituicao
            from curso

            %listar todos os curso e os nomes respectivos de suas instituicões
            select curso.nome, instituicao.nome
            from curso, instituicao
            where curso.Instituicao_idInstituicao = instituicao.Instituicao_idInstituicao

            %mostrar todos os usuarios de cursos que tenham bio no nome e seus respectivos cursos
            select usuario.nome, curso.nome
            from usuario, curso, usuario_has_curso
            where curso.nome like "Bio" and 
                curso.idCurso = usuario_has_curso.curso_idCurso and
                usuario.idUsuario = usuario_has_curso.usuario_idUsuario;

            %listar os avaliadores
            select usuario.*
            from usuario, avaliacao
            where usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorResponsavel or
                  usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorSuplente;

            select usuario.nome 
            from usuario, avaliacao
            where (avaliacao.parecerAvaliadorResponsavel = NULL or avaliacao.parecerAvaliadorSuplente = NULL)
                  and
                  (usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorResponsavel or
                  usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorSuplente)
            %mostrar as transportadores que entregam os produtos para os clientes com o CPF
            %888777256087

            select transportadora.*
            from transportadora, entrega, venda, clientes
            where cliente.cpf =  "888777256087" and %filtro básico
                transportadora.idTransportadora = entrega.transportadora_idTransportadora and
                venda.numeroNotaFiscal = entrega.venda_numeroNotaFiscal and
                cliente.idCliente = venda.cliente_idCliente;
