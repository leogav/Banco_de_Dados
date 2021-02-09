-- Func (cod_func, nome, dta_nasc, salário, nro_depto ce , cod_superv ce )
-- Depto (nro_depto, nome, cod_ger ce )
-- Projeto (cod_proj, nome, duração, nro_depto ce )
-- Participa (cod_proj ce , cod_func ce , horas_trab)

-- 6)Crie um gatilho para que, quando houver uma exclusão de projeto, exclua todas as
-- participações do mesmo


CREATE FUNCTION exclui_proj_part() RETURNS OPAQUE AS
' BEGIN
DELETE FROM Participa
WHERE cod_proj = OLD.cod_proj;
RETURN NULL;
END;
' LANGUAGE 'plpgsql';


CREATE TRIGGER tg_exclui_proj_part
AFTER DELETE ON Projeto FOR EACH ROW
EXECUTE PROCEDURE exclui_proj_part();


-- 7) Crie um gatilho que não permita que se reduza o salário de um funcionário, emitindo uma
-- msg de erro caso se tente fazer isso

CREATE FUNCTION protecao_salario_func() RETURNS OPAQUE AS
' BEGIN
IF (NEW.salário < OLD.salário) THEN
	RAISE NOTICE ''O novo salario deve ser maior que o anterior'';
	RETURN NULL;
ELSE
	RETURN NEW;
ENDIF;
END;
' LANGUAGE 'plpgsql';


CREATE TRIGGER tg_protecao_salario_func
BEFORE UPDATE ON Projeto FOR EACH ROW
EXECUTE PROCEDURE protecao_salario_func();



-- 8) Altere o exercício 4, deixando também como parâmetro da função o ano de divisão dos
-- aumentos.

CREATE OR REPLACE FUNCTION aumenta_sal (NUMERIC, NUMERIC, NUMERIC)
RETURNS BOOLEAN
AS
'
DECLARE cs_Func CURSOR
	(pc_aumento_velhos NUMERIC, pc_aumento_novos NUMERIC, ano_divisao NUMERIC )
	FOR SELECT * FROM Func;
	v_um_func Func%RowType;
BEGIN
	OPEN cs_Func ($1, $2, $3);
		FETCH cs_Func INTO v_um_func;
			WHILE FOUND LOOP
				IF (EXTRACT (YEAR FROM v_um_func.dta_nasc) < ano_divisao) THEN
					UPDATE Func SET salario = salario * (1 + pc_aumento_velhos
					/ 100) WHERE cod_func = v_um_func.cod_func;
				ELSE
					UPDATE Func SET salario = salario * (1 + pc_aumento_novos
					/ 100) WHERE cod_func = v_um_func.cod_func;
				END IF;
				FETCH cs_Func INTO v_um_func;
			END LOOP;
	CLOSE cs_Func;
	RETURN ''t'';
END;
'
LANGUAGE 'plpgsql';