
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Simboli� sek� apjungimas ir j� atvaizdavimas.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2016-03-29 | 2016-04-09 | 2016-04-12 | 2016-04-19
#


# TURINYS -------------------------------

#
#   1. Simboli� sek� apjungimas:
#      * funkcija paste
#      * funkcija paste0
#
#   2. Objekt� atvaizdavimas ekrane:
#      * funkcija print
#
#   3. Pagalbin�s simboli� sek� atvaizdavimo funkcijos:
#      * funkcija noquote
#      * funkcija strtrim
#      * funkcija abbreviate
#      * funkcija toString
#      * funkcija encodeString
#


# PASTABOS ------------------------------

#
# Para�yti apie funkcij� format ir format.info.
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
# SEK� APJUNGIMAS                         #
# --------------------------------------- #

# Atliekant �vairius skai�iavimus arba pateikiant t� skai�iavim� rezultatus, yra 
# kelios tipin�s situacijos, kada simboli� sek� reikia sujungti su kita simboli�
# seka. Simboliai �ia gali b�ti tiek skai�iai, tiek raid�s arba skyrybos �enklai. 
# R kalboje simboli� sek� apjungimui naudojama funkcija paste. Jos parametrai:
#
#        ... -- apjungiami vektoriai,
#        sep -- simboli� seka, kuri atskiria atskir� vektori� elementus.
#   collapse -- NULL arba simboli� seka, kuri atskiria vektorius.

# Parametras ... nurodo, kad apjungiam� sek� ar vektori� skai�ius n�ra i� anksto
# nustatytas, tod�l vektori� gali b�ti du, trys ir daugiau. Apjungimas gali b�ti 
# atliekamas keliais b�dais. Papras�iausiu atveju vieno vektoriaus elementai bus
# apjungiami su atitinkamais kito vektoriaus elementais. 

# Pavyzd�iui, apjungsime did�i�sias ir ma��sias lotyni�kos ab�c�l�s raides. �iuo
# atveju gaunamos tarpu atskirtos atitinkam� raid�i� poros. Tarpu, nes tokia yra
# parametro sep numatyta reik�m�.

paste(LETTERS, letters)

# Norint, kad vektori� elementai b�t� sujungti be tarpo, parametrui sep nurodome
# tu��i� sek� "".

paste(LETTERS, letters, sep = "")

# Tokiu atveju kartais patogiau naudoti f-j� paste0(...) = paste(..., sep = "").

paste(LETTERS, letters)


# Apjungiant raides, kiekvienas vektorius tur�jo daug element� -- tiek, kiek yra
# raid�i�. Lygiai taip pat galima apjungti dvi sekas ir gauti vien� bendr� sek�.
# Pavyzd�iui, suformuluosime tekst�, kuris pasako �ios dienos dat�.

paste("�ios dienos data:", Sys.Date())


# Funkcija paste apjungiamus skaitinius arba kitokio tipo vektorius automati�kai 
# paver�ia � character tipo reik�mi� vektorius. Pavyzd�iui, taip galima sudaryti
# datas i� atskir� met�, m�nesi� ir dien� vektori�.

metai <- c(1236, 1260, 1410, 1514, 1605)
m�nuo <- c(9, 7, 7, 9, 9)
diena <- c(22, 13, 15, 8, 27)

datos <- paste(metai, m�nuo, diena, sep = "-")
datos


# Jeigu apjungiami nevienod� element� skai�i� turintys vektoriai, tai trumpesnis
# vektorius cikli�kai prat�siamas. Pavyzd�iui, taip paprastai galima sugeneruoti
# �vairias numeruotas sekas:

paste("A", 0:9, sep = "")

paste(1, 1:10, sep = "/")

paste(seq(5, 25, 5), "%")


# Jeigu vektori� elementus reikia apjungti � vien� bendr� tekst�, tai parametrui
# collapse priskiriama simboli� seka, kuri tekste atskiria vektoriaus elementus.
# Standartin� parametro reik�m� NULL nurodo, kad elementai � vien� bendr� tekst�
# nebus apjungiami. Jeigu parametrui priskiriame tu��i� sek� "", tada apjungimas 
# bus be tarp�. Pavyzd�iui, taip galima apjungti ab�c�l�s raides ar skai�i� sek�.

paste(letters, collapse = "")

paste(0:9, collapse = "")

paste(1, 1:10, sep = "/", collapse = " + ")


# NAUDINGA ------------------------------

# Gana da�nai skai�iavim� rezultatus reikia �ra�yti � atskirus failus. Paprastai
# tokie failai sudaromi automati�kai, o j� vardai da�niausiai skiriasi tik eil�s 
# numeriu. Pavyzd�iui, sudarysime penki� tekstini� fail� pavadinim� vektori�.

base <- "failas_"  # bendra visiems failams pavadinimo dalis
type <- ".txt"     # failo i�pl�timas
numb <- 1:5        # failo numeris

failai <- paste(base, numb, type, sep = "")
failai


# NAUDINGA ------------------------------

# Funkcij� paste galima panaudoti kod� generavimui. Pavyzd�iui, u�ra�ysime f-j�,
# kuri sudaro kod� i� atsitiktinai su vienodomis tikimyb�mis pasirinkt� did�i�j� 
# lotyni�kos ab�c�l�s raid�i�. Tarkime, kad kodas bus i� k raid�i�. J� i�rinkim�
# atliksime naudojant funkcij� sample, o apjungim� � kod� --- su funkcija paste.

kodas <- function(k = 5) paste(sample(LETTERS, k, TRUE), collapse = "")

# Tokios f-jos rezultatas bus vienas kodas. Tarkime, mums reikalingas tri�enklis 
# kodas.

kodas(3)

# �sta�ius kodo generavimo funkcij� � funkcij� replicate, galime sugeneruoti bet
# kok� kiek� nustatyto ilgio kod�. Pavyzd�iui, sugeneruosime 10 tri�enkli� kod�.

kodai <- replicate(10, kodas(3))
kodai

# Paprastai reikalaujama, kad visi kodai (pvz., duomen� lentel�s eilu�i� vardai)
# b�t� unikal�s. Tai nesunku patikrinti.

anyDuplicated(kodai)


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite toki� komand�, kuri bet kokios duomen� lentel�s kintam�j� vardus 
#    automati�kai pakeist� � "X_1", "X_2" ir t. t.
# 2. U�ra�ykite komand�, kuri �od� arba bet koki� kit� simboli� sek� u�ra�yt� i� 
#    kito galo.
# 3. Sudarykite program�, kuri generuot� atsitiktin� skai�i� �od�i�, sudaryt� i�
#    atsitiktinio skai�iaus ma��j� lotyni�kos ab�c�l�s raid�i�.


# --------------------------------------- #
# OBJEKT� ATVAIZDAVIMAS EKRANE            #
# --------------------------------------- #

# Tai, kaip ekrane bus vaizduojamas vektorius, matrica, duomen� lentel� ar kitas 
# R objektas, priklauso nuo to objekto tipo (klas�s). Pavyzd�iui, character tipo
# reik�m�s vaizduojamos kabut�se, o factor tipo reik�m�s - be kabu�i�. Paprastai
# objektai vaizduojami taip, kaip numatyta, be papildomo apipavidalinimo, ta�iau 
# standartines R objekt� atvaizdavimo taisykles galima pakeisti.

# �vairi� R objekt� i�vedimui � ekran� naudojama funkcija print. Jos parametrai:
#
#          x -- vektorius ar kitokio tipo R objektas,
#     digits -- ma�iausias realiojo skai�iaus reik�ming� skaitmen� skai�ius,
#      quote -- TRUE nurodo, kad character tipo reik�m�s rodomos su kabut�mis,
#   na.print -- simboli� seka, kuri vaizduojama vietoje NA reik�m�s,
#  print.gap -- tarpo plotis tarp vektoriaus element� arba matricos stulpeli�,
#      right -- FALSE nurodo, kad simboli� sekos lygiuojamos pagal de�in� pus�,
#        max -- � ekran� i�vedam� vektoriaus ar matricos element� skai�ius.


# Kiek realiojo skai�iaus skaitmen� rodoma ekrane, nustato sisteminis parametras
# digits. Standartin� jo reik�m� yra 7.

options("digits")

# Jeigu reali�j� skai�i� atvaizdavimui ekrane naudojama funkcija print, kei�iant
# jos parametro digits reik�m�, galima nustatyti ekrane rodom� skaitmen� skai�i�. 
# Pademonstruosime, kaip, kei�iant �io parametro reik�m�, kompiuterio ekrane bus 
# atvaizduojamas reali�j� skai�i� vektorius.

x <- rnorm(20)
x

print(x)

print(x, digits = 1)
print(x, digits = 5)
print(x, digits = 20)


# Parametras print.gap nurodo tarpo tarp gretim� vektoriaus reik�mi� ar matricos
# stulpeli� plot�. Pavyzd�iui, padidinsime tarp� tarp vektoriaus element� iki 5.

print(x)
print(x, print.gap = 5)
print(x, print.gap = 5, digits = 3)

# Taip pat galima padidinti tarpus tarp matricos arba duomen� lentel�s stulpeli�.

m <- matrix(x, 5, byrow = TRUE)
m

print(m, print.gap = 4)
print(m, print.gap = 4, digits = 3)


# Praleistos reik�m�s standarti�kai �ymimos NA, lygiai taip pat jos vaizduojamos
# ir ekrane. Ta�iau, naudojant parametr� na.print, vietoje NA galima pavaizduoti 
# kitoki� simboli� sek� arba net ir vien� simbol�. Pavyzd�iui, i�vesime � ekran�
# skaitin� vektori� su praleistomis reik�m�mis, kurias �ymi ta�ko simbolis. 

y <- airquality$Ozone
y

print(y)
print(y, na.print = ".")


# Standarti�kai character tipo reik�m� ekrane rodoma su kabut�mis. Jeigu tekstas
# turi b�ti rodomas be kabu�i�, parametro quote reik�m� reikia pakeisti � FALSE.

w <- c("lorem", "ipsum", "dolor", "sit", "amet", "aliquip", "docendi", "decore",
       "mnesarchum", "nullam", "perfecto", "an", "vix", "cu", "et", "molestiae",
       "consetetur", "assum", "libris", "pro", "in", "et", "mel", "nisl", "nam",
       "fugit", "est", "recusabo", "dissentias", "enim", "salutatus", "fabulas")

print(w)
print(w, quote = FALSE)

# Jeigu �od�iai ar kitos character tipo reik�m�s yra nevienodo ilgio, jas galima
# i�lygiuoti pagal ilgiausio �od�io kair� arba de�in� pus�. Tam naudojamas f-jos
# print parametras rigth.

print(w)
print(w, right = TRUE)
print(w, right = TRUE, quote = FALSE)
print(w, right = TRUE, quote = FALSE, print.gap = 7)


# NAUDINGA ------------------------------

# Tai, kaip R objektas vaizduojamas ekrane, priklauso nuo jo tipo (klas�s). F-ja
# print turi kelet� metod�, kurie pritaikomi �vairaus tipo objekt� atvaizdavimui.

methods(print)

# Vienas i� da�nai pasitaikan�i� objekt� -- da�ni� lentel�s. Joms funkcija print
# taip pat turi metod� bei kelet� specifini� parametr�, nuo kuri� priklauso, tai 
# kaip atrodo ekrane atspausdinta da�ni� lentel�.

# Pavyzd�iui, sudarysime gretim� raid�i� lietuvi�kuose �od�iuose da�ni� lentel�.
# I� prad�i� u�ra�ome da�nai pasitaikan�i� �od�i� vektori�.

z <- c("prie", "ta�iau", "didelis", "sistema", "gamyba", "�mon�", "koks", "nes",
      "vieta", "�em�", "pirmas", "nor�ti", "naujas", "dabar", "narys", "�inoti",
      "pagal", "�statymas", "vaikas", "tod�l", "net", "iki", "gyvenimas", "jei",
      "da�nai", "pirmininkas", "svarbus", "ant", "grup�", "kiekvienas", "dalis",
      "atlikti", "seimas", "diena", "tai", "sakyti", "du", "valstyb�", "duomuo",
      "gerai", "prie�", "kur", "negal�ti", "jeigu", "pasaulis", "niekas", "d�l",
      "�alis", "klausimas", "geras", "nei", "nustatyti", "be", "metas", "sav�s",
      "viskas", "prad�ti", "procesas", "pateikti", "kartas", "priimti", "gauti",
      "veikla", "�kis", "vanduo", "�vairus", "dirbti", "ligonis", "pagrindinis",
      "kiek", "pavyzdys", "imti", "skirti", "informacija", "lietuvis", "pad�ti",
      "tarp", "ranka", "tapti", "bendras", "vyriausyb�", "kalb�ti", "projektas",
      "miestas", "�odis", "projektas", "respublika", "kalba", "daryti", "s�lyga")

# �od�ius i�skaidome � atskiras raides, sudarome vienas po kito einan�i� raid�i�
# poras, atskir� �od�i� raid�i� poras apjungiame � bendr� lentel� ir tada i� jos 
# sudarome raid�i� por� da�ni� lentel�.

s <- strsplit(z, "")
p <- sapply(s, embed, 2)
g <- do.call(rbind, p)

pirma <- g[, 2]
antra <- g[, 1]

L <- table(pirma, antra)
L

# Matome, kad da�ni� lentel�je yra gana daug nulini� da�ni�. Taip yra tod�l, kad 
# nagrin�jam� �od�i� palyginus nedaug ir retos raid�i� poros tarp j� nepasitaiko.
# Didelis nulini� da�ni� kiekis lentel�je trukdo ��velgti kitus skai�ius. Ta�iau,
# naudojant funkcijos print parametr� zero.print, galima nustatyti, kok� simbol� 
# rodyti vietoje nulio. Pavyzd�iui, nustatysime, kad b�t� rodomas ta�kas.

print(L)
print(L, zero.print = ".")


# Da�ni� lentel� i� esm�s yra skai�i� matrica, ta�iau jos klas� ne "matrix", bet 
# "table", ir pagal �� po�ym� da�ni� lentel�s atskiriamos nuo vis� kit� matric�. 
# Ta�iau R objekto klas� galima nesunkiai pakeisti. Pavyzd�iui, skai�i� matricai 
# priskirsime "table" klas� ir taip apgausime funkcij� print.

m <- matrix(sample(0:1, 100, TRUE), 10)
m

# Paprasta matrica n�ra da�ni� lentel� ir parametras zero.print nieko nepakei�ia.

class(m)
print(m, zero.print = ".")

# Pakeitus objekto klas�, ta pati matrica atpa��stama kaip da�ni� lentel�, tod�l
# jau galima nustatyti, kaip ji turi b�ti atvaizduojama ekrane.

class(m)
class(m) <- "table"

print(m, zero.print = ".")


# U�DUOTIS ------------------------------ 

# 1. Sugalvokite toki� koreliacij� matricos atvaizdavimo funkcij�, kad reik�m�s, 
#    absoliutiniu dyd�iu ma�esn�s u� tam tikr� pasirenkam� rib�, b�t� nerodomos.
# 2. 
#    


# --------------------------------------- #
# SIMBOLI� SEK� ATVAIZDAVIMO FUNKCIJOS    #
# --------------------------------------- #

# D�l �vairi� prie�as�i� skai�i� vektori�, duomen� lentel�, simboli� sek� ar bet
# kok� kit� R objekt� nevisada galima pavaizduoti tok�, koks jis yra. Pavyzd�iui,
# gali b�ti taip, kad teksto ilg� riboja simboli� skai�ius eilut�je. Tada tekst�
# reikia nukirpti, kad jis tilpt� � eilut�. Pana�i� situacij� yra ir daugiau.

# R turi kelet� pagalbini� funkcij�, kurios padeda suformuoti tekst�: paversti �
# simboli� sek� skai�i� vektorius, nukirpti simboli� sek� iki tam tikro simboli� 
# skai�iaus, sulygiuoti atskiras simboli� sekas ir pan.

# Pati papras�iausia i� toki� funkcij� -- noquote. �i funkcija pakei�ia simboli�
# sekos klas� � "noquote", ir tokia simboli� seka ekrane vaizduojama be kabu�i�.
# Kabut�s parodo simboli� sekos ribas ir tuo pa�iu parodo, kad simboli� seka yra
# simboli� seka, o ne kintamojo pavadinimas, ta�iau kartais tai neb�tina �inoti. 
# Pavyzd�iui, pakeisime lietuvi�k� �od�i� vektoriaus klas� ir juos atvaizduosime
# ekrane be kabu�i�.

z <- noquote(z)
z

# �inoma, naudojant funkcij� unclass, galima sugr��inti pradin� vektoriaus klas�.

z <- unclass(z)
z


# Funkcija strtrim nukerpa ilgos simboli� sekos gal� ir tokiu b�du sutrumpina j�
# iki nustatyto simboli� skai�iaus. �i funkcija turi tik du parametrus:
#
#          x -- simboli� seka,
#      width -- simboli� sekos ilgis.

# Pavyzd�iui, vis� savait�s dien� pavadinimus sutrumpinsime iki trij� raid�i�.

dienos <- c("Pirmadienis", "Antradienis", "Tre�iadienis", "Ketvirtadienis", 
            "Penktadienis", "�e�tadienis", "Sekmadienis") 

strtrim(dienos, 3)


# Jeigu sutrumpinta seka turi b�ti unikali, naudojama funkcija abbreviate. Sekos 
# sutrumpinimo algoritmas toks: i� prad�i� i� sekos pa�alinami visi tarpai, tada 
# panaikinamos ma��j� raide u�ra�ytos bals�s, kurios eina po priebalsi�, ir, jei
# tokia seka turi daugiau simboli�, negu nurodyta, pa�alinamos did�iosios raid�s.
# Funkcijos parametrai:
# 
#    names.arg -- simboli� sek� vektorius,
#    minlength -- minimalus sutrumpintos sekos ilgis,
#          dot -- loginis, nurodo ar trumpinio gale turi b�ti dedamas ta�kas,
#       strict -- loginis, nurodo ar b�tinai i�laikyti minimal� trumpinio ilg�,
#       method -- c("left.kept", "both.sides")

# Pavyzd�iui, iki trij� raid�i� sutrumpinsime lietuvi�kus m�nesi� pavadinimus.

m�nesiai <- c("Sausis", "Vasaris", "Kovas", "Balandis", 
              "Gegu��", "Bir�elis", "Liepa", "Rugpj�tis", 
              "Rugs�jis", "Spalis", "Lapkritis", "Gruodis")

abbreviate(m�nesiai, minlength = 3)

# Naudojant funkcij� strtrim, m�nesi� pavadinimai gaunami labiau �prasti, ta�iau 
# d�l to, kad sutampa pirmosios trys raid�s, rugpj�tis ir rugs�jis neatskiriami.
# Kartais, pavyzd�iui, sudarant da�ni� lentel�, tai gali sukelti problem�.

strtrim(m�nesiai, 3)

# Jei simboli� seka susideda i� keli� �od�i�, sutrumpinimas sudaromas i� pirm�j�
# t� �od�i� raid�i�. Pavyzd�iui, sudarysime trumpinius i� vard� ir pavard�i�.

vardai <- c("Pierre de Fermat", "Carl Friedrich Gauss", "Alan Mathison Turing")

abbreviate(vardai, minlength = 3)


# F-ja toString apjungia vektoriaus elementus � vien� simboli� sek�. Jeigu sekos
# simboli� skai�ius vir�ija nustatyt� rib�, sekos galas nukerpamas, o vietoje jo
# �ra�omas daugta�kis. Taip parodoma, kad sek� turi t�sin�. Funkcijos parametrai:
#
#          x -- vektorius,
#      width -- apjungtos sekos ilgis,

# �is vektoriaus element� apjungimo b�das nat�raliai gerai tinka tuo atveju, kai
# vektoriaus elementai patys sudaro lengvai atsp�jam� sek�. Pavyzd�iui, tai gali
# b�ti skai�i� arba �od�i� seka, datos, ka�kokie �inomi posakiai ir pan.

toString(getwd(), 20)
toString(letters, 20)
toString(dienos, 30)
toString(1:100, 20)


# Funkcija encodeString vektoriaus elementus paver�ia � tam tikro ilgio simboli� 
# sekas. Jei seka trumpesn�, prie jos kair�s arba de�in�s pus�s pridedami tarpai.
# I� kurios pus�s bus pridedami tarpai, priklauso nuo to, pagal kuri� pus� sekos
# lygiuojamos. Funkcijos parametrai:
#
#          x -- vektorius,
#      width -- sekos ilgis, NA arba NULL nurodo ilgiausios sekos ilg�,
#      quote -- kabu�i� simbolis,
#  na.encode -- jeigu FALSE, tai seka nebus sudaroma,
#    justify -- lygiavimo taisykl�: "left", "right", "centre" arba "none".

# Pavyzd�iui, duotas skirting� ilgi� �od�i� vektorius. I� jo element� sudarysime
# vienodo ilgio simboli� sekas.

�od�iai <- c("�", "a�", "�uo", "imti", "�odis", "sodyba", "prad�ti", "susisuko")
�od�iai

# Jei parametro width reik�m� NA ar NULL, tai gaunamos sekos, kuri� ilgiai lyg�s
# daugiausia simboli� turin�io vektoriaus elemento ilgiui. �iuo atveju visos jos
# suvienodinamos pagal ilgiausi� �od�.

encodeString(�od�iai, width = NA)

# Nusta�ius didesn� simboli� sek� ilg�, papildomais tarpais bus praple�iamos jau
# visos sekos.

encodeString(�od�iai, width = 50)

# Standarti�kai visos sekos lygiuojamos pagal kair�j� kra�t�. Lygiavimo taisykl� 
# nusako parametro justify reik�m�. Pavyzd�iui, priskyrus reik�m� "right", sekas 
# i�lygiuosime pagal de�in�j� kra�t�, priskyrus reik�m� "centre" -- centruosime.

encodeString(�od�iai, width = 50, justify = "right")
encodeString(�od�iai, width = 50, justify = "centre")


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    