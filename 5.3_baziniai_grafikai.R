
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindin�s auk�to lygio grafin�s funkcijos.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2014-03-29 | 2014-04-24
#


# TURINYS -------------------------------

#
#   1. Auk�to lygio grafin�s funkcijos:
#      * funkcija curve
#      * funkcija barplot
#      * funkcija boxplot
#      * funkcija hist
#


# PASTABOS ------------------------------

#
# Para�yti apie curve parametr� xname.
# Sugalvoti u�davini� funkcijai boxplot.
# Para�yti apie barplot parametr� axis.lty.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# AUK�TO IR �EMO LYGIO GRAFIN�S FUNKCIJOS #
# --------------------------------------- #

# Visas R grafines funkcijas s�lyginai galima padalinti � dvi dideles grupes:
#
#   1) auk�to lygio grafin�s funkcijos,
#   2) �emo lygio grafin�s funkcijos.
#
# Auk�to lygio grafin�s funkcijos yra skirtos baziniam tam tikro tipo grafiko ar
# diagramos brai�ymui. Toks grafikas turi suformuot� koordina�i� sistem�, a�is,
# antra�tes ir visus kitus tokio tipo grafikui reikalingus elementus. �emo lygio
# grafin�s funkcijos yra skirtos jau suformuot� grafik� papildymu tam tikrais jo
# elementais: papildomais ta�kais, linijomis, kitokiomis nei standartin�s a�imis,
# tekstu ir kitais elementais.

# Auk�to lygio grafin�s funkcijos visada suformuoja ir nubrai�o nauj� grafik�, o
# �emo lygio funkcijos ta�kus, linijas arba kitus grafinius elementus u�deda ant 
# jau sudaryto grafiko.

# Didel� dal� da�niausiai naudojam� grafik� galima nubrai�yti naudojant funkcij�
# plot, ta�iau kai kuriuos grafikus ir diagramas patogiau brai�yti naudojant tam
# skirtas specializuotas funkcijas. 


# --------------------------------------- #
# FUNKCIJA CURVE                          #
# --------------------------------------- #

# Funkcija curve naudojama vieno kintamojo funkcijos y = f(x) grafiko brai�ymui. 
# Pagrindiniai jos parametrai:
#
#       expr -- funkcijos f(x) pavadinimas,
#       from -- intervalo [a, b] reik�m� a,
#         to -- intervalo [a, b] reik�m� b,
#          n -- ta�k� skai�ius intervale [a, b],
#        add -- FALSE, nurodo ar grafik� u�d�ti ant jau sudaryto grafiko.

# Sudarant funkcijos f(x) intervale [a, b] grafik�, �is intervalas padalinamas � 
# 100 lygi� dali�, kurias viena nuo kitos atskiria n = 101 ta�k�. Tuose ta�kuose
# skai�iuojamos funkcijos y = f(x) reik�m�s ir gaunamos ta�k� (x, y) koordinat�s.

# Papras�iausiu atveju funkcijai curve galima nurodyti bet kokios standartin�s R 
# funkcijos pavadinim� ir intervalo, kuriame nubrai�omas �ios funkcijos grafikas, 
# ribas. Pvz., nubrai�ysime funkcijos y = sin(x) grafik� intervale [-pi, pi].

curve(sin, from = -pi, to = pi)

# Kaip visada, jei parametrai u�ra�omi nustatyta tvarka, j� pavadinim� galima ir
# nera�yti. Taip gaunama paprastesn�s ir lengviau perskaitoma i�rai�ka.

curve(sin, -pi, pi)

# Standartines R funkcijas galima panaudoti kit� funkcij� sudarymui. Pavyzd�iui,
# R turi funkcij� y = sin(x), ta�iau neturi funkcijos y = sin(2x). Jos i�rai�k� 
# kaip argument� galima �ra�yti tiesiai � funkcij� plot.

curve(sin(2*x), -pi, pi)

# Sud�ting� funkcij� i�rai�k� geriau u�ra�yti kaip R funkcija ir duoti jai vard�.
# Pvz., nubrai�ysime racionalios trupmenos y = x/(x^2 + x + 1) intervale [-5, 5] 
# grafik�. Pirmiausia jos i�rai�k� u�ra�ysime kaip R funkcij�.

fun.rt <- function(x) {
  y <- x/(x^2 + x + 1)
  return(y)
}

curve(fun.rt, -5, 5)


# Funkcija curve yra auk�to lygio grafin� funkcija, tod�l kiekvien� kart� brai�o 
# nauj� grafik�, ta�iau jos parametrui add priskyrus reik�m� TRUE, nauj� grafik� 
# galima u�d�ti ant jau nubrai�yto grafiko vir�aus. Pvz., nubrai�ysime funkcijos 
# y = sin(kx)/k intervale [-pi, pi] grafikus, kai parametro k reik�m� kinta nuo 
# 1 iki 4. I� prad�i� u�ra�ysime tokios funkcijos i�rai�k�.

fun.si <- function(x, k) {
  y <- sin(k*x)/k
  return(y)
}

# �i funkcija yra dviej� kintam�j� funkcija. Tam, kad funkcija curve j� parodyt�
# teisingai, vien� parametr� fiksuosime -- priskirsime jam reik�m�. Tokiu b�du
# funkcija tampa vieno kintamojo funkcija, kurios grafik� curve gali nubrai�yti.

curve(fun.si(x, k = 1), -pi, pi)

# Grafikus su kitomis parametro k reik�m�mis u�d�sime ant jau nubrai�yto grafiko
# vir�aus.

curve(fun.si(x, k = 2), -pi, pi, add = TRUE)
curve(fun.si(x, k = 3), -pi, pi, add = TRUE)
curve(fun.si(x, k = 4), -pi, pi, add = TRUE)


# NAUDINGA ------------------------------

# Pasikartojan�i� i�rai�k� galima �d�ti � cikl� ir tokiu b�du keisti parametro k 
# reik�m�. Funkcinio programavimo apologetai gali naudoti konstrukcij� su sapply 
# ir visk� u�ra�yti viena eilute. Pastaba, parametro add reik�m� nustatome pagal
# login� s�lyg� -- tikrinama ar parametro k reik�m� didesn� u� vienet�. Jei taip, 
# tai add �gyja reik�m� TRUE, prie�ingu atveju priskiriama reik�m� FALSE.

sapply(1:16, function(k) curve(fun.si(x, k), -pi, pi, add = k > 1))


# U�DUOTIS ------------------------------ 

# 1. Naudojant funkcij� curve nubrai�ykite funkcijos y = ln(x) grafik� intervale 
#    (0, 1]. Pakeiskite komand� taip, kad grafike a�ies Oy ribos b�t� [-5, 5].
# 2. Nubrai�ykite standartinio normaliojo skirstinio tankio funkcijos grafik�
#    intervale [-4, 4]. 
# 3. Nubrai�ykite atsiktinio dyd�io, pasiskirs�iusio tolygiai intervale [2, 5],
#    tankio funkcijos grafik�. A�ies Ox ribos tegul bus [0, 7].
# 4. Ant vieno grafiko nubrai�ykite funkcij� y = sin(x) ir y = cos(x) grafikus
#    intervale [-pi, pi]. Tegul vienos funkcijos grafikas bus raudonos spalvos.
# 5. Ant vieno grafiko nubrai�ykite tris normaliojo skirstinio tankio funkcijos 
#    variantus: su vidurkiu 0, su vidurkiu 1 ir su vidurkiu 3. Visais atvejais
#    standartinis nuokrypis tegul b�na vienodas ir lygus 1.


# --------------------------------------- #
# FUNKCIJA BARPLOT                        #
# --------------------------------------- #

# Funkcija barplot naudojama stulpelini� diagram� brai�ymui. Paprastai naudojami
# �ie parametrai:
#
#     height -- stulpeli� auk��i� vektorius arba matrica,
#      width -- stulpeli� plo�i� vektorius,
#      space -- tarpo tarp stulpeli� reik�m�,
#      horiz -- FALSE, nurodo ar stulpeliai bus brai�omi horizontaliai,
#     beside -- FALSE, nurodo ar tos pa�ios grup�s stulpelius brai�yti greta,
#        add -- FALSE, nurodo ar diagram� u�d�ti ant jau sudaryto grafiko.

# Pa�iu papras�iausiu atveju funkcijai barplot galima nurodyti sveik�j� skai�i�
# vektori�. Kiekvienas vektoriaus elementas atitinka vien� diagramos stulpel�, o 
# jo auk�tis lygus atitinkamo vektoriaus elemento reik�mei.

h <- c(3, 2, 5, 3, 1)

barplot(height = h)

# Jei parametrai sura�omi nustatyta tvarka, tai j� pavadinim� galima ir nera�yti. 

barplot(h)

# Pa�iu bendriausiu atveju, vektoriaus, pagal kur� brai�oma diagrama, elementai 
# gali b�ti bet kokie real�s skai�iai. Neigiamus vektoriaus elementus diagramoje 
# atitinka "neigiamo" auk��io stulpeliai.

h <- c(-2, 2.5, 5, 3, -0.5)

barplot(h)

# Stulpeli� plotis nustatomas kei�iant parametro width reik�m�. Stulpeliai gali
# b�ti ir nevienodo plo�io. Tokiu atveju parametrui width perduodamas stulpeli� 
# plo�i� reik�mi� vektorius.

barplot(h, width = 1:5)

# Stulpeliai vienas nuo kito atskirti tarpu, kurio plotis proporcingas stulpelio
# plo�iui. Pagal nutyl�jim� proporcingumo koef. lygus 0.2 ir gali b�ti pakeistas 
# nustatant kit� parametro space reik�m�. Jeigu parametras space = 1, tai tarpai 
# tarp stulpeli� bus tokio paties plo�io kaip ir stulpeliai.

barplot(h, space = 0)
barplot(h, space = 1)

# Tam, kad stulpeliai diagramoje b�t� brai�omi horizontaliai, naudojamas loginis 
# parametras horiz. Pagal nutyl�jim� jo reik�m� yra FALSE.

barplot(h, horiz = TRUE)

# Suprantama, galima keisti standartinius grafinius parametrus. Pvz., papildomai 
# nustatysime a�ies Oy ribas, stulpeli� spalv� ir pagrindin� diagramos antra�t�.

barplot(h, ylim = c(-5, 8), col = "red", main = "Stulpelin� diagrama")


# Labai da�nai funkcija barplot naudojama �vairioms da�ni� lentel�ms atvaizduoti.
# Kaip pavyzd� panaudosime laivo "Titanic" �vairi� kategorij� keleivi� skai�iaus
# duomen� lentel� Titanic.

Titanic

dimnames(Titanic)

# Titanic yra keturi� kintam�j� kry�min� da�ni� lentel�. Sumuodami toki� lentel� 
# pagal vien� kur� nors kintam�j�, gauname to kintamojo reik�mi� da�ni� lentel�. 
# Pavyzd�iui, sudarysim skirtinga klase keliavusi� keleivi� skai�iaus lentel� ir
# nubrai�ysime j� atitinkan�i� stulpelin� diagram�.

d <- margin.table(Titanic, 1)
d

barplot(d)

# Analogi�kai i� pradin�s lentel�s galima gauti dviej� kintam�j� kry�min� da�ni� 
# lentel�. Pavyzd�iui, sudarysime keleivio klas�s ir lyties da�ni� lentel� ir j�
# atvaizduosime diagramos pavidalu.

d <- margin.table(Titanic, c(2, 1))
d

barplot(d)

# Matome, kad da�niai atskirai paimtoje kategorijoje vaizduojami vienu stulpeliu.
# Naudojant parametr� beside, juos galima i�skaidyti � atskirus stulpelius.

barplot(d, beside = TRUE)

# Kei�iant atstum� tarp stulpeli�, parametrui space reikia perduoti vektori� su
# dviem reik�m�mis: antroji nurodo tarp� tarp skirting� grupi�, o pirmoji nurodo
# tarp� tarp stulpeli� grup�s viduje.

barplot(d, beside = TRUE, space = c(0.1, 0.8))


# NAUDINGA ------------------------------

# Funkcija barplot turi nema�ai kit� parametr�, kuriais galima keisti diagramos
# i�vaizd�: stulpeli� ir atskir� j� dali� spalv�, leisti arba u�drausti brai�yti 
# a�is ir ra�yti j� pavadinimus. Keletas i� j�:
#
#        col -- stulpeli� spalv� numeri� ar pavadinim� vektorius,
#     border -- stulpeli� r�melio spalva,
#  names.arg -- stulpeli� pavadinim� vektorius,
#  axisnames -- TRUE, nurodo ar rodyti a�i� pavadinimus,
#       axes -- TRUE, nurodo ar rodyti a�is,
#       plot -- TRUE, nurodo ar brai�yti diagram�.

# Naudojant parametr� col, galima keisti stulpeli� spalv�. Kadangi kiekvienoje
# grup�je yra po du stulpelius, parametrui priskiriame vektori� su dviem spalv�
# pavadinimais.

barplot(d, beside = TRUE, col = c("lightblue", "cornsilk"))

# Vietoje konkre�i� spalv� galima nurodyti koki� nors spalv� palet�. Pavyzd�iui,
# parametrui col nurodysime trij� pilkos spalvos atspalvi� palet�.

barplot(d, col = gray.colors(3))

# Naudojant parametr� border, galima pakeisti stulpelio r�melio spalv�.

barplot(d, border = 3)

# Parametrui border priskyrus reik�m� NA, r�melis apie stulpel� nebrai�omas.

barplot(d, border = NA)


# Jei da�ni� lentel� turi vardus, funkcija barplot juos naudoja grup�ms pa�ym�ti. 
# Naudojant parametr� names.arg �iuos grupi� u�ra�us galima pakeisti. Pavyzd�iui,
# pakeisime da�ni� lentel�s d keleivi� klas�s pavadinimus.

barplot(d, names.arg = c("Pirma", "Antra", "Tre�ia", "�gula"))

# U�ra�us ant a�i� galima u�drausti naudojant parametr� axisnames.

barplot(d, axisnames = FALSE)

# Naudojant parametr� axes, galima u�drausti a�i� rodym�.

barplot(d, axes = FALSE)

# Naudojant parametr� plot, galima u�drausti brai�yti ir pa�i� diagram�. Tokiu
# atveju funkcijos rezultatas yra matrica su stulpeli� auk��iais.

barplot(d, plot = FALSE)


# Funkcija barplot ne tik nubrai�o stulpelin� diagram�, bet jos rezultat� galima
# priskirti kintamajam. Taip gauname diagramos stulpeli� vidurio ta�k� vektori�. 
# Jei sudaroma grupuota stulpelin� diagrama, tai rezultatas yra gaunama matrica, 
# kurios stulpeliuose yra diagramos vienos grup�s stulpeli� vidurio ta�kai. 

barstat <- barplot(d)
barstat


# U�DUOTIS ------------------------------ 

# 1. Sukurkite vektori� n = (1, 3, 2, 5, 4). Nubrai�ykite toki� �io vektoriaus n 
#    stulpelin� diagram�, kurioje vis� stulpeli� spalva b�t� skirtinga.
# 2. Nubrai�ykite vektoriaus n stulpelin� diagram� ir kiekvienam jos stulpeliui 
#    suteikite vard�.
# 3. Nubrai�ykite vektoriaus n stulpelin� diagram�, kurioje kiekvieno stulpelio 
#    plotas b�t� lygus vienetui.
# 4. Naudodami duomen� lentel� HairEyeColor, sudarykite kry�min� aki� ir plauk� 
#    spalvos da�ni� lentel�. Parametrui legend priskirkite reik�m� TRUE ir taip
#    ant diagramos u�d�kite legend�. Kokia aki� spalva re�iausia tarp blondin�?


# --------------------------------------- #
# FUNKCIJA BOXPLOT                        #
# --------------------------------------- #

# Vieno arba keli� kintam�j� sta�iakampei diagramai brai�yti naudojama funkcija 
# boxplot. Pagrindiniai jos parametrai:
#
#          x -- kiekybinio kintamojo reik�mi� vektorius,
#       data -- duomen� lentel�s pavadinimas,
#     subset -- login� s�lyga, kuri i�skiria dal� duomen� lentel�s stebini�,
#         at -- vektorius su reik�m�mis, kuriose atidedama sta�iakamp� diagrama,
# horizontal -- FALSE, nurodo ar diagrama bus brai�oma horizontaliai,
#        add -- FALSE, nurodo ar diagram� u�d�ti ant jau sudaryto grafiko.

# Pavyzd�iui, nubrai�ysime kiekybinio kintamojo s sta�iakamp� diagram�.

s <- c(0.6, 3.4, 6.1, 0.7, 5.2, 1.4, 2.3, 3.4, 2.5, 9.4, 2.7, 4.1, 2.9, 0.1, 7.5)
k <- c("T", "N", "N", "T", "T", "T", "N", "T", "T", "N", "T", "N", "T", "T", "N")

boxplot(s)

# Diagramoje matome, kokiose ribose kinta kintamojo reik�m�s, kam lygi kintamojo
# mediana, atskirai pa�ymimos labai ma�os arba labai didel�s kintamojo reik�m�s.
# Jei kiekybinio kintamojo s reik�m�s yra i� skirting� grupi�, galima nubrai�yti
# sta�iakampes diagramas kiekvienoje grup�je atskirai.

boxplot(s ~ k)

# Jei vienas ar keli sta�iakampei diagramai nubrai�yti reikalingi kintamieji yra 
# data.frame tipo duomen� lentel�je, funkcijai boxplot galima nurodyti jos vard�. 
# Pavyzd�iui, nubrai�ysime lentel�s airquality temperat�ros kiekvienam steb�jim�
# m�nesiui diagramas.

boxplot(Temp ~ Month, data = airquality)

# Jei diagrama brai�oma ne i� vis� duomen� lentel�je esan�i� duomen�, parametrui
# subset galima nurodyti login� s�lyg� ir taip i�rinkti tik tam tikrus stebinius.
# Pavyzd�iui, naudojant t� pa�i� duomen� lentel�, nubrai�ysime temperat�ros iki
# rugpj��io m�nesio sta�iakampes diagramas.

boxplot(Temp ~ Month, data = airquality, subset = Month < 8)


# NAUDINGA ------------------------------

# Yra keletas kit� parametr�, kuriais galima keisti boxplot diagramos i�vaizd�:
# 
#        col -- diagramos d��ut�s spalva,
#      names -- kintamojo x grupi� vard� vektorius,
#    outline -- TRUE, nurodo ar diagramoje bus pa�ymimos i�skirtys,
#   varwidth -- FALSE, nurodo ar stulpelio plotis proporcingas imties t�riui,
#      width -- vektorius su santykini� diagramos stulpeli� plo�i� reik�m�mis.

# Pavyzd�iui, sudarysime grupuoto kintamojo s diagram� ir ant to paties grafiko
# palyginimui u�d�sime bendr� kintamojo s diagram�.

# I� prad�i� nubrai�ysime grupuot� kintamojo s diagram�. Kad v�liau ant jos b�t�
# galima u�d�ti bendr� diagram�, i�pl�sime a�ies Ox ribas ir nurodysime, kad tos
# d��ut�s b�t� atidedamos ties x = 3 ir x = 4. Tada ant jau sudarytos diagramos 
# u�d�sime bendr� kintamojo s sta�iakamp� diagram�. 

boxplot(s ~ k, xlim = c(0, 5), at = 3:4, names = c("Taip", "Ne"))
boxplot(s, add = TRUE, width = 1, col = "red")


# Nubrai�ysime dar vien� toki� kombinuot� diagram�. Ant kintam�j� Temp ir Month 
# sklaidos diagramos u�d�sime grupuot� sta�iakamp� diagram�.

plot(Temp ~ Month, data = airquality, pch = 20, xlim = c(4, 10), col = 3)
boxplot(Temp ~ Month, data = airquality, add = TRUE, at = 5:9)


# Tam, kad sta�iakamp�s d��ut�s ant diagramos b�t� nubrai�ytos tam tikra tvarka,
# reikia, kad tokia pa�ia tvarka b�t� i�rikiuotos kategorinio kintamojo reik�m�s. 
# Tam naudojama funkcija reorder. Pvz., nubrai�ysime vidurkio did�jimo tvarka
# i�d�stytas atskir� m�nesi� temperat�ros sta�iakampes diagramas.

M <- with(airquality, reorder(Month, Temp, mean))
boxplot(Temp ~ M, data = airquality)


# Funkcija boxplot ne tik nubrai�o sta�iakamp� diagram�, bet ir gali sukurti jai 
# nubrai�yti reikaling� duomen� rinkin� - boxplot objekt�. Jame sura�ytos grup�s,
# ir j� vardai, reik�mi� ir i�siskirian�i� element� kiekvienoje grup�je skai�ius, 
# d��utei nubrai�yti reikalingos statistikos: mediana, kvartiliai ir "�s�" galai.

boxstat <- boxplot(Temp ~ Month, data = airquality)
boxstat

names(boxstat)

boxstat$stats     # vis� grupi� d��u�i� statistikos: galai, kvartiliai, mediana
boxstat$n         # reik�mi� grup�se skai�ius
boxstat$conf      # medianos pasikliautinasis intervalas
boxstat$out       # i�siskirian�i� stebini� reik�m�s
boxstat$group     # i�siskirian�i� stebini� grup�s numeriai
boxstat$names     # grupi� vardai


# U�DUOTIS ------------------------------ 

# 1. Nubrai�ykite duomen� lentel�s iris kintamojo Sepal.Length boxplot diagram�
#    grup�se pagal kintamojo Species reik�mes. Kurioje grup�je mediana didesn�?
# 2. U�ra�ykite komand�, kuri, naudojant diagramos objekt� boxstat, automati�kai
#    nustatyt�, kurioje duomen� grup�je yra i�siskirian�i� reik�mi�.


# --------------------------------------- #
# FUNKCIJA HIST                           #
# --------------------------------------- #

# Histogramos sudarymui ir jos brai�ymui naudojama standartin� R funkcija hist. 
# Pagrindiniai jos parametrai:
# 
#          x -- kiekybinio kintamojo reik�mi� vektorius,
#     breaks -- kintamojo x padalinimo � intervalus ta�k� vektorius,
#       freq -- TRUE, nurodo ar bus brai�oma da�ni� histograma,
#      right -- TRUE, nurodo, kad histogramos intervalai yra (a, b] pavidalo,
#     labels -- FALSE, da�niai arba u�ra�� ant histogramos stulpeli� vektorius,
#       plot -- TRUE, nurodo ar brai�yti histogram�,
#        add -- FALSE, nurodo ar histogram� u�d�ti ant jau sudaryto grafiko.


# Kaip pavyzd� panaudosime Nilo vandens lygio steb�jimo duomenis. Patogumo d�lei 
# sukursime atskir� kintam�j� x ir nubrai�ysime jo histogram�.

x <- as.numeric(Nile)
x
  
hist(x)

# Be papildom� nustatym� histogramos stulpeli� skai�ius parenkamas automati�kai. 
# Naudojant parametr� breaks, kintamojo reik�mi� srit� galima padalinti � kelis 
# intervalus, pagal kuriuos ir sudaroma histograma. Pats papras�iausias b�das --
# nurodyti interval� padalijimo ta�k� vektori�. Reikia priminti, kad histogramos
# stulpeli� bus vienu ma�iau nei ta�k� skai�ius.

hist(x, breaks = c(400, 600, 800, 1000, 1200, 1400))

# Tok� pat padalinimo ta�k� vektori� galima sudaryti naudojant aritmetin�s sekos 
# generavimo funkcij� seq. Tarkime, kad intervalo plotis bus lygus 200.

hist(x, breaks = seq(400, 1400, by = 200))

# Interval� sudarymo komand� galima visi�kai automatizuoti. Paprastai histograma 
# brai�oma intervale nuo minimalios iki maksimalios kintamojo reik�m�s. Tada jas
# galima apskai�iuoti naudojant funkcijas min ir max. Interval� skai�i� nurodome
# per funkcijos seq parametr� length.out. PASTABA! Intervalai yra (a, b] formos,
# ir formaliai minimali� reik�m� turintis imties elementas � pirm�j� interval�
# tur�t� nepatekti, ta�iau parametras include.lowest nurodo, kad reikia �traukti.

hist(x, breaks = seq(min(x), max(x), length = 6))

# Kintamojo reik�mes padalinti � intervalus galima ir naudojant funkcij� pretty.
# �i funkcija padalinimo ta�kus parenka taip, kad visi intervalai b�t� "gra��s".

hist(x, breaks = pretty(x))


# Ant histogramos stulpeli� galima u�ra�yti atitinkam� interval� da�nius. Tam
# naudojama funkcija labels. Vietoj login�s parametro reik�m�s galima nurodyti 
# reik�mi�, kurias reikia u�ra�yti ant stulpeli�, vektori�.

hist(x, breaks = pretty(x), labels = TRUE)


# NAUDINGA ------------------------------

# Kaip ir kitos grafin�s funkcijos, funkcija hist priima standartinius grafinius
# parametrus, kuriais galima keisti histogramos i�vaizd�.

# Kartais ant histogramos reikia u�d�ti kokio nors skirstinio tankio funkcijos
# grafik�. Nubrai�ysime temperat�ros histogram� ir ant jos u�d�sime normaliojo
# skirstinio tankio funkcijos grafik�, o kadangi skirstinio parametrai ne�inomi,
# juos �vertinsime i� imties.

t <- as.numeric(nhtemp)

vid <- mean(t)
std <- sd(t)

# Pirma nubrai�ome histogram�. Kadangi ant jos vir�aus brai�ysime tankio f-jos
# grafik�, �ia reikalinga ne da�ni�, o santykini� da�ni� histograma. J� gauname
# parametrui freq priskirdami reik�m� FALSE.

hist(t, freq = FALSE, xlim = c(46, 56), main = "Temperat�ros pasiskirstymas")
curve(dnorm(x, mean = vid, sd = std), col = "red", add = TRUE)


# Funkcija hist ne tik nubrai�o histogram�, bet ir gali sukurti �iai histogramai 
# nubrai�yti reikaling� duomen� rinkin� - histogramos objekt�. Jei pats grafikas 
# nereikalingas, jo brai�ym� galima u�drausti naudojant parametr� plot.

histat <- hist(x, breaks = pretty(x), plot = FALSE)
histat

# I� jo galima su�inoti, kokie yra kintamojo da�niai intervaluose, �i� interval�
# padalinimo ta�kus, interval� vidurio ta�kus ir pan.

names(histat)

histat$breaks  # interval� padalinimo ta�kai
histat$mids    # interval� vidurio ta�kai
histat$counts  # da�niai intervaluose

# Funkcija plot turi metod� histogramos objektui atvaizduoti.

plot(histat)


# U�DUOTIS ------------------------------ 

# 1. Nubrai�ykite duomen� lentel�s airquality bir�elio m�n. temperat�ros da�ni� 
#    histogram�. Nurodykite a�i� pavadinimus ir visos histogramos pavadinim�.
# 2. Nubrai�ykite toki� kintamojo y histogram�, kad ant stulpeli� b�t� u�ra�yti
#    ne da�niai, bet did�iosios ab�c�l�s raid�s. Tokie vardai stulpeliams turi 
#    b�ti priskiriami automati�kai ir nepriklausomai nuo stulpeli� skai�iaus.
# 3. U�ra�ykite komand�, kuri naudodama histogramos objekt�, surast� auk��iausi� 
#    histogramos stulpel� atitinkan�io intervalo vidur�.
# 4. Sugalvokite b�d�, kaip nubrai�yti Nilo vandens lygio histogram� panaudojant 
#    da�nius intervaluose i� anks�iau jau sukurto histogramos objekto -- histo.
# 5. Sugalvokite b�d�, kaip nubrai�yti bet kokio kintamojo x histogram� visi�kai 
#    nenaudojant funkcijos hist.
