create or replace PROCEDURE creer_partie(pniveau IN ZZW2090A.PARTIE.NIVEAU%TYPE,ppseudo IN ZZW2090A.PARTIE.PSEUDO%TYPE,
                                         pid_collection OUT ZZW2090A.COLLECTION.ID_COLLECTION%TYPE,
                                         pid_partie OUT ZZW2090A.PARTIE.ID_PARTIE%TYPE,
                                         ptemps OUT ZZW2090A.PARTIE.TEMPS%TYPE,
                                         pretour OUT NUMBER) IS
  vtemps NUMBER;
  vid_partie ZZW2090A.PARTIE.ID_PARTIE%TYPE;
    check_exception EXCEPTION;
    foreign_key_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(check_exception,-2290);
  PRAGMA EXCEPTION_INIT(foreign_key_exception,-2291);
  ecode NUMBER;
  errm VARCHAR(255);
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

    INSERT INTO ZZW2090A.PARTIE(ID_PARTIE,TEMPS,DATE_PARTIE,PSEUDO,NIVEAU,STATUT,SCORE)
    VALUES (SEQ_PARTIE_ID_PARTIE.nextval,vtemps,CURRENT_TIMESTAMP,ppseudo,pniveau,'EC',0);

    SELECT MAX(ID_PARTIE) INTO vid_partie FROM ZZW2090A.PARTIE;

    SELECT ID_COLLECTION INTO pid_collection FROM ZZW2090A.NIVEAU WHERE NIVEAU=pniveau;

    pid_partie := vid_partie;
    ptemps := vtemps;
    COMMIT;
    pretour := -10;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    pretour := 3;
    RAISE_APPLICATION_ERROR(-20025,'Le niveau n''existe pas');
    WHEN DUP_VAL_ON_INDEX THEN
    pretour := 4;
    RAISE_APPLICATION_ERROR(-20026,'Cette partie existe déjà ! ');
    WHEN check_exception THEN
    RAISE_APPLICATION_ERROR(-20027,'Le statut doit être soit EC (en cours), soit G (gagné), soit P (perdu)');
    pretour := 5;
    WHEN foreign_key_exception THEN
    IF(SQLERRM  LIKE '%fk_partie_pseudo%') THEN
      pretour := 6;
      RAISE_APPLICATION_ERROR(-20028,'La référence de ce pseudo n''existe pas');
    ELSE
      pretour := 7;
      RAISE_APPLICATION_ERROR(-20024,'La référence de ce niveau n''existe pas');
    END IF;
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    pretour := 8;
    IF(SQLERRM  LIKE '%-20014%') THEN
      pretour := -1;
    elsif (SQLERRM  LIKE '%-20013%') THEN
      pretour := -2;
    end if;
  END creer_partie;