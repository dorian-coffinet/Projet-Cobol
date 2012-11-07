        program-id. pl-ajouter.

        select fajoute assign 'support.dat'
        organization indexed record key RefS
        access dynamic.


        fd fajoute.
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
        1 nb pic 99 value 0.
        1 j pic 99 value 1.

        1 n pic 99 value 10.
        1 mot pic x(20).


        screen section.
       1 s-plg-titre.
            2 blank screen.
            2 line 1 col 1 'Ajout livre'.





        1 s-plg-fiche.
            2 line 3  col 1 'Reference du livre : '.
            2 s-ref line 3 col 30 pic x(5) to refS required.
            2 line 4 col 1 'Support du livre : '.
            2 s-cat  col 30 pic x(30) to LibS required.
            2 line 5 col 1 'Designation du support : '.
            2 s-sup  col 30 pic x(50) to DesignS required.
            2 line 6 col 1 'Disponibilite : '.
            2 s-dis  col 30 pic x to Dispo required.
            2 line 7 col 1 'Categorie du livre : '.
            2 s-lib  col 30 pic x(30) to LibC required.
        1 s-plg-mots.
           2 line 8 col 1 'Combien de mots cles voulez-vous rentrer ?'.
           2 s-nb col 40 pic zz to nb required.
        1 a-erreur.
           2 line 9 col 1 ' Veuillez entrer moins de mots cles'.
        1 s-plg-mot.
          2 line 10 col 1 'Entrer les mots cles : '.
          2 s-m line n col 30  pic x(20) to mot required.
        procedure division.
        open i-o fajoute
        display s-plg-titre
        read fajoute invalid set refexiste to false
                    not invalid set refexiste to true
        end-read

        if  refexiste
            then
                display ' le livre existe deja'
            else
                display s-plg-fiche
                accept s-ref
                accept s-cat
                accept s-sup
                accept s-dis
                accept s-lib
                display s-plg-mots
                accept s-nb


                perform until nb < 11
                   display a-erreur
                   accept s-nb
                end-perform

                perform test after varying j from 1 by 1 until j=nb
                   display s-plg-mot
                   accept s-m
                   move mot to motscles(j)
                   compute n = n + 2
                end-perform

                write livre invalid set erreur to true
                                not invalid set erreur to false
                end-write

            if erreur
                then display ' erreur d ecriture dans le fichier'
            end-if
        end-if.

        close fajoute
        end program pl-ajouter.

