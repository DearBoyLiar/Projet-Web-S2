CREATE OR REPLACE TRIGGER trigger_blocage
  FOR INSERT ON ZZW2090A.PARTIE
  COUMPOUND TRIGGER
  BEFORE EACH ROW IS
  DECLARE
    nb_partie_perdues_heure NUMBER=0;
  BEGIN

    SELECT COUNT(*) INTO nb_partie_perdues_heure FROM ZZW2090A.PARTIE WHERE DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '1' hour) AND STATUT='P';

    IF nb_partie_perdues_heure >= 5  THEN
      RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
    END IF;
  END;