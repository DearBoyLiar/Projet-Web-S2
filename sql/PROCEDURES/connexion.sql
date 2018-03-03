CREATE OR REPLACE PROCEDURE connexion(ppseudo IN UTILISATEUR.PSEUDO%TYPE,
                                      ppassword OUT UTILISATEUR.MOT_DE_PASSE%TYPE) IS
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN
    SELECT MOT_DE_PASSE INTO ppassword FROM UTILISATEUR WHERE PSEUDO=ppseudo;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002,'Aucun tuple portant ce pseudo !');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END;