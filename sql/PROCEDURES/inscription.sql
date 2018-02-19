CREATE OR REPLACE PROCEDURE inscription(ppseudo  UTILISATEUR.PSEUDO%TYPE , ppassword UTILISATEUR.MOT_DE_PASSE%TYPE) IS
  BEGIN
    INSERT INTO UTILISATEUR(PSEUDO, MOT_DE_PASSE,DATE_INSCRIPTION) 
    VALUES (ppseudo,ppassword,SYSDATE);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20001,'Ce compte existe d�j� !');
  END;
