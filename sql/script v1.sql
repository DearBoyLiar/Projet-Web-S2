 ---------------------------------------------------------------
 --        Script Oracle.  
 ---------------------------------------------------------------


------------------------------------------------------------
-- Table: Utilisateur
------------------------------------------------------------
CREATE TABLE utilisateur(
	pseudo            VARCHAR2 (255) NOT NULL  ,
	mot_de_passe      VARCHAR2 (255) NOT NULL  ,
	date_inscription  DATE   NOT NULL,
	experience        NUMBER(10,0),
	CONSTRAINT utilisateur_pk PRIMARY KEY (pseudo)
);

------------------------------------------------------------
-- Table: Partie
------------------------------------------------------------
CREATE TABLE partie(
	id_partie        NUMBER NOT NULL ,
	temps            NUMBER(10,0)   ,
	resultat_partie  NUMBER (1) ,
	date_partie      DATE   ,
	pseudo           VARCHAR2 (255) NOT NULL  ,
	niveau           NUMBER(10,0)   ,
	CONSTRAINT partie_pk PRIMARY KEY (id_partie) ,
	CONSTRAINT ck_boolean_resultat_partie CHECK (resultat_partie IN (0,1))
);

------------------------------------------------------------
-- Table: Logo
------------------------------------------------------------
CREATE TABLE logo(
	id_logo        NUMBER NOT NULL ,
	lien_logo      VARCHAR2 (255)NOT NULL  ,
	reponse        VARCHAR2 (255)NOT NULL  ,
	id_collection  NUMBER(10,0)  NOT NULL,
	CONSTRAINT logo_pk PRIMARY KEY (id_logo) ,
	CONSTRAINT logo_uniq UNIQUE (lien_logo,reponse)
);

------------------------------------------------------------
-- Table: Collection
------------------------------------------------------------
CREATE TABLE collection(
	id_collection  NUMBER NOT NULL ,
	CONSTRAINT collection_Pk PRIMARY KEY (id_collection)
);

------------------------------------------------------------
-- Table: Niveau
------------------------------------------------------------
CREATE TABLE niveau(
	niveau         NUMBER(10,0)  NOT NULL  ,
	nb_logo_gagne  NUMBER(10,0)   ,
	id_collection  NUMBER(10,0)   ,
	CONSTRAINT niveau_pk PRIMARY KEY (niveau)
);

------------------------------------------------------------
-- Table: Repond
------------------------------------------------------------
CREATE TABLE repond(
	resultat_reponse  NUMBER (1) ,
	date_reponse      DATE   ,
	reponse_repondu   VARCHAR2 (25)  ,
	id_logo           NUMBER(10,0)  NOT NULL  ,
	id_partie         NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT repond_Pk PRIMARY KEY (id_logo,id_partie) ,
	CONSTRAINT ck_boolean_resultat_reponse CHECK (resultat_reponse IN (0,1))
);




ALTER TABLE partie ADD FOREIGN KEY (pseudo) REFERENCES utilisateur(pseudo);
ALTER TABLE partie ADD FOREIGN KEY (niveau) REFERENCES niveau(niveau);
ALTER TABLE logo ADD FOREIGN KEY (id_collection) REFERENCES collection(id_collection);
ALTER TABLE niveau ADD FOREIGN KEY (id_collection) REFERENCES collection(id_collection);
ALTER TABLE repond ADD FOREIGN KEY (id_logo) REFERENCES logo(id_logo);
ALTER TABLE repond ADD FOREIGN KEY (id_partie) REFERENCES partie(id_partie);

CREATE SEQUENCE seq_partie_id_partie START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_logo_id_logo START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_collection_id_collection START WITH 1 INCREMENT BY 1 NOCYCLE;


CREATE OR REPLACE TRIGGER partie_id_partie
	BEFORE INSERT ON partie 
  FOR EACH ROW 
	WHEN (NEW.id_partie IS NULL) 
	BEGIN
		 select seq_partie_id_partie.NEXTVAL INTO :NEW.id_partie from DUAL; 
	END;
CREATE OR REPLACE TRIGGER logo_id_logo
	BEFORE INSERT ON logo 
  FOR EACH ROW 
	WHEN (NEW.id_logo IS NULL) 
	BEGIN
		 select seq_logo_id_logo.NEXTVAL INTO :NEW.id_logo from DUAL; 
	END;
CREATE OR REPLACE TRIGGER collection_id_collection
	BEFORE INSERT ON collection 
  FOR EACH ROW 
	WHEN (NEW.id_collection IS NULL) 
	BEGIN
		 select seq_collection_id_collection.NEXTVAL INTO :NEW.id_collection from DUAL; 
	END;
