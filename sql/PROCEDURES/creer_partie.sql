CREATE OR REPLACE PROCEDURE creer_partie(pniveau partie.NIVEAU%TYPE,ppseudo partie.PSEUDO%TYPE) IS
  vtemps NUMBER;
    check_exception EXCEPTION;
    foreign_key_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(check_exception,-2290);
  PRAGMA EXCEPTION_INIT(foreign_key_exception,-2291);
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN

    IF pniveau = 1 OR pniveau = 2 THEN
      vtemps := 300;
    ELSIF pniveau = 3 OR pniveau = 4 THEN
      vtemps := 240;
    ELSIF pniveau = 5 OR pniveau = 6 THEN
      vtemps := 210;
    ELSIF pniveau = 7 OR pniveau = 8 THEN
      vtemps := 180;
    ELSIF pniveau = 9 OR pniveau = 10 THEN
      vtemps := 150;
    ELSE
      RAISE_APPLICATION_ERROR(-20005,'Ce niveau n''existe pas');
    END IF;

    INSERT INTO PARTIE(ID_PARTIE,TEMPS,DATE_PARTIE,PSEUDO,NIVEAU,STATUT)
    VALUES (SEQ_PARTIE_ID_PARTIE.nextval,vtemps,SYSDATE,ppseudo,pniveau,'EC');

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20006,'Cette partie existe déjà ! ');
    WHEN check_exception THEN
    RAISE_APPLICATION_ERROR(-20007,'Le statut doit être soit EC (en cours), soit G (gagné), soit P (perdu)');
    WHEN foreign_key_exception THEN
    IF(SQLERRM  = '%fk_partie_pseudo%') THEN
      RAISE_APPLICATION_ERROR(-20008,'La référence de ce pseudo n''existe pas');
    ELSE
      RAISE_APPLICATION_ERROR(-20009,'La référence de ce niveau n''existe pas');
    END IF;
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END;