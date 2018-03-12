CREATE OR REPLACE PROCEDURE creer_partie(pniveau IN partie.NIVEAU%TYPE,ppseudo IN partie.PSEUDO%TYPE,
  pid_collection OUT COLLECTION.ID_COLLECTION%TYPE,pid_partie OUT PARTIE.ID_PARTIE%TYPE ) IS
  vtemps NUMBER;
  vid_partie PARTIE.ID_PARTIE%TYPE;
  vid_collection COLLECTION.ID_COLLECTION%TYPE;
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
    END IF;

    INSERT INTO PARTIE(ID_PARTIE,TEMPS,DATE_PARTIE,PSEUDO,NIVEAU,STATUT,SCORE)
    VALUES (SEQ_PARTIE_ID_PARTIE.nextval,vtemps,CURRENT_TIMESTAMP,ppseudo,pniveau,'EC',0);

    SELECT MAX(ID_PARTIE) INTO vid_partie FROM PARTIE;

    SELECT ID_COLLECTION INTO vid_collection FROM NIVEAU WHERE NIVEAU=pniveau;

    pid_partie := vid_partie;
    pid_collection := vid_collection;

    COMMIT;
    EXCEPTION
    WHEN NO_DATA_FOUND  THEN
    RAISE_APPLICATION_ERROR(-20010,'Ce niveau n''est pas présent dans la BD');
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
  END creer_partie;