-
CREATE TABLE IF NOT EXISTS Dieta (
  cod_dieta INTEGER NOT NULL,
  autoria VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_dieta));

CREATE UNIQUE INDEX cod_dieta_UNIQUE ON Dieta (cod_dieta ASC);


-- -----------------------------------------------------
-- Table Administrador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Administrador (
  CRA INTEGER NOT NULL,
  cod_usuario_adm INTEGER,
  PRIMARY KEY (cod_usuario_adm));


 ALTER TABLE Administrador 
 ADD FOREIGN KEY (cod_usuario_adm)
    REFERENCES Profissional (cod_usuario);


CREATE INDEX fk_Administrador_Profissional2_idx ON Administrador (cod_usuario_adm ASC);


-- -----------------------------------------------------
-- Table Profissional
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Profissional (
  cod_usuario INTEGER NOT NULL,
  nome VARCHAR(100) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  situacao INTEGER NOT NULL,
  fone BIGINT NOT NULL,
  data DATE NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  cod_usuario_adm INTEGER ,
  PRIMARY KEY (cod_usuario));
    
    ALTER TABLE Profissional ADD 
    FOREIGN KEY (cod_usuario_adm)
    REFERENCES Administrador (cod_usuario_adm);

CREATE UNIQUE INDEX cod_usuario_UNIQUE ON Profissional (cod_usuario ASC);

CREATE UNIQUE INDEX email_UNIQUE ON Profissional (email ASC);

CREATE INDEX fk_Profissional_Administrador1_idx ON Profissional (cod_usuario_adm ASC);


-- -----------------------------------------------------
-- Table Nutricionista
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Nutricionista (
  CRN DECIMAL(10,0) NOT NULL,
  cod_usuario_nutri INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_nutri),
  CONSTRAINT fk_Nutricionista_Profissional1
  	
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Profissional (cod_usuario));

-- -----------------------------------------------------
-- Table Medico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Medico (
  CRM DECIMAL(10,0) NOT NULL,
  especialidade VARCHAR(45) NOT NULL,
  cod_usuario_med INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_med),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table enfermeiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS enfermeiro (
  COREN DECIMAL(10,0) NOT NULL,
  especialidade VARCHAR(45) NULL,
  cod_usuario_enf INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_enf),
    FOREIGN KEY (cod_usuario_enf)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Paciente (
  CPF VARCHAR(11) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  sexo INTEGER NOT NULL,
  data_nasc DATE NOT NULL,
  rua VARCHAR(100) NULL,
  bairro VARCHAR(50) NULL,
  numero INTEGER NULL,
  CEP DECIMAL(10,0) NULL,
  foto VARCHAR(100) NULL,
  PRIMARY KEY (CPF));



-- -----------------------------------------------------
-- Table Internacao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Internacao (
  seq_intern INTEGER NOT NULL,
  data_saida DATE NULL,
  data_ent DATE NOT NULL,
  procedim TEXT NULL,
  dec_atual TEXT NULL,
  alergia TEXT NULL,
  incapaci TEXT NULL,
  estado TEXT NULL,
  doenca TEXT NOT NULL,
  andar INTEGER NOT NULL,
  leito VARCHAR(45) NOT NULL,
  quarto VARCHAR(45) NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_usuario_med INTEGER NOT NULL,
  PRIMARY KEY (seq_intern, CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Medico(cod_usuario_med));

CREATE UNIQUE INDEX seq_intern_UNIQUE ON Internacao (seq_intern ASC);

CREATE INDEX fk_Internacao_Paciente1_idx ON Internacao (CPF ASC);

CREATE INDEX fk_Internacao_Medico1_idx ON Internacao (cod_usuario_med ASC);


-- -----------------------------------------------------
-- Table Prescricao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Prescricao (
  data DATE NOT NULL,
  cod_dieta INTEGER NOT NULL,
  seq_intern INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_usuario_nutri INTEGER NOT NULL,
  PRIMARY KEY (cod_dieta, seq_intern, CPF),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta),
    FOREIGN KEY (seq_intern , CPF)
    REFERENCES Internacao (seq_intern , CPF),
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Nutricionista (cod_usuario_nutri));

CREATE INDEX fk_Prescricao_Dieta1_idx ON Prescricao (cod_dieta ASC);

CREATE INDEX fk_Prescricao_Internacao1_idx ON Prescricao (seq_intern ASC, CPF ASC);

CREATE INDEX fk_Prescricao_Nutricionista1_idx ON Prescricao (cod_usuario_nutri ASC);


-- -----------------------------------------------------
-- Table Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cardapio (
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_card));


-- -----------------------------------------------------
-- Table Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Alimento (
  cod_alim INTEGER NOT NULL,
  nome varchar (40) NOT NULL,
  proteina FLOAT NOT NULL,
  gordura FLOAT NOT NULL,
  carboidrato FLOAT NOT  NULL,
  caloria FLOAT NOT NULL,
  PRIMARY KEY (cod_alim));


-- -----------------------------------------------------
-- Table Dieta_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Dieta_Cardapio (
  cod_dieta INTEGER NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_dieta, cod_card),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card));

CREATE INDEX fk_Dieta_has_Cardapio_Cardapio1_idx ON Dieta_Cardapio (cod_card ASC);

CREATE INDEX fk_Dieta_has_Cardapio_Dieta_idx ON Dieta_Cardapio (cod_dieta ASC);


-- -----------------------------------------------------
-- Table Cardapio_Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cardapio_Alimento (
  cod_card INTEGER NOT NULL,
  cod_alim INTEGER NOT NULL,
  quantidade INTEGER NULL,
  PRIMARY KEY (cod_card, cod_alim),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card),
    FOREIGN KEY (cod_alim)
    REFERENCES Alimento (cod_alim));

CREATE INDEX fk_Cardapio_has_Alimento_Alimento1_idx ON Cardapio_Alimento (cod_alim ASC);

CREATE INDEX fk_Cardapio_has_Alimento_Cardapio1_idx ON Cardapio_Alimento (cod_card ASC);


-- -----------------------------------------------------
-- Table Cozinheiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cozinheiro (
  registro INTEGER NOT NULL,
  cod_usuario_coz INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_coz),
    FOREIGN KEY (cod_usuario_coz)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table Cozinheiro_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cozinheiro_Cardapio (
  cod_usuario_coz INTEGER NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_coz, cod_card),
    FOREIGN KEY (cod_usuario_coz)
    REFERENCES Cozinheiro (cod_usuario_coz),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card));

CREATE INDEX fk_Cozinheiro_has_Cardapio_Cardapio1_idx ON Cozinheiro_Cardapio (cod_card ASC);

CREATE INDEX fk_Cozinheiro_has_Cardapio_Cozinheiro1_idx ON Cozinheiro_Cardapio (cod_usuario_coz ASC);


-- -----------------------------------------------------
-- Table Nutricionista_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Nutricionista_Paciente (
  cod_usuario_nutri integer NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (cod_usuario_nutri, CPF),
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Nutricionista (cod_usuario_nutri),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_Nutricionista_has_Paciente_Paciente1_idx ON Nutricionista_Paciente (CPF ASC);

CREATE INDEX fk_Nutricionista_has_Paciente_Nutricionista1_idx ON Nutricionista_Paciente (cod_usuario_nutri ASC);


-- -----------------------------------------------------
-- Table Medico_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Medico_Paciente (
  cod_usuario_med INTEGER NOT NULL,
  CPF VARCHAR(11)NOT NULL,
  PRIMARY KEY (cod_usuario_med, CPF),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Medico (cod_usuario_med),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_Medico_has_Paciente_Paciente1_idx ON Medico_Paciente (CPF ASC);

CREATE INDEX fk_Medico_has_Paciente_Medico1_idx ON Medico_Paciente (cod_usuario_med ASC);


-- -----------------------------------------------------
-- Table enfermeiro_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS enfermeiro_Paciente (
  cod_usuario_enf INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (cod_usuario_enf, CPF),
    FOREIGN KEY (cod_usuario_enf)
    REFERENCES enfermeiro (cod_usuario_enf),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_enfermeiro_has_Paciente_Paciente1_idx ON enfermeiro_Paciente (CPF ASC);

CREATE INDEX fk_enfermeiro_has_Paciente_enfermeiro1_idx ON enfermeiro_Paciente (cod_usuario_enf ASC);


-- -----------------------------------------------------
-- Table OBS_Internacao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OBS_Internacao (
  CPF VARCHAR(11) NOT NULL,
  seq_intern INTEGER NOT NULL,
  observacao VARCHAR(45) NULL,
  seq_obs INTEGER NOT NULL,
  PRIMARY KEY (CPF, seq_intern, seq_obs),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF),
    FOREIGN KEY (seq_intern)
    REFERENCES Internacao (seq_intern));

CREATE INDEX fk_Paciente_has_Internacao_Internacao1_idx ON OBS_Internacao (seq_intern ASC);

CREATE INDEX fk_Paciente_has_Internacao_Paciente1_idx ON OBS_Internacao (CPF ASC);



-- -----------------------------------------------------
-- Table Fone_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fone_Paciente (
  seq_fone INTEGER NOT NULL,
  telefone BIGINT NOT NULL,
  CPF VARCHAR (11) NOT NULL,
  PRIMARY KEY (seq_fone,CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF)); 

CREATE INDEX fk_Fone_Paciente_Paciente1_idx ON Fone_Paciente (CPF ASC);


-- -----------------------------------------------------
-- Table Familia_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Familia_Paciente (
  seq_familia INTEGER NOT NULL,
  parentesco VARCHAR(40) NOT NULL,
  nome VARCHAR (100),
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (seq_familia, CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF)
    )
;

CREATE INDEX fk_Familia_Paciente_Paciente1_idx ON Familia_Paciente (CPF ASC);


-- -----------------------------------------------------
-- Table Refeicao_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Refeicao_Cardapio (
  seq_refeicao INTEGER NOT NULL,
  refeicao VARCHAR(45) NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (seq_refeicao, cod_card),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card)
    )
;

CREATE INDEX fk_Refeicao_Cardapio_Cardapio1_idx ON Refeicao_Cardapio (cod_card ASC);


-- -----------------------------------------------------
-- Table Vitamina_Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Vitamina_Alimento (
  seq_vitamina INTEGER NOT NULL,
  vitamina VARCHAR(45) NULL,
  cod_alim INTEGER NOT NULL,
  PRIMARY KEY (seq_vitamina, cod_alim),
    FOREIGN KEY (cod_alim)
    REFERENCES Alimento (cod_alim)
    )
;

CREATE INDEX fk_Vitamina_Alimento_Alimento1_idx ON Vitamina_Alimento (cod_alim ASC);


-- -----------------------------------------------------
-- Table Internacao_Dieta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Internacao_Dieta (
  seq_intern INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_dieta INTEGER NOT NULL,
  PRIMARY KEY (seq_intern, CPF, cod_dieta),
    FOREIGN KEY (seq_intern , CPF)
    REFERENCES Internacao (seq_intern , CPF),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta));

CREATE INDEX fk_Internacao_has_Dieta_Dieta1_idx ON Internacao_Dieta (cod_dieta ASC);

CREATE INDEX fk_Internacao_has_Dieta_Internacao1_idx ON Internacao_Dieta (seq_intern ASC, CPF ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




-------------------------- SEQUENCES--------------------------

CREATE SEQUENCE sequence_profissional;
CREATE SEQUENCE sequence_dieta ;
CREATE SEQUENCE sequence_cardapio;
CREATE SEQUENCE sequence_alimento;


----------------------------------------USUARIO ESPECIAL ADMINISTRADOR-------------------------------------------------------

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( '123','EVillyn Milena','7656789','evillynmilena@gmail.com','1','16997231009','2019.11.20','administrador', '123');

INSERT INTO administrador (cra,cod_usuario_adm) VALUES ('4213','123');

------------------------------------------INSERT PROFISSIONAL----------------------------------------------------------------
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Maria José de Oliveira','78780','maria@gmail.com','1','1698654367','2013.10.22','cozinheira', '123');

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Marcelo Rosa','97766556','drmarcelo@gmail.com','1','16936547521','2016.10.02','medico', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Ricardo Pereira','78780','ricardo@gmail.com','1','16985643671','2011.02.04','enfermeiro', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Paula Souza','877339202','nutripaula@gmail.com','1','1698783398','2018.12.07','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Pedro','112457','drpepaulo@gmail.com','0','16915426253','2009.11.13','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Pedro Damião','125743','drpedro@gmail.com','1','16864745941','2017.10.20','medico', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Leonardo Gavioli','452654','gavioli@gmail.com','1','16963214587','2018.06.15','medico', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Keila Melo','265478','drakeila@gmail.com','1','16964904532','2016.10.02','medica', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Bianca Dias','564871','dradias@gmail.com','1','16923548595','2011.01.22','medica', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Luciana Barbosa','25547','dralubarb@gmail.com','1','16956847125','2002.05.06','medica', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Neide Machado','4528755','neidee@gmail.com','1','16923856579','2010.11.12','cozinheira', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Lorena Almeida','2447895','lo_almeida@gmail.com','1','16975489631','2014.04.13','cozinheira', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'José Gabriel Silva','855421','josegab@gmail.com','1','16912479532','2016.06.25','cozinheiro', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Gabriele Teixeira','552316','gabiiteixeira@gmail.com','1','16988564941','2001.02.01','cozinheira', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Julia Prado','2556987','juliaprado@gmail.com','1','16995863475','2010.03.10','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Pedro Paulo Fernandes','112457','drpaulo@gmail.com','1','16915426253','2009.11.13','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Damião Arruda','265478','daminutri@gmail.com','1','16926547895','2017.10.14','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Gregorio de Souza','25789595','n_greg@gmail.com','1','16933654598','2002.04.16','nutricionista', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Dionisio Leao','547854','didienf@gmail.com','1','16954752156','2005.12.23','enfermeiro', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Sabrina Bonora','56478','sabrinabonora@gmail.com','1','16944785968','2001.02.03','enfermeira', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Lidia Figueireido','0223188','lidiaf@gmail.com','1','16955478996','2005.06.03','enfermeira', '123');
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Larissa Miyuki','254487','enflari@gmail.com','1','16999547502','2011.10.29','enfermeira', '123');


---------------------------------------INSERT ALIMENTOS------------------------------------------------------------------

INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'Abobora cozida','1.4','0.7','10.28','48');
INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'Batata','0','0','7.2','50');
INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'Arroz','2','0.3','28','130');
INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'Feijão','11','0.593','2.3','77');
INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'Pão integral','11','30.3','54','293');

------------------------------------INSERT CARDAPIO--------------------------------------------------------------------

INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));
INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));

----------------------------------------INSERT CARDAPIO ALIMENTO --------------------------------------

INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('01','01','100');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('02','05','20');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('01','03','50');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('03','04','100');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('03','03','4050');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('05','02','60');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('05','01','70');
INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('05','04','50');

------------------------------------------INSERT DIETA-------------------------------------------------

INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'Natural','Paula Souza');

INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'Saudavel','Paula Souza');
INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'Diabetes','Julia Prado');
INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'Pouco sodio','Damiao Arruda');
INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'Perda de peso','Julia Prado');
 
 --------------------------------------INSERT DIETA CARDAPIO-------------------------------------------

INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('1','1');
INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('2','1');
INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('5','5');
INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('3','4');
INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('1','2');

------------------------------------- INSERT COZINHEIRO---------------------------------------------

INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('87655343','1');
INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('95843486','10');
INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('75922389','11');
INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('87655340','12');
INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('85752365','13');

------------------------------------ INSERT COZINHEIRO CARDAPIO -----------------------------------

INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('1','1');
INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('2','10');
INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('2','11');
INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('3','13');
INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('3','12');

------------------------------------- INSERT ENFERMEIRO --------------------------------------

INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('09987652','Intensivista','4');
INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('12058478','Geral','18');
INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('12058478','Pediatra','19');
INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('12058478','Geral','20');
INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('12058478','Intensivista','21');



------------------------------------INSERT PACIENTE------------------------------------------

INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('97542156789','José Carlos','01','1980.02.11','São sebatião','Centro','22','14120000');

INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('24096765023','Kelly da Silva','02','1999.12.11','Minas Gerais','Vila Nova','156','14010150');
INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('79981777056','Monique de Azevedo','02','1991.05.09','Sete de Setembro','Novo Mundo','266','14010180');
INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('52128439019','Juan Novais','01','1980.02.12','Guatambu','Jardim Recreio','739','14010040');
INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('60490441041','Francisco de Assis','01','1975.11.11','Pau Brasil','Bom Retiro','569','14010260');
INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('14024025031','Daniel Fagundes','01','1989.05.17','','Boa Vista','366','14010279');
INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('98241789658','Carmem Joséfa','02','2000.03.20','Felicio de Souza','Bela Vista','661','14010272');

---------------------------------INSERT ENFERMEIRO PACIENTE ---------------------------

INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('04','97542156789');
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('18','24096765023');
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('20','79981777056');
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('21','52128439019');
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('18','14024025031');
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('04','98241789658');


---------------------------------- INSERT FAMILIA PACIENTE-----------------------------

INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Irmã','Lurdes de Ffatima','97542156789');
INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Mãe','Maiara de Azevedo','79981777056');
INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('02','Pai','Paulo de Azevedo','79981777056');
INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Esposa','Dominique Novais','52128439019');
INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Irm','Fatima Fagundes','14024025031');
INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Mãe','Fabricia Santos','98241789658');


--------------------------------- INSERT FONE PACIENTE------------------------------

INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16993261653','97542156789');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16989214456','24096765023');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16994223187','79981777056');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16920520550','52128439019');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16956002660','60490441041');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16998753960','14024025031');
INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16993582478','98241789658');

-----------------------------------INSERT MEDICO------------------------------

INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('454527','2','Clinico');

INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('922453','5','Clinico Geral');
INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('822214','6','Cirurgião');
INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('601254','7','Anestesista');
INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('847560','8','Cardiologista');
INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('961423','9','Clinico Geral');

----------------------------------------INSERT MEDICO PACIENTE ------------------------------------

INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('2','97542156789');
INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('5','24096765023');
INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('6','79981777056');
INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('6','60490441041');
INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('9','14024025031');
INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('9','98241789658');

---------------------------------- INSERT INTERNACAO-----------------------------------------------

INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'01','2019.11.09','2019.11.20','Entubação','consciente e falando','Não','Não','Bom','diabetes tipo 1','02','502','18','97542156789','2');
INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'01','2019.11.25','2019.12.04','Retirada de pedra no rim','Consciente e falando','Não','Não','Bom','Não','01','101','05','79981777056','5');
INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'01','2018.08.02','2019.09.10','Anemia','Consciente e falando','Amendoim','Não','Fébril e desidratado','Dengue','02','501','18','14024025031','9');
INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'01','2017.11.03','2017.11.20','Marca-passotubação','Consciente com dores fortes','Não','Cadeirante','Regular','Não','03','303','10','52128439019','8');
INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'02','2018.10.08','2018.11.06','Parada Cardiaca','Inconsciente','Não','Cadeirante','Grave','Não','01','101','05','52128439019','8');
INSERT INTO internacao (cod_intern, seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) VALUES(NEXTVAL('sequence_internacao'),'01','2019.02.03','2019.03.05','Anemia','Consciente e falando','Não','Não','Fébril e desidratado','Dengue','01','102','19','98241789658','9');


----------------------------------INSERT INTERNACAO DIETA--------------------------------------

INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','97542156789','03');
INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','79981777056','04');
INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','14024025031','02');
INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','52128439019','05');
INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('02','52128439019','05');
INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','98241789658','05');

----------------------------------- INSERT NUTRICIONISTA----------------------

INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('004887583','03');
INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('026526544','14');
INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('325478451','15');
INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('664872135','16');
INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('147896320','17');

--------------------------------INSERT PACIENTE NUTRICIONISTA-------------------

INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('03','97542156789');
INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('14','79981777056');
INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('15','14024025031');
INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('16','52128439019');
INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('17','52128439019');

---------------------------------INSERT OBS_Internacao-------------------------------------

INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('97542156789','01','01','Não apresentou piora do quadro');
INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('79981777056','01','01','Não apresentou piora do quadro');
INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('14024025031','01','01','Houve melhora nos sintomas, aumento das hemácias da doença');
INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('52128439019','02','01','Houve piora do quadro do paciente');
INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('52128439019','02','02','O paciente foi a óbito');

---------------------------------INSERT REFEICAO CARDAPIO----------------------------------
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('02','Almoço','01');
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('03','Janta','01');
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('04','Almoço','05');
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('05','Janta','04');
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('02','Almoço','03');

---------------------------- INSERT VITAMINA-------------------------------------------------
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('01','Vitamina C','01');
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('02','Vitamina B','02');
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('03','Vitamina E','03');
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('04','Vitamina B1','04');
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('02','Vitamina B','05');

-----------------------------INSERT PRESCRICAO---------------------------------------------------------
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2019.11.20','03','01','97542156789','03');
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2019.11.25','04','01','79981777056','014');
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2018.09.02','02','01','14024025031','015');
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2017.11.03','05','01','52128439019','016');
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2018.10.25','05','02','52128439019','017');










