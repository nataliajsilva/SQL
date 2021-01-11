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
 
 SELECT max_nota_media, nome_disciplina, nome_completo_aluno, notas_medias_disciplina_id FROM (
	SELECT MAX(nota_media) AS max_nota_media, notas_medias.disciplina_id AS notas_medias_disciplina_id, disciplina.nome as nome_disciplina
	FROM (
		SELECT AVG(nota) as nota_media, aluno_id, disciplina_id
		FROM avaliacoes_aplicadas 
		GROUP BY aluno_id, disciplina_id
	) AS notas_medias
	INNER JOIN disciplina ON disciplina.disciplina_id = notas_medias.disciplina_id
	GROUP BY notas_medias.disciplina_id, disciplina.nome) AS max_notas_medias
INNER JOIN (
		SELECT AVG(nota) as nota_media, avaliacoes_aplicadas.aluno_id, avaliacoes_aplicadas.disciplina_id, aluno.nome_completo as nome_completo_aluno
		FROM avaliacoes_aplicadas
        INNER JOIN aluno ON aluno.aluno_id = avaliacoes_aplicadas.aluno_id
		GROUP BY aluno_id, disciplina_id) AS join_avg_nota 
        ON join_avg_nota.nota_media = max_nota_media AND join_avg_nota.disciplina_id = notas_medias_disciplina_id
ORDER BY nome_disciplina, max_nota_media DESC;

-- 2- Crie uma consulta que retorne todas as turmas cadastradas separadas por disciplina e o nome do professor.

select turma.nome as turma,
turma.grau_ensino,
disciplina.nome as disciplina,
professor.nome_completo as professor
from grade_aulas_professores as aulas 
inner join turma as turma on aulas.turma_id = turma.turma_id
inner join disciplina as disciplina on aulas.disciplina_id = disciplina.disciplina_id
inner join professor as professor on aulas.professor_id = professor.professor_id
group by aulas.turma_id, disciplina.nome, professor.nome_completo;
