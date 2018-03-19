CREATE OR REPLACE PROCEDURE creer_repond(presultat_reponse IN ZZW2090A.REPOND.RESULTAT_REPONSE%TYPE,
  preponse_repondue IN ZZW2090A.REPOND.REPONSE_REPONDUE%TYPE,
  pid_logo IN ZZW2090A.LOGO.ID_LOGO%TYPE,
  pid_partie IN ZZW2090A.PARTIE.ID_PARTIE%TYPE ) IS
    check_exception EXCEPTION;
    foreign_key_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(check_exception,-2290);
  PRAGMA EXCEPTION_INIT(foreign_key_exception,-2291);
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN

    INSERT INTO ZZW2090A.REPOND(ID_LOGO,ID_PARTIE,DATE_REPONSE,RESULTAT_REPONSE,REPONSE_REPONDUE)
    VALUES (pid_logo,pid_partie,CURRENT_TIMESTAMP,presultat_reponse,preponse_repondue);

    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20011,'Vous avez déjà répondu dans cette partie à cette question ! ');
    WHEN check_exception THEN
    RAISE_APPLICATION_ERROR(-20007,'Le résultat de la réponse doit être entre 0 et 1');
    WHEN foreign_key_exception THEN
    IF(SQLERRM  = '%fk_repond_logo%') THEN
      RAISE_APPLICATION_ERROR(-20008,'La référence de ce logo n''existe pas');
    ELSE
      RAISE_APPLICATION_ERROR(-20009,'La référence de cette partie n''existe pas');
    END IF;
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END creer_repond;