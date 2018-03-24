CREATE OR REPLACE TRIGGER trigger_niveau
  BEFORE UPDATE ON PARTIE
  FOR EACH ROW
  DECLARE
  BEGIN
    IF :NEW.statut='G' THEN
         update_exp_utilisateur(:NEW.pseudo,:NEW.niveau);
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20012,'Ce pseudo n''existe pas');
        WHEN OTHERS  THEN
        ecode := SQLCODE;
        errm :=SQLERRM;
        RAISE_APPLICATION_ERROR(ecode,errm);
  END;