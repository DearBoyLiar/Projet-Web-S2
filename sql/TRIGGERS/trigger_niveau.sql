CREATE OR REPLACE TRIGGER trigger_blocage
  BEFORE INSERT ON PARTIE
  FOR EACH ROW
  DECLARE
    vexperience utilisateur.experience%TYPE;
  BEGIN

    SELECT EXPERIENCE INTO vexperience FROM UTILISATEUR WHERE PSEUDO = :NEW.PSEUDO;

    IF :NEW.niveau > vexperience THEN
      RAISE_APPLICATION_ERROR(-20009,'Ce niveau n''est pas accessible, vous n''avez pas l''exérience requise');
    END IF;
  END;

