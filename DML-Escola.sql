select *from turma;
insert into turma (nome, grau_ensino) values ("9B", "ensino fundamental");
update turma set nome = "2B" where turma_id = 8;
delete from turma where turma_id not in (1,2,5,6);

select *from aluno;
select *from aluno where nome_completo = "natalia de jesus silva";
insert into aluno (nome_completo, documento, turma_id) values ("mirela salvatori", '77702288002', 24);
delete from aluno where aluno_id not in (1,2,3,4,5,6,13,14,15,16,17,18);

select *from disciplina;
select *from disciplina where nome = "artes";
insert into disciplina (nome) values ("geografia");

select *from professor;
insert into professor (nome_completo, documento) values ("leticia", '00449288044');

select *from grade_aulas_professores;
select *from grade_aulas_professores where dia_semana = "terca-feira";
insert into grade_aulas_professores (dia_semana, horario, professor_id, turma_id, disciplina_id)
values ("sexta-feira", "10:50 às 11:50", 11, 2, 7);
update grade_aulas_professores set disciplina_id = 11 where id in (51,56);
delete from grade_aulas_professores where id = 42;

select *from avaliacoes_aplicadas;
select *from avaliacoes_aplicadas where disciplina_id = 3 and aluno_id = 1;
insert into avaliacoes_aplicadas (nome, nota, data_aplicacao, professor_id, turma_id, aluno_id, disciplina_id)
values("avaliacao 3", 9.0, '2020-12-18', 5, 2, 6, 2);
update avaliacoes_aplicadas set nome = "avaliacao 2" where id in (332,333,334,335,336,337);
delete from avaliacoes_aplicadas where id = 130;

-- exercicios

-- 1- Crie uma consulta que retorne os melhores alunos por média de nota de cada disciplina.
 select max(media2), disciplina from (
 select aluno,disciplina, max(media) as media2 from (
 select avg(a.nota) as media, b.nome_completo as aluno, c.nome as disciplina
 from avaliacoes_aplicadas as a
 inner join aluno as b on a.aluno_id = b.aluno_id
 inner join disciplina as c on a.disciplina_id = c.disciplina_id
 group by a.disciplina_id,a.aluno_id) media_alunos
 group by aluno,disciplina) media_alunos2
 group by disciplina;

-- 2- Crie uma consulta que retorne todas as turmas cadastradas separadas por disciplina e o nome do professor.

select b.nome as turma,
b.grau_ensino,
c.nome as disciplina,
d.nome_completo as professor
from grade_aulas_professores as a
inner join turma as b on a.turma_id = b.turma_id
inner join disciplina as c on a.disciplina_id = c.disciplina_id
inner join professor as d on a.professor_id = d.professor_id
group by a.turma_id,c.nome,d.nome_completo;
