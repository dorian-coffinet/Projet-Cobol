       program-id. pl-supprimer.


       select fsupprim assign 'support.dat'
       organization indexed record key RefS
       access dynamic.

       fd fsupprim.

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
           2 line 1 col 1 'Suppression Livre'.
           2 line 3  col 1 'Reference Livre : '.
           2 s-ref line 3 col 30 pic x(5) to RefS required.


       procedure division.
       open i-o fsupprim
       display s-plg-titre
       accept s-ref
       read fsupprim invalid set refexiste to false
                   not invalid set refexiste to true
       end-read

       if not refexiste
           then
               display ' Livre n existe pas'
           else
               delete fsupprim invalid set erreur to true
                               not invalid set erreur to false
               end-delete

           if erreur
               then display ' erreur de suppression dans le fichier'
           else
                display ' Livre supprime'

           end-if
       end-if.

       close fsupprim
       end program pl-supprimer.
