       program-id. pl-rechercher.

       select frecherche assign 'support.dat'
       organization indexed record key RefS
       access dynamic.


       fd frecherche.
       1 livre.
                2 RefS pic x(5).
                2 LibS pic x(30).
                2 DesignS pic x(50).
                2 Dispo pic x.
                2 LibC pic x(30).
                2 tab.
                   3 motscles pic x(20) occurs 10.


       working-storage section.
       1 j pic 99.
       1 bool2 pic 9 value 0.
       1 motcle pic x(20).
       1 fin-fich pic x value 'n'.
       88 fin-frecherche value 'o' false 'n'.



       1 bool pic 9 value 0.
       1 n pic 999 value 5.

       screen section.

       1 s-plg-titre.
           2 blank screen.
           2 line 1 col 1 'Recherche livre'.
           2 line 3  col 1 'Entrer le mot cle : '.
           2 s-mot line 3 col 30 pic x(20) to motcle required.

       1 a-plg-res.

           2 line n col 1 'Reference du livre : '.
           2 a-ref line n col 30 pic x(5) from RefS.
           2 line + 1 col 1 'Support du livre : '.
           2 a-cat  col 30 pic x(30) from LibS.
           2 line + 1 col 1 'Designation du support : '.
           2 a-sup  col 30 pic x(50) from DesignS.
           2 line + 1 col 1 'Disponibilite : '.
           2 a-dis  col 30 pic x from Dispo.
           2 line + 1 col 1 'Categorie du livre : '.
           2 a-sup  col 30 pic x(30) from LibC.
       1 a-plg-res2.
           2 line 5 col 1 'Aucun livre trouve correspondant au mot cle'.
       procedure division.
       open i-o frecherche
       display s-plg-titre
       accept s-mot
       read frecherche next end set fin-frecherche to true
       end-read
       perform until fin-frecherche
           perform boucle
           read frecherche next end set fin-frecherche to true end-read
       end-perform

       close frecherche
       goback.

       boucle.
       compute bool = 0
       perform test after varying j from 1 by 1 until bool=1 or j=10
           if motscles(j) = motcle
           then
               compute bool = 1
               compute bool2 = 1
           end-if
       end-perform


       if bool = 1 then
           display a-plg-res
           compute n = n + 6
       end-if.

       if bool2 = 0
       display a-plg-res2
       end-if
       end program pl-rechercher.


