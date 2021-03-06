
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Baziniai veiksmai su simboli� sekomis.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2016-03-21 | 2016-03-29
#


# TURINYS -------------------------------

#
#   1. Simboli� tekste pakeitimas:
#      * funkcija nchar
#      * funkcija tolower
#      * funkcija toupper
#      * funkcija chartr
#
#   2. Simboli� sek� skaidymas � atskiras dalis:
#      * funkcija substr
#      * funkcija strsplit
#


# PASTABOS ------------------------------

#
# Pastab� n�ra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# SIMBOLI� SEKOJE PAKEITIMAS              #
# --------------------------------------- #

# Teorin�je informatikoje apibr��iamas specialus duomen� tipas --- string. Tokio 
# duomen� tipo reik�m�s yra baigtin� element� skai�i� turin�ios sekos, sudarytos 
# i� bet kokia tvarka i�d�styt� simboli� i� tam tikros aib�s, vadinamos alfabetu.
# Duomen� tipas tuo pa�iu apibr��ia ir veiksmus su string tipo kintamaisiais.

# Simboli� seka ra�oma tarp viengub� ar dvigub� kabu�i�. Simboli� sekas, kaip ir
# kitus vienodo tipo elementus, galima apjungti � vektorius. R turi kelet� toki�
# tekstini� vektori� -- konstant�. Tai did�iosios ir ma�osios raid�s bei m�nesi�
# pavadinimai.

letters
LETTERS

month.abb
month.name

# Sek� skai�ius tokiame vektoriuje nustatomas naudojant standartin� f-j� length.
# Pavyzd�iui, m�nesi� pavadinim� yra 12:

length(month.name)

# Simboli� skai�i� sekoje vadinkime sekos ilgiu. Jam apskai�iuoti naudojama f-j� 
# nchar. Jos parametrai:
#
#          x -- simboli� seka arba keletos sek� vektorius,
#       type -- sekos dyd�io matavimo vienetai: "bytes", "chars" arba "width".

# Funkcijos nchar rezultatas yra skai�i� vektorius. Jo element� skai�ius sutampa
# su vektoriaus x element� skai�iumi. Pavyzd�iui, nustatysime m�nesi� pavadinim�
# ilgius.

nchar(month.name)

# Tok� ilgi� vektori� galima panaudoti ilgiausios sekos nustatymui ir i�rinkimui.
# Pavyzd�iui, nustatysime, kurio m�nesio pavadinimas ilgiausias.

month.name[which.max(nchar(month.name))]

# Atskiru atveju sek� vektorius gali b�ti ir viena seka. Pavyzd�iui, nustatysime 
# ilgiausio dani�ko �od�io ilg�.

�odis <- "Kindercarnavalsoptochtvoorbereidingswerkzaamhedenplan"
nchar(�odis)


# Kartais n�ra jokio skirtumo, kokiomis raid�mis para�ytas tekstas, did�iosiomis 
# ar ma�osomis. Pavyzd�iui, bioinformatikoje pagrindinis tyrimo objektas yra DNR 
# arba amino r�g��i� sekos. DNR sekos u�ra�omos simboliais i� aib�s {A, C, G, T}.
# Ta�iau ta pati seka gali b�ti u�ra�yta ir ma�osiomis raid�mis -- skirtumo n�ra.
# Atliekant nat�ralios kalbos tekst� statistin� analiz�, did�iosios bei ma�osios
# raid�s da�niausiai taip pat neskiriamos, o kartais tiesiog reikia suvienodinti 
# raid�i� registr�. Tam naudojamos funkcijos toupper ir tolower.

# Pavyzd�iui, i� did�i�j� lietuvi�kos ab�c�l�s raid�i� vektoriaus gausime ma��j� 
# raid�i� vektori�.

RAID�S <- c("A", "�", "B", "C", "�", "D", "E", "�", 
            "�", "F", "G", "H", "I", "�", "Y", "J", 
            "K", "L", "M", "N", "O", "P", "R", "S", 
            "�", "T", "U", "�", "�", "V", "Z", "�")

raid�s <- tolower(RAID�S)
raid�s


# Jei vienus simbolius sekoje reikia pakeisti � kitus, naudojama funkcija chartr.
# Jos parametrai:
#
#        old -- kei�iam� simboli� seka,
#        new -- pakeist� simboli� seka,
#          x -- seka, kurioje atliekamas simboli� pakeitimas.

# Pavyzd�iui, �i� funkcij� galima panaudoti tuo atveju, kai visame tekste reikia 
# pakeisti vien� kok� nors neteisingai naudojam� simbol� � kit� simbol�. Tarkime,
# �inome, kad Bertrand Russell sakinyje vietoje simbolio "?" turi b�ti raid� "i".

citata <- "Ar�?aus? g?n�a? kyla tada, ka? n� v?ena �al?s netur? svar?� �rodym�."

chartr("?", "i", citata)


# Atskiru atveju galima pakeisti visas ab�c�l�s raides. Tada raid�s tekste lieka 
# savo vietose, bet pakei�ia savo tapatyb�, tod�l pradinis tekstas u��ifruojamas. 
# Toks �ifras vadinamas keitini� �ifru (substitution). Vienas seniausi� keitini�
# �ifras --- Cezario �ifras, kuriame kiekviena raid� kei�iama � raid�, stovin�i�
# ab�c�l�je trimis pozicijomis toliau. Cezario �ifro apibendrinimas --- post�mio
# �ifras (shift cipher), kuriame post�mis atliekamas per k raid�i�, 0 < k < n, o 
# n yra ab�c�l�s raid�i� skai�ius. Pavyzd�iui, u��ifruosime tekst� taikant toki� 
# papras�iausi� raid�i� keitimo taisykl�: 
#
#              a --> � --> b --> c --> � --> ... --> z --> � --> a              

tekstas <- "Jei jums atrodo, kad nieko nesupratote, tai tikriausiai taip ir yra."

old <- "a�bc�de��fghi�yjklmnoprs�tu��vz�"
new <- "�bc�de��fghi�yjklmnoprs�tu��vz�a"

chartr(old, new, tekstas)


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite komand�, kuri lietuvi�kas did�i�sias ir ma��sias raides pakeist� 
#    � atitinkamas lotyni�kas raides.
# 2. U�ra�ykite toki� komand�, kad duotas tekstas b�t� u��ifruotas Cezario �ifru.
#    Sugalvokite, kaip i��ifruoti taip u��ifruot� tekst�.


# --------------------------------------- #
# SUBSEKOS I�SKYRIMAS                     #
# --------------------------------------- #

# Pa�ym�kime n simboli� sek� L = s_1 s_2 ... s_n. Tada seka S = s_i ... s_j, kur
# 1 <= i <= j <= n, bus vadinama sekos L subseka (substring). Jeigu sekoje L yra
# tarp�, tai subseka S taip pat gali b�ti sudaryta vien i� tarp�, ta�iau subseka 
# negali b�ti tu��ia seka "". Atskirais atvejais gaunamos tokios subsekos: 
# 
#  prefiksas -- kai i = 1,
#   sufiksas -- kai j = n.

# R kalboje subsekos i�skyrimui arba jos keitimui naudojama funkcija substr. Jos 
# parametrai:
#
#          x -- pradin� simboli� seka arba sek� vektorius,
#      start -- i�skiriamos subsekos pirmojo simbolio eil�s numeris i,
#       stop -- i�skiriamos subsekos paskutinio simbolio eil�s numeris j.

# Parametr� start ir stop reik�m�s neb�tinai turi b�ti vienas skai�ius -- galima 
# priskirti ir skai�i� vektori�. Tada i� sekos bus i�skirtos kelios jos subsekos.


# Akrostichas - tai eiliuotas k�rinys, kurio eilu�i� pirmosios raid�s, skaitomos
# i� vir�aus � apa�i�, sudaro atskir� �od�. Antikin�je Graikijoje, Romoje ir net
# Viduram�iais buvo �prasta akrostichu �ra�yti autoriaus vard�. Kartais ne�inom�
# teksto autori� pavyksta identifikuoti pagal akrostich�. Pirma lietuvi�ka knyga
# taip pat turi akrostich� -- taip Martynas Ma�vydas lotyni�kai �ra�� savo vard� 
# MARTINUS MASVIDIUS, kuris, beje, buvo pasteb�tas tik XX am�iuje!

# I�nagrin�sime Vinco Kudirkos eil�ra�t� "M�sl�s". Eil�ra��io tekstas padalintas
# � atskiras eilutes. I� kiekvienos eilut�s i�skirsime pirm�j� jos raid�.

eil�ra�tis <- c("Dievas visad ant l�p�, o �irdyje velnias;",
                "Akis tuojau u�merkia i�vydusi kelnes;",
                "Vaik��ioja atsipl��us � ��adai mat toki;",
                "Atmintyje tik laiko, kur atlaidai koki",
                "Tur lie�uv� bjauresn� u� gyvat�s gyl�;",
                "Kasdien tupi ba�ny�ioj, nes tingin� myli.",
                "Atminki, kas tai b�t�, jei m�slius mint moki?")
eil�ra�tis

# Kadangi i� kiekvienos eilut�s reikia i�skirti po vien� raid�, funkcijos substr 
# parametr� start ir stop reik�m�s sutampa.

substr(eil�ra�tis, 1, 1)


# Sufiks� medis --- tai med�io pavidalo abstrakti duomen� strukt�ra, sudaryta i�
# vis� sekos L sufiks�. Jei seka L turi n simboli�, tada jos sufiks� medis tur�s 
# n numeruot� vir��ni� (lap�). Visos vidin�s vir��n�s, i�skyrus �akn�, turi bent 
# dvi briaunas (�akas). Kiekviena briauna pa�ymima simboli� seka, kuri yra sekos 
# L subseka, ta�iau i� tos pa�ios vir��n�s i�einan�ios briaunos negali prasid�ti 
# tuo pa�iu simboliu. Seka, kuri gaunama apjungus visas briaunas nuo �aknies iki
# vieno pasirinkto lapo, yra ka�kuris pradin�s sekos sufiksas. Pavyzd�iui, sekos 
# "susisuko" sufiks� medis atrodo taip:
#                                                  sufiksai
#                                                 ----------
#
#                               +---sisuko         susisuko
#                       +---u---|                  
#                       |       +---ko             suko
#               +---s---|                          
#               |       +---isuko                  sisuko
#      root: ---|                                  
#               |       +---sisuko                 usisuko
#               +---u---|                          
#               |       +---ko                     uko
#               |                                  
#               +---isuko                          isuko
#               |                                  
#               +---ko                             ko
#               |                                  
#               +---o                              o


# Yra keletas sufiks� med�io sudarymo algoritm�. Pirm� algoritm� 1973 m. pasi�l�
# Weiner, kur� 1976 m. supaprastino McCreight. Ukkonen 1995 m. pasi�l� greitesn�,
# bet ir sud�tingesn� algoritm�. Farach 1997 m. gavo optimal� visiems alfabetams 
# sufiks� med�i� sudarymo algoritm�.

# Sufiks� med�iai pla�iai naudojami bioinformatikoje ir kitose su teksto analize
# susijusiose srityse, kur reikia nustatyti, ar tam tikra seka S yra kitos sekos
# L subseka. Sufiks� med�io sudarymo algoritmai gana sud�tingi, tod�l �ia paties
# med�io nesudarin�sime, ta�iau sudarysime sekos L = "susisuko" sufiks� vektori�:

L <- "susisuko"
n <- nchar(seka)

S <- substring(L, 1:n, n)
S


# Vienas i� pagrindini� bioinformatikos tyrim� objekt� yra DNR ir baltym� sekos.
# DNR molekul� gali b�ti labai ilga. Pvz., tipinis bakterij� DNR sekos ilgis yra
# tarp 1 ir 10 mln. nukleotid�, �mogaus DNR seka ilgesn� nei 3 mlrd. nukleotid�.
# Da�niausiai nagrin�jama ne visa organizmo DNR seka, o tik tam tikra jos dalis.

# �inoma, kad DNR sekoje n�ra tarp� ar kit� nat�ralioms kalboms b�ding� skyrybos 
# �enkl�, tod�l seka skaitoma i�tisai. Sudaroma tokio paties ilgio subsek� seka, 
# kur pirmoji subseka prasideda pirmuoju sekos nariu, antroji - antruoju ir t.t. 
# Tokiu b�du gaunamas taip vadinamas slenkantis langas, kurio plotis k yra lygus
# slenkan�ios subsekos ilgiui. Kuo ma�esnis langas, tuo didesnis slenkan�i� sek� 
# arba taip vadinam� �od�i� skai�ius. Kra�tutiniu atveju, kai k = 1, tai gauname 
# atskir� pradin�s sekos simboli� sek�. 

# Pavyzd�iui, duotas DNR sekos fragmentas. Naudojant slenkant� lang�, sudarysime 
# �i� sek� sudaran�i� �od�i� i� k = 3 simboli� aib� ir gausime j� da�ni� lentel�.

dnr <- "GCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGCT"

n <- nchar(dnr)
k <- 3

w <- substring(dnr, 1:(n-k+1), k:n)
w

# Pagal �od�i� da�ni� pasiskirstym� galima spr�sti apie statistines sek� savybes.
# Kadangi DNR sekos alfabet� sudaro keturios raid�s, tai �od�i� i� trij� raid�i� 
# yra 4^3 = 64. Nagrin�jama DNR seka palyginus trumpa, tad did�ioji dalis �od�i� 
# �ioje sekoje pasirodo tik po vien� kart�, o kai kurie �od�iai visai nepasirodo. 
# Pavyzd�iui, sekoje n�ra �od�i� "ACA", "CCC" ir dar keletos kit�. 

table(w)


# Funkcija substr gali b�ti naudojama ir vienos subsekos pakeitimui � kit� tokio
# paties ilgio subsek�. Pavyzd�iui, turime fail� pavadinim� vektori�. Vis� fail�
# pavadinimai standartiniai ir vienodo ilgio. Pakeisime failo i�pl�tim� i� "txt"
# � "rez".

failai <- c("failas_01.txt", "failas_02.txt", "failas_03.txt", "failas_04.txt")

substr(failai, 11, 13) <- "rez"
failai

# �inoma, tokiam tikslui naudojama funkcija substr turi labai ribotas pritaikymo
# galimybes. Pavyzd�iui, �iuo atveju, jei fail� pavadinimai b�t� skirting� ilgi�, 
# kiekvienam pavadinimui reik�t� nustatyti vis kitokias indeks� reik�mes. �ymiai
# didesnes galimybes turi reguliarios i�rai�kos (regular expressions).


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite komand�, kuri sudaryt� absoliu�iai vis� sekos L subsek� vektori�
#    ir nustatykite j� skai�i�.
# 2. U�ra�ykite komand�, kuri pirm�j� vis� vieno sakinio �od�i� raid� pakeist� � 
#    atitinkam� did�i�j� raid�.
# 3. U�ra�ykite komand�, kuri DNR sek� suskaidyt� � nepersikertan�ius �od�ius i�
#    k = 10 simboli�.


# --------------------------------------- #
# SEKOS I�SKAIDYMAS � ATSKIRAS DALIS      #
# --------------------------------------- #

# Vienas i� tipini� ir da�nai atliekam� veiksm� --- sekos suskaidymas � atskiras
# dalis. Pavyzd�iui, sakin� galima suskaidyti � atskirus �od�ius ar net atskirus
# simbolius. Tekstiniu formatu u�ra�yt� dat� galima i�skaidyti � metus, m�nesius
# ir dienas ir t. t. �is suskaidymas primena subsekos i�skyrim�, bet �iuo atveju
# laikoma, kad sekos dalys atskirtos tam tikru simboliu ar j� kombinacija. Pvz.,
# sakinyje �od�iai vienas nuo kito atskirti tarpo simboliu, atskiros datos dalys
# atskiriamos arba br�k�neliu, arba ta�ku.

# R kalboje sekos skaidymui � atskiras dalis naudojama f-ja strsplit. Parametrai:
#
#          x -- seka arba sek� vektorius,
#      split -- simbolis arba j� seka, pagal kuri� skaidoma pradin� seka,
#      fixed -- loginis, FALSE nurodo, kad split yra ne reguliari i�rai�ka.


# Pavyzd�iui, duota kableliais vienas nuo kito atskirt� olimpiadini� �od�i� seka. 
# �i� sek� reikia i�skaidyti � atskirus �od�ius.

�od�iai <- "b�la, g�sta, gv�ra, kr��ta, s�la, ��la, ���ta, t��ta, tr��ta"
�od�iai

# Galima pasteb�ti, kad �ioje sekoje �od�iai atskirti ne tik kableliais, bet dar
# ir tarpais, tod�l parametrui split nurodome simboli� sek� ", ".

strsplit(�od�iai, split = ", ")

# Funkcijos strsplit rezultatas yra list tipo s�ra�as. Tai nelabai patogu, jeigu
# skaidome vien� sek�, bet labai patogu, jei � atskiras dalis skaidomos i� karto
# kelios sekos. Tada gauname s�ra��, kuris turi tiek element�, kiek yra pradini�
# sek�. S�ra�o elementai yra vektoriai, kuri� elementai yra atskiros sek� dalys.
# Pavyzd�iui, duotas Vilniaus greit�j� autobus� mar�rut� vektorius. I�skaidysime
# �iuos mar�rutus � atskiras dalis, kurios viena nuo kitos atskirtos br�k�neliu.

mar�rutai <- c("Stotis-Kalvarij� g.-Santari�k�s",
               "Santari�k�s-Laisv�s pr.-Stotis",
               "Fabijoni�k�s-Centras-Oro uostas",
               "Pilait�-Konstitucijos pr.-Saul�tekis",
               "Pa�ilai�iai-Ozo g.-Saul�tekis",
               "Parko-Oland� g.-�aliasis tiltas")

strsplit(mar�rutai, split = "-")


# Parametro split reik�m� yra reguliari i�rai�ka - tai tokia simboli� seka, kuri
# leid�ia u�ra�yti tam tikr� sekos �ablon�. Reguliarios i�rai�kos naudoja dviej�
# tip� simbolius: simbolius, kurie interpretuojami tiesiogiai, ir metasimbolius,
# kurie turi speciali� prasm�. Kokie simboliai yra metasimboliai - priklauso nuo
# reguliari� i�rai�k� standarto. R naudojamas i�pl�stas reg. i�rai�k� standartas
# ERE, kuriame metasimboliai yra
#
#                            . \ | ( ) [ { ^ $ * + ? 
#
# Jei metasimbol� reikia naudoti kaip simbol�, prie� j� ra�omas valdymo simbolis. 
# Pavyzd�iui, R reguliarioje i�rai�koje skliaustai () u�ra�omi \\( \\).

# Tuo atveju, kada parametrui split priskiriama seka turi b�ti interpetuojama ne 
# kaip reguliari i�rai�ka, parametrui fixed priskiriama login� reik�m� TRUE. Tai
# nurodo, kad visi metasimboliai bus suprantami, kaip paprasti simboliai.

# Pavyzd�iui, reikia i�skaidyti tekstiniu formatu u�ra�ytas datas. Datoje metai,
# m�nuo ir diena vienas nuo kito atskirti ta�ku.

#          Saul�s        Durb�s        �algirio      Or�os         Salaspilio
#         ------------  ------------  ------------  ------------  ------------ 
data <- c("1236.09.22", "1260.07.13", "1410.07.15", "1514.09.08", "1605.09.27")
data

# Reguliariose i�rai�kose ta�kas yra metasimbolis, kuris nurodo bet kok� simbol�,
# tarp j� ir pat� ta�k�, tod�l datos bus i�skaidytos pagal skai�ius ir ta�kus, o 
# rezultatas bus tu��ios sekos.

strsplit(data, ".")

# Kad "." b�t� interpretuojamas kaip ta�kas, pakei�iame parametro fixed reik�m�.

strsplit(data, ".", fixed = TRUE)

# Naudojant valdymo simbol�, ta�k� galima u�ra�yti ir kaip reguliari� i�rai�k�.

strsplit(data, "\\.")


# NAUDINGA ------------------------------

# Naudojant reguliarias i�rai�kas, sud�ting� taisykl�, pagal kuri� skaidoma seka,
# galima u�ra�yti gana kompakti�kai. Pavyzd�iui, seka gali b�ti skaidoma � dalis 
# ne pagal vien� konkret� simbol�, bet i� karto pagal du alternatyvius simbolius. 
# Alternatyvos reguliariose i�rai�kose apjungiamos simboliu |. 

# Pavyzd�iui, duotas vektorius su Vilniaus, Rygos ir Talino miest� koordinat�mis. 
# �ias koordinates reikia i�skaidyti � laipsnius, minutes ir platum� arba ilgum� 
# nurodan�ius simbolius. Galima pasteb�ti, kad platuma ir ilguma atskirtos tarpu, 
# o laipsniai ir minut�s turi savo simbolius, tod�l �iuo atveju i� viso bus trys 
# alternatyv�s simboliai, pagal kuriuos � atskiras dalis skaidoma kiekviena seka.

koordinat�s <- c(Vilnius = "54�41'N 25�17'E", 
                    Riga = "56�56'N 24�06'E", 
                 Tallinn = "59�26'N 24�44'E")

strsplit(koordinat�s, "�|'| ")
strsplit(koordinat�s, "[�' ]")


# Jei seka � atskiras dalis skaidoma pagal bent vien� kart� pasirodant� konkret� 
# simbol�, tai toki� sek� �ablon� galima u�ra�yti naudojant metasimbol� +, kuris
# nurodo, jog prie� j� stovintis simbolis sekoje pasirodo vien� ar daugiau kart�.

serijos <- "1---1--1-1111---1111---11-11-1-111-111-----1-11-----1--1-1-----1-11"

strsplit(serijos, "-+")


# NAUDINGA ------------------------------

# Tekstinio formato failuose gali b�ti saugomi labai �vair�s duomenys. Pvz., tai
# gali b�ti paprastas tekstas, DNR seka, programos kodas, duomen� lentel� ir pan. 
# Kad duomenys i� failo b�t� nuskaitomi korekti�kai, kiekvienu atveju naudojamas 
# tam tikras tekstini� duomen� saugojimo formatas. Vienas i� universali� duomen� 
# lenteli� u�ra�ymo format� yra CSV (Comma-Separated Values). Kintam�j� reik�m�s 
# stulpeliuose atskiriamos kableliu arba kabliata�kiu.

# Pavyzd�iui, duotas failas su artimiausi� met� saul�s u�temim� duomenimis. Data,
# laikas, u�temimo tipas, ry�kumas, trukm� ir koordinat�s atskirtos kabliata�kiu.

failas <-  
"2015-03-20;09:46:47;Total;1.045;2:47;64.4�N;6.6�W
2016-03-09;01:58:19;Total;1.045;4:09;10.1�N;148.8�E
2016-09-01;09:08:02;Annular;0.974;3:06;10.7�S;37.8�E
2017-02-26;14:54:33;Annular;0.992;0:44;34.7�S;31.2�W
2017-08-21;18:26:40;Total;1.031;2:40;37.0�N;87.7�W
2019-07-02;19:24:08;Total;1.046;4:33;17.4�S;109.0�W
2019-12-26;05:18:53;Annular;0.970;3:40;1.0�N;102.3�E
2020-06-21;06:41:15;Annular;0.994;0:38;30.5�N;79.7�E
2020-12-14;16:14:39;Total;1.025;2:10;40.3�S;67.9�W
2021-06-10;10:43:07;Annular;0.943;3:51;80.8�N;66.8�W
2021-12-04;07:34:38;Total;1.037;1:54;76.8�S;46.2�W
2023-04-20;04:17:56;Hybrid;1.013;1:16;9.6�S;125.8�E
2023-10-14;18:00:41;Annular;0.952;5:17;11.4�N;83.1�W
2024-04-08;18:18:29;Total;1.057;4:28;25.3�N;104.1�W
2024-10-02;18:46:13;Annular;0.933;7:25;22.0�S;114.5�W
2026-02-17;12:13:06;Annular;0.963;2:20;64.7�S;86.8�E
2026-08-12;17:47:06;Total;1.039;2:18;65.2�N;25.2�W
2027-02-06;16:00:48;Annular;0.928;7:51;31.3�S;48.5�W
2027-08-02;10:07:50;Total;1.079;6:23;25.5�N;33.2�E
2028-01-26;15:08:59;Annular;0.921;10:27;3.0�N;51.5�W
2028-07-22;02:56:40;Total;1.056;5:10;15.6�S;126.7�E
2030-06-01;06:29:13;Annular;0.944;5:21;56.5�N;80.1�E
2030-11-25;06:51:37;Total;1.047;3:44;43.6�S;71.2�E"

# Prisijungimui prie virtualaus tekstinio failo naudojame f-j� textConnection, o
# eilu�i� nuskaitymui naudojame funkcij� readLines. Taip gauname vektori�, kurio 
# elementai eilu�i� simboli� sekos. Toki� sek� yra tiek, kiek faile yra eilu�i�.

eilut�s <- readLines(textConnection(failas))
eilut�s

# CSV faile reik�m�s eilut�se atskirtos kabliata�kiu. Pagal j� sek� suskaidome � 
# atskiras dalis.

eclipses <- strsplit(eilut�s, ";")
print(eclipses, quote = FALSE)


# Paprastai duomen� lentel�s nuskaitymui i� tekstinio failo naudojama tam skirta
# funkcija read.table. Ji turi parametr� sep, per kur� ir nurodoma reik�m�, kuri
# atskiria reik�mes lentel�s stulpeliuose.

read.table(textConnection(failas), sep = ";")


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite komand�, kuri sudaryt� simboli� pasirodymo tekste da�ni� lentel�.
#
# 2. U�ra�ykite komand�, kuri sakin� i�skaidyt� � atskirus �od�ius bei nustatyt�
#    kiekvieno �od�io ilg�.
# 3. Tarkime, kad vis� sakini� pabaig� tam tikrame tekste �ymi ta�kas, �auktukas 
#    arba klaustukas, o po �i� �enkl� visada prasideda naujas sakinys (realyb�je, 
#    �inoma, taip yra nevisada). U�ra�ykite komand�, kuri nustatyt�, kiek �od�i� 
#    yra kiekviename duoto teksto sakinyje.
# 4. Sugalvokite toki� komand�, kuri nuskaityt� kabliata�kiais atskirt� vektori� 
#    elementus, kurie vienas nuo kito atskirti kableliais. Pvz., tokia seka turi
#    4 vektorius: "1.2, 4.9, 3.1; 8.6, 7.4; 2.5, 1.2, 8.2, 1.8; 0.5". Rezultatas
#    turi b�ti s�ra�as i� 4 element�, kuri� elementai yra vektori� reik�m�s.
