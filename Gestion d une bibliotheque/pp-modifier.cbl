       program-id. pp-modifier.

       select fmodif assign 'pret.dat'
       organization indexed access dynamic
       record key clef = DatePret RefS CodeE
       alternate record key RefS duplicates
       alternate record key CodeE duplicates.


       fd fmodif.
       1 pret.
               2 DatePret pic 9(8).
               2 RefS pic x(5).
               2 CodeE pic x(5).
               2 DateRetour pic 9(8).

       working-storage section.


        1 pic x.
        88 clefexiste value 'o' false'n'.
        1 pic x.
        88 erreur value 'o' false 'n'.



       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Modification de la date de pret'.

       1 s-plg-date.
           2 line 3  col 1 'Date de pret : '.
           2 s-date line 3 col 30 pic z(8) to DatePret required.
       1 s-plg-ref.
           2 line 5  col 1 'Reference du livre : '.
           2 s-ref line 5 col 30 pic x(5) to RefS required.
       1 s-plg-code.
           2 line 7  col 1 'Code de l adehrent : '.
           2 s-code line 7 col 30 pic x(5) to CodeE required.

       1 a-plg-fiche.
           2 line 9 col 1 'Nouvelle date de retour : '.
           2 s-dat line 9 col 30 pic z(8) to DateRetour required.

       procedure division.
       open i-o fmodif
       display s-plg-titre
       display s-plg-date
       accept s-date
       display s-plg-ref
       accept s-ref
       display s-plg-code
       accept s-code

       read fmodif invalid set clefexiste to false
                   not invalid set clefexiste to true
       end-read

       if not clefexiste
           then
               display ' Le pret n existe pas'
           else
               display a-plg-fiche
               accept s-dat
               rewrite pret invalid set erreur to true
                               not invalid set erreur to false
               end-rewrite

           if erreur
               then display ' erreur decriture dans le fichier'
               else display ' date de retour modifie'
           end-if
       end-if.

       close fmodif
       end program pp-modifier.
