       program-id. pa-supprimer.


       select fsupprim assign 'adherent.dat'
       organization indexed record key codeE
       access dynamic.

       fd fsupprim.
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
           2 line 1 col 1 'Suppression Adherent'.
           2 line 3  col 1 'Numero adherent : '.
           2 s-code line 3 col 30 pic x(5) to codeE required.


       procedure division.
       open i-o fsupprim
       display s-plg-titre
       accept s-code
       read fsupprim invalid set codexiste to false
                   not invalid set codexiste to true
       end-read

       if not codexiste
           then
               display ' Adherent n existe pas'
           else
               delete fsupprim invalid set erreur to true
                               not invalid set erreur to false
               end-delete

           if erreur
               then display ' erreur de suppression dans le fichier'
           else
               display 'Adherent supprime'
           end-if
       end-if.

       close fsupprim
       end program pa-supprimer.


