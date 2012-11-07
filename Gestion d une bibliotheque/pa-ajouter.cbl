       program-id. pa-ajouter.


       select fajout assign 'adherent.dat'
       organization indexed record key codeE
       access dynamic.

       fd fajout.
       1 adherent.
                2 codeE pic x(5).
                2 nomE pic x(30).
                2 prenomE pic x(30).
                2 adrE pic x(150).


       working-storage section.
       1 pic x.
       88 codexiste value 'o' false'n'.
       1 pic x.
       88 erreur value 'o' false 'n'.
       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Ajout Adherent'.
           2 line 3  col 1 'Numero adherent : '.
           2 s-code line 3 col 30 pic x(5) to codeE required.

       1 a-plg-fiche.

           2 line 5 col 1 'Nom adherent : '.
           2 s-nom line 5 col 30 pic x(30) to nomE required.
           2 line 7 col 1 'Prenom adherent : '.
           2 s-prenom line 7 col 30 pic x(30) to prenomE required.
           2 line 9 col 1 'Adresse adherent : '.
           2 s-adr line 9 col 30 pic x(150) to adrE required.

       procedure division.
       open i-o fajout
       display s-plg-titre
       accept s-code
       read fajout invalid set codexiste to false
                   not invalid set codexiste to true
       end-read

       if codexiste
           then
               display ' Adherent existe deja'
           else
               display a-plg-fiche
               accept s-nom
               accept s-prenom
               accept s-adr
               write adherent invalid set erreur to true
                               not invalid set erreur to false
               end-write

           if erreur
               then display ' erreur decriture dans le fichier'
           end-if
       end-if.

       close fajout
       end program pa-ajouter.


