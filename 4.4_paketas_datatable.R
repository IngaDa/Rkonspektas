
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindiniai veiksmai su data.table tipo lentel�mis.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2015-08-12 | 2015-08-20
#


# TURINYS -------------------------------

#
#   1. data.table lentel�s sudarymas:
#      * funkcija data.table
#      * parametras keep.rownames
#      * parametras key 
#      * parametras with
#      * parametras mult
#      * parametras nomatch
#      * funkcija fread
#      * funkcija copy
#      * funkcija tables
#      * funkcija set
#      * funkcija setnames
#      * funkcija setcolorder
#
#   2. eilu�i� ir stulpeli� i�rinkimas:
#      * operatorius %between% 
#      * operatorius %like% 
#
#   3. veiksmai su stulpeliais:
#      * operatorius :=
#      * operatorius .()
#
#   4. eilu�i� grupavimas:
#      * parametras .N
#      * parametras .SD
#      * parametras .EACHI
#
#   5. data.table eilu�i� indeksavimas:
#      * funkcija setkey
#      * funkcija key
#


# PASTABOS ------------------------------

#
# Sugalvoti u�davinius.
#


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE DATA.TABLE                 #
# --------------------------------------- #

# Tipiniai veiksmai su duomen� lentel�mis tai -- reikiam� eilu�i� arba stulpeli�
# i�rinkimas, vieno ar daugiau stulpeli� sumos, vidurkio ar kit� charakteristik� 
# apskai�iavimas. Da�nai vienoje lentel�je yra keli� skirting� grupi� matavimai,
# tod�l skai�iuojamos s�lygin�s charakteristikos -- atskirai kiekvienoje grup�je.

# Standarti�kai R naudojamos data.frame tipo duomen� lentel�s. Veiksmams atlikti 
# naudojamos �vairios tam skirtos funkcijos. �tai keletas da�niausiai naudojam�:
# 
#     subset -- eilu�i� ir stulpeli� i�rinkimui i� duomen� lentel�s,
#  transform -- nauj� lentel�s stulpeli� sudarymui ar sen� perskai�iavimui,
#      merge -- dviej� lenteli� apjungimui,
#    colSums -- matricos ar lentel�s stulpeli� sumos, 
#    rowSums -- matricos ar lentel�s eilu�i� sumos, 
#   colMeans -- matricos ar lentel�s stulpeli� vidurkiai, 
#   rowMeans -- matricos ar lentel�s eilu�i� vidurkiai, 
#        ave -- vieno kintamojo vidurkinimui grup�se,
#      scale -- naudojama vektoriaus ar lentel�s centravimui ir normavimui,
#      sweep -- galima naudoti vektoriaus reik�mi� vidurkinimui,
#      apply -- veiksmai matricos eilut�se arba stulpeliuose,
#     tapply -- s�lygini� charakteristik� skai�iavimas grup�se.


# Pavyzd�iui, keliais standartiniais b�dais apskai�iuosime duomen� lentel�s iris 
# kintamojo Sepal.Length vidurk� grup�se pagal kintamojo Species reik�mes.

   tapply(iris[, "Sepal.Length"],      iris[, "Species"],  mean)
       by(iris[, "Sepal.Length"],      iris[, "Species"],  mean)
aggregate(iris[, "Sepal.Length"], list(iris[, "Species"]), mean)

# Tokiu atveju tipin� veiksm� seka: suskaidyti lentel� pagal grupavimo kintam�j�,
# apskai�iuot reikiamas charakteristikas ir (kartais) apjungti gautus rezultatus.

      sapply(split(iris, iris$Species), function(x) mean(x$Sepal.Length))
stack(lapply(split(iris, iris$Species), function(x) mean(x$Sepal.Length)))

# Kitas pavyzdys -- apskai�iuoti vis� kintam�j� vidurkius atskirai grup�se pagal
# grupavimo kintamojo reik�mes.

aggregate(iris[, -5], list(R��is = iris[, 5]), mean)

lapply(split(iris, iris$Species), function(x) colMeans(x[, -5]))
lapply(split(iris, iris$Species), function(x)    apply(x[, -5], 2, mean))


# Laikas, per kur� atliekamos tokios operacijos, priklauso nuo eilu�i� ir grupi�
# skai�iaus lentel�je -- kuo j� daugiau, tuo ilgiau u�trunka skai�iavimai, tod�l
# net papras�iausios duomen� pertvarkymo operacijos su itin didel�mis data.frame
# tipo lentel�mis gali u�trukti labai ilgai.

# Kita problema -- visi R objektai ir duomenys b�tinai turi tilpti � kompiuterio 
# atmint�. D�l tos prie�asties sud�tingos strukt�ros ir didel�s apimties duomen� 
# saugojimui naudojamos specializuotos duomen� baz�s.

# Labai dideli� duomen� lenteli� apdorojimui naudojamas data.table tipo lentel�s
# formatas. Nuo standartin�s R data.frame tipo lentel�s data.table skiriasi tuo, 
# kad leid�ia indeksuoti eilutes, d�l ko �ymiai pagreit�ja eilu�i� i�rinkimas ir 
# j� grupavimas. Pagrindiniai veiksmai su data.table tipo lentel�mis:
# 
#   -- eilu�i� i�rinkimas, 
#   -- eilu�i� grupavimas,
#   -- nauj� stulpeli� sudarymas,
#   -- nereikaling� stulpeli� panaikinimas,
#   -- stulpeli� reik�mi� perskai�iavimas,
#   -- stulpeli� charakteristik� apskai�iavimas,
#   -- lenteli� apjungimas.

# Pagal savo strukt�r� data.table tipo lentel�, kaip ir data.frame, yra vektori� 
# s�ra�as. data.frame lentel�s turi unikalius eilu�i� pavadinimus, o jeigu toki�
# n�ra -- eilut�s numeruojamos. data.table eilu�i� pavadinim� neturi, vietoje j�
# visos eilut�s turi unikalius raktus. �iuo po�i�riu data.table pana�u � duomen�
# bazes. 

# Kaip ir data.frame, data.table lenteles galima apjungti naudojant rbind, cbind
# ar merge funkcijas. Unikali� eilu�i� i�skyrimui naudojama standartin� funkcija 
# unique. 

# Atliekant veiksmus su data.frame tipo lentele, kiekvien� kart� sukuriama nauja 
# lentel�, o pradin� lentel� i�lieka tokia pati. Pvz., naudojant funkcij� subset 
# i� lentel�s iris i�mesime vien� stulpel�. 

subset(iris, select = -Species)

# Buvo sudaryta nauja lentel�, bet pradin� lentel� nepasikeit�. Ji nepasikeis ir
# tuo atveju, jei, pvz., naudojant funkcij� transform, sudarysime nauj� stulpel�.

transform(iris, Sepal.Sum = Sepal.Length + Sepal.Width)

# Veiksmai su data.table lentel�s stulpeliais atliekami nedarant lentel�s kopij�.
# Tai i� esm�s skiriasi nuo data.frame ir yra didelis privalumas dirbant didel�s 
# apimties duomenimis.


# Tarkime, kad turime data.table lentel� DT. Jos argumentus galima suskirstyti � 
# tris dalis:
#                                 DT[i, j, by]
# 
#          i -- i�renkam� eilu�i� numeriai arba login� s�lyga,
#          j -- i�renkam� stulpeli� pavadinimai,
#         by -- grupavimo kintamojo pavadinimas arba login� s�lyga.
#
# Priklausomai nuo atliekam� veiksm� �iuos argumentus galima naudoti ir visus i� 
# karto, ir atskirai po vien� arba du. Lentel�s viduje visi stulpeliai yra tarsi
# kintamieji, tod�l standarti�kai vietoje stulpeli� numeri� naudojami j� vardai.


# --------------------------------------- #
# DATA.TABLE LENTEL�S SUDARYMAS           #
# --------------------------------------- #

# Norint naudoti data.table tipo lenteles, turi b�ti suinstaliuotas ir �trauktas
# to paties pavadinimo R paketas.

library(data.table)


# data.table tipo lentel� sudaroma pana�iai, kaip ir data.frame lentel�, tik �ia
# vektori� apjungimui � lentel� naudojama funkcija data.table.

x <- c("Re_5", "Mi_5", "Do_5", "Do_4", "So_4")
y <- c(587.33, 659.25, 523.25, 261.63, 329.00)

xy <- data.table(X = x, Y = y)
xy


# Kitas b�das sudaryti data.table tipo lentel� -- konvertuoti data.frame lentel�.
# Tam naudojama ta pati funkcija data.table. Pvz., tokiu b�du i� lentel�s mtcars 
# sudarysime data.table tipo lentel�.

mtcars

mt <- data.table(mtcars)
mt

# Paprastai data.frame lentel�s eilut�s turi unikalius numerius, bet joms galima 
# priskirti ir pavadinimus, kurie taip pat turi b�ti unikal�s. Ta�iau data.table
# tipo lentel�s eilut�s turi tik numerius. Norint i�laikyti eilu�i� pavadinimus,
# naudojamas loginis argumentas keep.rownames. Tokiu atveju lentel�je sukuriamas
# papildomas kintamasis rn.

mt <- data.table(mtcars, keep.rownames = TRUE)
mt


# Jeigu duomenys �ra�yti � tekstin� fail�, juos galima nuskaityti naudojant f-j�
# fread. Rezultatas bus data.table tipo duomen� lentel�. Pavyzd�iui, �ra�ysime �
# tekstin� fail� duomen� lentel� iris ir j� nuskaitysime kaip data.table lentel�.

write.table(iris, file = "df.txt", quote = FALSE, row.names = FALSE, sep = ";")

# Funkcijos fread parametrai beveik tokie pat kaip ir read.table parametrai, bet 
# yra ir kai kuri� skirtum�. Pagrindiai parametrai tokie:
#
#      input -- failo vardas,
#     header -- loginis kintamasis, nurodo ar lentel� turi antra�t�,
#        sep -- stulpeli� atskyrimo simbolis,
#      nrows -- nuskaitom� eilu�i� skai�ius,
#       skip -- praleid�iam� eilu�i� skai�ius,
#     select -- nuskaitom� stulpeli� pavadinim� vektorius,
#       drop -- praleid�iam� stulpeli� pavadinim� vektorius.

df <- fread(input = "df.txt", header = TRUE, sep = ";")
df


# data.table tipo lentel� tuo pa�iu yra ir data.frame lentel�, d�l to jas galima 
# naudoti su visomis funkcijomis, kuri� argumentas yra data.frame lentel�. Pvz.,
# su data.table lentel�mis veikia tokios funkcijos kaip names, colnames, nrow su 
# ncol ir daugelis kit�.

class(df)

# Visi veiksmai su data.table tipo lentele atliekami by reference, t.y. nedarant 
# jos kopij�. D�l tos prie�asties, jei viena data.table lentel� priskiriam kitai, 
# tai naujas objektas nesukuriamas, o gauname t� pa�i� lentel� su dviem vardais.
# Dar daugiau -- visi pakeitimai padaryti pradin�je lentel�je, bus matomi ir jos
# "kopijoje". �it� fakt� patikrinsime kiek v�liau.

yx <- xy
yx

# Norint gauti nepriklausom� data.table lentel�s kopij�, naudojama funkcija copy.

dt <- copy(xy)
dt

# Vis� data.table lenteli� bei j� charakteristik� s�ra�� sudaro funkcija tables.

tables()


# Jei lentel�je reikia pakeisti kuri� nors vien� reik�m�, galim naudoti funkcij�
# set. Jos sintaks� set(x, iL, jL, value) atitinka konstrukcij� x[i, j] <- value.
# Eilut�s ir stulpelio numeriai i ir j turi b�ti sveikieji skai�iai. Pavyzd�iui,
# taip pakeisime pirmos eilut�s ir pirmo stulpelio reik�m� i� "Re_5" � "re".

set(xy, 1L, 1L, "re")
xy

# Jeigu eilut�s numeris nenurodomas, tada laikoma, kad kei�iamos visos stulpelio 
# reik�m�s, ir parametrui value priskiriamas nauj� stulpelio reik�mi� vektorius.

set(xy, j = 1L, value = c("re", "mi", "do", "do", "sol"))
xy

# Funkcija setnames naudojama data.table lentel�s stulpeli� pavadinimams keisti.

setnames(xy, c("X", "Y"), c("Nata", "Da�nis"))
xy

# Stulpeli� tvarkos pakeitimui naudojama funkcija setcolorder. Pavyzd�iui, �itai
# lentelei sukeisime vietomis stulpelius.

setcolorder(xy, c("Da�nis", "Nata"))
xy

# Dabar galima patikrinti ar lentel�je yx matosi visi tie pakeitimai, kurie buvo
# atlikti su lentele xy, o lentel� dt liko nepakitusi.

identical(xy, yx)

xy
yx
dt


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# EILU�I� IR STULPELI� I�RINKIMAS         #
# --------------------------------------- #

dt <- data.table(iris)
dt

# Eilut�s i�renkamos argumentui i priskiriant reikiam� eilu�i� numeri� vektori�. 
# Pavyzd�iui, i� visos lentel�s i�rinksime tre�i� eilut�.

dt[3]

# Eilutes galima i�rinkti pagal tam tikr� login� s�lyg�. Pavyzd�iui, i�rinksime
# tas eilutes, kuriose kintamojo Sepal.Length reik�m� didesn� u� 7.

dt[Sepal.Length > 7]

# Login�s s�lygos gali b�ti gana sud�tingos. Pavyzd�iui., i�rinksime tas eilutes,
# kuriose kintamojo Sepal.Length reik�m�s lygios 4.3, 5.4, 6.1, 7.2. �iuo atveju 
# panaudosime standartin� R operatori� %in%.

dt[Sepal.Length %in% c(4.3, 5.4, 6.1, 7.2)]

# Tuo atveju, kada eilutes reikia i�rinkti i� tam tikro vieno stulpelio reik�mi�
# intervalo, galima naudoti special� operatori� %between%.

dt[Sepal.Length %between% c(5.3, 5.5)]

# Jeigu ie�koma reik�m� n�ra tiksliai �inoma, jos paie�kai galima naudoti %like%
# operatori�. Pvz., rasime visas eilutes, kuriose stulpelio Sepal.Length reik�m�
# po kablelio turi skai�i� 4: 3.4, 4.4, 5.4 ir t. t.

dt[Sepal.Length %like% ".4"]


# Stulpelio reik�m�s i�renkamos argumentui j priskiriant to stulpelio pavadinim�.
# Jei eilu�i� numeriai nenurodomi, i�renkamos visos to stulpelio reik�m�s. Pvz.,
# taip � atskir� vektori� i�rinksime stulpelio Sepal.Length reik�mes.

dt[, Sepal.Length]

# Jei i� atrinkt� stulpeli� reikia gauti nauj� lentel�, t� stulpeli� pavadinimus 
# reikia apjungti � s�ra��. Tam galima naudoti speciali� data.table konstrukcij�
# .() arba �prast� funkcij� list -- rezultatas bus tas pats. Pavyzd�iui, gausime
# lentel� su dviem stulpeliais Sepal.Length ir Sepal.Width.

dt[, .(Sepal.Length, Sepal.Width)]

dt[, list(Sepal.Length, Sepal.Width)]

# SVARBI PASTABA! Kadangi data.table lentel�s viduje stulpeli� vardai suprantami
# kaip paprasti R kintamieji, tai visos konstrukcijos su jais yra i�rai�kos. D�l 
# to, kintam�j� vardus apjungus su funkcija c, gausime vien� bendr� vektori�.

dt[, c(Sepal.Length, Sepal.Width)]


# Stulpelius galima i�rinkti ir pagal j� numer� lentel�je, ta�iau tam reikalinga
# pakeisti papildomo data.table parametro with reik�m� i� TRUE � FALSE.

dt[, c(1, 2), with = FALSE]

# Toks b�das naudojamas ir tuo atveju, kai reikia manipuliuoti kintam�j� vardais.
# Kintam�j� vardus � vektori� galima apjungti rankiniu b�du arba galima naudoti 
# kitus metodus, pavyzd�iui, reikiam� stulpeli� ie�koti naudojant funkcij� grep.
# Pvz., i� lentel�s i�rinksime tik tuos kintamuosius, kuri� pavadinime yra �odis 
# "Sepal".

dt[, c("Sepal.Length", "Sepal.Width"), with = FALSE]

dt[, grep("Sepal", names(dt)), with = FALSE]


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# STULPELI� SUK�RIMAS IR PANAIKINIMAS     #
# --------------------------------------- #

# Kintamasis data.table lentel�je sukuriamas naudojant := priskyrimo operatori�.
# Kair�je �io operatoriaus pus�je ra�omas kintamojo vardas, o de�in�je tam tikra 
# i�rai�ka. Pvz., sukursime kintam�j� Sepal.Sum, kuris bus dviej� kintam�j� suma.

dt[, Sepal.Sum := Sepal.Length + Sepal.Width]
dt

# SVARBI PASTABA! Kintamasis data.table lentel�je sukuriamas ar perskai�iuojamas 
# by reference, tod�l �ia �prasta R konstrukcija dt <- dt[...] nenaudotina! 

# Tuo atveju, kai de�in�je pus�je reik�mi� neu�tenka u�pildyti visam stulpeliui,
# jos cikli�kai prat�siamos. Pavyzd�iui, taip paprastai galima sukurti kintam�j� 
# X su viena ir ta pa�ia reik�me.

dt[, X := 1]
dt

# Jeigu vienu metu sukuriami arba perskai�iuojami i� karto keli kintamieji, tada
# kair�je operatoriaus := pus�je ra�omas kintam�j� vard� vektorius, de�in�je --
# s�ra�as, kurio elementai yra t� kintam�j� reik�m�s arba reik�mi� apskai�iavimo
# i�rai�kos.

dt[, c("V", "G") := list(mean(Sepal.Length), as.numeric(Species))]
dt

# Kintamajam priskyrus reik�m� NULL, jis i� lentel�s panaikinamas.

dt[, X := NULL]
dt

# Analogi�kai panaikinami i� karto keli stulpeliai.

dt[, c("Sepal.Sum", "V", "G") := NULL]
dt


# Vienas i� tipini� veiksm� -- vieno ar keli� lentel�s stulpeli� charakteristik�
# skai�iavimas. Tai gali b�ti kintam�j� vidurkiai, element� skai�ius ir pana�ios
# charakteristikos. Tokiu atveju argumentui j priskiriama funkcija nuo kintamojo. 
# Pavyzd�iui, apskai�iuosime kintamojo Sepal.Length vidurk�.

dt[, mean(Sepal.Length)]

# Jeigu i�rai�ka �traukiama � .() skliaustus, rezultatas yra data.table lentel�.
# Beje, Kaip ir anks�iau, vietoje skliaust� galima naudoti funkcij� list.

dt[, .(mean(Sepal.Length))]

# �inoma, apskai�iuotai kintamojo charakteristikai galima priskirti nauj� vard�.

dt[, .(Vidurkis = mean(Sepal.Length))]

# Tokiu b�du galima u�ra�yti komand� i� karto keli� stulpeli� statistikoms gauti.
# Pavyzd�iui, sudarysime lentel� su dviej� kintam�j� Sepal.Length ir Sepal.Width 
# vidurkiais ir reik�mi� �iuose stulpeliuose skai�iumi.

dt[, .(N = length(Sepal.Length), L = mean(Sepal.Length), W = mean(Sepal.Width))]


# NAUDINGA ------------------------------

# I� esm�s data.table lentel�s viduje su kintamaisiais galima daryti k� tik nori.
# Pavyzd�iui, kintam�j� vardus galima naudoti grafik� brai�ymui.

dt[, plot(Petal.Length, Petal.Width, col = Species, pch = 19)]

# Jei reikia, kelias kabliata�kiu atskirtas komandas galima apjungti riestiniais 
# skliaustais. Pavyzd�iui, nubrai�ysime dviej� kintam�j� sklaidos diagram� ir j�
# papildysime paprastosios tiesin�s regresijos tiese.

dt[, {plot(Petal.Length, Petal.Width); abline(lm(Petal.Width ~ Petal.Length))}]


# --------------------------------------- #
# EILU�I� GRUPAVIMAS                      #
# --------------------------------------- #

# Labai da�nai reikia apskai�iuoti tam tikras kintam�j� charakteristikas grup�se
# pagal kategorinio kintamojo reik�mes. �iuo atveju data.table lentel� papildome
# argumentu by, kuriam nurodomas arba grupavimo kintamasis, arba login�s s�lygos.
# Pavyzd�iui, apskai�iuosime kintamojo Sepal.Length vidurk� atskirai kiekvienoje 
# kintamojo Species reik�mi� grup�je -- gausime trij� s�lygini� vidurki� lentel�.

dt[, mean(Sepal.Length), by = Species]

# �inoma, vienu metu galima apskai�iuoti kelias s�lygines charakteristikas. Pvz.,
# apskai�iuosime kintamojo Sepal.Length vidurk� ir sum� atskirai pagal kintamojo
# Species reik�mes.

dt[, .(Vidurkis = mean(Sepal.Length), Suma = sum(Sepal.Length)), by = Species]

# Grupavimas gali b�ti atliekamas pagal login� s�lyg�. Pvz., sudarysime 2 grupes
# pagal tai, ar kintamojo Sepal.Width reik�m� didesn� u� 3, ar ne.

dt[, .(Vidurkis = mean(Sepal.Length)), by = Sepal.Width > 3]

# Jeigu grupavimas atliekamas pagal kelis kintamuosius arba logines s�lygas, tai
# juos apjungiame su .() skliaustais (kaip ir anks�iau, vietoje .() tinka list). 

dt[, .(Vidurkis = mean(Sepal.Length)), by = .(Species, Sepal.Width > 3)]


# NAUDINGA ------------------------------

# Grupavimo kintamiesiems ir login�ms s�lygoms galima suteikti pavadinim�. Pvz.,
# papildysime anks�iau u�ra�yt� komand� taip, kad login�s s�lygos sudaryta grup� 
# taip pat tur�t� pavadinim�. 

# Patogumo d�lei loginio kintamojo reik�mes TRUE ir FALSE b�t� geriau pakeisti � 
# labiau suprantamus pavadinimus. Vienas i� b�d� -- naudoti funkcij� ifelse. Bet 
# tokia komanda bus labai ilga, tod�l j� geriau i�skaidyti � dvi dalis. Problema
# tame, kad data.table tipo lentel�je stulpeli� pavadinimai interpretuojami kaip 
# kintamieji, tod�l ra�omi be kabu�i� ir u� lentel�s rib� jokios prasm�s neturi.
# Skliaustai .() taip pat naudojami tik data.table lentel�s viduje. 

# �iuo atveju, naudojant funkcij� quote, reikiam� komand� paver�iame � call tipo 
# i�rai�k�. Ji suvykdoma lentel�s viduje, kur kintam�j� pavadinimai turi prasm�.

grup� <- quote(.(R��is = Species, 
                 Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras")))
grup�

dt[, .(Vidurkis = mean(Sepal.Length)), by = grup�]


# NAUDINGA ------------------------------

# Kartu su grupavimo argumentu by naudojamos kelios specialios funkcijos, kurios 
# leid�ia supaprastintai u�ra�yti da�nai pasitaikan�ias konstrukcijas:
#
#        .SD -- ta pati lentel�, ta�iau be grupavimo kintamojo,
#        .BY -- grupavimo kintamojo reik�mi� s�ra�as,
#         .N -- eilu�i� skai�ius grup�je,
#         .I -- eilu�i� numeriai grup�je,
#       .GRP -- grup�s numeris.


# Priklausomai nuo to, kuriam argumentui priskiriama reik�m� .N, rezultatas gali 
# b�ti arba paskutini lentel� eilut�, arba bendras eilu�i� skai�ius.

dt[.N]
dt[, .N]

# Kadangi .N nurodo eilu�i� skai�i� grup�je, naudojant .N galima sudaryti da�ni� 
# lentel�.

dt[, .N, by = .(Species, Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras"))]

# Naudojant .I, galima su�inoti � konkre�ias grupes patenkan�i� eilu�i� numerius.

dt[, .I, by = .(Species, Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras"))]


# Atlikus eilu�i� grupavim�, tolimesniems skai�iavimams tas grupavimo kintamasis 
# da�niausiai nereikalingas ir tam, kad netrukdyt�, i� lentel�s yra pa�alinamas.
# Kaip tik tokiais atvejais ir naudojama .SD konstrukcija. 

# .SD lentel�s viduje galima taikyti �prastas funkcijas nuo kintam�j�-stulpeli�.
# Pavyzd�iui, naudojant funkcij� lapply, apskai�iuosime vis� lentel�s stulpeli� 
# vidurkius grup�se pagal kintamojo Species reik�mes.

dt[, lapply(.SD, mean), by = Species]

# I� esm�s tok� pat rezultat� galima gauti ir naudojant kitas standartines f-jas.

dt[, .(Vidurkis = apply(.SD, 2, mean)), by = Species]
dt[, .(Vidurkis = colMeans(.SD)), by = Species]


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# DATA.TABLE EILU�I� INDEKSAVIMAS         #
# --------------------------------------- #

# data.table lentelei galima priskirti raktus - tokias stulpeli� reik�mes, pagal 
# kurias vienareik�mi�kai nustatoma, i� kurios eilut�s ta reik�m� paimta. Raktas
# gali b�ti sudaromas pagal vien� ar kelis lentel�s stulpelius. D�l �ios savyb�s
# data.table lentel�s primena duomen� bazes. 

# Rakt� turin�ios lentel�s eilut�s i�rikiuojamos pagal to rakto reik�mes, d�l to
# eilu�i� i�rinkimas pagal rakt� yra labai greitas. 

# Raktas data.table lentelei priskiriamas naudojant funkcij� setkey. Pavyzd�iui, 
# lentelei dt priskirsime rakt� pagal stulpelio Species reik�mes.

setkey(dt, Species)

# Kokius raktus turi lentel�, nustatoma naudojant funkcij� key.

key(dt)

# Raktas gali b�ti nustatomas ir sudarant lentel�. Tam naudojamas parametras key,
# kuriam priskiriamas kintam�j� vard� vektorius.

dt <- data.table(iris, key = "Species")
dt

key(dt)


# I�renkant eilutes pagal rakto reik�m�, rakto reik�m� priskiriama argumentui i.
# Pavyzd�iui, i�rinksime tas lentel�s eilutes, kurios priklauso "setosa" grupei.

dt["setosa"]

# Standarti�kai i�vedamos visos eilut�s, kurios turi nurodyt� rakto reik�m�, bet
# i� viso galimi keli variantai: rodyti visas eilutes, rodyti pirm� ar paskutin�
# eilut�. Tam naudojamas parametras mult.

dt["setosa", mult = "all"]
dt["setosa", mult = "first"]
dt["setosa", mult = "last"]

# Gali b�ti, kad lentel�je n�ra eilu�i�, kurios tur�t� nustatytas rakto reik�mes.
# Tokios nerastos eilut�s pa�ymimos NA reik�me, bet, naudojant parametr� nomatch, 
# galima nustatyti, kad jos neb�t� rodomos. Pvz., i�rinksime tas eilutes, kurios
# priklauso "setosa" arba "mimosa" grupei.

dt[c("setosa", "mimosa")]

# Matome, kad "mimosa" grup�je n�ra n� vienos eilut�s, tod�l ta grup� �ymima NA.
# Kad tokia eilut� neb�t� rodoma, parametrui nomatch priskiriame reik�m� 0.

dt[c("setosa", "mimosa"), nomatch = 0]


# Raktas gali b�ti naudojamas skai�iuojant s�lygines stulpeli� charakteristikas. 
# Tai atliekama argumentui by priskiriant .EACHI reik�m�. Pavyzd�iui, u�ra�ysime
# komand�, kuri apskai�iuot� kintamojo Sepal.Length vidurk� grup�se pagal rakto 
# reik�mes "setosa" ir "virginica".

dt[c("setosa", "virginica"), mean(Sepal.Length), by = .EACHI]


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# NEDIDELIS GREI�IO BANDYMAS: DF vs DT    #
# --------------------------------------- #

n = 1e7

x <- sample(LETTERS, n, TRUE)
y <- sample(letters, n, TRUE)
z <- runif(n)

DF <- data.frame(x, y, z)
DT <- data.table(DF)

head(DF)
head(DT)


system.time(DF[DF$x == "R" & DF$y == "f", ])
system.time({setkey(DT, x, y); DT[J("R", "f")]})
