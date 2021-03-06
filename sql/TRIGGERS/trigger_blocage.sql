create or replace TRIGGER trigger_blocage
  FOR INSERT ON ZZW2090A.PARTIE
COMPOUND TRIGGER
  BEFORE EACH ROW IS
      mutating_exc EXCEPTION;
    PRAGMA EXCEPTION_INIT(mutating_exc,-04091);
    nb_partie_perdues_heure NUMBER;
    heure_last_partie_perdue NUMBER;
  BEGIN

    SELECT extract(hour from CAST(TO_CHAR(DATE_PARTIE,'DD-MON-YYYY HH24:MI:SS') as timestamp)) INTO heure_last_partie_perdue FROM ZZW2090A.PARTIE WHERE DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '1' hour) AND ROWNUM =1 AND STATUT='P' AND PSEUDO=:NEW.PSEUDO ORDER BY DATE_PARTIE DESC;
    SELECT COUNT(*) INTO nb_partie_perdues_heure FROM ZZW2090A.PARTIE WHERE DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '1' hour) AND PSEUDO=:NEW.PSEUDO AND STATUT='P';

    IF nb_partie_perdues_heure >= 5 THEN
      IF (heure_last_partie_perdue = 20) THEN
        IF extract(hour from current_timestamp) > 0 THEN
          RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
        END IF;
      ELSIF (heure_last_partie_perdue = 21) THEN
        IF  extract(hour from current_timestamp) >= 0 THEN
          RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
        END IF;
      ELSIF (heure_last_partie_perdue=22) THEN
        IF  extract(hour from current_timestamp) >= 22 OR extract(hour from current_timestamp) < 2 THEN
          RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
        END IF;
      ELSIF (heure_last_partie_perdue = 23) THEN
        IF  extract(hour from current_timestamp) = 23 OR extract(hour from current_timestamp) < 3 THEN
          RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
        END IF;
      ELSE
        IF  extract(hour from current_timestamp) < heure_last_partie_perdue+4 THEN
          RAISE_APPLICATION_ERROR(-20013,'Vous êtes bloqué pour 4 heures car vous avez trop perdu');
        END IF;
      END IF;
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('');
    WHEN mutating_exc THEN
    DBMS_OUTPUT.PUT_LINE('');
  END BEFORE EACH ROW ;
END;