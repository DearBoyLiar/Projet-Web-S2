CREATE OR REPLACE TYPE pseudos  is varray(5)  of VARCHAR(255);
CREATE OR REPLACE TYPE dates is varray(5) of DATE;
CREATE OR REPLACE TYPE scores is varray(5) of NUMBER;

CREATE OR REPLACE PROCEDURE recup_highscore(pniveau IN NIVEAU.NIVEAU%TYPE,pmode IN NUMBER,ppseudos OUT pseudos,pdates OUT dates,pscores OUT scores) IS
vpseudos pseudos := pseudos('stub','stub','stub','stub','stub');
vdates dates := dates('01-MAR-2016','01-MAR-2016','01-MAR-2016','01-MAR-2016','01-MAR-2016');
vscores scores := scores(0,0,0,0,0);
i NUMBER :=1;
CURSOR c_highscore_minute IS SELECT PSEUDO,DATE_PARTIE,SCORE FROM HIGHSCORE_MINUTE WHERE NIVEAU = pniveau;
CURSOR c_highscore_hour IS SELECT PSEUDO,DATE_PARTIE,SCORE FROM HIGHSCORE_HOUR WHERE NIVEAU = pniveau;
CURSOR c_highscore_global IS SELECT PSEUDO,DATE_PARTIE,SCORE FROM HIGHSCORE_GLOBAL WHERE NIVEAU = pniveau;
BEGIN
    IF pmode=0 THEN
      FOR highscore_minute_line IN c_highscore_minute LOOP
          vpseudos(i) := highscore_minute_line.PSEUDO;
          vdates(i) := highscore_minute_line.DATE_PARTIE;
          vscores(i) := highscore_minute_line.SCORE;
          i := i+1;
      END LOOP;
    ELSIF pmode=1 THEN
      FOR highscore_hour_line IN c_highscore_hour LOOP
          vpseudos(i) := highscore_hour_line.PSEUDO;
          vdates(i) := highscore_hour_line.DATE_PARTIE;
          vscores(i) := highscore_hour_line.SCORE;
          i := i+1;
      END LOOP;
    ELSIF pmode=2 THEN
      FOR highscore_global_line IN c_highscore_global LOOP
          vpseudos(i) := highscore_global_line.PSEUDO;
          vdates(i) := highscore_global_line.DATE_PARTIE;
          vscores(i) := highscore_global_line.SCORE;
          i := i+1;
      END LOOP;
    END IF;
  ppseudos := vpseudos;
  pdates := vdates;
  pscores := vscores;
END;