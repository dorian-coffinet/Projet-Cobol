       program-id. pa-modifier.


       select fmodif assign 'adherent.dat'
       organization indexed record key codeE
       access dynamic.

       fd fmodif.
       1 adherent.
                2 codeE pic x(5).
                2 nomE pic x(30).
                2 prenomE pic x(30).
                2 adrE pic x(150).

       1 adresse pic x(150).
       working-storage section.
       1 pic x.
       88 codexiste value 'o' false'n'.
       1 pic x.
       88 erreur value 'o' false 'n'.
       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Modification Adherent'.
           2 line 3  col 1 'Numero adherent : '.
           2 s-code line 3 col 30 pic x(5) to codeE required.

       1 a-plg-fiche.
           2 line 9 col 1 'Nouvelle adresse adherent : '.
           2 s-adr line 9 col 30 pic x(150) to adrE required.

       procedure division.
       open i-o fmodif
       display s-plg-titre
       accept s-code
       read fmodif invalid set codexiste to false
                   not invalid set codexiste to true
       end-read

       if not codexiste
           then
               display ' Adherent n existe pas'
           else
               display a-plg-fiche
               accept s-adr
               rewrite adherent invalid set erreur to true
                               not invalid set erreur to false
               end-rewrite

           if erreur
               then display ' erreur decriture dans le fichier'
               else display ' adresse modifiée '
           end-if
       end-if.

       close fmodif
       end program pa-modifier.


