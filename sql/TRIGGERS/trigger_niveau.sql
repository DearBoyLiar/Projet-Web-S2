CREATE OR REPLACE TRIGGER trigger_niveau
  BEFORE INSERT ON PARTIE
  FOR EACH ROW
  DECLARE
    vexperience ZZW2090A.UTILISATEUR.experience%TYPE;
  BEGIN
    SELECT EXPERIENCE INTO vexperience FROM ZZW2090A.UTILISATEUR WHERE PSEUDO = :NEW.PSEUDO;

    IF :NEW.NIVEAU > vexperience THEN
      RAISE_APPLICATION_ERROR(-20014,'Ce niveau n''est pas accessible, vous n''avez pas l''exérience requise');
    END IF;
  END;
