create database escolarMentoriaSql;
use escolarMentoriaSql;

create table aluno (aluno_id smallint unsigned not null auto_increment, 
nome_completo varchar(255) not null, 
documento char(11) not null, 
turma_id smallint unsigned not null , 
primary key(aluno_id), 
foreign key(turma_id) references turma(turma_id) on delete restrict);

create table turma (turma_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
grau_ensino varchar(255) not null,
primary key(turma_id));

create table disciplina (disciplina_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
primary key(disciplina_id));

create table professor (professor_id smallint unsigned not null auto_increment,
nome_completo varchar(255) not null,
documento char(11) not null,
primary key(professor_id));

create table grade_aulas_professores (id smallint unsigned not null auto_increment,
dia_semana varchar(50) not null, -- melhor opção tipo enum  
horario varchar(50) not null,  -- tipo time, sendo: coluna de horario_inicio e horario_fim
professor_id smallint unsigned not null,
turma_id smallint unsigned not null,
disciplina_id smallint unsigned not null,
primary key(id),
unique key aulas_professor (professor_id, turma_id, disciplina_id), -- restriçao 
foreign key(professor_id) references professor(professor_id) on delete restrict,
foreign key(turma_id) references turma(turma_id) on delete restrict,
foreign key(disciplina_id) references disciplina(disciplina_id) on delete restrict);

alter table grade_aulas_professores MODIFY COLUMN dia_semana enum ('segunda-feira', 'terca-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira');

alter table grade_aulas_professores  add unique key aulas_professor (professor_id, turma_id, disciplina_id); -- adicionar dia semana para cada linha ser unica

create table avaliacoes_aplicadas (id smallint unsigned not null auto_increment,
nome varchar(50) not null,
nota float not null,
data_aplicacao date not null,
professor_id smallint unsigned not null,
turma_id smallint unsigned not null,
aluno_id smallint unsigned not null,
disciplina_id smallint unsigned not null,
primary key(id),
key avaliacoes_aluno(id, professor_id, turma_id, aluno_id, disciplina_id),
foreign key(professor_id) references professor(professor_id) on delete restrict,
foreign key(turma_id) references turma(turma_id) on delete restrict,
foreign key(aluno_id) references aluno(aluno_id) on delete restrict,
foreign key(disciplina_id) references disciplina(disciplina_id) on delete restrict);