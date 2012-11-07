       program-id. p-adherent.



       working-storage section.
       1 choix pic 9.
       1 bool pic 9 value 0.
       1 suite pic x.


       screen section.

       1 a-plg-entete.
           2 blank screen.
           2 line 5 col 1 'Adh' &x'82' & 'rents'.
       1 a-plg-menu.
           2 line 7 col 1 '1-Consulter fiche'.
           2 line 8 col 1 '2-Ajouter'.
           2 line 9 col 1 '3-Modifier'.
           2 line 10 col 1 '4-Supprimer'.
           2 line 11 col 1 '5-Calcul amende'.
           2 line 12 col 1 '6-Quitter'.


       1 s-plg-choix.
           2 line 13 col 1 'Veuillez taper votre choix : '.
           2 s-choix pic z to choix required.



       1 s-plg-suite line 24 col 80 pic x to suite auto secure.




       procedure division.
         perform test after until bool = 1
        display a-plg-entete
        display a-plg-menu
        display s-plg-choix
        accept s-choix

        evaluate choix
            when 1 call 'pa-consulter-fiche' compute bool = 0
            when 2 call 'pa-ajouter' compute bool = 0
            when 3 call 'pa-modifier' compute bool = 0
            when 4 call 'pa-supprimer' compute bool = 0
            when 5 call 'pa-calcul_amende' compute bool = 0
            when 6 compute bool = 1
        end-evaluate

        accept s-plg-suite

        end-perform

        goback.
        end program p-adherent.
