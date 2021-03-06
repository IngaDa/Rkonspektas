
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Matric� ir s�ra�� ciklo funkcijos apply, lapply ir sapply.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2013-08-25 | 2013-08-29
#


# TURINYS -------------------------------

#
#   1. Kelios pastabos apie funkcin� programavim�:
#      * trumpai apie duomenis ir ciklus
#
#   2. Matricos ir s�ra�o ciklo funkcijos:
#      * funkcija apply
#      * funkcija lapply
#      * funkcija sapply
#


# PASTABOS ------------------------------

#
# Sugalvoti daugiau u�davini�.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE DUOMENIS IR CIKLUS         #
# --------------------------------------- #

# Paprastai statistiniai duomenys yra vektoriaus, matricos arba duomen� lentel�s
# pavidalo. Visi vektoriaus elementai b�tinai yra to paties tipo: arba skai�iai, 
# arba simboliai ir t.t. Kadangi visi matricos elementai yra to paties tipo, tai 
# bet kuri matricos eilut� arba stulpelis taip pat yra vektorius.

v <- c(60, 9, 61, 62, 64, 4, 91, 6, 57, 2, 78, 76, 3, 41, 72, 95, 47, 11, 8, 96)

m <- matrix(v, ncol = 5)
m

class(m)           # m yra matricos tipo objektas
mode(m)            # matrica sudaryta i� skai�i�

is.vector(m[1, ])  # pirma matricos eilut� yra vektorius
is.vector(m[, 1])  # pirmas matricos stulpelis taip pat vektorius


# Duomen� lentel�s stulpeliai gali b�ti skirting� tip�, tod�l eilut�s elementai
# taip pat bus skirting� tip�. D�l tos prie�asties viena atskirai paimta duomen�
# lentel�s eilut� n�ra vektorius, ta�iau yra specialaus list tipo s�ra�as, kurio 
# elementai gali b�ti skirtingo tipo.

d <- data.frame(x = 1:5, y = letters[1:5], z = TRUE)
d

class(d)           # duomen� lentel� i� skirtingo tipo vektori� stulpeliuose
mode(d)            # duomen� lentel� sudaryta i� list tipo �ra�� eilut�se

# Priklausomai nuo to, kaip interpretuojama duomen� lentel�, yra keli b�dai kaip 
# i� lentel�s kaip vektori� i�skirti vien� jos stulpel�. Bet kokiu atveju reikia
# nurodyti arba kintamojo pavadinim�, arba stulpelio numer� duomen� lentel�je.

d$x                # � duomen� lentel� �i�rim kaip � duomen� lentel�

d[, 1]             # � duomen� lentel� �i�rim kaip � matric�
d[, "x"]           #

d[[1]]             # � duomen� lentel� �i�rim kaip � list tipo s�ra��
d[["x"]]           #


# R turi labai daug standartini� funkcij� skaitin�ms vektori� charateristikoms 
# apskai�iuoti:

length(v)          # element� skai�ius
min(v)             # minimumas
max(v)             # maksimumas
sum(v)             # suma
median(v)          # mediana
mean(v)            # vidurkis

# Statistikoje �ias ir daug kit� charakteristik� tenka apskai�iuoti matricoms ir
# duomen� lentel�ms. Kadangi matrica turi daug stulpeli�, o kiekvienas i� j� yra 
# vektorius, tam tikrai vektoriaus charakteristikai apskai�iuoti skirt� funkcij� 
# galima �d�ti � cikl� ir tokiu b�du j� apskai�iuoti visoms matricos eilut�ms ar 
# stulpeliams i� karto.

# Pavyzd�iui, tokiu b�du apskai�iuosime matricos eilu�i� sumas. Sukursime tu��i�
# vektori�, kurio i-ajam elementui priskirsime i-osios eilut�s m[i, ] element�
# sum�. Sumavimas atliekamas cikle, ten ciklo kintamasis i �gyja reik�mes nuo 1 
# iki nrow(m) ir taip "perb�ga" per visas matricos eilutes.

eilut�s.suma <- vector()

for (i in 1:nrow(m)) {
  eilut� <- m[i, ]
  eilut�s.suma[i] <- sum(eilut�)
}

eilut�s.suma

# Tokia programa, kurioje detaliai apra�omos visos skai�iavimo instrukcijos, yra 
# tipi�kas imperatyvinio programavimo, kurio pagrindas yra kintamasis, pavyzdys. 

# R yra funkcinio programavimo kalba, ir pagal funkcinio programavimo paradigm�
# bet kokie skai�iavimai traktuojami kaip funkcijos (matematine prasme) reik�m�s 
# apskai�iavimas, kuri priklauso nuo pradini� duomen� ir kit� funkcij� rezultato.

# Funkcinis programavimas daugeliu dalyk� i� esm�s skiriasi nuo imperatyvinio 
# programavimo. Pavyzd�iui, grynai funkciniame programavime n�ra ciklo s�vokos. 
# Vietoje ciklo iteracijos realizuojamos per rekursij�, kada funkcija i��aukia
# pati save. D�l tos prie�asties, programuojant su R reikia prisiminti taisykl�: 

# JEI KYLA NORAS RA�YTI FOR CIKL�, TAI GREI�IAUSIAI JIS �IA VISAI NEREIKALINGAS.

# �iam tikslui R naudojamos apply �eimos funkcijos, kuri� apra�ymui skirtas �is
# konspektas.


# --------------------------------------- #
# FUNKCIJA APPLY                          #
# --------------------------------------- #

# Daug statistini� skai�iavim� atliekama su matricomis. Jei tam tikrus veiksmus 
# reikia atlikti su visomis matricos eilut�mis ar stulpeliais, ir tuos veiksmus
# galima u�ra�yti kaip funkcij�, tai tokiais atvejais naudojama funkcija apply.
# Jos parametrai:
# 
#        X -- matricos pavadinimas,
#   MARGIN -- indekso reik�m�: eilut�ms 1, stulpeliams 2,
#      FUN -- funkcija,
#      ... -- papildomi funkcijos parametrai (jei tokie yra).

# Parametras FUN gali b�ti bet kokia standartin� R funkcija, kurios argumentas
# yra vektorius. 

# Pavyzd�iui, naudodami funkcij� apply apskai�iuosime matricos m eilu�i� sumas.
apply(m, 1, sum)

# Analogi�kai gaunamos matricos stulpeli� sumos.
apply(m, 2, sum)

# Funkcijos reik�m� neb�tinai turi b�ti vienas skai�ius. Pavyzd�iui, nurod�ius
# funkcij� summary, kiekvienai matricos eilutei arba stulpeliui apskai�iuojamos 
# i� karto kelios skaitin�s charakteristikos.
apply(m, 2, summary)


# Atliekant specifinius skai�iavimus, nevisada galima rasti tinkam� standartin� 
# R funkcij�. Tokiais atvejais tenka sukurti savo funkcij�. Tarkime, kad reikia 
# apskai�iuoti ma�iausios ir did�iausios vektoriaus reik�m�s vidurk�. Konkre�iai 
# tokios funkcijos R neturi, tod�l j� u�ra�ysime. 

minmax.vidurkis <- function (x) {
  min <- min(x)
  max <- max(x)
  vid <- (min + max)/2
  return(vid)
}

# Toki� funkcij� jau galima �ra�yti � funkcij� apply.
apply(m, 2, minmax.vidurkis)


# T� pa�i� funkcij� u�ra�ysime vadovaudamiesi funkcinio programavimo paradigma, 
# pagal kuri� vienos funkcijos rezultatas tiesiogiai perduodamas kitai funkcijai.
# Standartin� funkcija range gr��ina vektori� su ma�iausia ir did�iausia reik�me, 
# kur� be tarpini� kintam�j� perduodame vidurkio skai�iavimo funkcijai mean. 

minmax.vidurkis <- function (x) mean(range(x))

apply(m, 2, minmax.vidurkis)

# Tais atvejais, kai funkcij� pavyksta u�ra�yti labai kompakti�kai, j� galima 
# �ra�yti tiesiai � funkcij� apply. Toks apply naudojimas yra �prasta praktika
# programuojant su R.

apply(m, 2, function (x) mean(range(x)))

# �ia funkcijos argumentas x yra matricos eilut�, jei apply parametras MARGIN
# lygus 1, arba stulpelis, jei MARGIN reik�m� yra 2.


# � apply �statomos funkcijos da�nai pa�ios turi savo parametrus. Pvz., funkcija
# sum ir daugelis kit� R funkcij� turi parametr� na.rm, kuriam priskyrus reik�m� 
# TRUE, praleistos reik�m�s duomenyse ignoruojamos. Tokie papildomi parametrai
# perduodami kaip ... parametras.

u <- c(60, 9, NA, 62, 64, 4, 91, 6, 57, 2, NA, 76, 3, 41, 72, 95, 47, 11, 8, 96)

n <- matrix(u, ncol = 5)
n

# Pavyzd�iui, apskai�iuosime matricos su praleistomis reik�m�mis stulpeli� sumas.
# Kadangi pirmame ir tre�iame stulpeliuose yra praleist� reik�mi�, apskai�iuoto
# sum� vektoriaus pirmas ir tre�ias elementai taip pat turi praleistas reik�mes.

apply(n, 2, sum)

# Pakeitus funkcijos sum parametro na.rm reik�m� � TRUE, sumos apskai�iuojamos
# visiems matricos stulpeliams (reikia nepamir�ti, kad sumos gautos atmetus NA
# reik�mes ir susumavus skirting� element� skai�i�, tod�l nelabai palyginamos).

apply(n, 2, sum, na.rm = TRUE)


# U�DUOTIS ------------------------------ 

# 1. Naudojant funkcij� apply, u�ra�ykite komand�, kuri apskai�iuot� matricos m 
#    stulpeli� vidurk�. U�ra�ykite toki� komandos versij�, kuri apskai�iuot� tik
#    pirm� dviej� stulpeli� vidurkius.
# 2. Naudojant f-j� apply, u�ra�ykite komand�, kuri matricos stulpeli� elementus 
#    i�rikiuot� did�jimo tvarka. Vektoriaus element� i�rikiavimui naudojama f-ja 
#    sort.
# 3. Naudojant f-j� apply, u�ra�ykite komand�, kuri i� skai�i� matricos eilu�i� 
#    i�rinkt� po du did�iausius elementus. Funkcij� dviej� did�iausi� vektoriaus 
#    element� i�rinkimui galima u�sira�yti atskirai ir �statyti j� � f-j� apply.
# 4. Naudodami funkcij� apply, apskai�iuokite, kiek matricos m stulpeliuose yra
#    element�, kuri� reik�m�s didesn�s nei 50.


# --------------------------------------- #
# FUNKCIJOS LAPPLY IR SAPPLY              #
# --------------------------------------- #

# Ne visus duomenis galima pateikti matricos pavidalu. Pvz., nevienod� element�
# skai�i� turin�i� vektori� negalima apjungti � matric�. Be to, nei vektorius,
# nei matrica negali tur�ti skirtingo tipo element�. Tokios strukt�ros duomenims
# naudojamas list tipo s�ra�as. Labai da�nai � s�ra�� apjungiami to paties tipo, 
# ta�iau gana sud�tingi objektai. Tai gali b�ti vektori� ar matric� s�ra�as, net 
# duomen� lenteli� ar dar sud�tingesni� objekt� s�ra�as.

# Funkcijos apply analogas s�ra�ams yra funkcijos lapply ir sapply. Pagrindiniai
# j� parametrai:
# 
#        X -- s�ra�o pavadinimas,
#      FUN -- funkcija,
#      ... -- papildomi funkcijos parametrai (jei tokie yra).

# Tais atvejais, kai funkcijos FUN reik�m� yra vektorius arba dar sud�tingesnis
# objektas, ir rezultatai turi b�ti s�ra�o pavidalu, naudojama funkcija lapply. 
# Jeigu funkcijos FUN reik�m� yra vienas skai�ius, simbolis arba login� reik�m�, 
# patogiau, kai bendras rezultatas yra vektorius, tod�l tokiu atveju naudojama 
# funkcija sapply. Rezultat� pateikimo forma vienintelis �i� funkcij� skirtumas.

# Pvz., apskai�iuosime s�ra�o, kur� sudaro nevienod� element� skai�i� turintys
# vektoriai, vidurkius.

v1 <- c(11, 21, 38, 32,  7, 41, 14, 10, 32, 19, 42, 28, 33, 38, 5, 17)
v2 <- c(30, 38, 22, 38, 45, 23, 23,  3, 18, 38)
v3 <- c(61, 71, 98, 81, 59, 76, 92, 31, 89, 32, 83, 43)
v4 <- c(81, 95, 74, 61, 27, 73, 60, 72, 50, 32, 79, 32, 10, 74)
v5 <- c(12, 14, 56, 45, 6, 85, 64, 8, 59, 59, 69, 5, 50, 34)


l <- list(Pirmas = v1, Antras = v2, Tre�ias = v3, Ketvirtas = v4, Penktas = v5)

# Naudojant lapply rezultatas bus s�ra�as i� penki� element�, kuri� reik�m�s yra
# atskirai kiekvieno vektoriaus vidurkis.
lapply(l, mean)

# Naudojant sapply rezultatas yra penkis elementus turintis vidurki� vektorius.
# Kadangi pradinio s�ra�o elementai turi vardus, tai ir rezultat� vektorius taip 
# pat turi element� vardus.
sapply(l, mean)


# Jei funkcijos FUN rezultatas yra vektorius, tai lapply rezultatas bus s�ra�as,
# kurio elementai yra tie vektoriai, o sapply rezultatas bus matrica, kuri tur�s
# tiek stulpeli�, kiek element� tur�jo pradinis s�ra�as.

# Pavyzd�iui, naudojant funkcij� summary, apskai�iuosime kiekvieno vektoriaus i� 
# s�ra�o l pagrindines skaitines charakteristikas. Patogumo d�lei, �i� funkcij� 
# rezultatus priskirsime kintamiesiems.

rez.l <- lapply(l, summary)
rez.l

rez.s <- sapply(l, summary)
rez.s

# Paprastai toki� skai�iavim� rezultatai naudojami tolimesnei duomen� analizei,
# kur, priklausomai nuo gaut� rezultat� pavidalo (vektorius, matric� ar s�ra�as) 
# v�l galima taikyti kuri� nors apply �eimos ar kit� funkcij�.

# Pavyzd�iui, galima nesunkiai atsakyti � klausim�, kurio vektoriaus minimumas
# did�iausias. Tam reikia surasti did�iausi� pirmosios eilut�s (Min) element�.
# Tam panaudosime funkcij� which.max.

which.max(rez.s[1, ])


# Funkcijos lapply ir sapply gali b�ti naudojamos ne tik skai�iavimams, bet ir 
# duomen� pertvarkymams. Pvz., u�ra�ysime komand�, kuri i� kiekvieno vektoriaus 
# i�skirs pirmuosius k element�, k yra ma�iausias vektoriaus element� skai�ius.
# Vektoriaus element� skai�i� apskai�iuosime naudojant funkcij� length.

sapply(l, length)

# Matome, kad vektori� element� skai�ius nevienodas, vadinasi, pirmiausia reikia
# susirasti ma�iausi� vektoriaus element� skai�i�. 

k <- min(sapply(l, length))
k

# Vektoriaus element� i�skyrimui sudarysime speciali� funkcij�, kuri� �ra�ysime
# tiesiai � funkcij� lapply.

lapply(l, function(x) x[1:k])


# Funkcinio programavimo apologetai visas komandas apjungt� � vien� i�rai�k�!

lapply(l, "[", 1:min(sapply(l, length)))

# Vektoriaus element� i�skyrimui naudojamas operatorius [, kur� galima panaudoti 
# ir kaip funkcij�, kurios parametras yra i�skiriam� element� indeks� vektorius.
# �iuo atveju tai b�t� sveikieji skai�iai nuo 1 iki k.

lapply(l, "[", 1:k)
sapply(l, "[", 1:k)

# Pirmuoju atveju gaunamas s�ra�as, kuriame visi vektoriai turi vienod� element�
# skai�i�, antruoju atveju gaunama matrica, kurios stulpeliuose yra vektoriai.


# NAUDINGA ------------------------------

# Nors funkcijos lapply ir sapply skirtos s�ra�ams, jas lygiai taip pat galima 
# panaudoti pasikartojantiems veiksmams su vektoriais ir duomen� lentel�mis. 

# Pavyzd�iui, sugeneruosime n skirting� vektori�, kuri� elementai yra sveikieji 
# skai�iai nuo 1 iki n. Tam naudosime kaip funkcij� u�ra�yt� i�rai�k� 1:n, kur n 
# �gyja reik�mes 1, 2 ir t.t. iki 5. Kadangi vis� vektori� element� skai�ius yra
# skirtingas ir � matric� j� apjungti negalima, tod�l galutinis rezultatas bus 
# toki� vektori� s�ra�as.

lapply(1:5, function(n) 1:n)


# � funkcij� lapply arba sapply �sta�ius duomen� lentel�, funkcija "perb�ga" per
# stulpelius. Pavyzd�iui, naudodami funkcij� class, nustatysime duomen� lentel�s
# kintam�j� tip�.

sapply(d, class)

# Element� i�skyrimo operatori� [ naudojant kaip funkcij�, galima u�ra�yti toki�
# komand�, kuri � atskirus vektorius i�skirt� duomen� lentel�s stulpelius.

lapply(d, "[")

# Funkcija complete.cases nustato, ar duomen� lentel�s eilut� turi bent vien�
# praleist� reik�m�. Naudojant funkcij� sapply, galima u�ra�yti komand�, kuri
# patikrina, ar lentel�s stulpelyje yra bent viena praleista reik�m�.

sapply(d, function(x) any(is.na(x)))


# U�DUOTIS ------------------------------ 

# 1. Naudojant f-j� sapply, u�ra�ykite i�rai�k�, kuri surast� atskirai kiekvieno
#    vektoriaus i� s�ra�o l did�iausi� reik�m�. U�ra�ykite i�rai�k�, kuri rast� 
#    pa�i� did�iausi� vis� vektori� reik�m� (bendr� maksimum� i� vis� maksimum�).
# 2. Naudojant funkcij� sapply, u�ra�ykite i�rai�k�, kuri apskai�iuot� kiekvieno
#    vektoriaus i� s�ra�o l element� kvadrat� sum�.
# 3. U�ra�ykite toki� i�rai�k�, kuri apskai�iuot�, kuris s�ra�o l vektorius turi
#    did�iausi� skirtum� tarp savo did�iausios ir ma�iausios reik�m�s. Atsakymas
#    turi b�ti s�ra�o elemento, t.y. vektoriaus numeris.
# 4. Naudojant funkcij� sapply, apskai�iuokite, kiek kiekvienas s�ra�o vektorius 
#    turi element�, kuri� reik�m�s didesn�s u� 50.
# 5. Naudojant funkcij� lapply, u�ra�ykite komand�, kuri i� kiekvieno s�ra�o l
#    vektoriaus suformuot� matric� su dviem stulpeliais.
# 6. F-j� lapply pritaikant vektoriui, u�ra�ykite komand�, kuri interval� [0, 1] 
#    lygiomis dalimis padalina � 10, 20 ir 30 dali�. Interval� dalinan�i� ta�k�
#    sekos generavimui naudokite funkcij� seq su parametru length.out.
# 7. Naudojant f-j� sapply patikrinkite, kurie duomen� lentel�s d stulpeliai yra
#    numeric tipo. U�ra�ykite i�rai�k�, kuri suskai�iuot�, kiek toki� stulpeli�
#    lentel�je yra i� viso.
