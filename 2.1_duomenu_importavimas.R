
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Duomen� importavimo i� tekstinio ar binarinio failo b�dai.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2013-07-08 | 2013-07-12
#


# TURINYS -------------------------------

#
#   1. Duomen� nuskaitymas i� tekstinio failo:
#      * proced�ra scan
#      * proced�ra readLines
#      * proced�ra read.table
#      * proced�ra read.csv
#      * proced�ra read.delim
#
#   2. Duomen� nuskaitymas i� binarinio failo:
#      * proced�ra save
#      * proced�ra load
#


# PASTABOS ------------------------------

#
# Para�yti apie funkcij� count.fields.
# Para�yti apie funkcij� read.fwf.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# DUOMEN� NUSKAITYMAS I� TEKSTINIO FAILO  #
# --------------------------------------- #

# Daug element� turintys vektoriai, didel�s matricos, duomen� lentel�s arba kiti 
# dideli duomen� masyvai paprastai laikomos failuose, kuri� nuskaitymui R turi 
# kelet� proced�r�. Aptarsime da�niausiai pasitaikan�ias situacijas.

# Vieno vektoriaus element� nuskaitymui i� failo naudojama proced�r� scan. Galima 
# i�ra�yti pagrindinius jos parametrus:
#
#    file -- kabut�se u�ra�omas duomen� failo vardas arba kelias iki failo,
#    what -- vektoriaus reik�mi� tipas: numeric(), character() ir pan.,
#     sep -- vektoriaus elementus skiriantis simbolis, pagal nutyl�jim� tarpas,
#     dec -- de�imtainio kablelio simbolis, pagal nutyl�jim� tai ta�kas ".",
#    skip -- pirm�j� nenuskaitom� eilu�i� faile skai�ius,
#  nlines -- nuskaitom� failo eilu�i� skai�ius,
#       n -- maksimalus vektoriaus element� skai�ius.

# Jei parametro file reik�m� nenurodoma, pagal nutyl�jim� laikoma, jog jo reik�m�
# yra "" ir vektoriaus reik�m�s bus �vedamos i� klaviat�ros.

# Vektoriaus elementai nuskaitomi eilut�mis. Elementai faile gali b�ti sura�yti 
# viename stulpelyje arba keliose eilut�se po kelis elementus vienoje eilut�je. 
# Element� skai�ius eilut�se neb�tinai turi sutapti ir gali skirtis.


# Sukursime tekstin� fail� su keliomis skaitin�mis reik�m�mis. Reik�m�s viena nuo
# kitos atskiriamos naujos eilut�s simboliu \n, tod�l faile visos jos sura�omos 
# po vien� kiekvienoje eilut�je.

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
cat(v, file = "test.dat", sep = "\n")

# I� sukurto tekstinio failo nuskaitome reik�mes ir i� j� sudarome vektori� x.
x <- scan(file = "test.dat")
x

# Galima nesunkiai patikrinti, kad pradinis ir nuskaitytas vektoriai sutampa.
identical(v, x)


# Sukursime simbolini� reik�mi� vektori� ir �ra�ysime � fail�. Reik�mes atskirsime 
# tarpo �enklu, tod�l visos raid�s faile bus vienoje eilut�je.

v <- c("a", "b", "c", "x", "y", "z")
cat(v, file = "test.dat", sep = " ")

# Kadangi dabar vektoriaus elementai yra simboliai, tai reikia nurodyti j� tip�.
x <- scan(file = "test.dat", what = character())
x


# Lietuvi� kalboje de�imtain�s trupmenos sveikoji ir trupmenin� dalys skiriamos
# kableliu, tod�l nuskaitant tok� vektori� reikia pakeisti parametro dec reik�m�
# � ",". Sukursime fail�, kuriame realieji skai�iai u�ra�yti su kableliu.

v <- c("1,5", "2,1", "3,1", "4,9")
cat(v, file = "test.dat", sep = "\n")

# Norint korekti�kai nuskaityti tok� fail�, reikia nurodyti, kad trupmenin� dal�
# skiria kablelis, o ne ta�kas, kaip nurodyta pagal nutyl�jim�.
x <- scan(file = "test.dat", dec = ",")
x


# Failo prad�ioje gali b�ti kelios tu��ios eilut�s arba eilut�s, kuriose sura�yta 
# papildoma informacija. Tada proced�rai reikia nurodyti ir praleid�iam� eilu�i� 
# skai�i�.

v <- c("praleisti", "praleisti", " ", "a", "b", "c")
cat(v, file = "test.dat", sep = "\n")

# Gautame faile pirmos trys eilut�s neturi jokios informacijos, tod�l jas reikia
# praleisti. 

x <- scan(file = "test.dat", what = character(), skip = 3)
x


# NAUDINGA ------------------------------

# Da�nai duomen� failas yra internete. Tokiu atveju proced�ros parametrui file 
# reikia nurodyti piln� jo adres�.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_1a.dat"

x <- scan(file = adresas)
x


# Teksto eilut�ms i� failo nuskaityti naudojama specialiai tam skirta proced�ra 
# readLines. Pagrindiniai jos parametrai:
#
#     con -- duomen� failas arba simboli� eilut�,
#       n -- nuskaitom� eilu�i� skai�ius.

# Proced�ros rezultatas yra character tipo vektorius, kurio vienas elementas yra 
# viena teksto eilut�.

# Pavyzd�iui, nuskaitysime tekstin� fail�, kuris turi penkias eilutes, po vien�
# sakin� kiekvienoje eilut�je.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_3a.dat"

x <- readLines(adresas)
x


# U�DUOTIS ------------------------------ 

# 1. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_1b.dat" 
#    nuskaitykite pirmus 20 vektoriaus element�. 
# 2. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_2a.dat" 
#    nuskaitykite kabliata�kiais atskirtus �od�ius. Turite gauti character tipo
#    vektori� i� 10 element�.
# 3. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_3a.dat" 
#    nuskaitykite tik pirmas 3 eilutes. 


# Duomen� lentel�s i� failo nuskaitomos naudojant proced�r� read.table. Baziniai
# jos parametrai tokie:
#
#       file -- kabut�se u�ra�omas duomen� failo vardas arba kelias iki failo,
#     header -- TRUE nurodo, kad pirmoje eilut�je sura�yti kintam�j� vardai,
#        sep -- stulpelius atskiriantis simbolis, pagal nutyl�jim� tarpas,
#        dec -- de�imtainio kablelio simbolis, pagal nutyl�jim� tai ta�kas ".",
#       skip -- skai�ius pirm�j� eilu�i�, kurias reikia praleisti,
#      nrows -- skai�ius eilu�i�, kurias reikia nuskaityti,
#  row.names -- eilu�i� vard� vektorius, j� stulpelio numeris arba pavadinimas,
#  col.names -- stulpeli� pavadinim� vektorius,
# na.strings -- praleistos reik�m�s simbolis, pagal nutyl�jim� "NA",
#      as.is -- jei TRUE, tai kategoriniai kintamieji nuskaitomi kaip faktoriai.


# Kaip ir proced�rai scan, �ia galima nurodyti, kad duomen� failas yra internete.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1a.dat" 

# Pa�iu papras�iausiu atveju stulpeliai faile gali b�ti sura�yti be pavadinim�.
# Tada proced�rai u�tenka nurodyti tik duomen� failo adres�, o kintam�j� vardai
# sudaromi automati�kai.

d <- read.table(file = adresas)
d

# Jei duomen� faile stulpeliai pavadinim� neturi, kintamiesiems vardus suteikti 
# galima nuskaitymo metu. Tam reikia sukurti j� vard� vektori�. Vard� vektorius 
# turi tur�ti tiek element�, kiek duomen� faile yra stulpeli�.
k.vardas <- c("x", "y", "z")

d <- read.table(file = adresas, col.names = k.vardas)
d

# Jei kintamieji vardus turi, jie b�na sura�yti pirmoje duomen� failo eilut�je.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat"

# Tokiu atveju parametro header reik�m� pakei�iame � TRUE.
d <- read.table(file = adresas, header = TRUE)
d


# Paprastai duomen� lentel�s eilu�i� pavadinimai sutampa su j� eil�s numeriais.
# Nuskaitymo i� failo metu eilut�s sunumeruojamos automati�kai. Ta�iau naudojant
# parametr� row.names galima eilut�ms suteikti kitus vardus, ta�iau jie b�tinai 
# turi b�ti unikal�s.

# Jei pirmoje failo eilut�je kintam�j� vard� yra vienu ma�iau nei stulpeli�, tai 
# laikoma, kad pirmame stulpelyje yra eilu�i� vardai.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_2a.dat"

# I� failo nuskaitome duomen� lentel�, kurios eilut�s turi savo raidinius kodus.
d <- read.table(file = adresas, header = TRUE)
d

# Eilu�i� pavadinimai gali b�ti bet kuriame kitame duomen� lentel�s stulpelyje.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_2b.dat" 

# �ia nurodome, kad eilu�i� kodai yra tre�iame duomen� lentel�s stulpelyje "E".
d <- read.table(file = adresas, header = TRUE, row.names = "E")
d


# Kartais duomen� failo prad�ioje b�na �ra�oma tam tikra papildoma informacija. 
# Jei duomen� failo eilut� prasideda komentaro simboliu #, tai nuskaitymo metu
# tokia eilut� automati�kai praleid�iama. 
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_3a.dat" 

# �io failo prad�ioje para�yta, kad trupmenin� skai�iaus dalis skiriama kableliu,
# tod�l pakei�iame parametro dec reik�m�.
d <- read.table(file = adresas, header = TRUE, dec = ",")
d

# Jei failo prad�ioje yra kelios neu�komentuotos eilut�s, kurias reikia praleisti, 
# tokiu atveju per parametr� skip nurodome toki� eilu�i� skai�i�.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_3b.dat" 

d <- read.table(file = adresas, header = TRUE, dec = ",", skip = 6)
d


# NAUDINGA ------------------------------

# Jei kelias iki failo yra ilgas, o duomen� nuskaitymas atliekamas vien� kart�,
# kartais papras�iau ir grei�iau duomen� fail� pasirinkti interaktyviai naudojant 
# komand� file.choose().

# Pvz., sukursime paprast� duomen� fail� "test.dat", kuriame � vien� stulpel� 
# sura�ytos visos did�iosios ab�c�l�s raid�s. 
cat(LETTERS, file = "test.dat", sep = "\n")

# Nuskaitysime fail� ne nurodydami jo piln� vard�, o pasirinkdami interaktyviai. 
# Vis� kit� proced�ros read.table parametr� reik�m�s paliktos pagal nutyl�jim�.

d <- read.table(file = file.choose())
d


# U�DUOTIS ------------------------------ 

# 1. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat" 
#    duomen� lentel� nuskaitykite be kintam�j� vard� eilut�s. 
# 2. Pakeiskite duomen� failo "lent_1b.dat" nuskaitymo komand�, kad duomen�
#    lentel�s kintamieji gaut� vardus "a", "b" ir "c".
# 3. Duomen� failo "test.dat" nuskaitymo komand� pakeiskite taip, kad kintamajam
#    b�t� priskirtas vardas "Raid�s".


# Kad duomenis b�t� galima nesunkiai perkelti i� vienos programos � kit�, jie � 
# failus ra�omi tam tikru standartiniu formatu. Vienas tekstinio duomen� failo 
# formatas yra taip vadinamas "comma separated value" arba sutrumpintai CSV. Jis
# skirtas lentel�s pavidalo duomenims u�ra�yti, kur stulpeliuose yra kintamieji,
# o eilut�se yra stebiniai.

# Toks failas pirmoje eilut�je turi stulpeli� pavadinimus. Jei stulpeliai vienas
# nuo kito atskiriami kableliu, tai trupmenin� skai�iaus dalis skiriama ta�ku.
# Tokio formato duomen� failui nuskaityti naudojama read.csv proced�ra.

# Jei stulpeliai vienas nuo kito atskiriami kabliata�kiu, tai trupmenin� skai�iaus 
# dalis skiriama mums �prastu kableliu. Tokio formato duomen� failui nuskaityti 
# naudojama proced�ra read.csv2.

adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1c.csv" 

d <- read.csv2(file = adresas)
d

# �inoma, CSV formato fail� galima nuskaityti ir naudojant proced�r� read.table,
# ta�iau �iuo atveju nuskaitymo komanda yra paprastesn�. Jei stulpeliai duomen�
# faile atskiriami tabuliacijos �enklu "\t", tada tokiems duomenims nuskaityti 
# gali b�ti taikoma proced�ra read.delim arba read.delim2.


# NAUDINGA ------------------------------

# Kartais pasitaiko situacija, kai i� duomen� failo reikia nuskaityti tik dal�
# kintam�j�, pvz., pirmus penkis kintamuosius arba kas antr�. Vienas sprendimas 
# akivaizdus: i� prad�i� nuskaityti visus stulpelius, o tada �vairiais b�dais i� 
# lentel�s galima i�mesti nereikalingus kintamuosius. 

# Kitas b�das nuskaityti tam tikrus stulpelius -- panaudoti proced�ros parametr� 
# colClasses, kuriam nurodomas vis� nuskaitom� stulpeli� tip� vektorius. Vietoje
# �prasto reik�m�s tipo numeric, character ar pan., galima nurodyti NULL tip�.
# Tada kintamasis, kuriam priskirtas NULL tipas � duomen� lentel� ne�traukiamas.

# Pavyzd�iui, i� failo "lent_1b.dat" nuskaitysime tik pirmus du kintamuosius. 
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat"

# Tam i� prad�i� sukursime pagalbin� duomen� lentel�s kintam�j� tip� vektori�.
k.tipas <- c("numeric", "numeric", "NULL")

d <- read.table(file = adresas, header = TRUE, colClasses = k.tipas)
d


# U�DUOTIS ------------------------------ 

# 1. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_4a.dat" 
#    nuskaitykite kas antr� stulpel�. 
# 2. I� failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_4b.dat" 
#    nuskaitykite tik paskutinius 2 i� 20 duomenyse esan�i� stulpeli�. Nuskaitymo 
#    metu jiems priskirkite vardus "X" ir "Y".


# --------------------------------------- #
# DUOMEN� NUSKAITYMAS I� BINARINIO FAILO  #
# --------------------------------------- #

# Jei duomenys sud�tingos strukt�ros, juos ne visada patogu laikyti tekstiniame 
# faile. Pavyzd�iui, tokie gali b�ti sud�tingi s�ra�ai, R statistini� proced�r� 
# rezultat� lentel�s ir t.t. Tokiais atvejais kintamuosius ar duomen� rinkinius 
# patogiau u�saugoti kaip binarin� R duomen� fail� su standartiniu tokio tipo
# failui i�pl�timu .RData (i�pl�timas gali b�ti ir kitoks). Vien� ar kelis R 
# kintamuosius tokiu formatu eksportuojame naudojant funkcij� save.

# Pavyzd�iui, binariniu formatu i�saugosime standartin� did�i�j� raid�i� vektori�.
save(LETTERS, file = "test.RData")

# Tokio tipo failas importuojamas naudojant proced�r� load. �inoma, kaip ir kitus 
# duomenis, binarin� fail� taip pat galima nuskaityti ir i� interneto.
load(file = "test.RData")


# U�DUOTIS ------------------------------ 

# 1. Faile "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/rdat_1a.RData"
#    i�saugotas kintamasis m su duomen� lentele. Importuokite �� fail�.
