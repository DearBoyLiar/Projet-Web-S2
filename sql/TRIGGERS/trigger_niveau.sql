CREATE OR REPLACE TRIGGER trigger_blocage
  AFTER INSERT ON PARTIE
  FOR EACH ROW
  DECLARE
    vexperience ZZW2090A.UITLISATEUR.experience%TYPE;
  BEGIN

    SELECT EXPERIENCE INTO vexperience FROM ZZW2090A.UITLISATEUR WHERE PSEUDO = :NEW.PSEUDO;

    IF :NEW.niveau > vexperience THEN
      RAISE_APPLICATION_ERROR(-20009,'Ce niveau n''est pas accessible, vous n''avez pas l''exérience requise');
    END IF;
  END;

