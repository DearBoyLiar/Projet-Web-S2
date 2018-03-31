CREATE OR REPLACE PROCEDURE update_partie(pid_partie IN ZZW2090A.PARTIE.ID_PARTIE%TYPE,pstatut IN ZZW2090A.PARTIE.STATUT%TYPE,
  pscore IN ZZW2090A.PARTIE.SCORE%TYPE,ppseudo IN ZZW2090A.UTILISATEUR.PSEUDO%TYPE,pniveau IN ZZW2090A.NIVEAU.NIVEAU%TYPE) IS
  check_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(check_exception,-2290);
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN
    UPDATE ZZW2090A.PARTIE SET STATUT=pstatut, SCORE = pscore WHERE ID_PARTIE=pid_partie;

    IF pstatut='G' THEN
        update_exp_utilisateur(ppseudo,pniveau);
    END IF;

    DELETE FROM ZZW2090A.PARTIE WHERE STATUT='EC';
    COMMIT;
  EXCEPTION
    WHEN check_exception THEN
    RAISE_APPLICATION_ERROR(-20011,'Le statut doit être soit EC (en cours), soit G (gagné), soit P (perdu)');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END update_partie;
