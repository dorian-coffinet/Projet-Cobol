       program-id. pp-consultation.

       select fref assign 'pret.dat'
       organization indexed access dynamic
       record key clef = DatePret RefS CodeE
       alternate record key RefS duplicates
       alternate record key CodeE duplicates.


       fd fref  .
       1 pret.
               2 DatePret pic 9(8).
               2 RefS pic x(5).
               2 CodeE pic x(5).
               2 DateRetour pic 9(8).

       working-storage section.

       1 cod pic x(5).
       1 ref pic x(5).
       1 fin-freference pic x value 'n'.
       88 fin-fref value 'o' false 'n'.

       1 bool pic 9 value 0.
       1 n pic 999 value 8.

       1 choix pic 9 value 0.

       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Consultation des Prets '.

       1 a-plg-menu.
           2 line 3 col 1 '1-Consultation par adherent'.
           2 line 4 col 1 '2-Consultation par livre'.


       1 s-plg-choix.
           2 line 6 col 1 'Veuillez taper votre choix : '.
           2 s-choix pic z to choix required.


       1 s-plg-code.
           2 line 7 col 1 'Veuillez taper le code de l adherent: '.
           2 s-code pic x(5) to cod required.

       1 s-plg-ref.
           2 line 7 col 1 'Veuillez taper la reference du livre: '.
           2 s-ref pic x(5) to ref required.


       1 a-plg-fiche.
           2 line n  col 1 'Reference du livre emprunte : '.
           2 col 35 pic x(5) from RefS.

       1 a-plg-fiche2.
           2 line n  col 1 'Code adherent ayant emprunte ce livre : '.
           2 col 40 pic x(5) from CodeE.


       procedure division.
       open i-o fref
       display s-plg-titre
       display a-plg-menu
       display s-plg-choix
       accept s-choix

       if choix = 1  then

               display s-plg-code
               accept s-code
               read fref next end set fin-fref to true
               end-read
               perform until fin-fref
                           compute bool = 0
                              if CodeE = cod  then
                                  display  a-plg-fiche
                                  compute bool=1
                              end-if
                              if bool = 1 then
                                   compute n = n + 2
                               end-if
                       read fref next end set fin-fref to true end-read

               end-perform

               close fref

       end-if
       if choix = 2 then
               display s-plg-ref
               accept s-ref
               read fref next end set fin-fref to true
               end-read
               perform until fin-fref
                      compute bool = 0
                         if RefS = ref  then
                             display  a-plg-fiche2
                             compute bool=1
                         end-if
                         if bool = 1 then
                              compute n = n + 2
                          end-if
                        read fref next end set fin-fref to true end-read

               end-perform

               close fref

       end-if
       end program pp-consultation.





