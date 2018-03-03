CREATE OR REPLACE PROCEDURE recup_experience(ppseudo IN utilisateur.PSEUDO%TYPE, pexperience OUT utilisateur.EXPERIENCE%TYPE) IS
  vexperience utilisateur.EXPERIENCE%TYPE;
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN
    -- SELECT SUR NIVEAU POUR RECUP ID_COLLECTION
    SELECT EXPERIENCE into vexperience from utilisateur where PSEUDO=ppseudo;
    pexperience := vexperience;

    EXCEPTION
    WHEN NO_DATA_FOUND  THEN
    raise_application_error(-20003,'Ce pseudo n''existe pas ! ');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);

  END;
