
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Veiksmai su datos ir laiko duomenimis.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2015-11-05 | 2015-12-12
#


# TURINYS -------------------------------

#
#   1. Veiksmai su datos ir laiko kintamaisiais:
#      * funkcija weekdays
#      * funkcija months
#      * funkcija quarters
#      * funkcija trunc
#      * funkcija round
#      * funkcija seq
#      * funkcija cut
#
#   2. Skirtumas tarp dviej� laiko moment�:
#      * funkcija as.difftime
#      * funkcija difftime
#      * funkcija diff
#      * funkcija units
#      * funkcija proc.time()
#      * funkcija system.time
#


# PASTABOS ------------------------------

#
# Galima sugalvoti daugiau u�duo�i�.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# VEIKSMAI SU DATA IR LAIKU               #
# --------------------------------------- #

# Dirbant su datos ir laiko duomenimis, paprastai reikia atlikti tokius veiksmus:
# 
#  -- i� datos arba laiko i�skirti tam tikr� jo element�;
#  -- prie datos ar laiko prid�ti tam tikr� laiko interval�;
#  -- apskai�iuoti skirtum� tarp dviej� laiko moment�;
#  -- suskirstyti laiko momentus � tam tikrus intervalus;
#  -- generuoti laiko moment� sek�.


# Jei laiko momentas u�ra�ytas kaip POSIXlt klas�s objektas, kai kurias datos ir 
# laiko komponentes galima gauti be joki� papildom� funkcij�, kadangi tokiu b�du
# u�ra�ytas laiko momentas yra �vairi� laiko ir datos komponen�i� s�ra�as. Pvz.,
# nustatysime, kelinta savait�s, m�nesio ir met� diena yra �i diena.

t <- as.POSIXlt(Sys.time())
t

t$wday
t$mday
t$yday


# Savait�s dienos, m�nesio pavadinimo ir met� ketvir�io nustatymui bendru atveju 
# gali b�ti naudojamos �ios funkcijos: weekdays, months, quarters. Vis� funkcij� 
# argumentai vienodi:
#
#          x -- data arba laikas,
# abbreviate -- loginis, nurodo, pavadinimas turi b�ti sutrumpintas.

# Pavyzd�iui, �inomos keli� artimiausi� piln� Saul�s u�temim� datos. Nustatysime, 
# kuri� savait�s dien� vyks �itie u�temimai.

data <- c("2016-03-08", "2017-08-21", "2019-07-02", "2020-12-14", "2021-12-04")

d <- as.Date(data)
d

weekdays(d)


# Kadangi datos ir laiko kintamieji, nepriklausomai nuo j� formato, saugomi kaip 
# skai�iai, keletas standartini� funkcij� turi metodus datos ir laiko objektams:
#
#                 datoms                         laikui
#              ------------                  --------------
#               trunc.Date                    trunc.POSIXt
#               round.Date                    round.POSIXt 
#                 seq.Date                      seq.POSIXt
#                 cut.Date                      cut.POSIXt
#                hist.Date                     hist.POSIXt
#                axis.Date                     axis.POSIXt
#
# Tai rei�kia, kad su datomis ir laiku galima elgtis kaip su �prastais skai�iais: 
# juos apvalinti iki norimo tikslumo, generuoti laiko moment� sekas arba turimus 
# laiko momentus grupuoti � intervalus.


# Jeigu duot� laiko moment� reikia u�ra�yti dien�, valand�, minu�i� ar sekund�i� 
# tikslumu, naudojama funkcija trunc. Jeigu laiko moment� reikia suapvalinti iki 
# artimiausio laiko momento dien�, valand�, minu�i� arba sekund�i� tikslumu, tai 
# naudojama funkcija round. Abiej� funkcij� parametrai vienodi:
#
#          x -- laiko momentas,
#      units -- laiko apvalinimo vienetai, "secs", "mins", "hours" arba "days".


# Pavyzd�iui, duotas laiko momentas sekund�s t�kstant�j� tikslumu. U�ra�ysime j�
# dien�, valand�, minu�i� ir sekund�i� tikslumu. Vienu atveju naudosime funkcij� 
# trunc, kitu -- funkcij� round.

t <- as.POSIXct("2015-11-22 18:39:12.683", format = "%Y-%m-%d %H:%M:%OS")
t

format(t, format = "%H:%M:%OS3")

trunc(t, "day")
round(t, "day")

trunc(t, "hours")
round(t, "hours")

trunc(t, "mins")
round(t, "mins")

trunc(t, "secs")
round(t, "secs")


# Dat� ar laiko moment� sekos generavimui naudojama funkcija seq. �i standartin�
# funkcija turi atskirus metodus "Date" ir "POSIXt" klas�s objektams. Parametrai:
#
#       from -- pradin� data,
#         to -- galutin� data,
#         by -- datos kitimo �ingsnis,
# length.out -- sekos element� skai�ius,
# along.with -- sekos element� skai�ius pagal kit� vektori�.
#
# Parametrui from priskiriame "Date" klas�s reik�m�. Parametras to neprivalomas,
# jeigu per parametrus length.out arba along.with nurodome bendr� sekos element� 
# skai�i�. Parametrui by reik�m� galima priskirti net keliais skirtingais b�dais,
# kadangi sekos kitimo �ingsnis, intervalas tarp dviej� sekos element� gali b�ti:
# 
#  -- skai�ius, kuris nurodo dien� skai�i�;
#  -- difftime klas�s objektas;
#  -- �odinis laiko intervalas: "day", "week", "month", "quarter", "year";
#  -- kartotinis laiko intervalas: "7 days", "2 months", "-1 years" ir pan.

# Tarkime, kad sekos prad�ia ir pabaiga yra pirma ir paskutin� 2015 met� dienos.
# Sudarysime kelet� skirting� sek� su �vairaus dyd�io tarpais tarp gretim� dat�.

pr <- as.Date("2015-01-01")
pb <- as.Date("2015-12-31")

# Sugeneruosime sek�, kuri� sudaro visos sausio m�nesio dienos.
seq(pr, by = "day", length.out = 31)      

# Sudarome sek�, kurioje � praeit� atidedame penkias datas kas du metus.
seq(pr, by = "-2 years", length.out = 5)

# Vieneri� met� interval� suskirstome 4 savai�i� ilgio laiko intervalais. 
seq(pr, pb, by = "4 weeks")


# Jeigu funkcija seq naudojama laiko sekoms generuoti, tada parametrams from, to
# nurodome "POSIXt" laiko moment�, o parametrui by galima nurodyti �ias reik�mes:
# 
#  -- skai�i�, kuris rei�kia sekund�i� skai�i�;
#  -- difftime klas�s objekt�;
#  -- interval�: "sec", "min", "hour", "day", "week", "month", "quarter", "year";
#  -- kartotin� laiko interval�: "15 secs", "2 hour", "-1 years" ir pan.

# Pavyzd�iui, vienos valandos ilgio interval� reikia padalinti � ma�esnius laiko 
# intervalus po 90 sekund�i�. Pradinis momentas 08:00:00, galutinis -- 09:00:00.

pr <- as.POSIXlt("2015-01-01 08:00:00")
pb <- as.POSIXlt("2015-01-01 09:00:00")

seq(pr, pb, by = "90 secs")

# Tarkime, kad reikalinga seka i� 10 laiko moment� kas 45 minutes. Sugeneruosime
# toki� sek�.

seq(pr, by = "45 mins", length.out = 10)

# Jei laiko intervalai didesni, pradiniam ir galutiniam laiko momentams nurodyti 
# patogiau gali b�ti naudoti funkcij� ISOdate arba ISOdatetime. Pvz., sudarysime
# kas vien� dien� i�d�styt� 30 laiko moment� sek�, pradedant nuo 2015-11-23.

seq(ISOdate(2015, 11, 23), by = "day", length.out = 30)


# Dat� ir laiko moment� grupavimui naudojama funkcija cut; ji turi metodus "Date"
# ir "POSIXt" klas�s objektams. Pagrindiniai �ios funkcijos parametrai yra tokie:
#
#          x -- dat� arba laiko moment� vektorius,
#     breaks -- padalijimo ta�k� vektorius arba norimas interval� skai�ius,
#     labels -- NULL, interval� pavadinim� vektorius,
#      right -- FALSE, nurodo ar intervalo galas u�daras i� de�in�s.

# Grupuojant laiko intervalus parametrui breaks galima nurodyti tokias reik�mes:
# "sec", "min", "hour", "day", "DSTday", "week", "month", "quarter" arba "year".

# Pavyzd�iui, vienos paros b�gyje atid�sime 100 atsitiktini� laiko moment�, tada
# juos suskirstysime � intervalus po 6 valandas bei apskai�iuosime laiko moment�
# da�nius kiekviename tokiame intervale.

t <- ISOdatetime(2015, 11, 23, 0, 0, 0) + 24*3600*runif(100)
t

windows(9, 4)
plot(t, rep(0, 100), type = "n", xlab = "laikas", ylab = "", yaxt = "n")
rug(t)

intervalai <- cut(t, breaks = "6 hour")
intervalai

table(intervalai)


# Pavyzd�iui, vis� par� suskirstysime � du nevienodo ilgio intervalus: nuo 00:00
# iki 05:59 ir nuo 06:00 iki 23:59. Tokiu atveju parametrui breaks nurodome tris
# laiko momentus POSIX formatu.

p <- c("2015-11-23 00:00:00", "2015-11-23 06:00:00", "2015-11-23 23:59:59")
p <- strptime(p, format = "%Y-%m-%d %H:%M:%S")
p

intervalai <- cut(t, breaks = p, labels = c("naktis", "diena"))
intervalai

table(intervalai)


# Analogi�kai � intervalus suskirstomos ir datos. Pvz., dviej� m�nesi� intervale
# (pradedant nuo 2015-11-23) sugeneruosime 20 atsitiktini� dat� ir suskirstysime
# jas � dviej� savai�i� ilgio intervalus.

d <- as.Date("2015-11-23") + 2*30*runif(20)
d

intervalai <- cut(d, breaks = "2 weeks")
intervalai

table(intervalai)


# NAUDINGA ------------------------------

# Funkcija axis turi metod� POSIX klas�s objektams, tod�l laiko momentus galima
# pavaizduoti grafike. Pavyzd�iui, paros b�gyje atvaizduosime 100 laiko moment�.
# Papras�iausiu atveju tam galima naudoti funkcij� plot.

t <- ISOdatetime(2015, 12, 12, 0, 0, 0) + 24*3600*runif(100)

y <- rep(0, length(t))
plot(t, y, type = "n", ylab = "", yaxt = "n")
rug(t)

# Laiko a�� galima suformuoti toki�, kokia reikalinga. Pavyzd�iui, laiko moment�
# atid�jimui galima panaudosime funkcij� stripchart, kuri ta�kus atvaizduoja ant
# ties�s. Ta�iau ji netinkama POSIX klas�s objektui, tod�l laik� konvertuojame � 
# skai�i� vektori�. Ox a�� suformuojame i� naujo.

s <- as.numeric(t)

stripchart(s, pch = 19, axes = FALSE)
rug(s)

i <- pretty(extendrange(t), 6)
axis(1, at = i, labels = format(i, "%H:%M"))


# Tai, kad funkcija plot gali atvaizduoti POSIX klas�s objekt�, galima i�naudoti 
# laiko eilu�i� brai�ymui. Pavyzd�iui, pavaizduosime kaip per pastar�j� �imtmet� 
# keit�si Lietuvos gyventoj� skai�ius.

g <- c(2.75, 2.146, 2.711, 3.1, 3.398, 3.69, 3.46, 3.054)
d <- ISOdate(c(1897, 1923, 1959, 1970, 1979, 1989, 2001, 2011), 12, 31)

plot(d, g, type = "b", xlab = "",  ylab = "gyventoj� skai�ius", ylim = c(0, 4))


# U�DUOTIS ------------------------------ 

# 1. Apskai�iuokite, kiek i� viso penktadieni� per 2015 metus buvo 13-ta m�nesio 
#    diena.
# 2. �inoma, kad M�nulio faz� kartojasi vidutini�kai kas 29 paras 12 val. 44 min.
#    ir 2,9 sekundes (sinodinis m�nuo). Paskutin� 2015-�j� pilnatis prasid�s nuo
#    gruod�io 25 d. 13:11 val. Nustatykite vis� pilna�i� datas 2016 metais.
# 3. Nubrai�ykite grafik�, kuriame ant laiko a�ies b�t� pa�ym�ti Saul�s u�temim� 
#    momentai 2016--2021 met� laikotarpyje.


# --------------------------------------- #
# SKIRTUMAS TARP DVIEJ� LAIKO MOMENT�     #
# --------------------------------------- #

# Turint dat� ar laiko moment�, prie jo galima prid�ti tam tikr� laiko interval�. 
# Prie datos pridedamas skai�ius nurodo dien� skai�i�, prie POSIX laiko - nurodo 
# sekund�i� skai�i�. Pavyzd�iui, prie �ios dienos datos prid�sime �imt� dien� ir
# gausime nauj� dat�.

Sys.Date() + 100

# Pavyzd�iui, prie laiko momento prid�sime 120 sekund�i� ir tokiu b�du gausime 2
# minut�mis v�lesn� laiko moment�. 

ISOdatetime(2015, 11, 25, 21, 14, 00) + 120

as.POSIXlt("2015-11-25 21:14:00")     + 120


# Turint dvi datas arba du laiko momentus, galima apskai�iuoti skirtum� tarp j�.
# Pvz., nustatysime koks laiko skirtumas tarp atomin�s bombos sprogim� Japonijos
# miestuose Hiroshima ir Nagasaki.

Hiroshima <- as.POSIXlt("1945-08-06 08:15:00", tz = "Japan")
Nagasakis <- as.POSIXlt("1945-08-09 11:02:00", tz = "Japan")

Nagasakis - Hiroshima

# Pvz., apskai�iuosime, kiek laiko pra�jo nuo Hiroshima atomin�s bombos sprogimo. 

Sys.time() - Hiroshima


# Gautas laiko skirtumas yra "difftime" klas�s objektas. Skirtum� galima prid�ti 
# arba atimti i� datos arba laiko momento.

d <- Nagasakis - Hiroshima
d

Hiroshima + d
Hiroshima + d == Nagasakis


# Jeigu reikia apskai�iuoti skirtum� tarp dviej� dat� arba dviej� laiko moment�, 
# galima naudoti funkcij� difftime. Tada galima nurodyti, kokiais vienetais turi 
# b�ti i�reik�tas gautas laiko skirtumas. Funkcijos parametrai:
#
#      time1 -- pradinis laiko momentas,
#      time2 -- galutinis laiko momentas,
#         tz -- laiko zona,
#      units -- laiko vienetai: "auto", "secs", "mins", "hours", "days", "weeks".

# Jeigu parametrui units priskiriama reik�m� "auto", tai laiko skirtumas rodomas
# did�iausiais laiko vienetais. Galima pasteb�ti, kad tarp laiko vienet� m�nesi�
# n�ra. Taip yra tod�l, kad skirtingus m�nesius sudaro skirtingas dien� skai�ius.

difftime(Nagasakis, Hiroshima, units = "days")
difftime(Nagasakis, Hiroshima, units = "hours")


# Jeigu turime dat� arba laiko moment� vektori�, skirtumus tarp gretim� reik�mi�
# galime nustatyti naudojant standartin� funkcij� diff. Pavyzd�iui, taip gausime 
# dienomis i�reik�tus laiko skirtumus tarp did�iausi� LDK m��i� dat�.

#          Saul�s        Durb�s        �algirio      Or�os         "Salaspilio"
#         ------------  ------------  ------------  ------------  ------------ 
data <- c("1236-09-22", "1260-07-13", "1410-07-15", "1514-09-08", "1605-09-27")
data

t <- as.Date(data, format = "%Y-%m-%d")
t

diff(t)


# Jei duotas laiko skirtum� vektorius, tada � "difftime" format� jis paver�iamas 
# naudojant funkcij� as.difftime. Jos parametrai tokie:
#
#        tim -- laiko skirtum� vektorius, "character" arba "numeric",
#     format -- formatas, kuriuo u�ra�ytas laiko skirtumas,
#      units -- laiko matavimo vienetai, standarti�kai "auto".

# Pavyzd�iui, �inomas tam tikr� �vyki� laiko trukm�s vektorius. Sudarysime laiko
# skirtum� vektori�.

s <- c("01:54:02", "02:11:32", "02:26:45", "02:44:49", "02:57:09", "03:11:08")

d <- as.difftime(s, format = "%H:%M:%S", units = "hours")
d

# "difftime" klas�s laiko skirtumus galima apvalinti, sumuoti ir vidurkinti arba 
# skai�iuoti �vairias kitas statistines charakteristikas.

min(d)
max(d)
range(d)
quantile(d)

mean(d)
sum(d)

# Laiko skirtumai gali b�ti duoti kaip skaitini� reik�mi� vektorius. Pavyzd�iui, 
# tie patys laiko skirtumai gal�jo b�ti i�reik�ti sekund�mis.

s <- c(6842, 7892, 8805, 9889, 10629, 11468)

d <- as.difftime(s, units = "secs")
d


# Laiko skirtumas i�matuotas tam tikrais vienetais, ta�iau juos galima pakeisti.
# Tam yra keli skirtingi b�dai. Vienas i� j� - naudoti speciali� funkcij� units.
# Pavyzd�iui, laiko skirtum� tarp �it� dviej� �vyki� perskai�iuosime � valandas.

units(d) <- "hours"
d

# Kitas b�das -- laiko skirtum� galima konvertuoti � "numeric" klas�s skai�i� ir 
# nurodyti, kokiais laiko matavimo vienetais jis turi b�ti i�reik�tas.

as.numeric(d, units = "days")
as.numeric(d, units = "secs")


# NAUDINGA ------------------------------

# Funkcija sum turi metod� "difftime" klas�s objektui. Tai leid�ia sumuoti laiko 
# skirtumus. Ta�iau funkcija cumsum tokio metodo (ka�kod�l) neturi. Tad sukaupt� 
# laiko skirtum� sum� tenka skai�iuoti naudojant standartin� funkcij� sum. Pvz.,
# u�ra�ysime toki� funkcij� naudojant sapply konstrukcij�.

sapply(seq_along(d), function(n) sum(d[1:n]))


# NAUDINGA ------------------------------

# Kartais reikia �inoti, kiek laiko u�trunka tam tikri skai�iavimai. Pavyzd�iui,
# gali dominti, kiek laiko u�trunka viena ciklo iteracija arba reikia nustatyti,
# kuri i� dviej� alternatyvi� komand� �vykdoma grei�iau.

# Norint su�inoti skai�iavim� trukm�, reikia u�fiksuoti laik�, kada prasideda ir
# kada baigiasi skai�iavimai. Tam galima naudoti standartin� funkcij� Sys.time(). 
# Pavyzd�iui, apskai�iuosime, kiek laiko u�trunka 100 vektori� su normaliosiomis
# atsitiktin�mis reik�m�mis generavimas ir vidurkinimas.

start <- Sys.time()

  for (i in 1:100) {
    x <- rnorm(1000)
    v <- mean(x)   
  }

stop <- Sys.time()

difftime(stop, start, units = "secs")


# Tam pa�iam tikslui galima panaudoti ir funkcij� proc.time(), kuri parodo, kiek 
# laiko veikia R.

start <- proc.time()
 
  for (i in 1:100) {
    x <- rnorm(1000)
    v <- mean(x)   
  }

stop <- proc.time()

stop - start


# Jeigu i�rai�ka u�ra�oma kompakti�kai, tada jos vykdymo trukm� galima nustatyti
# �d�jus j� � funkcij� system.time(). Pvz., nustatysime, kuri i� dviej� funkcij� 
# grei�iau apskai�iuoja matricos stulpeli� vidurkius.

n <- 1000
m <- matrix(rnorm(n*n), ncol = n, nrow = n)

system.time(apply(m, 2, mean))
system.time(colMeans(m))


# U�DUOTIS ------------------------------ 

# 1. Nustatykite laiko tarpus tarp gretim� piln� Saul�s u�temim� 2016--2021 met� 
#    laikotarpyje.
# 2. Garsioji Halio kometa paskutin� kart� buvo matoma 1986 metais, o perihelyje
#    buvo t� pa�i� met� vasario 9 d. Jos periodas kintantis, vidutini�kai sudaro 
#    75,3 metus. Nustatykite, sekan�io perihelio dat�. Kokia gauta paklaida, jei
#    tiksliai �inoma, kad sekantis perihelis bus 2061 liepos 28 dien�?
