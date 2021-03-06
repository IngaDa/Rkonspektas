
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Duomen� lentel�s sudarymas ir jos kintamieji.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2012-09-03 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Duomen� lentel�s sudarymas:
#      * komanda data.frame
#      * komanda class
#      * komanda nrow ir ncol
#      * komanda names
#      * komanda row.names
#      * komanda attributes
#      * komanda str
#      * operatorius [
#      * operatorius [[
#      * operatorius &
#
#   2. Duomen� lenteli� apjungimas:
#      * kintam�j� prijungimas
#      * kintam�j� panaikinimas
#      * komanda cbind
#      * komanda rbind 
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
# DUOMEN� LENTEL�S SUDARYMAS              #
# --------------------------------------- #

# Pats bendriausias R duomen� tipas yra data.frame -- duomen� lentel�, kurios 
# stulpeliuose yra kintamieji, o eilut�se stebiniai. Esminis duomen� lentel�s 
# skirtumas nuo matricos yra tas, kad duomen� lentel�s stulpeliai gali b�ti ir 
# skirting� tip�. 


# Sudarysime duomen� lentel�, kurios stulpeliuose bus trys skirtingo tipo 
# vektoriai: numeric, logical ir character.

x <- c(22, 37, 68, 47, 92, 87, 39, 19, 97, 32)
y <- c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE)
z <- c("P", "P",  "P",  "T",  "T",  "T",  "A",  "A",  "A",  "A")

# Kaip ir sudarant vektorius arba s�ra�us, elementams galima suteikti vardus.
# Duomen� lentel�s elementai yra stulpeliuose esantys kintamieji - vektoriai.
# Jei kintam�j� vardai nenurodomi, tai stulpeliai tur�s vektori� pavadinimus.

d <- data.frame(X = x, Y = y, Z = z)
d

# Galima pasteb�ti, kad character tipo vektoriaus z reik�m�s duomen� lentel�je
# vaizduojamos be kabu�i�. Taip yra tod�l, kad character tipo kategoriniai 
# kintamieji automati�kai pavirsta � specialaus tipo factor kintamuosius.

# Taip sudaryta lentel� yra data.frame klas�s duomen� strukt�ra.
class(d)

# Lentel�s eilu�i� ir stulpeli� skai�iui rasti naudojamos funkcijos nrow ir ncol.
nrow(d)
ncol(d)

# Duomen� lentel�s kintam�j� vardus parodo funkcija names. 
names(d)

# Funkcija names naudojama ir kintam�j� vard� pakeitimui.
names(d) <- c("X", "Testas", "Tipas")
names(d)
d

# Duomen� lentel�s eilu�i� vardus parodo funkcija row.names. Pagal nutyl�jim� 
# eilut�s sunumeruojamos.
row.names(d)

# Lentel�s eilu�i� vardus galima pakeisti, ta�iau visi jie turi b�ti skirtingi.
row.names(d) <- letters[1:10]
d

# Pati papras�iausia duomen� lentel� turi kelet� pagrindini� atribut�: tai yra 
# kintam�j� vardai, eilu�i� pavadinimai ir nurodyta pa�ios lentel�s klas�.
attributes(d)

# Duomen� lentel�s atributus galima pakeisti. Pvz., gr��insime eilu�i� numerius.
attr(d, "row.names") <- 1:10
d

# Kaip ir bet kokio kito objekto, lentel�s strukt�r� galima pamatyti naudojant 
# funkcij� str. �ia matome, kad kintamasis d yra data.frame tipo 10*3 dyd�io
# lentel�, kurios kintamieji yra numeric, logical ir factor tipo vektoriai.
# Be to, faktorius turi tris kategorijas.
str(d)


# NAUDINGA ------------------------------

# Kai kurios duomen� lentel�ms ir matricoms naudojamos funkcijos yra specifin�s:
# vienos i� j� tinka lentel�ms, bet netaikomos matricoms ir atvirk��iai. Gali 
# b�ti, kad tam tikrais atvejais funkcijos rezultatas gali tur�ti kitoki� prasm�.

# Funkcija length apskai�iuoja vektori�, matric� ir s�ra�� element� skai�i�. Jei
# funkcijos length argumentas bus duomen� lentel�, rezultatas bus jos stulpeli�
# skai�ius. Tai galima paai�kinti tuo, kad duomen� lentel�s elementai yra jos
# kintamieji, t.y. stulpeliai.

length(d)

# Funkcija dim naudojama matricos eilu�i� ir stulpeli� skai�iui nustatyti. Jei 
# �ios funkcijos argumentas yra duomen� lentel�, tai rezultatas taip pat yra 
# vektorius, kurio pirmas elementas rei�kia eilu�i�, o antras -- stulpeli� skai�i�. 
# Ta�iau duomen� lenteli� atveju eilu�i� skai�ius gaunamas kaip eilu�i� vard� 
# vektoriaus element� skai�ius, o stulpeli� skai�ius -- kaip duomen� lentel�s 
# kintam�j� skai�ius.

# Taip ra�oma:
dim(d)

# O taip skai�iuojama :)
c(length(attributes(d)$row.names), length(d))


# Funkcijos rownames ir colnames naudojamos matric� eilu�i� ir stulpeli� vardams.
# Funkcija names nenaudojama matricos stulpeli� vardams.

#                   matrica     lentel�
# 
#   eilu�i� vardai  rownames    row.names
# stulpeli� vardai  colnames    names
#       abu vardai  dimnames    dimnames


# U�DUOTIS ------------------------------ 

# 1. Sukurkite duomen� lentel� h, kurioje pirmas stulpelis b�t� vardas ir pavard�, 
#    antras -- lytis (galima koduoti vyras-moteris, 0-1, V-M ir pan.), o tre�ias
#    stulpelis koks nors kiekybinis kintamasis, pvz., am�ius, atlyginimas, �gis.
# 2. Naudodami funkcij� names pakeiskite duomen� lentel�s kintam�j� vardus.
# 3. Naudodami funkcij� row.names pakeiskite sukurtos duomen� lentel�s eilu�i� 
#    numerius � raides.


# Kintam�j� i�skyrimo operatoriai [ ir [[ duomen� lentel�se naudojami dvejopai: 
# kaip matricose ir kaip s�ra�uose.

# Operatori� [ naudojant kaip matricoje, bet kuris lentel�s elementas pasiekiamas 
# nurodant eilut�s ir stulpelio numer�.
d[1, 1]

# Nenurod�ius eilut�s indekso, bus i�skiriamos visos duomen� lentel�s eilut�s.
# Pvz., i�skirsime visas pirmo stulpelio eilutes.
d[, 1]

# Nenurod�ius stulpelio indekso, bus i�skiriami visi duomen� lentel�s stulpeliai.
# Pvz., i�skirsime visus pirmos eilut�s stulpelius.
d[1, ]

# Indeks� nurod�ius su minuso �enklu, atitinkama eilut� arba stulpelis i�metami.
# Pvz., �ia lentel�je bus paliekami visi stulpeliai i�skyrus pirm�j�.
d[, -1]

# Kaip ir matricoms, galima nurodyti lentel�s eilu�i� ir stulpeli� indeks� aib�.
# Pvz., i� lentel�s d i�skirsime pirmas dvi eilutes ir paskutinius du stulpelius.

i <- c(1, 2)
j <- c(2, 3)
d[i, j]

# Kartais toki� konstrukcij� galima para�yti ir trumpiau.
d[1:2, 2:3]


# Da�nai duomen� lentel�s kintamuosius patogiau i�skirti nurodant j� vardus.
d[, "X"] 

# Duomen� lentel�s eilutes taip pat galima identifikuoti pagal j� vardus. Reikia 
# tur�ti omeny, kad pagal nutyl�jim� eilut�s yra numeruojamos, ta�iau j� numeriai
# yra character tipo, tod�l juos reikia nurodyti kabut�se!
d["1", ]


# Operatori� [ galima naudoti � duomen� lentel� �i�rint kaip � vektori� ar s�ra��.
# Tokiu atveju lentel�s elementai yra jos kintamieji, t.y. stulpeliai. Nurod�ius 
# vieno lentel�s elemento numer�, gausime taip pat lentel� tik su vienu stulpeliu.
d[1]

# Nurod�ius neigiam� indeks�, atitinkam� numer� turintis kintamasis-stulpelis 
# nebus pasirenkamas.
d[-1]

# Nurod�ius kintam�j� indeks� aib�, galima i�skirti ir kelet� kintam�j�.
d[1:2]

# Operatori� [[ naudojant i�skirtas lentel�s elementas -- kintamasis tur�s savo 
# pradin� tip� ir strukt�r�, t.y. gausime paprast� vektori�.
d[[1]]

# Vietoje duomen� lentel�s kintamojo numerio galima naudoti jo vard�.

d["X"]       # pirmu b�du gauname duomen� lentel� su vienu stulpeliu 
d[["X"]]     # antru b�du gaunamas vektorius su lentel�s kintamojo reik�m�mis

# Galima patikrinti dviem skirtingais b�dais gaut� duomen� lentel�s element� tip�.
a <- d["X"]
b <- d[["X"]]

class(a)   
class(b)   


# Vien� duomen� lentel�s kintam�j� galima i�skirti naudojant operatori� $. �ia
# kintamojo vardas da�niausiai ra�omas be kabu�i�. Matricoms toks b�das netinka!

d$X
d$Testas


# U�DUOTIS ------------------------------ 

# 1. Keliais skirtingais b�dais i�skirkite i� lentel�s d antr�j� stulpel�. Reikia 
#    panaudoti stulpelio numer�, jo vard�, operatorius [, [[ ir $.
# 2. I� lentel�s d sukurkite nauj� lentel�, kurioje nelikt� dviej� paskutini� 
#    eilu�i�. Kaip tai padaryti naudojant ne eilu�i� numerius, o j� vardus?
# 3. Naudojant kintam�j� numerius sukeiskite vietomis pirmus du lentel�s d 
#    stulpelius. T� pat� veiksm� atlikite naudojant kintam�j� vardus.
# 4. Sukurkite tok� indeks�, kur� naudojant i� lentel�s d b�t� i�skiriamos eilut�s 
#    su nelyginiais numeriais.
# 5. Sukurkite tok� indeks�, kur� naudojant i� lentel�s d b�t� galima i�skirti 
#    eilutes, kuriose kintamasis Testas �gyj� reik�m� TRUE.


# --------------------------------------- #
# DUOMEN� LENTELI� APJUNGIMAS             #
# --------------------------------------- #

# Gana da�nai pasitaiko situacija, kai prie jau sukurtos duomen� lentel�s reikia 
# prijungti nauj� kintam�j�. Tam yra keletas b�d�. Naudojant operatori� [ galima 
# nurodyti stulpelio, kuriame bus naujas kintamasis, numer� arba nurodyti jo vard�.

# Duomen� lentel�je d sukursime nauj� stulpel�, jam priskirsime reik�mi� vektori� 
# ir taip gausime nauj� lentel�s kintam�j�. Jo vardas parenkamas pagal nutyl�jim�.

d[4] <- rep(1:2, each = 5)
d

# Da�nu atveju papras�iau i� karto nurodyti naujo kintamojo vard�. Stulpelis su 
# naujo kintamojo reik�m�mis prie lentel�s bus prijungtas i� de�in�s. Pvz., 
# lentel�je sukursime nauj� kintam�j� "N" ir jam priskirsime tam tikr� reik�mi� 
# vektori�.
 
d["N"] <- 1:10
d

# � lentel� �i�rint kaip � matric�, nauj� kintam�j�, kaip ir anks�iau, sukuriame 
# nurodydami atitinkamo stulpelio numer� arba stulpelio vard�, o eilu�i� indeks� 
# praleid�iame.

d[, "M"] <- 1
d

# Nurodant kintam�j� vard� vektori�, galima sukurti i� karto kelet� nauj� lentel�s 
# kintam�j�. Pvz., �ia jiems visiems priskiriamas praleist� reik�mi� vektorius.

d[c("A", "B", "C")] <- NA
d

# Naudojant operatori� $ naujas kintamasis sukuriamas nurodant jo vard� ir 
# priskiriant jam reik�mi� vektori�.

d$Kodas <- letters[1:10]
d

# Panaikinti duomen� lentel�s kintam�j� taip pat yra keletas b�d�. Galima sukurti 
# nauj� lentel�, kurioje neb�t� nereikalingo kintamojo, ta�iau dauguma atvej� 
# papras�iau kintamajam priskirti tu��i� objekt� NULL. Kintam�j� nurodyti galima 
# keliais skirtingais b�dais.

d[4]     <- NULL     # naudojame operatori� [, nurodome kintamojo numer�
d["N"]   <- NULL     # naudojame operatori� [, nurodome kintamojo vard�
d[, "M"] <- NULL     # naudojame operatori� [, nurodome stulpelio vard�
d$Kodas  <- NULL     # naudojame operatori� $, nurodome kintamojo vard�

d

# Tuo atveju, kai reikia panaikinti kelet� kintam�j� i� karto, jiems reikia 
# priskirti s�ra�a i� NULL objekt�.

d[c("A", "B", "C")] <- list(NULL)
d


# U�DUOTIS ------------------------------ 

# 1. Naudodami operatori� [ anks�iau sudarytoje lentel�je h sukurkite nauj� 
#    kintam�j� N, kurio visos reik�m�s b�t� lygios nuliui.
# 2. Naudodami operatori� $ lentel�je h sukurkite kintam�j� X, kurio visos 
#    reik�m�s praleistos. Nekuriant i� naujo kintamojo X, paskutin� jo reik�m� 
#    pakeiskite i� NA � 100.
# 3. Lentel�je h panaikinkite tokius du kintamuosius, kurie vard� s�ra�e yra 
#    paskutiniai.


# Pana�iai kaip ir matricas, naudojant funkcij� cbind, vien� lentel� galima 
# prijungti prie kitos lentel�s �ono. Tokiu atveju abiej� lenteli� eilu�i� 
# skai�ius turi b�ti vienodas!

a <- data.frame(A = 10:15, B = TRUE)
b <- data.frame(A = 6:1, B = FALSE)
a
b

m <- cbind(a, b)
m

# Kintam�j� vardai gali b�ti neb�tinai skirtingi, ta�iau tokiu atveju kintam�j� 
# pasirenkant pagal vard�, bus i�renkamas pirmasis i� pasikartojant� vard� 
# turin�i� kintam�j� -- nepageidaujama situacija!

names(m)

m$A
m$A <- NULL
m

# Naudojant funkcij� cbind, prie lentel�s kaip nauj� kintam�j� galima prijungti 
# ir vektori�. Pvz., taip sukursime nauj� lentel�s d kintam�j� I, kurio visos 
# reik�m�s bus lygios 1. Kadangi prijungiamas vektorius yra trumpesnis, jo 
# reik�m�s pakartojamos.

d <- cbind(d, I = 1)
d

# Naudojant funkcij� rbind, duomen� lentel�s apjungiamos sudedant jas vien� ant 
# kitos. �iuo atveju b�tina, kad kintam�j� vardai abiejose lentel�se sutapt�, 
# ta�iau eilu�i� skai�ius gali b�ti bet koks.

m <- rbind(a, b)
m


# U�DUOTIS ------------------------------ 

# 1. Naudodami funkcij� cbind anks�iau sudarytoje lentel�je h sukurkite nauj� 
#    kintam�j� N, kurio visos reik�m�s b�t� lygios nuliui.
# 2. Sukurkite tokius pa�ius kintamuosius turin�i� lentel� k, kuri tur�t� tik 
#    vien� eilut�, ir prijunkite j� prie lentel�s h apa�ios.
