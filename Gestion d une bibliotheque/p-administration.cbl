       identification division.
       program-id. p-administration.

       file-control.
           select utilisateur assign 'util.dat'
           organization indexed
           access dynamic
           record key login.

           select adherent assign 'adherent.dat'
           organization indexed
           access dynamic
           record key CodeE.

           select pret assign 'pret.dat'
           organization indexed
           access dynamic
           record key is clef =  DatePret, RefP, CodeP
           alternate key RefP duplicates
           alternate key CodeP duplicates.

           select livre assign 'support.dat'
           organization indexed
           access dynamic
           record key RefS.







       data division.

       fd utilisateur.
       01 utilisateurs.
           02 nom         pic x(20).
           02 prenom      pic x(20).
           02 login       pic 9(5).
           02 motpasse    pic x(15).
           02 statut      pic x.










       fd adherent.
       1 adherents.
           2 CodeE         pic x(5).
           2 NomE          pic x(30).
           2 PrenomE       pic x(30).
           2 AdrE          pic x(150).














       fd pret.
       01 prets.
           02 DatePret pic 9(8).
           02 RefP pic x(5).
           02 CodeP pic x(5).
           02 DateRetour pic 9(8).


       fd livre.
       1 livres.
           2 RefS          pic x(5).
           2 LibS          pic x(30).
           2 DesignS       pic x(50).
           2 DispoS        pic x.
           2 LibC          pic x(30).
           2 TabS.
               3 Motcle    pic x(20) occurs 10.










       fd fich.
       01 ligne.
           02 texte pic x(800).


       working-storage section.
       01 choix pic 9.
       01 choix2 pic x(10).
       01 suite pic x.
       01 continuer pic x.
       01 alogin pic 9(5).
       01 anomutil pic x(20).
       01 apreutil pic x(20).
       01 amotpasse pic x(15).
       01 astatut pic x.
       01 continuer1 pic x.
       01 continuer2 pic x.
       01 continuer3 pic x.
       01 log pic x(10).
       01 alogin3 pic 9(5).
       01 alogin2 pic 9(5).
       01 anomutil2 pic x(20).
       01 apreutil2 pic x(20).
       01 amotpasse2 pic x(15).
       01 astatut2 pic x.
       01 alogin21 pic 9(5).
       01 dateop pic x(10).
       01 codeope1 pic x.
       01 nomfich1 pic x(15).
       01 cleprim1 pic x(15).
       01 opereu1 pic x.
       01 v-fin-f-histo pic x value 'N'.
       88 fin-f-histo value 'O' false 'N'.
       01 suiteHisto pic x.

       01 fin-fich pic x value 'N'.
       88 finFich value 'O' false 'N'.
       01 codeAdher pic x(5).
       01 dateJour pic x(8).
       01 dateJour2 redefines dateJour pic 9(8).
       01 amende pic 9(3).
       01 fin-pret pic x value 'N'.
       88 finPret value 'O' false 'N'.
       01 nbJours pic 9(3).
       01 continuer5 pic x.


       linkage section.
       01 typeutil pic x.
     **01 logutil pic 9(5).

       screen section.
       01 a-plg-titre.
           02 blank screen.
           02 line 4 col 10 'Vous êtes sur la page d''administration'.
       01 a-plg-administration.
           02 line 8 col 5 '0- Quitter la page d''administration'.
           02 line 10 col 5 '1- Ajouter un utilisateur'.
           02 line 12 col 5 '2- Modifier un utilisateur'.
           02 line 14 col 5 '3- Supprimer un utilisateur'.
           02 line 16 col 5 '4- Consulter historique'.
           02 line 18 col 5 '5- Imprimer lettres de rappel'.
       01 s-plg-choix.
           02 line 20 col 10 'Que voulez-vous faire ? (entrer un '
           & 'chiffre)'.
           02 s-choix pic z to choix.
       01 a-plg-choixinv.
           02 line 22 col 5 'choix invalide'.
       01 s-plg-suite line 26 col 80 pic x to suite auto secure.
       01 s-plg-ajout.
           02 blank screen.
           02 line 10 col 1 'Nom : '.
           02 s-anomutil pic x(20) to anomutil.
           02 line 12 col 1 'Prenom : '.
           02 s-apreutil pic x(20) to apreutil.
           02 line 14 col 1 'Login : '.
           02 s-alogin pic z(5) to alogin.
           02 line 16 col 1 'Mot de passe : '.
           02 s-amotpasse pic x(15) to amotpasse.
           02 line 18 col 1 'Statut d''utilisateur (1 pour util1,'
           & '2 pour util2, 3 pour administ) : '.
           02 s-astatut pic x to astatut.
       01 s-plg-continuer1.
           02 blank screen.
           02 line 15 col 5'Voulez-vous ajouter un autre utilisateur'
           & '?O/N'.
           02 s-continuer1 pic x to continuer1.
       01 s-plg-continuer3.
           02 blank screen.
           02 line 16 col 5'Voulez-vous supprimer un autre utilisateur'&
           '?O/N'.
           02 s-continuer3 pic x to continuer3.
       01 a-plg-UtilExistant.
           02 line 18 col 5 'Cet utilisateur existe déjà'.
       01 s-plg-supprimer.
           02 blank screen.
           02 line 18 col 1 'Login a supprimer :'.
           02 s-alogin3 pic z(5) to alogin3.
       01 a-plg-UtilInexistant.
           02 line 18 col 5 'Cet utilisateur n''existe pas'.
       01 s-plg-mod.
           02 blank screen.
           02 line 10 col 1 ' Entrer le login de l''utilisateur a'&
           'modifier : '.
           02 s-alogin2 pic z(5) to alogin2.
       01 s-plg-modifier.
           02 blank screen.
           02 line 12 col 1 'Login : '.
           02 s-alogin21 pic z(5) using login.
           02 line 13 col 1 'Nom : '.
           02 s-anomutil2 pic x(20) using nom.
           02 line 14 col 1 'Prenom :'.
           02 s-apreutil2 pic x(20) using prenom.
           02 line 15 col 1 'Mot de passe : '.
           02 s-amotpasse2 pic x(15) using motpasse.
           02 line 16 col 1 'Statut d''utilisateur : '.
           02 s-astatut2 pic x using statut.
       01 s-plg-afichisto.
           02 blank screen.
           02 line 5 col 1 'date de l''operation : '.
           02 a-dateope line 5 col 25 pic x(10) from dateope.
           02 line 7 col 1 'login : '.
           02 a-login1 line 7 col 8 pic z(5) from login1.
           02 line 9 col 1 'Nom du fichier : '.
           02 a-nomfich line 9 col 15 pic x(15) from nomfich.
           02 line 11 col 1 'Cle primaire : '.
           02 a-cleprim line 11 col 18 pic x(15) from cleprim.
           02 line 13 col 1 'Operation reussie ou non : '.
           02 a-opereu line 13 col 25 pic x from opereu.
           02 line 15 col 1 'Appuyer sur une touche pour continuer '.
           02 s-suiteHisto pic x to suiteHisto.
       01 a-plg-lettre.
           02 blank screen.
           02 line 5 col 20 'Nouvelle lettre de rappel'.
       01 s-plg-codeAdher.
           02 blank screen.
           02 line 8 col 5 'Entrer le code de l''adherent pour lequel '
           & 'vous voulez imprimer une lettre de rappel : '.
           02 s-codeAdher pic x(5) to codeAdher.
       01 a-plg-aucunPret.
           02 line 10 col 5 'Cet adherent n''a effectue aucun pret'.
       01 s-plg-continuer5.
           02 blank screen.
           02 line 8 col 5 'Voulez-vous imprimer une autre lettre ? '
           & 'O/N'.
           02 s-continuer5 pic x to continuer5.


       procedure division using typeutil.                                ** logutil

               move 'mauvaischoix' to choix2
               open i-o utilisateur

               perform until (choix2 = 'bonchoix')
                   display a-plg-titre
                   display a-plg-administration
                   display s-plg-choix
                   accept s-choix
                   evaluate choix
                   when 0
                       move 'bonchoix' to choix2
                   when 1

       *>  fonction permettant d' ajouter un utilisateur

      *                move 'bonchoix' to choix2
                       move 'O' to continuer1
                   perform until(function upper-case(continuer1)='N')
                       display s-plg-ajout
                       accept s-anomutil
                       move anomutil to nom
                       accept s-apreutil
                       move apreutil to prenom
                       accept s-alogin
                       move alogin to login
                       accept s-amotpasse
                       move amotpasse to motpasse
                       accept s-astatut
                       move astatut to statut
                       start utilisateur key = login
                           invalid
                               write utilisateurs
                               end-write
                           not invalid
                               display a-plg-UtilExistant
                       end-start
      **                move 'A' to codeope1
      **                move 'utilisateur' to nomfich1
      **                move 'login' to cleprim1
      **                move 'R' to opereu1
      **                call 'Ecrirehisto' using logutil
      **                codeope1 nomfich1 cleprim1 opereu1
      **                end-call
                   display s-plg-continuer1
                   accept s-continuer1
                 end-perform


                   when 2

       *>  fonction permettent de modifier un utilisateur

      *              move 'bonchoix' to choix2
                     move 'O' to continuer2
                     perform until(function upper-case(continuer2)='N')
                       display s-plg-mod
                       accept s-alogin2
                       move alogin2 to login
                       start utilisateur key = login
                           invalid
                               display a-plg-UtilInexistant
                           not invalid
                               read utilisateur key login
                               display s-plg-modifier
                               accept s-alogin21
                               accept s-anomutil2
                               accept s-apreutil2
                               accept s-amotpasse2
                               accept s-astatut2
                               rewrite utilisateurs
                               end-rewrite
                      end-start
                      display s-plg-continuer3
                      accept s-continuer3
                    end-perform

                   when 3

       *>  fonction permettant de supprimer un utilisateur

      *                move 'bonchoix' to choix2
                       move 'O' to continuer3
                     perform until(function upper-case(continuer3)='N')
                       display s-plg-supprimer
                       accept s-alogin3
                       move alogin3 to login
                       start utilisateur key = login
                           invalid key
                               display a-plg-UtilInexistant
                           not invalid key
                               delete utilisateur
                               end-delete
                       end-start
                       display s-plg-continuer3
                       accept s-continuer3
                     end-perform


                   when 4

      *                move 'bonchoix' to choix2
       *>  fonction permettant de consulter l' historique
     **                open input f-historique
                       set fin-f-histo to false
                       perform until fin-f-histo
                           read f-historique
                              at end
                              set fin-f-histo to true
                           end-read
                           if (login1 not = 00000) then
                               display s-plg-afichisto
                               accept s-suiteHisto
                           end-if
                       end-perform
                       stop ' '
     **                close f-historique
                   when 5
      *                    move 'bonchoix' to choix2

       *>  fonction permettant d' imprimer lettre


                           move 'O' to continuer5 perform until
                           (function upper-case(continuer5) not = 'O')
                           display s-plg-codeAdher
                           accept s-codeAdher
                           move codeAdher to CodeE
                           open input adherent
      *                    open output fich
                           read adherent key CodeE
                           end-read
                           move 'Bibliothèque INFOrmatique' to ligne
                           write ligne
                           write ligne from ' '
                           string 'A : ' NomE ' ' PrenomE into ligne
                           write ligne
                           write ligne from adrE
                           write ligne from ' '
                           write ligne from 'Vous avez emprunté les '
                           & 'supports suivants :'
                           write ligne from ' '
                           open input pret
                           open input livre
                           move codeAdher to codeP
                           start pret key = codeP
                           not invalid key
                               perform until finFich
                                   read pret next end
                                   set finFich to true not end
                                   if(DateRetour=0)and(CodeP=codeAdher)
                                   then
                                       move RefP to RefS
                                       read livre key RefS
                                       string RefS ' ' LibS ' ' DesignS
                                       'le ' DatePret into ligne
                                       write ligne
                                   end-if
                               end-read
                           end-perform
                       end-start
                       close livre
                       write ligne from ' '
                       write ligne from 'Nous vous rappelons que la '
                       & 'durée d''un prêt est de 3 semaines.'
                       write ligne from 'Merci de rapporter ces '
                       & 'supports le plus rapidement possible.'
                       write ligne from ' '
                       move 0 to amende
                       move 0 to nbJours
                       start pret key = CodeP
                           invalid key
                               display a-plg-aucunPret
                           not invalid key
                               set finPret to false
                               perform until finPret
                                   read pret next end set finPret
                                   to true not end
                                   if (DateRetour not = 0) then
                                       compute nbJours = function
                                       integer-of-date(DatePret) -
                                      function integer-of-date(DatePret)
                                   else
                                       compute nbJours = function
                                       integer-of-date(DatePret) -
                                     function integer-of-date(dateJour2)
                                   end-if
                                   if (nbJours > 21) then
                                       compute amende = amende +
                                       ((nbJours - 21) * 0.5)
                                   end-if
                                   end-read
                               end-perform
                       end-start
                       close pret
                       string 'Votre amende s''élève à ' amende
                       ' euros à ce jour.' into ligne
                       write ligne
                       move function CURRENT-DATE to dateJour
                       move space to ligne
                       string 'Nancy, le ' dateJour into ligne
                       write ligne
                       close adherent
                       display s-plg-continuer5
                       accept s-continuer5
                   end-perform

                   when other
                       display a-plg-choixinv
                           display a-plg-administration
                           display s-plg-choix
                           accept s-choix
                   end-evaluate
      *            accept s-plg-suite
               end-perform
               close utilisateur

           goback.
       end program p-administration.

