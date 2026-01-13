create or replace package pkg_cliente as


function fn_validar_email(p_email in tb_cliente.email%type) return number;

function fn_normalizar_cep(p_cep in tb_cliente.cep%type) return varchar2;

procedure prc_deletar_cliente(p_id_cliente in tb_cliente.id_cliente%type);
  
procedure prc_listar_clientes(p_nome tb_cliente.nome%type, p_email tb_cliente.email%type, p_rc out sys_refcursor);
  
  
end pkg_cliente;
/
create or replace package body pkg_cliente as

function fn_validar_email (p_email in tb_cliente.email%type) return number -- retorna 1 para válido, 0 para inválido
is
  v_regex varchar2(100) := '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$';
  v_retorno number := 0;
begin

  if regexp_like(upper(p_email), v_regex) then
    v_retorno := 1;
  end if;

  return v_retorno;
  
end;

function fn_normalizar_cep (p_cep in tb_cliente.cep%type) return varchar2
is
  v_cep varchar2(8);
begin

  v_cep := regexp_replace(p_cep, '[^0-9]', ''); 

  if length(v_cep) != 8 then
     v_cep := null;
  end if;

  return v_cep;

end;

procedure prc_deletar_cliente(p_id_cliente in tb_cliente.id_cliente%type)
as
begin
  
  delete from tb_cliente where id_cliente = p_id_cliente;
  
end;

procedure prc_listar_clientes(p_nome tb_cliente.nome%type, p_email tb_cliente.email%type, p_rc out sys_refcursor)
as

v_sql   varchar2(4000);

begin
  
  v_sql := 'SELECT ID_CLIENTE,NOME,EMAIL,CEP,LOGRADOURO,BAIRRO,CIDADE,UF,ATIVO,DT_CRIACAO,DT_ATUALIZACAO FROM tb_cliente WHERE 1=1 ';
  
  if p_nome is not null then
    v_sql := v_sql || ' AND UPPER(NOME) LIKE UPPER(''%' || p_nome || '%'')';
  end if;
  
  if p_email is not null then
      v_sql := v_sql || ' AND UPPER(email) LIKE UPPER(''%' || p_email || '%'')';
  end if;

  --dbms_output.put_line(v_sql);
  open p_rc for v_sql;
exception
    when others then
        dbms_output.put_line('Erro : ' || sqlerrm ||chr(13)||'SQL: '||chr(13)||v_sql);
  
end;

end pkg_cliente;
/
