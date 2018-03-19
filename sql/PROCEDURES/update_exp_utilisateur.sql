CREATE OR REPLACE PROCEDURE update_exp_utilisateur(ppseudo IN ZZW2090A.UTILISATEUR.PSEUDO%TYPE,
  pniveau IN ZZW2090A.NIVEAU.NIVEAU%TYPE) IS
  ecode NUMBER;
  errm VARCHAR(20);
  vexperience NUMBER;
  BEGIN

    SELECT EXPERIENCE INTO vexperience FROM ZZW2090A.UTILISATEUR WHERE PSEUDO=ppseudo;

    IF vexperience <= pniveau THEN
      UPDATE ZZW2090A.UTILISATEUR SET EXPERIENCE = pniveau+1 WHERE PSEUDO=ppseudo;
    END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20012,'Ce pseudo n''existe pas');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END update_exp_utilisateur;