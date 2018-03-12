CREATE OR REPLACE PROCEDURE update_partie(pid_partie IN PARTIE.ID_PARTIE%TYPE,pstatut IN PARTIE.STATUT%TYPE,
  pscore IN PARTIE.SCORE%TYPE,ppseudo IN UTILISATEUR.PSEUDO%TYPE,pniveau IN NIVEAU.NIVEAU%TYPE) IS
  check_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(check_exception,-2290);
  ecode NUMBER;
  errm VARCHAR(20);
  BEGIN
    UPDATE PARTIE SET STATUT=pstatut, SCORE = pscore WHERE ID_PARTIE=pid_partie;

    IF pstatut='G' THEN
      update_exp_utilisateur(ppseudo,pniveau);
    END IF;

    COMMIT;
  EXCEPTION
    WHEN check_exception THEN
    RAISE_APPLICATION_ERROR(-20011,'Le statut doit être soit EC (en cours), soit G (gagné), soit P (perdu)');
    WHEN OTHERS  THEN
    ecode := SQLCODE;
    errm :=SQLERRM;
    RAISE_APPLICATION_ERROR(ecode,errm);
  END update_partie;
