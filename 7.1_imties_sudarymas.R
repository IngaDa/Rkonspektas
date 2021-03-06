
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Atsitiktin�s imties sudarymas naudojant proced�r� sample.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2013-03-25 | 2013-04-17 | 2015-09-20
#


# TURINYS -------------------------------

#
#   1. Atsitiktin�s imties i� vektoriaus element� i�rinkimas:
#      * funkcija sample
#      * funkcija set.seed
#
#   2. Tikimybini� eksperiment� modeliavimas:
#      * Bernulio bandym� schema
#


# PASTABOS ------------------------------

#
# Kol kas pastab� n�ra.
#


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# ATSITIKTIN�S IMTIES I�RINKIMAS          #
# --------------------------------------- #

# Atsitiktin�s imties i� vektoriaus element� sudarymui naudojama komanda sample.
# Jos parametrai:
#
#          x -- vektorius, i� kurio renkamos imties reik�m�s,
#       size -- i� vektoriaus x i�renkam� element� skai�ius, 
#    replace -- loginis kintamasis, nurodo, ar i�rinkimas su pasikartojimais,
#       prob -- i�renkam� element� tikimyb�s, pagal nutyl�jim� jos vienodos.


# Pvz., i� 5 elementus turin�ios aib�s x = {1, 2, 3, 4, 5} atsitiktine tvarka su 
# vienodomis tikimyb�mis reikia i�rinkti 3 elementus. Sudarysime tok� vektori� x, 
# kurio element� reik�mes sutapatinsime su aib�s element� numeriais.

x <- 1:5
n <- 3
sample(x, size = n)

# Kaip visada, jei proced�ros parametrai u�ra�omi numatyta tvarka, j� pavadinim� 
# galima nera�yti -- komanda bus �iek tiek trumpesn� ir kompakti�kesn�.

sample(x, n)


# Funkcijai sample nurod�ius tik reik�mi� vektori� x, imtis bus sudaryta i� vis�
# atsitiktine tvarka i�d�styt� vektoriaus element� -- gaunamas jo perstatinys.

x <- 1:5
sample(x)

# Jei parametro x reik�m� yra ne vektorius, bet vienas nat�rinis skai�ius m, tai 
# imtis bus renkama i� vektoriaus (1, 2, ..., m) element�.

m <- 5
n <- 3
sample(m, n)


# Naudojant R proced�r� sample, pagal nutyl�jim� sudaroma paprastoji atsitiktin� 
# negr��intin� imtis, tod�l imties elementai nesikartoja. Jeigu imties elementai 
# gali kartotis arba i�renkam� element� skai�ius didesnis u� vektoriaus element� 
# skai�i�, loginio parametro replace reik�m� pakei�iama � TRUE.

sample(x, n, replace = TRUE)


# Pagal nutyl�jim� vis� vektoriaus element� i�rinkimo tikimyb�s vienodos, ta�iau 
# jas galima pakeisti; parametrui prob priskiriamas element� i�rinkimo tikimybi� 
# vektorius. Tikimybi� vektoriaus element� skai�ius turi sutapti su vektoriaus x 
# element� skai�iumi, o tikimybi� suma turi b�ti lygi vienetui. 

# Pvz., sudarysime imt� i� aib�s x = {1, 2, 3, 4, 5} rinkdami k = 1000 element�. 
# Kadangi vis� aib�s element� i�rinkimo � imt� tikimyb�s vienodos ir lygios 1/5, 
# tokiu b�du sudarytoje imtyje j� skai�ius tur�t� b�ti ma�daug vienodas ir lygus
# apie 200.

n <- 1000

imtis <- sample(x, n, replace = TRUE)
table(imtis)
barplot(table(imtis))

# Pavyzd�iui, i�rinkimo tikimybes pakeisime taip, kad pirmas ir paskutinis aib�s
# elementai b�t� i�renkami su tikimybe 0.1, antras ir ketvirtas su tikimybe 0.2, 
# o tre�ias --- su tikimybe 0.4. Tai rei�kia, kad gautoje imtyje tre�io elemento 
# tur�t� b�ti apie 400, antro ir ketvirto apie 200, o pirmo ir paskutinio po 100.

n <- 1000
p <- c(0.1, 0.2, 0.4, 0.2, 0.1)

imtis <- sample(x, n, replace = TRUE, prob = p)
table(imtis)


# NAUDINGA ------------------------------

# Visiems atsitiktini� dyd�i� generatoriams galima nurodyti pradin� generuojamos
# sekos reik�m�, kuri vadinama seed. Su ta pa�ia seed reik�me gaunama tokia pati 
# skai�i� seka. Suprantama, kad atsitiktini� dyd�i� seka, kuri� galima atkartoti,
# n�ra atsitiktin�, tod�l tokiu b�du gauti dyd�iai vadinami pseudoatsitiktiniais.
# �i� generatori� savyb� galima naudoti tuo atveju, kai reikia visi�kai tiksliai 
# atkartoti tikimybinio modeliavimo eksperiment�: generuoti identi�kus duomenis,
# patikrinti, ar korekti�kai veikia nuo atsitiktinumo priklausantis algoritmas.

# Generatoriui seed reik�m� nustatoma per funkcij� set.seed, kuriai priskiriamas 
# sveikasis skai�ius, kuris ir yra seed reik�m�.

set.seed(666)
sample(5)

# Norint gauti t� pa�i� ats. dyd�i� sek�, seed reik�m� reikia nurodyti i� naujo.

sample(5)
sample(5)
sample(5)

set.seed(666)
sample(5)
set.seed(666)
sample(5)
set.seed(666)
sample(5)


# NAUDINGA ------------------------------

# Funkcij� sample galima naudoti ne tik imties i� vektoriaus reik�mi� i�rinkimui, 
# bet ir imties sudarymui i� kit� duomen� strukt�r�. Gana da�nai pasitaiko tokia
# situacija, kada i� didel�s duomen� lentel�s atsitiktine tvarka reikia i�rinkti 
# tik dal� jos eilu�i�. Pvz., i� duomen� lentel�s iris i�rinksime 10 jos eilu�i�. 

m <- nrow(iris)  # duomen� lentel�s eilu�i� skai�ius
n <- 10          # i�renkam� eilu�i� skai�ius

# Sudarome atsitiktinai su vienodomis tikimyb�mis i�renkam� eilu�i� numeri� sek�.
i <- sample(m, n)
i

# I� duomen� lentel�s pasirenkame tik tas eilutes, kuri� numeriai pateko � imt�.
d <- iris[i, ]
d


# U�DUOTIS ------------------------------ 

# 1. Naudodami proced�r� sample, para�ykite loterijos skai�i� generavimo komand�,
#    kuri i� 30 sunumeruot� kamuoliuk� be pasikartojim� i�traukt� 6.
# 2. Para�ykite antr� loterijos programos pus�, kuri tokiu pa�iu b�du parinkt� 6
#    �aid�jo skai�ius ir apskai�iuot�, kiek i� j� sutampa su loterijos skai�iais.
# 3. U�ra�ykite komand�, kuri vektoriaus LETTERS elementus i�d�liot� atsitiktine 
#    tvarka.
# 4. U�ra�ykite komand�, kuri atsitiktine tvarka sud�liot� duomen� lentel�s iris
#    eilutes.


# --------------------------------------- #
# BERNULIO BANDYM� MODELIAVIMAS           #
# --------------------------------------- #

# Kadangi proced�ra sample gali generuoti nepriklausom� atsitiktini� dyd�i� sek�,
# j� galima panaudoti nesud�ting� tikimybini� eksperiment� modeliavimui. Pla�iai 
# taikoma nepriklausom� bandym� schema ir atskiras jos atvejis Bernulio bandymai.

# Tarkime, kad vykdome n nepriklausom� bandym�, kuri� metu atsitiktinis �vykis A
# pasirodo su tam tikra pastovia tikimybe p. Jei �vykis A pasirodo, tok� bandym� 
# pa�ymime vienetu, jei �vykis nepasirodo --- bandym� pa�ymime nuliu. Tokiu b�du 
# gautas atsitiktinis dydis vadinamas Bernulio dyd�iu su parametru p. Sudarysime 
# komand�, kuri generuoja n Bernulio dyd�i� sek�.

x <- 0:1          # sudarome eksperimento baig�i� vektori�
p <- c(0.4, 0.6)  # nurodome eksperimento baig�i� tikimybes
n <- 10           # nurodome bandym� skai�i�

b <- sample(x, n, replace = TRUE, prob = p)
b

# S�kming� bandym� skai�ius, atlikus n Bernulio bandym� serij�, yra atsitiktinis
# dydis. Tok� dyd� vadiname binominiu atsitiktiniu dyd�iu su parametrais n ir p. 

sum(b)


# Klasikinis Bernulio bandym� schemos pavyzdys --- monetos m�tymo eksperimentas. 
# Pvz., sumodeliuosime eksperiment�, kuriame 100 kart� metama simetri�ka moneta.
# Kad b�t� papras�iau, monetos puses pa�ym�sime raid�mis H ir S, i� j� sudarome
# vieno metimo baig�i� vektori�, i� kurio renkane n reik�mi� su pasikartojimais.

moneta <- c("H", "S")
n <- 100

b <- sample(moneta, n, replace = TRUE)
b

# Modeliavimo rezultatus galima atvaizduoti da�ni� lentele arba da�ni� diagrama.
# Kadangi abi monetos pus�s i�renkamos su vienodomis tikimyb�mis, j� pasirodym� 
# da�nis turi b�ti apytiksliai lygus. T� ir parodo da�ni� lentel�.

l <- table(b)
l

barplot(l)


# U�DUOTIS ------------------------------ 

# 1. Sumodeliuokite simetri�ko lo�imo kauliuko m�tym�. Sugalvokite komand�, kuri
#    modeliuot� i� karto 100 lo�imo kauliuk� metim�.
# 2. Kaip m�tant lo�imo kauliuk� galima imituoti monetos m�tym�? U�ra�ykite tok� 
#    proces� modeliuojant� algoritm�.
# 3. Sumodeliuokite dviej� simetri�k� monet� n = 100 metim� serij� ir sudarykite 
#    vis� kombinacij� atsivertim� da�ni� lentel�. Ar visos kombinacijos pasirodo 
#    vienodai da�nai?
# 4. Tarkime, kad X yra bendra ta�k� suma metant du simetri�kus lo�imo kauliukus. 
#    Modeliavimo b�du nustatykite, kokia suma pasitaiko da�niau, X = 9 ar X = 10.
#    Kaip kei�iasi situacija, kai metami i� karto trys lo�imo kauliukai?
