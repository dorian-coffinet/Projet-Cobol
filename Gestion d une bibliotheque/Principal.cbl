       program-id. menu-principal.


       working-storage section.
       1 choix pic 9 value 0.
       1 bool pic 9 value 0.

       screen section.
       1 a-plg-entete.
           2 blank screen.
           2 line 5 col 1 'Menu Principal'.
       1 a-plg-menu.
           2 line 7 col 1 '1-Gestion des adhérents'.
           2 line 8 col 1 '2-Gestion des livres'.
           2 line 9 col 1 '3-Gestion des prêts'.
           2 line 10 col 1 '4-Administration'.
           2 line 11 col 1 '5-Quitter'.
       1 s-plg-choix.
           2 line 12 col 1 'Veuillez taper votre choix : '.
           2 s-choix pic z to choix required.


       procedure division.
        perform test after until bool = 1
          display a-plg-entete
          display a-plg-menu
          display s-plg-choix

       accept s-choix
       evaluate choix

           when 1 call 'p-adherent' compute bool = 0
           when 2 call 'p-livre' compute bool = 0
           when 3 call 'p-pret' compute bool = 0
           when 4 call 'p-administration' compute bool = 0
           when 5 compute bool =1

       end-evaluate
       end-perform
       end program menu-principal.


