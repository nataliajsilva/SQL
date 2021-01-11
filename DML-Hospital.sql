select *from especialidade;
insert into especialidade (nome) values ("oftalmologia");
update especialidade set nome = "urologia" where especialidade_id = 3;

select *from setor;
insert into setor (nome,local) values ("branco","3º andar");

select *from medico;
insert into medico (nome_completo,documento,crm) values ("yang cheng", '99875598500' ,"45194");

select *from paciente;
insert into paciente (nome_completo,documento,data_nascimento,sexo,tipo_sanguineo) 
values ("thiago santos", '83355598333', '1959-10-06', "masculino", "O");

select *from medicamento;
select *from medicamento where nome = "omeprazol";
insert into medicamento (nome,fabricante,dosagem) values ("omeprazol", "ultrafarma", "20 mg 56 capsulas");

select *from especialidades_medico; 
insert into especialidades_medico (medico_id,especialidade_id,setor_id) values (2,2,3);

select *from prontuario;
select *from prontuario where paciente_id = 1;
insert into prontuario (paciente_id,data_atualizacao) values (5, '2020-08-09');

select *from consulta;
insert into consulta (prontuario_id,medico_id,setor_id,data_consulta) values (3,5,3, '2020-01-25');
update consulta set medico_id = 1 where id in (14,15,16);
delete from consulta where id = 17;

select *from receita;
insert into receita (medico_id, paciente_id, data_receita) values (5,3, '2020-01-25');
delete from receita where receita_id = 7;

select *from exame;
select *from exame where setor_id = 1;
insert into exame (setor_id,nome) values (4,"tomografia de coerencia optica");

select *from resultado_exame;
insert into resultado_exame (exame_id,prontuario_id,resultado_exame) values (7 , 5, "nada consta");

select *from lista_medicamentos_receita;
insert into lista_medicamentos_receita (receita_id, medicamento_id) values (13,4);


-- exercicios

/* 8- No banco de dados hospitalar: crie uma consulta que retorne o total de consultas realizadas de cada paciente.*/

select count(consulta.prontuario_id) as qtd_consultas,
paciente.nome_completo as nome_paciente
from consulta as consulta
inner join prontuario on consulta.prontuario_id = prontuario.prontuario_id
inner join paciente on prontuario.paciente_id = paciente.paciente_id
group by consulta.prontuario_id;


/* 9- No banco de dados hospitalar: crie uma consulta que retorne o nome do paciente e as datas de consulta 
mais recente e mais antiga.*/

select paciente.nome_completo as nome_paciente,
max(consulta.data_consulta) as consulta_recente,
min(consulta.data_consulta) as consulta_antiga
from consulta as consulta
inner join prontuario on consulta.prontuario_id = prontuario.prontuario_id
inner join paciente on prontuario.paciente_id = paciente.paciente_id
group by consulta.prontuario_id;


/* 10- No banco de dados hospitalar: crie uma consulta que retorne o medicamento receitado mais vezes por cada médico.*/

select count(medicamento.medicamento_id) as qtd,
medicamento.nome as medicamento,
medico.nome_completo as medico
from lista_medicamentos_receita as medicamento_receita
inner join medicamento on medicamento_receita.medicamento_id = medicamento.medicamento_id
inner join receita on medicamento_receita.receita_id = receita.receita_id
inner join medico on receita.medico_id = medico.medico_id
group by medicamento, medico;