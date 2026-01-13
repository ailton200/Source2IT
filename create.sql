----------------------------------
----------------------------------
-- Criando a tabela de clientes --
----------------------------------
----------------------------------
create table TB_CLIENTE
( ID_CLIENTE      number not null,
  NOME            varchar2(255)not null,
  EMAIL           varchar2(255),
  CEP             varchar2(8),            
  LOGRADOURO      varchar2(255),
  BAIRRO          varchar2(100), 
  CIDADE          varchar2(100),
  UF              varchar2(2), 
  ATIVO           varchar2(1) DEFAULT 1, 
  DT_CRIACAO      date DEFAULT SYSTIMESTAMP, 
  DT_ATUALIZACAO  date );  
----------------------------------
----------------------------------
----Criando a sequence------------
----------------------------------
----------------------------------
create sequence SEQ_CLIENTE
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
nocache
cycle;
----------------------------------
----------------------------------
----Criando a trigger-------------
----------------------------------
----------------------------------
CREATE OR REPLACE TRIGGER TRG_CLIENTE_BI
BEFORE INSERT ON TB_CLIENTE  
FOR EACH ROW 
BEGIN  
  :new.ID_CLIENTE := SEQ_CLIENTE.NEXTVAL;
  :new.DT_CRIACAO := sysdate;
END;
----------------------------------
----------------------------------
----Criando as constraints--------
----------------------------------
----------------------------------
alter table TB_CLIENTE add constraint ID_CLIENTE_PK primary key (ID_CLIENTE);
alter table TB_CLIENTE add constraint UK_EMAIL unique (EMAIL);
alter table TB_CLIENTE add constraint CK_UF check (UF IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'));
----------------------------------
----------------------------------
----------------------------------
