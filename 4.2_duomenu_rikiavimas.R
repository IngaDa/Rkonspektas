
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Vektoriaus element� i�rikiavimas ir duomen� lenteli� pertvarkymai.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2013-09-09 | 2013-09-22
#


# TURINYS -------------------------------

#
#   1. Vektori� ir duomen� lenteli� i�rikiavimas:
#      * funkcija rev
#      * funkcija sort
#      * funkcija order
#
#   2. Duomen� lenteli� pertvarkymas:
#      * funkcija stack
#      * funkcija unstack
#      * funkcija reshape
#


# PASTABOS ------------------------------

#
# �traukti funkcijas rank ir xtfrm.
# Sugalvoti u�davini� su funkcija reshape.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# VEKTORIAUS REIK�MI� RIKIAVIMAS          #
# --------------------------------------- #

# Prie� atliekant statistin� duomen� analiz�, turimus duomenis da�niausiai tenka 
# sutvarkyti ir suteikti jiems tam tikr� standartin� form�, kuri leid�ia taikyti
# standartines statistines proced�ras. Analizuojant gautus rezultatus, juos taip
# pat da�niausiai reikia pertvarkyti, i�rikiuoti, agreguoti ir t.t.

# Vektoriaus element� i�rikiavimui prie�inga tvarka naudojama funkcija rev.
x <- c(7.7, 3.8, -0.5, 5.3, 8.9, 1.5, -3.2, 4.1, -1.4, -4.7)

rev(x)


# Vektoriaus reik�mi� i�rikiavimui nema��jimo arba nedid�jimo tvarka naudojama 
# funkcija sort. Jos parametrai:
# 
#          x -- vektorius,
# decreasing -- pagal nutyl�jim� FALSE, nurodo rikiavimo tvarka,
#    na.last -- pagal nutyl�jim� NA, gali b�ti TRUE arba FALSE arba.

# Pagal nutyl�jim� skaitinio vektoriaus elementai i�rikiuojami nema��jimo tvarka.

sort(x)

# Statistikoje taip gaunama imties variacin� eilut�, kurios i-asis elementas yra
# vadinamas i-�j� pozicine statistika. Pavyzd�iui, 1-oji pozicin� statistika yra
# imties minimumas. U�ra�ysime pirmosios pozicin�s statistikos nustatymo komand� 
# funkcinio programavimo stiliumi.

sort(x)[1]


# Rikiuojant nedid�jimo tvarka, parametro decreasing reik�m� pakei�iama � TRUE.
sort(x, decreasing = TRUE)

# Rikiuojant vektori� su praleistomis reik�m�mis, jos pagal nutyl�jim� i�metamos.
y <- c(7.7, 3.8, NA, 5.3, 8.9, 1.5, NA, 4.1, NA, NA)

sort(y)

# Kad i�rikiuoto vektoriaus su praleistomis reik�m�mis element� skai�ius i�likt� 
# toks pat, praleistas reik�mes galima nukelti � vektoriaus prad�i� arba gal�.

sort(y, na.last = TRUE)
sort(y, na.last = FALSE)


# Pagal nutyl�jim� raid�s i�rikiuojamos ab�c�l�s tvarka.
r <- c("Y", "M", "S", "F", "I", "Q", "Z", "E", "O", "H", "A", "W", "J", "R", "T")

sort(r)

# Ilgesn�s simboli� sekos (neb�tinai vienodo ilgio) i�rikiuojamos leksikografine 
# tvarka: i� prad�i� pagal pirm� �od�io simbol�, tada pagal antr� ir t.t.
s <- c("ZSZ", "LFB", "IY", "OWJV", "WL", "LNXCO", "ZS", "ARIHB", "TUCYS", "KRHU")

sort(s)


# Vektoriaus element� numerius i�rikiuotame vektoriuje nustato f-ja order. Jos
# parametrai:
#
#        ... -- vienas arba keli vektoriai,
#    na.last -- pagal nutyl�jim� NA, gali b�ti TRUE arba FALSE arba,
# decreasing -- pagal nutyl�jim� FALSE, nurodo rikiavimo tvarka.

# Funkcijos order reik�m� yra vektoriaus element� perstatinys. Tai rei�kia, kad
# �i funkcija gr��ina ne i�rikiuotus vektoriaus elementus, o j� numerius. 

z <- c("c", "a", "b")

i <- order(z)
i

# Pirmojo gauto vektoriaus elemento reik�m� 2 nurodo, kad pirmas tarp i�rikiuot� 
# vektoriaus element� b�t� antrasis vektoriaus elementas z[2], kurio reik�m� "a".
# Antrasis elementas lygus 3 ir tai rei�kia, kad antras tarp i�rikiuot� element�
# b�t� z[3], kurio reik�m� "b". Tre�iasis elementas lygus 1, vadinasi tre�iasis
# tarp i�rikiuot� element� b�t� z[1], kurio reik�m� lygi "c".

# Parodysime, kad vektoriaus elementus i�d�s�ius pagal funkcijos order gr��inam� 
# numeri� vektori�, gaunamas i�rikuotas vektorius, kok� gautume su funkcija sort.

z[i]


# Funkcijos order gr��inamas vektorius naudojamas matricos arba duomen� lenteli� 
# eilu�i� i�rikiavimui pagal kurio nors stulpelio reik�mes. Pavyzd�iui, lentel�s 
# tyrimas eilutes i�rikiuosime pagal kintam�j� "X".

tyrimas <- read.table(header = TRUE, text = "
X     Y     Z
b   1.3  TRUE
a   5.2  TRUE
b   2.5  TRUE
c   1.2  FALSE
a   3.8  FALSE
c   2.4  FALSE
")

i <- order(tyrimas$X)

tyrimas[i, ]

# Laikantis funkcinio programavimo stiliaus visk� galima u�ra�yti viena i�rai�ka.

tyrimas[order(tyrimas$X), ]

# Kad funkcijos order viduje b�t� galima tiesiogiai naudoti lentel�s kintam�j�
# pavadinimus, j� galima �kelti � funkcij� with. Tai ypa� patogu tuo atveju, kai
# reikia u�ra�yti i� karto kelis vienos lentel�s kintamuosius.

with(tyrimas, tyrimas[order(X), ])

# Eilutes galima i�rikiuoti i� karto pagal kelis stulpelius. Pvz., i�rikiuosime 
# eilutes kintamojo "X" did�jimo (ab�c�l�s) tvarka, bet tuo atveju kai kintamojo 
# "X" reik�m�s sutampa, eilutes i�rikiuosime pagal kintam�j� "Y".

with(tyrimas, tyrimas[order(X, Y), ])


# NAUDINGA ------------------------------

# Funkcija order sukuria tok� perstatin�, kuris vektoriaus elementus i�rikiuoja 
# nema��jimo tvarka. Jei lentel�s eilutes reikia i�rikiuoti vektoriaus ma��jimo 
# tvarka, nurodomas parametras decreasing = TRUE. Jei vektorius arba kintamasis, 
# pagal kur� atliekamas rikiavimas, yra skaitinis, papras�iau pakeisti jo �enkl�.

# Pvz., i�rikiuosime lentel�s tyrimas eilutes kintamojo "X" did�jimo tvarka, bet 
# kintamojo "Y" ma��jimo tvarka.

with(tyrimas, tyrimas[order(X, -Y), ])

# Kategoriniams kintamiesiems �enklo pakeisti negalima, tod�l tokiais atvejais
# gali b�ti naudojama speciali funkcija xtfrm. Pavyzd�iui, i�rikiuosime lentel� 
# kintamojo "X" ma��jimo tvarka ir kintamojo "Y" did�jimo tvarka.

with(tyrimas, tyrimas[order(-xtfrm(X), Y), ])


# U�DUOTIS ------------------------------ 

# 1. Vektori� x i�rikiuokite ma��jimo tvarka nenaudojant f-jos sort parametro
#    decreasing = TRUE. Sugalvokite kelis b�dus tokiam i�rikiavimui atlikti.
# 2. Lentel�s tyrimas eilutes i�rikiuokite pagal visus tris jos kintamuosius i� 
#    karto: pagal "Z", tada pagal "X", o esant vienodoms j� reik�m�ms pagal "Y".


# --------------------------------------- #
# DUOMEN� LENTELI� PERTVARKYMAS           #
# --------------------------------------- #

# � tekstinius failus ar Excel lenteles sura�omi duomenys da�niausiai b�na taip
# vadinamo "wide" formato: viename stulpelyje sura�ytos vieno kintamojo reik�m�s, 
# kintam�j� paprastai b�na ne vienas, o vien� objekt� apra�o viena eilut�. Tai 
# nat�ralus duomen� sura�ymo b�das, bet jis ne visada patogus duomen� analizei.

# Vienos duomen� lentel�s keli� kintam�j� apjungimui � vien� kintam�j� naudojama 
# funkcija stack. Jos parametrai:
#
#        x -- "wide" formato duomen� lentel�,
#   select -- duomen� lentel�s kintamasis arba keli� kintam�j� vard� vektorius,

# Funkcijos rezultatas yra lentel�, kur stulpelyje "values" sura�omos kintam�j� 
# reik�m�s, o stulpelyje "ind" -- t� kintam�j� pavadinimai.

# Tarkime, kad yra lentel�, kurioje kiekvienas matavimas pakartotas tris kartus,
# reik�m�s sura�ytos � kintamuosius X, Y ir Z. Sudarysime lentel�, kurioje visi 
# trys kintamieji apjungti � vien� bendr� kintam�j�.

kintamieji <- read.table(header = TRUE, text = "
  X    Y    Z
1.5  3.2  0.2
1.2  3.9  0.7
1.9  3.5  0.5
1.7  3.4  0.1
")

kintamieji

# Apjungimo rezultatas yra taip vadinamo "long" formato lentel�, kurioje � vien� 
#�kintam�j� apjungtos vis� trij� lentel�s kintam�j� reik�m�s.

matavimai <- stack(kintamieji)
matavimai

# Naudojant parametr� select, galima nurodyti, kuriuos kintamuosius apjungti. Su 
# minuso �enklu nurodyti kintamieji neapjungiami. Pvz., apjungsime kintamuosius
# "X" ir "Y". Toks pats rezultatas gaunamas i�metus kintam�j� "Z".

stack(kintamieji, select = c(X, Y))
stack(kintamieji, select = -Z)


# Galima ir atvirk�tin� duomen� lentel�s transformacija, kai apjungti stulpeliai 
# i�skaidomi � atskirus kintamuosius. Tam naudojama funkcija unstack. Parametrai:
#
#        x -- "long" formato duomen� lentel�,
#     form -- formul�, kuri nurodo, kaip � stulpelius i�skaidyti kintam�j�.

# Formul� ra�oma taip: X ~ G. �ia X yra kintamasis, kur� reikia suskaidyti, o G 
# yra grupavimo kintamasis.

# Jeigu "long" formato lentel� buvo gauta naudojant funkcij� stack, atvirk�tin� 
# transformacija atliekama nenurodant joki� parametr� (jie �ra�yti atributuose).

unstack(matavimai)

# Jei kintamojo reik�mes grupuojan�i� kintam�j� lentel�je yra ne vienas, galima
# nurodyti, pagal kur� i� j� atliekamas i�skaidymas � stulpelius. Tam nurodomas
# parametras form. 

matavimai <- read.table(header = TRUE, text = "
reik�m�  tipas  grup�
1.5      X      Pirmas
1.2      X      Pirmas
1.9      X      Pirmas
1.7      X      Pirmas
3.2      Y      Pirmas
3.9      Y      Pirmas
3.5      Y      Antras
3.4      Y      Antras
0.2      Z      Antras
0.7      Z      Antras
0.5      Z      Antras
0.1      Z      Antras
")

unstack(matavimai, form = reik�m� ~ tipas)
unstack(matavimai, form = reik�m� ~ grup�)


# Sud�tingesn�s strukt�ros duomen� lentel�s pertvarkymams naudojama f-ja reshape. 
# Pagrindiniai jos parametrai:
# 
#      data -- "wide" arba "long" formato duomen� lentel�,
#   varying -- pasikartojan�ius matavimus atitinkantys lentel�s kintamieji,
#   v.names -- kintamojo, � kur� apjungiami pasikartojantys matavimai, vardas,
#     idvar -- vienas ar keli grupavimo kintamieji, 
#   timevar -- kintamasis, kuris "long" lentel�je nurodo vien� matavim� serij�,
# direction -- "long" arba "wide", nurodo � kokio formato lentel� transformuoti.

# Pertvarkant lentel� i� "wide" formato � "long", lentel�je atsiranda kintamasis
# "time". J� atitinkantis kintamasis nurodomas parametrui timevar, kai lentel� 
# pertvarkoma i� "long" formato � "wide".

# Pavyzd�iui, turime lentel�, kurioje yra trys to paties kintamojo matavimai ir
# grupavimo kintamasis. Sudarysime lentel�, kurioje kintamieji "X.1", "X.2" ir 
# "X.3" apjungiami � vien� kintam�j�.

d.ww <- read.table(header = TRUE, text = "
nr  grup�   X.1   X.2   X.3
 1      A  2.84  2.08  1.06
 2      B  2.95  2.08  0.96
 3      A  2.85  2.03  1.10
 4      B  3.07  1.90  0.96
 5      A  3.21  1.99  1.11
 6      B  2.87  1.97  0.90
")

# Papras�iausiu atveju funkcijai u�tenka nurodyti tik pasikartojan�ius matavimus
# atitinkan�i� kintam�j� vardus, kiti automati�kai priskiriami parametrui idvar.
d.wl <- reshape(d.ww, varying = c("X.1", "X.2", "X.3"), direction = "long")
d.wl

# Kintamuosius parametrams galima i�vardinti nurodant j� stulpeli� numerius. 
d.wl <- reshape(d.ww, varying = 3:5, v.names = "X", idvar = 1:2, direc = "long")
d.wl

# Toki� pertvarkyt� lentel� galima atversti atgal panaudojant t� pa�i� funkcij� 
# reshape be joki� parametr� (vis� j� reik�m�s �ra�ytos lentel�s atributuose).

reshape(d.wl)


# Jei pradiniai duomenys yra "long" formato, naudojant f-j� reshape, juos galima 
# pertvarkyti � "wide" formato duomen� lentel�.

d.ll <- read.table(header = TRUE, text = "
nr grup� bandymas    X
1      A        1 2.84
2      B        1 2.95
3      A        1 2.85
4      B        1 3.07
5      A        1 3.21
6      B        1 2.87
1      A        2 2.08
2      B        2 2.08
3      A        2 2.03
4      B        2 1.90
5      A        2 1.99
6      B        2 1.97
1      A        3 1.06
2      B        3 0.96
3      A        3 1.10
4      B        3 0.96
5      A        3 1.11
6      B        3 0.90
")

# Kintam�j� "time", kuris "long" formato lentel�je atskiria kintamojo matavim� 
# serijas, �ioje lentel�je atitinka kintamasis "bandymas". 

t <- "bandymas"
g <- c("nr", "grup�")

d.lw <- reshape(d.ll, v.names = "X", idvar = g, timevar = t, direction = "wide")
d.lw

# Taip pertvarkytos lentel�s atvirk�tin� transformacija � "long" formato lentel� 
# atliekama naudojant f-j� reshape be joki� papildom� parametr�.

reshape(d.lw)


# U�DUOTIS ------------------------------ 

# 1. Naudojant funkcij� unstack, lentel� tyrimas pertvarkykite i� "long" formato 
#    � "wide". Suskaidyti reikia kintam�j� "Y", o jo grupavimas atliekamas pagal 
#    kintam�j� "X". Kod�l tokios lentel�s pervarkymui netinka funkcija reshape?
# 2. Sugalvokite b�d�, kaip lentel�s duomenys kintamuosius "X.1", "X.2" ir "X.3" 
#    apjungti naudojant funkcij� stack.
# 3. Pertvarkykite lentel� chickwts: kintam�j� weight padalinkite � grupes pagal 
#    kintamojo feed reik�mes.
