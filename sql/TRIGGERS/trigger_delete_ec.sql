CREATE OR REPLACE TRIGGER trigger_delete_ec
  FOR UPDATE ON ZZW2090A.PARTIE
  COMPOUND TRIGGER
  AFTER STATEMENT IS
  nb_ec NUMBER;
  BEGIN
    SELECT COUNT(*)  INTO nb_ec FROM ZZW2090A.PARTIE WHERE STATUT='EC';
    IF nb_ec > 0 THEN
        DELETE FROM ZZW2090A.PARTIE WHERE STATUT='EC';
    END IF;
  END AFTER STATEMENT;
END;