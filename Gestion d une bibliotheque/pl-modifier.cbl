       program-id. pl-modifier.


       select fmodif assign 'support.dat'
       organization indexed record key RefS
       access dynamic.

       fd fmodif.
        1 livre.
                 2 RefS pic x(5).
                 2 LibS pic x(30).
                 2 DesignS pic x(50).
                 2 Dispo pic x.
                 2 LibC pic x(30).
                 2 tab.
                    3 motscles pic x(20) occurs 10.











       working-storage section.


        1 pic x.
        88 refexiste value 'o' false'n'.
        1 pic x.
        88 erreur value 'o' false 'n'.



       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Modification Livre'.
           2 line 3  col 1 'Reference du livre : '.
           2 s-ref line 3 col 30 pic x(5) to RefS required.

       1 a-plg-fiche.
           2 line 9 col 1 'Nouveau libelle de catégorie du livre : '.
           2 s-lib line 9 col 30 pic x(30) to LibC required.

       procedure division.
       open i-o fmodif
       display s-plg-titre
       accept s-ref
       read fmodif invalid set refexiste to false
                   not invalid set refexiste to true
       end-read

       if not refexiste
           then
               display ' Le livre n existe pas'
           else
               display a-plg-fiche
               accept s-lib
               rewrite livre invalid set erreur to true
                               not invalid set erreur to false
               end-rewrite

           if erreur
               then display ' erreur decriture dans le fichier'
               else display ' libelle  modifie'
           end-if
       end-if.

       close fmodif
       end program pl-modifier.
