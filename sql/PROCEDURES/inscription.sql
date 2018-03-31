CREATE OR REPLACE PROCEDURE inscription(ppseudo ZZW2090A.UTILISATEUR.PSEUDO%TYPE ,
  ppassword ZZW2090A.UTILISATEUR.MOT_DE_PASSE%TYPE) IS
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN
    INSERT INTO ZZW2090A.UTILISATEUR(PSEUDO, MOT_DE_PASSE,DATE_INSCRIPTION,EXPERIENCE)
    VALUES (ppseudo,ppassword,CURRENT_TIMESTAMP,1);


    INSERT INTO ZZW2090A.PARTIE(ID_PARTIE,TEMPS,DATE_PARTIE,PSEUDO,NIVEAU,STATUT,SCORE)
    VALUES (SEQ_PARTIE_ID_PARTIE.nextval,300,CURRENT_TIMESTAMP,'laura',1,'EC',0);

    COMMIT;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20001,'Ce compte existe déjà !');
    WHEN OTHERS THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END inscription;