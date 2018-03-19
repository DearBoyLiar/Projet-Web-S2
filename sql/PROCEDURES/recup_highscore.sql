CREATE OR REPLACE TYPE pseudos as table of VARCHAR(255);
CREATE OR REPLACE TYPE dates as table of DATE;
CREATE OR REPLACE TYPE scores as table of NUMBER;

CREATE OR REPLACE PROCEDURE recup_highscore(pniveau IN ZZW2090A.NIVEAU.NIVEAU%TYPE,pmode IN NUMBER,
                                            ppseudos OUT pseudos,pdates OUT dates,pscores OUT scores) AS
  BEGIN
    IF pmode=0 THEN
      SELECT PSEUDO,DATE_PARTIE,SCORE
      BULK COLLECT into ppseudos, pdates,pscores
      FROM ZZW2090A.PARTIE
      WHERE NIVEAU = pniveau
            AND DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '1' minute)
      ORDER BY SCORE DESC;
    ELSIF pmode=1 THEN
      SELECT PSEUDO,DATE_PARTIE,SCORE
      BULK COLLECT into ppseudos, pdates,pscores
      FROM ZZW2090A.PARTIE
      WHERE NIVEAU = pniveau
            AND DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '1' hour)
      ORDER BY SCORE DESC;
    ELSIF pmode=2 THEN
      SELECT PSEUDO,DATE_PARTIE,SCORE
      BULK COLLECT into ppseudos, pdates,pscores
      FROM ZZW2090A.PARTIE
      WHERE NIVEAU = pniveau
      ORDER BY SCORE DESC;
    END IF;
  END;