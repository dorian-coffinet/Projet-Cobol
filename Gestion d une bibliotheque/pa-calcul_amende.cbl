       program-id. pa-calcul_amende.

       select fpret assign 'pret.dat'
       organization indexed access dynamic
       record key clef = DatePret RefS CodeE
       alternate record key RefS duplicates
       alternate record key CodeE duplicates.

       select fadherent assign 'adherent.dat'
       organization indexed record key codeEE
       access dynamic.










       fd fpret.

       1 pret.
               2 DatePret pic 9(8).
               2 RefS pic x(5).
               2 CodeE pic x(5).
               2 DateRetour pic 9(8).






       fd fadherent.
       1 adherent.
               2 codeEE pic x(5).
               2 nomE pic x(30).
               2 prenomE pic x(30).
               2 adrE pic x(150).



       working-storage section.
       1 cod pic x(5).
       1 amende pic 9(3).
       1 nbJours pic 9(3).
       1 fin-pret pic x value 'n'.
       88 finPret value 'o' false 'n'.
       1 dateJour pic 9(8).









       screen section.
       1 s-plg-calcul.
           2 blank screen.
           2 line 2 col 1 'Entrer le code de l adherent :'.
           2 s-cod col 35 pic x(5) to cod.
       1 a-plg-aucunPret.
           2 line 3 col 1 'aucun pret'.
       1 a-plg-amende.
           2 line 10 col 5 'Cet adherent a une amende de '.
           2 a-amende col 35 pic z(3) from amende.
           2 line 10 col 40 'euros '.














       procedure division.

       open input fpret input fadherent
       move function CURRENT-DATE to dateJour(7:2)
       display s-plg-calcul
        accept s-cod
        move cod to CodeE
        move 0 to amende
       move 0 to nbJours
       start fpret key = CodeE
       invalid key
       display a-plg-aucunPret
       not invalid key
       set finPret to false
        perform until finPret
       read fpret next end set finPret
       to true not end
       if (DateRetour = 0 ) and
       (CodeE = cod) then
       compute nbJours = function integer-of-date(dateJour)-
       function integer-of-date(DatePret)



       end-if
        if (nbJours > 21) then
       compute amende = amende +
          ((nbJours - 21) * (1/2))
        end-if
       end-read
        end-perform
       display a-plg-amende
        end-start






















