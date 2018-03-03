CREATE OR REPLACE PROCEDURE creer_partie(pniveau partie.NIVEAU%TYPE,ppseudo partie.PSEUDO%TYPE) IS
vtemps NUMBER := 300;
BEGIN

  IF (pniveau == 3 OR pniveau == 4) THEN
    vtemps := 240;
  ENF IF;

  IF (pniveau == 5 OR pniveau == 6) THEN
    vtemps := 210;
  ENF IF;

  IF (pniveau == 7 OR pniveau == 8) THEN
    vtemps := 180;
  ENF IF;

  IF (pniveau == 9 OR pniveau == 10) THEN
    vtemps := 150;
  ENF IF;

  INSERT INTO PARTIE(ID_PARTIE,TEMPS,DATE_PARTIE,PSEUDO,NIVEAU,STATUT)
  VALUES ()
END;