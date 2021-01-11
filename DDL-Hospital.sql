create database hospitalarMentoriaSql;
use hospitalarMentoriaSql;

create table especialidade (especialidade_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
primary key(especialidade_id));

create table setor (setor_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
local varchar(255) not null,
primary key(setor_id));

create table medico (medico_id smallint unsigned not null auto_increment,
nome_completo varchar(255) not null,
documento char(11) not null,
crm varchar(50) not null,
primary key(medico_id));

create table paciente (paciente_id smallint unsigned not null auto_increment,
nome_completo varchar(255) not null,
documento char(11) not null,
data_nascimento date not null,
sexo varchar(50) not null,  -- melhor tipo enum
tipo_sanguineo varchar(50) not null, -- melhor tipo enum
primary key(paciente_id));

alter table paciente MODIFY COLUMN sexo enum ('masculino', 'feminino');
alter table paciente MODIFY COLUMN tipo_sanguineo enum ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-');

create table medicamento (medicamento_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
fabricante varchar(255) not null,
dosagem varchar(255) not null,
primary key(medicamento_id));

create table especialidades_medico (id smallint unsigned not null auto_increment,
medico_id smallint unsigned not null,
especialidade_id smallint unsigned not null,
setor_id smallint unsigned not null,
primary key(id),
key medico_especialidades(especialidade_id, medico_id),
foreign key(especialidade_id) references especialidade(especialidade_id) on delete restrict,
foreign key(medico_id) references medico(medico_id) on delete restrict,
foreign key(setor_id) references setor(setor_id) on delete restrict);

create table consulta (id smallint unsigned not null auto_increment,
prontuario_id smallint unsigned not null,
medico_id smallint unsigned not null,
setor_id smallint unsigned not null,
data_consulta date not null,
primary key(id),
key consultas_paciente(id, prontuario_id),
foreign key(prontuario_id) references prontuario(prontuario_id) on delete restrict,
foreign key(medico_id) references medico(medico_id) on delete restrict,
foreign key(setor_id) references setor(setor_id) on delete restrict);

create table prontuario (prontuario_id smallint unsigned not null auto_increment,
paciente_id smallint unsigned not null,
data_atualizacao date not null,  -- melhor tipo date time
primary key(prontuario_id),
key prontuario_paciente(prontuario_id, paciente_id),
foreign key(paciente_id) references paciente(paciente_id) on delete restrict);

create table receita (receita_id smallint unsigned not null auto_increment,
medico_id smallint unsigned not null,
paciente_id smallint unsigned not null,
data_receita date not null,
primary key(receita_id),
foreign key(medico_id) references medico(medico_id) on delete restrict,
foreign key(paciente_id) references paciente(paciente_id) on delete restrict);

create table exame (exame_id smallint unsigned not null auto_increment,
setor_id smallint unsigned not null,
nome varchar(255) not null,
primary key(exame_id),
foreign key(setor_id) references setor(setor_id) on delete restrict);

create table resultado_exame (id smallint unsigned not null auto_increment,
exame_id smallint unsigned not null,
prontuario_id smallint unsigned not null,
resultado_exame varchar(255) not null,
primary key(id),
foreign key(exame_id) references exame(exame_id) on delete restrict,
foreign key(prontuario_id) references prontuario(prontuario_id) on delete restrict);

create table lista_medicamentos_receita (id smallint unsigned not null auto_increment,
receita_id smallint unsigned not null,
medicamento_id smallint unsigned not null,
primary key(id),
key medicamento_receita(id, receita_id),
foreign key(receita_id) references receita(receita_id) on delete restrict,
foreign key(medicamento_id) references medicamento(medicamento_id) on delete restrict);