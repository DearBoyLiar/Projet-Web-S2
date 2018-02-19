CREATE OR REPLACE PROCEDURE recup_collection(pniveau IN niveau.NIVEAU%TYPE,pid_logo OUT TAB_ID_LOGO,
                                                   plien_logo OUT TAB_LIEN_LOGO,preponse OUT TAB_REPONSE) IS
  vid_collection collection.ID_COLLECTION%TYPE;
  tab_id_logos TAB_ID_LOGO;
  tab_lien_logos TAB_LIEN_LOGO;
  tab_reponses TAB_REPONSE;
  BEGIN
    -- SELECT SUR NIVEAU POUR RECUP ID_COLLECTION
    SELECT ID_COLLECTION into vid_collection from niveau where NIVEAU=pniveau;

    -- Récupération des id_logo, lien_logo et réponse pour la collection renseignée
    SELECT id_logo,lien_logo,reponse INTO tab_id_logos, tab_lien_logos,tab_reponses
    FROM LOGO WHERE ID_COLLECTION = vid_collection;

    pid_logo := tab_id_logos;
    plien_logo := tab_lien_logos;
    preponse:= tab_reponses;

  END;