CREATE OR REPLACE PROCEDURE update_exp_utilisateur(ppseudo IN UTILISATEUR.PSEUDO%TYPE,pniveau IN NIVEAU.NIVEAU%TYPE) IS
  ecode NUMBER;
  errm VARCHAR(20);
  vexperience NUMBER;
  BEGIN

    SELECT EXPERIENCE INTO vexperience FROM UTILISATEUR WHERE PSEUDO=ppseudo;

    IF vexperience <= pniveau THEN
      UPDATE UTILISATEUR SET EXPERIENCE = pniveau+1 WHERE PSEUDO=ppseudo;
    END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20012,'Ce pseudo n''existe pas');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END update_exp_utilisateur;