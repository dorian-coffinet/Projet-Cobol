       program-id. pp-enregistrerp.


       select fenregistre assign 'pret.dat'
       organization indexed access dynamic
       record key clef = DatePret RefS CodeE
       alternate record key RefS duplicates
       alternate record key CodeE duplicates.

       select fcherche assign 'support.dat'
       organization indexed record key RefSu
       access dynamic.






       fd fenregistre.

       1 pret.
               2 DatePret pic 9(8).
               2 RefS pic x(5).
               2 CodeE pic x(5).
               2 DateRetour pic 9(8).





        fd fcherche.

        1 livre.
                  2 RefSu pic x(5).
                  2 LibS pic x(30).
                  2 DesignS pic x(50).
                  2 Dispo pic x.
                  2 LibC pic x(30).
                  2 tab.
                     3 motscles pic x(20) occurs 10.

       working-storage section.
       1 pic x.
       88 clefexiste value 'o' false'n'.
       1 pic x.
       88 refexiste value 'o' false'n'.
       1 pic x.
       88 codexiste value 'o' false'n'.
       1 pic x.
       88 erreur value 'o' false 'n'.
       1 pic x.
       88 erreur2 value 'o' false 'n'.

       1 dte pic 9(8).
       1 d pic x.
       1 ref pic x(5).
       1 cod pic x(5).

       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Enregitrement d un pret'.



        1 s-plg-ref.
           2 line 5  col 1 'Reference du livre emprunte : '.
           2 s-ref line 5 col 30 pic x(5) to ref required.
        1 s-plg-code.
           2 line 7  col 1 'Code de l adherent qui emprunte : '.
           2 s-code line 7 col 30 pic x(5) to cod required.
        1 s-plg-fait.
           2 line 9  col 1 'Pret effectue '.




         01 a-plg-refExistante.
                    02 line 17 col 5 'Ces donnees existent deja.'.



       procedure division.
       open i-o fenregistre
       open i-o fcherche






       display s-plg-titre
       display s-plg-ref
       accept s-ref
       display s-plg-code
       accept s-code

       move ref to RefS
       move ref to RefSu

       move 'N' to Dispo
       move cod to CodeE
       move function current-date(1:8) to DatePret


       start fenregistre key = clef
         invalid key
                move '00000000' to DateRetour

                  write pret
                end-write
                rewrite livre
                end-rewrite
                display  s-plg-fait
            not invalid key
            display a-plg-refExistante
        end-start



       close fenregistre
       close fcherche
       goback.
       end program pp-enregistrerp.


