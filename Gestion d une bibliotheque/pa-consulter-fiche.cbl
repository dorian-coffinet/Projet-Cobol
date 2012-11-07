       program-id. pa-consulter-fiche.

       select ffiche assign 'adherent.dat'
       organization indexed record key codeE
       access dynamic.

       fd ffiche.
       1 adherent.
               2 codeE pic x(5).
               2 nomE pic x(30).
               2 prenomE pic x(30).
               2 adrE pic x(150).




       screen section.

       1 s-plg-code.
           2 blank screen.
           2 line 1 col 1 'Veuillez taper le ref de l adherent: '.
           2 s-code pic x(5) to codeE required.

       1 a-plg-fiche.
           2 line 3  col 1 'Numero adherent : '.
           2 line 3 col 30 pic x(5) from codeE.
           2 line 5 col 1 'Nom adherent : '.
           2 line 5 col 30 pic x(30) from nomE.
           2 line 7 col 1 'Prenom adherent : '.
           2 line 7 col 30 pic x(30) from prenomE.
           2 line 9 col 1 'Adresse adherent : '.
           2 line 9 col 30 pic x(150) from adrE.



       procedure division.
       open input ffiche
       display s-plg-code
       accept s-code
       read ffiche
       invalid key
       display 'Adherent n existe pas'
       not invalid key
       display a-plg-fiche
       end-read
       close ffiche
       end program pa-consulter-fiche.
