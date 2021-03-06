
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Skai�i� ir teksto formatavimo funkcijos.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2016-03-29 | 2016-04-19
#


# TURINYS -------------------------------

#
#   1. Skai�i� ir teksto formatavimas:
#      * funkcija formatC
#      * funkcija prettyNum
#      * funkcija sprintf
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
# TRUMPAI APIE TEKSTO FORMATAVIM�         #
# --------------------------------------- #

# Labai da�nai skai�iavim� rezultatus reikia �terpti � tekst�, kuris i�vedamas �
# ekran� ar tekstin� fail�. �vairaus tipo reik�mi�, suformatuot� pagal tam tikr�
# i� anksto nustatyt� �ablon�, i�vedimas � ekran� ar kitus �renginius, vadinamas 
# formatuotu spausdinimu. Daugelis programavimo kalb� �iam tikslui turi funkcij�
# printf (print formatted), kurios standartas susiformavo C kalboje, o R kalboje
# �iam tikslui naudojama funkcijos printf atmaina sprintf. �i f-ja skai�i� �deda 
# � teksto �ablon� ir tok� formatuot� tekst� gr��ina kaip simboli� sek�.

# Skai�i� atvaizdavimui R dar turi funkcijas formatC, prettyNum, kurios taip pat
# naudoja �i� i� C kalbos at�jusi� formatavimo tradicij�.


# --------------------------------------- #
# SKAI�I� FORMATAVIMAS                    #
# --------------------------------------- #

# Atskirai skai�i� formatavimui, naudojant C kalboje priimt� sintaks�, naudojama 
# funkcija formatC. Jos parametrai:
#
#                x -- reali� skai�i� vektorius,
#           digits -- reik�ming� skaitmen� skai�ius,
#            width -- skai�iui u�ra�yti skirt� simboli� skai�ius,
#           format -- skai�iaus u�ra�ymo formatas,
#             flag -- papildomos skai�iaus formatavimo priemon�s, 
#         big.mark -- sveikosios dalies skaitmen� grupavimo simbolis,
#       small.mark -- trupmenin�s dalies skaitmen� grupavimo simbolis, 
#     big.interval -- skaitmen� grup�s sveikojoje dalyje dydis,
#   small.interval -- skaitmen� grup�s trupmenin�je dalyje dydis,
#     decimal.mark -- sveikosios ir trupmenin�s dalies atskyrimo simbolis,
#   preserve.width -- skai�i� su grupuotais skaitmenimis formatavimo taisykl�,
#       zero.print -- loginis, nurodo, ar rodyti nulines vektoriaus reik�mes, 
#    drop0trailing -- loginis, nurodo, ar rodyti nulius u� reik�mini� skaitmen�.


c <- 299792458L       # �viesos greitis
e <- 2.718281828      # Oilerio konstanta
m <- 9.109383561e-31  # elektrono mas�
L <- 6.022140857e+23  # Avogadro skai�ius

# Bet kur� skai�i� galima u�ra�yti keliais skirtingais formatais. Pvz., sveik�j�
# skai�i� 1000 galima u�ra�yti kaip real�j� skai�i� 1000.0 ar eksponentine forma
# (scientific format) kaip 1.0000e+03. Skai�iaus u�ra�ymo format� nustato format
# parametras. Pagrindin�s jo reik�m�s tokios:
#
#          "d" -- sveikiesiems skai�iams,
#          "f" -- realiesiems skai�iams, xx.xxxx,
#          "e" -- scientific format, x.xxxe+nn,
#          "E" -- scientific format, x.xxxE+nn,
#          "s" -- simboli� sekai.

# Be �i� reik�mi�, dar yra "g" ir "G", kurios nurodo, kad skai�ius bus u�ra�omas
# atitinkamai "e" arba "E" formatu, jei �iuo formatu jis u�ra�omas trumpiau. Dar
# yra reik�m� "fg", kuri nurodo, kad skai�ius bus u�ra�ytas "f" formatu --- kaip
# realus skai�ius, ta�iau reik�ming� skaitmen� skai�ius bus toks, koks nurodytas
# parametru digits, tod�l sveikieji skai�iai, kuriems parametras digits = 0, bus
# ra�omi be trupmenin�s dalies. Pagal nutyl�jim� sveikiesiems skai�iams formatas
# yra "d", o realiesiems skai�iams -- "g".

# Parametras digits nurodo arba norim� skaitmen� skai�i� po kablelio, kai format
# parametro reik�m� yra "f", arba reik�ming� skaitmen� skai�i�, kai formatas yra 
# "e", "g" arba "fg". Pagal nutyl�jim� realiesiems skai�iams digits = 4.

# Parametras width nustato skai�iui u�ra�yti skirtos simboli� sekos ilg�. Jei jo
# reik�m� nenurodoma, tada automati�kai width = digits + 1. Jeigu width = 0, tai 
# simboli� skai�ius lygus parametro digits reik�mei.


# Panagrin�sime, kaip galima atvaizduoti didel� sveik�j� skai�i�. Tegul tai b�na
# c raide �ymimas �viesos greitis vakuume. PASTABA! Sveikieji skai�iai R kalboje 
# ra�omi su simboliu L gale. Prie�ingu atveju laikoma, kad skai�ius yra realusis.

class(299792458L)
class(299792458)

# Nuo skai�iaus klas�s priklauso tai, kokiu formatu tas skai�ius atvaizduojamas. 
# Pvz., jei nenurodome formato, vienu atveju tas pats skai�ius vaizduojamas kaip
# sveikasis, kitu atveju --- standartine skai�iaus i�rai�ka (scientific format).

#       123456789
#       ||||||||| 
formatC(299792458L)
formatC(299792458)

# Jeigu parametrui priskiriame reik�m� "f", tai sveikasis skai�ius bus u�ra�ytas
# kaip realusis. Jei parametro reik�m� "e", skai�ius u�ra�omas standartine forma
# su 4 reik�miniais skaitmenimis. Parametro format reik�m� "fg" nurodo, kad toks
# sveikasis skai�ius tur�t� b�ti u�ra�omas kaip realusis, bet kadangi reik�mini� 
# skaitmen� skai�ius digits sveikiesiems lygus nuliui, trupmenin� dalis nerodoma.

formatC(299792458L, format = "f")
formatC(299792458L, format = "e")
formatC(299792458L, format = "fg")

# �iam skai�iui u�ra�yti reikia 9 skaitmen�. Jei parametro width reik�m� ma�esn� 
# u� 9, skai�ius vis tiek bus u�ra�omas naudojant 9 simbolius. Ta�iau jam galima
# skirti ir daugiau simboli�. Tada skai�ius bus lygiuojamas pagal de�ini�j� pus�.

formatC(299792458L, width = 2)
formatC(299792458L, width = 12)

# Jeigu sveikasis skai�ius u�ra�omas kaip realusis, bet parametro digits reik�m�
# nenurodoma, tada jis u�ra�omas su 4 reik�miniais skaitmenimis po kablelio. Tai
# galima pakeisti priskiriant parametrui digits kit� reik�m�.

formatC(299792458L, format = "f")
formatC(299792458L, format = "f", digits = 1)
formatC(299792458L, format = "e", digits = 1)

# Kombinuojant �i� trij� pagrindini� parametr� reik�mes, skai�i� galima u�ra�yti
# labai �vairiai. Pavyzd�iui, skai�iui u�ra�yti skirsime 20 simboli�. U�ra�ysime 
# j� vienu atveju, kaip sveik�j� skai�i�, o kitu - kaip real�j� skai�i� su dviem 
# reik�miniais skai�iais po kablelio.

formatC(299792458L, format = "d", width = 20)
formatC(299792458L, format = "f", width = 20, digits = 2)


# Panagrin�sime, kaip galima atvaizduoti labai ma�� real�j� skai�i�. Pavyzd�iui,
# tegul tai b�na elektrono mas� m. Kadangi m realusis skai�ius, pagal nutyl�jim�
# parametro format reik�m� yra "g", vadinas, jis vaizduojamas standartine forma.
# Jeigu toks realusis skai�ius u�ra�omas kaip sveikasis, jis bus rodomas kaip 0.
# Jei parametro format reik�m� "f", tada pagal nutyl�jim� rodomi pirmieji keturi 
# reik�miniai skaitmenys, kurie �iuo atveju visi lyg�s nuliui. Nurod�ius format�
# "fg", skai�ius u�ra�omas taip, kad b�t� matomi keturi reik�miniai skaitmenys.

formatC(m)
formatC(m, format = "g")
formatC(m, format = "e")
formatC(m, format = "d")
formatC(m, format = "f")
formatC(m, format = "fg")

# Norint pamatyti vis� skai�i�, papildomai reik�t� nurodyti reik�mini� skaitmen�
# skai�i�. �iuo atveju j� yra 10.

formatC(m, format = "fg", digits = 10)

# PASTABA! Jeigu reik�mini� skaitmen� skai�ius nurodomas didesnis, nei j� yra i�
# tikro, skai�iuje atsiranda papildomi skaitmenys, kuri� netur�t� b�ti. Taip yra
# d�l slankiojo kablelio skai�i� aritmetikos paklaid�, nes kompiuterio atmintyje 
# skai�iui u�ra�yti skiriamas tam tikras fiksuotas bit� kiekis (32 ar 64), kurio 
# neu�tenka skai�iui i�reik�ti. Tai galioja ir labai dideliems, ir labai ma�iems
# skai�iams. Pavyzd�iui, skai�iui m nurodysime 20 reik�mini� skai�i�, kurie visi 
# bus rodomi, nors i� tikro reik�mini� skai�i� �iuo atveju yra tik 10.

formatC(m, format = "fg", digits = 20)

# Jeigu skai�ius n�ra labai didelis arba labai ma�as, o parametro digits reik�m�
# vir�ija tikr�j� reik�mini� skaitmen� skai�i�, tai skai�iaus gale yra prira�omi 
# nuliai (trailing zeros). Pavyzd�iui, konstanta e �ia u�ra�yta su 10 reik�mini� 
# skai�i�. Atvaizduokime j� su 15 reik�mini� skai�i�.

formatC(e, format = "f", digits = 15)

# Loginis parametras drop0trailing nustato, kad galima nerodyti nuli�, kurie yra
# ra�omi u� reik�mini� skai�i�. Taigi, nors parametras digits vir�ija reik�mini�
# skaitmen� skai�i�, nuliai gale jau nebus ra�omi.

formatC(e, format = "f", digits = 15, drop0trailing = TRUE)


# Kadangi, naudojant funkcij� formatC, skai�ius atvaizduojamas kaip tekstas, yra
# galimyb� pritaikyti papildomas teksto formatavimo priemones: skai�i� ra�yti su 
# �enklu, pakeisti lygiavim� ir k.t. Tam skirtas parametras flag, kurio reik�m�s
# gali b�ti tokios:
#
#          "0" -- skai�iaus prad�ioje bus ra�omi nuliai,
#          "+" -- skai�ius ra�omas su �enklu,
#          "-" -- i�lygiavimas pagal kair�,
#          " " -- jei pirmas simbolis ne �enklas, tada dedamas tarpas,
#          "#" -- alternatyvus spausdinimas, priklauso nuo formato.

# Sudarant kodus ar eil�s numerius, patogumo d�lei skai�iaus prad�ioje gali b�ti 
# ra�omi nuliai. Pavyzd�iui, i� sveik�j� skai�i� sekos 1, 2, ..., 100 sudarysime 
# 3-j� simboli� ilgio kodus.

formatC(1:100, flag = "0", width = 3)

# Jei parametro width reik�m� didesn� u� skai�iaus skaitmen� skai�i�, tada pagal
# nutyl�jim� skai�ius bus lygiuojamas pagal de�in�j� kra�t�. Tai galima pakeisti
# parametrui flag priskyrus reik�m� "-".

formatC(1:100, flag = "-", width = 3)

# Kai kada svarbu nurodyti skai�iaus �enkl�. Pvz., tai gali b�ti temperat�ros ar
# ekonomini� rodikli� poky�iai laike. Tokiu atveju parametrui flag nurodome "+".
# Pavyzd�iui, duotas Vilniaus miesto kiekvieno m�nesio �emiausi� oro temperat�r�
# s�ra�as (E. Rimkus, 2013). Pavaizduosime �ias temperat�ras su �enklu.

#        Sau.   Vas.  Kov.  Bal.  Geg.  Bir.  Lie.  Rug.  Rgs.  Spa.  Lap.   Grd.
#       -----  ----- ----- ----- ----- ----- ----- ----- ----- ----- -----  -----
t <- c(-20.5, -16.3, -9.4, -0.1,  5.9, 10.4, 12.9, 13.2,  8.1,  0.4, -7.7, -19.0)

formatC(t, flag = "+")
formatC(t, flag = "+", format = "f", digits = 1)

# Papildomai galima nurodyti, kad skai�iams pavaizduoti b�t� naudojamas vienodas
# simboli� skai�ius. Skai�i�, kurie turi ma�iau skaitmen�, prad�ioje bus dedamas 
# tarpas.

formatC(t, flag = "+", format = "f", digits = 1, width = 5)

# Jeigu sekoje yra ir teigiam�, ir neigiam� skai�i�, ta�iau teigiamiems nurodyti
# �enkl� neb�tina, vietoje jo galima palikti tarp�. Tai nurodoma parametrui flag 
# priskiriant reik�m� " ".

formatC(t, flag = " ")
formatC(t, flag = " ", format = "f", digits = 1)
formatC(t, flag = " ", format = "f", digits = 1, width = 5)


# Pagal lietuvi� kalbos taisykles, sveikoji de�imtain�s trupmenos dalis skiriama
# kableliu, ta�iau kitose kalbose, o taip pat ir programavimo kalbose, paprastai 
# tam naudojamas ta�kas. Tai, koks simbolis naudojamas u�ra�ant skai�i�, nustato 
# parametras decimal.mark. U�ra�ysime temperat�r� reik�mes pagal lietuvi� kalbos 
# taisykles.

formatC(t, decimal.mark = ",")
formatC(t, decimal.mark = ",", format = "f", digits = 1)


# Labai didelius arba labai ma�us skai�ius, jei jie neu�ra�yti standartine forma, 
# vizualiai nelengva suvokti. Patogumo d�lei, toki� skai�i� skaitmenys gali b�ti 
# grupuojami, taip atskiriant �imt�, t�kstan�i�, milijon� ir t.t. eil�. Funkcija
# formatC �iam tikslui turi tokias dvi parametr� poras:
#
#                  sveikosios dalies           trupmenin�s dalies
#                  ----------------            ----------------
#                  big.mark                    small.mark 
#                  big.interval                small.interval

# Pirmoji pora nustato sveikosios skai�iaus dalies skaitmen� grupavimo taisykl�, 
# antroji - trupmenin�s dalies skaitmen� grupavimo taisykl�. Parametrai big.mark
# ir small.mark nurodo simbol�, kuriuo atskiriamos skaitmen� grup�s, o parametro
# big.interval arba small.interval reik�m� yra sveikasis skai�ius, kuris nurodo, 
# kas kiek skaitmen� skai�iuje dedamas skyriklis. Pvz., sugrupuosime skai�iaus c
# skaitmenis grup�mis po 3.

formatC(c, format = "fg", big.mark = "'")

# Pavyzd�iui, Avogadro skai�ius labai didelis, tod�l jo skaitmenis suskirstysime 
# � grupes po 10 skaitmen�. Taip i� karto matosi, kad skai�iaus eil� n > 20.

formatC(L, format = "fg", big.mark = "'", big.interval = 10)

# Analogi�kai sugrupuojami labai ma�o realiojo skai�iaus skaitmenys po kablelio.
# Pavyzd�iui, tokiu b�du u�ra�ysime elektrono mas� m. I� karto matome, kad yra 6 
# tokios grup�s, vadinasi mas�s m eil� ne ma�iau kaip -30.

formatC(m, format = "fg", small.mark = " ")

# Grupuojant skaitmenis padid�ja skai�iui u�ra�yti reikaling� simboli� skai�ius.
# Jeigu reikia, kad tokiems skai�iams u�ra�yti reikaling� simboli� skai�ius b�t� 
# vienodas, parametro preserve.width reik�m� kei�iama i� "individual" � "common".
# Pavyzd�iui, duotas tam tikr� Fibonacci sekos nari� vektorius. Sugrupuosime �i�
# skai�i� skaitmenis po 3 i�laikant t� pat� bendr� simboli� skai�i�.

#      10    20      30         40           50             60               70
#      --  ----  ------  ---------  -----------  -------------  ---------------
F <- c(55, 6765, 832040, 102334155, 12586269025, 1548008755920, 190392490709135) 

F.format <- formatC(F, format = "fg", big.mark = "'", preserve.width = "common")
F.format

# �itoks skai�i� i�lygiavimas pasimato, kai juos atspausdiname po vien� eilut�je.
# Tam galima panaudoti funkcij� cat.

cat(F.format, sep = "\n")


# Jeigu nulin�ms reik�m�ms formatas neturi b�ti nustatomas, parametro zero.print 
# reik�m� pakei�iama � FALSE. Tada vietoje nulio bus rodoma tarp� seka. Tai gali
# b�ti naudinga tuo atveju, kai sekoje yra daug nuli�, kuriuos galima ignoruoti.

z <- c(0, 1.1, -1.0, 0, -1.7, 1.2, 0, -1.3, 0, 1.5, 0, 1.2, 0, 0, 0, 0, 0, -1.2)

formatC(z, format = "f", zero.print = FALSE)
formatC(z, format = "f", zero.print = FALSE, digits = 1)


# NAUDINGA ------------------------------

# Skai�i� formatavimui gali b�ti naudojama ir funkcija prettyNum. Ji turi ma�iau 
# galimybi�, bet labai pana�i � funkcij� formatC. Jos parametrai:
#
#                x -- skai�i� vektorius,
#         big.mark -- sveikosios dalies skaitmen� grupavimo simbolis,
#       small.mark -- trupmenin�s dalies skaitmen� grupavimo simbolis, 
#     big.interval -- skaitmen� grup�s sveikojoje dalyje dydis,
#   small.interval -- skaitmen� grup�s trupmenin�je dalyje dydis,
#     decimal.mark -- sveikosios ir trupmenin�s dalies atskyrimo simbolis,
#   preserve.width -- skai�i� su grupuotais skaitmenimis formatavimo taisykl�,
#       zero.print -- loginis, nurodo, ar rodyti nulines vektoriaus reik�mes, 
#    drop0trailing -- loginis, nurodo, ar rodyti nulius u� reik�mini� skaitmen�,
#         is.cmplx -- loginis, nurodo, ar skai�ius x yra kompleksinis.

prettyNum(c, big.mark = "'")      # grupuojame skaitmenis
prettyNum(t, decimal.mark = ",")  # ta�k� pakei�iame � kablel�
prettyNum(z, zero.print = FALSE)  # nerodomi nuliai


# U�DUOTIS ------------------------------ 

# 1. �viesos greit� c = 299792458 m/s u�ra�ykite standartine skai�iaus i�rai�ka.
#    Skai�ius turi b�t� vaizduojamas su trimis skaitmenimis po kablelio.
# 2. U�ra�ykite komand�, kuri sukurt� sunumeruot� fail� sek� pagal tok� �ablon�: 
#    failas_001.txt, failas_002.txt, ..., failas_100.txt.
# 3. Merseno pirminiai skai�iai i�rei�kiami formule M = 2^p - 1, kur p taip pat
#    pirminis. Did�iausias �iuo metu �inomas pirminis skai�ius tuo pa�iu yra ir
#    Merseno pirminis skai�ius su parametru p = 74207281. Jis turi net 22338618 
#    skaitmen� ir sutrumpintai �ymimas M74207281. Ma�esni Merseno skai�iai taip
#    pat yra dideli, pavyzd�iui, M127 = 170141183460469231731687303715884105727, 
#    jo parametras p = 127. Naudojant funkcij� formatC, skai�i� M127 u�ra�ykite 
#    suskirstydami skaitmenis � grupes, kad i� to b�t� galima lengvai vizualiai
#    nustatyti j� skai�i�.


# --------------------------------------- #
# TEKSTO FORMATAVIMAS SU FUNKCIJA SPRINTF #
# --------------------------------------- #

# Kalbant grie�tai, funkcija sprintf tam tikr� duomen� sraut� pertvarko pagal i�
# anksto u�duot� format� ir gr��ina simboli� sek�. Jos parametrai:
#
#          fmt -- formatuoto teksto �ablonas,
#          ... -- � �ablon� �statomos reik�m�s.

# Parametras fmt --- tai pagal specialias taisykles u�ra�ytas teksto �ablonas, �
# kur� �statomos nustatyta tvarka i�vardyt� kintam�j� reik�m�s. I� esm�s fmt yra
# simboli� seka, kurioje yra dviej� r��i� objektai: tai �prasti simboliai, kurie
# � i�vedam� simboli� sek� nukopijuojami taip, kaip u�ra�yti, ir formatai, kurie
# nurodo, kaip turi b�ti pertvarkytos i�vardint� kintam�j� reik�m�s.

# Kad b�t� lengviau �sivaizduoti, i� prad�i� u�ra�ysime �ablon� be joki� format�:
#
#                       "Atstumas nuo {} iki {} yra {} km."
#
# �iuo atveju riestiniai skliaustai nurodo viet� tekste, kur galima �statyti tam
# tikr� reik�m�. Pavyzd�iui, jei kalbama apie atstumus tarp miest�, tai pirmieji
# skliaustai nurodo vieno miesto pavadinim�, antrieji --- kito miesto pavadinim�, 
# o vietoje tre�i�j� skliaust� ra�omas tam tikras skai�ius, kuris nurodo atstum� 
# tarp �i� miest� kilometrais.

# Visi formatai prasideda simboliu "%", o u�sibaigia viena raide, kuri ir nurodo 
# konkret� kintamojo atvaizdavimo reik�m�s format�:
#
#         i, d -- sveikasis skai�ius arba login� reik�m�,
#            o -- a�tuntainis skai�ius,
#         x, X -- �e�ioliktainis skai�ius,
#            f -- realus skai�ius, "[-]mmm.ddd",
#         e, E -- standartin� skai�iaus forma, "[-]m.ddde[+-]xx",
#         g, G -- atitinka %e ir %E, jei eksponent� < -4, kitu atveju %f,
#            s -- simboli� seka,
#            % -- i�vedamas simbolis "%".


# Pavyzd�iui, suformuosime �ablon� atstumui tarp dviej� miest� u�ra�yti. Tarkime, 
# kad miestus �ymi raid�s A ir B, o atstumas tarp j� lygus d. Tada �ablonas toks:
#
#                       "Atstumas nuo A iki B yra d km."
#
# �iuo atveju A ir B yra miest� pavadinimai, vadinasi j� formatas %s, o atstumas
# h sveikas skai�ius, tod�l �ios reik�m�s formatas %i. Gauname �tai tok� �ablon�:
#
#                      "Atstumas nuo %s iki %s yra %i km."                      
#
# Tarkime, kad vienas miestas yra Skuodas, o kitas - Druskininkai. Atstumas tarp
# j� 349 kilometr�. � f-j� sprintf �ra�ome �ablon�, tada reik�mes sura�ome tokia 
# tvarka, kokia jos turi b�ti �statytos � �ablon�.

#                     �ablonas                          reik�m�s         
#       |---------------------------------|  |---------------------------|
#                     1      2      3            1           2         3
sprintf("Atstumas nuo %s iki %s yra %i km.", "Skuodo", "Druskinink�", 349)


# Jeigu � �ablon� �statomos reik�m�s gali keistis, tai � funkcij� sprintf geriau
# sura�yti kintamuosius, kuriems tos reik�m�s bus priskiriamos.

�ablonas <- "Atstumas nuo %s iki %s yra %i km."

A <- "Skuodo"
B <- "Druskinink�"
d <- 349

sprintf(�ablonas, A, B, d)

# T� pat� �ablon� galima naudoti ir kitiems atstumams, pavyzd�iui, tarp �em�s ir
# M�nulio, u�ra�yti. �iuo atveju funkcijos sprintf i�rai�ka nesikei�ia, kei�iasi
# tik kintam�j� reik�m�s.

A <- "�em�s"
B <- "M�nulio"
d <- 384400

sprintf(�ablonas, A, B, d)


# U�ra�ant reik�m�s format�, standartin� formatavimo taisykl� galima pakoreguoti 
# tarp "%" ir format� nurodan�ios raid�s �ra�ant papildom� simbol�. Galimi tokie
# variantai:
#
#          m.n -- m nurodo bendr� simboli� skai�i�, o n nurodo tikslum�
#            0 -- skai�iaus prad�ioje bus ra�omi nuliai,
#            + -- skai�ius ra�omas su �enklu,
#            - -- i�lygiavimas pagal kair�,
#          " " -- jei pirmas simbolis ne �enklas, tada dedamas tarpas,
#            # -- alternatyvus spausdinimas, priklauso nuo formato.

# Naudojant kombinacij� m.n galima nurodyti i� karto kelis dalykus: tai reik�m�s 
# atvaizdavimui skirt� simboli� skai�i� bei skaitmen� po kablelio skai�i�, jeigu
# ta reik�m� yra realusis skai�ius. �ia m ir n gali �gyti reik�mes 0, 1, 2, ...
# Pavyzd�iui, tarkime, kad real�j� skai�i� e reikia u�ra�yti dviej� skaitmen� po 
# kablelio tikslumu, vadinasi, tam reikia 4 simboli�, tod�l formatas bus "%4.2f".

sprintf("%4.2f", e)

# Jei parametras m ma�esnis, nei reik�mei u�ra�yti reikaling� simboli� skai�ius,
# tada jis bus ignoruojamas. Pavyzd�iui, �iuo atveju m = 3, m = 2 ar m = 0 nieko
# nekei�ia.

sprintf("%3.2f", e)
sprintf("%2.2f", e)
sprintf("%1.2f", e)
sprintf("%0.2f", e)

# Jei parametras m didesnis, nei skai�iui u�ra�yti reikaling� simboli� skai�ius,
# tada rezultatas bus m simboli� ilgio seka su tarpais. Pavyzd�iui, �iuo atveju,
# nusta�ius m = 5, prie skai�iaus bus pridedamas vienas tarpas, nusta�ius m = 6,
# bus pridedami du papildomi tarpai ir pan.

sprintf("%5.2f", e)
sprintf("%6.2f", e)

# Jei reikia nustatyti tik skaitmen� po kablelio skai�i�, tai parametr� m galima
# ir visai praleisti. Dviej� skaitmen� po kablelio formatas u�ra�omas "%.2f".

sprintf("%.2f", e)

# Jei reikia nustatyti tik bendr� reik�mei u�ra�yti reikaling� simboli� skai�i�,
# tada galima praleisti parametr� n. Pavyzd�iui, galime nurodyti, kad skai�iui e 
# u�ra�yti b�t� skirta 15 simboli�.

sprintf("%15f", e)

# Analogi�kai gali b�ti nustatomas simboli� skai�ius sveikajam skai�iui u�ra�yti.
# Jeigu sveikajam skai�iui u�ra�yti reikia skirti m simboli�, tai formatas "%md".

sprintf("%3d", 2)

# Jeigu vietoje tarp� turi b�ti ra�omi nuliai, tai � format� �terpiamas simbolis 
# "0". Pavyzd�iui, skai�i� 2 u�ra�ysime kaip kod� 002.

sprintf("%03d", 2)

# Jei skai�ius ar kita reik�m� u�ima ma�iau vietos, nei jam skirta, tada jis bus
# lygiuojamas pagal de�in�j� kra�t�. Norint pakeisti lygiavim� � format� �ra�ome
# simbol� "-".

sprintf("%-3d", 2)


# Jei skai�ius turi b�ti ra�omas su �enklu, u�ra�ant format� tarp "%" ir formato 
# raid�s dedamas "+" simbolis. Pavyzd�iui, sudarysime �ablon� temprat�ros kitimo
# intervalui nurodyti. Tarkime, kad temperat�ros rei�m�s --- sveikieji skai�iai,
# tada formatas bus "%+d".

t.min <- -3
t.max <-  2

sprintf("Oro temperat�ra kinta nuo %+d iki %+d.", t.min, t.max)

# Jei temperat�ros reik�m�s realieji skai�iai, galima nurodyti skaitmen� skai�i�
# po kablelio. Pvz., skai�iaus su �enklu ir vienu skaitmeniu po kablelio format� 
# u�ra�ome taip: "%+.1f".

t.min <- -3.5
t.max <-  2.5

sprintf("Oro temperat�ra kinta nuo %+.1f iki %+.1f.", t.min, t.max)


# U�DUOTIS ------------------------------ 

# 1. Tarkime, kad duoti trys sveikieji skai�iai, kurie nurodo: valandas, minutes
#    ir sekundes. U�ra�ykite komand�, kuri i� �i� skai�i� u�ra�yt� laik� �prastu
#    HH:MM:SS formatu.
# 2. Panaudojant funkcij� Sys.time(), u�ra�ykite komand�, kuri � konsol� i�vest� 
#    prane�im� apie laik�, pavyzd�iui: "�iuo metu yra XX valand� ir YY minu�i�".
# 3. I� statistikos kurso �inoma, kad statistin� hipotez� priimama arba atmetama
#    pagal p-reik�m�: jeigu p-reik�m� ma�esn� u� pasirinkt� reik�mingumo lygmen�
#    alpha, tada hipotez� atmetama, o prie�ingu atveju -- priimama. Tarkime, kad
#    p-reik�m� �inoma, o alpha = 0.05. U�ra�ykite komand�, kuri � ekran� i�vest� 
#    p-reik�m�, alpha ir i�vad� apie tai, ar hipotez� priimama, ar atmetama.


# --------------------------------------- #
# PAPILDOMOS FUNKCIJOS SPRINTF GALIMYB�S  #
# --------------------------------------- #

# Apra�ant funkcij� sprintf buvo pasakyta, kad kintam�j� reik�m�s joje sura�omos 
# tokia tvarka, kokia jos �ra�omos � teksto �ablon�. Tai tiesa, ta�iau formatams
# galima suteikti eil�s numerius, kurie nurodo, kokia tvarka � �ablon� turi b�ti 
# �statomos toliau i�vardintos reik�m�s, vadinasi --- neb�tinai ta pa�ia tvarka, 
# kokia jos sura�ytos funkcijoje.

# Norint nurodyti, kelinta i� i�vardint� reik�mi� turi b�ti �statyta konkre�ioje
# �ablono vietoje, formate po % �enklo ra�omas reik�m�s numeris. Reik�m�s numer�
# sudaro skai�ius, po kurio ra�omas "$" simbolis. Pavyzd�iui, u�ra�ysime �ablon�
# binarinei operacijai: tam reikia nurodyti operatori� ir du operandus.

sprintf("%2$d %1$s %3$d", operatorius = "+", kair� = 15, de�in� = 79)


# Reik�mi� numeravimas leid�ia t� pa�i� reik�m� � �ablon� �statyti kelis kartus.
# Pavyzd�iui, viename sakinyje �ra�ysime skai�i� ir t� pat� skai�i� suapvalint�.

x <- 1/3
sprintf("Skai�ius %1$f suapvalintas iki dviej� skai�i� po kablelio: %1$.2f.", x)


# Jeigu toje pa�ioje �ablono vietoje vien� kart� reikia �ra�yti vien� reik�m�, o
# kit� kart� --- kit�, tai funkcijoje sprintf vietoje vienos konkre�ios reik�m�s
# galima �ra�yti reik�mi� vektori�. Tokiu b�du gauname analogi�k� tekst� rinkin� 
# su skirtingomis reik�m�mis toje pa�ioje teksto vietoje. Pavyzd�iui, i�ra�ysime
# Lietuvos kunigaik��i� valdymo metus.

K <- c("Mindaugas", "Treniota", "Vai�elga", "�varnas", "Traidenis", "Daumantas")

nuo <- c(1239, 1263, 1264, 1267, 1269, 1282)
iki <- c(1263, 1264, 1267, 1268, 1281, 1285)

sprintf("Lietuvos didysis kunigaik�tis %s.", K)
sprintf("Lietuvos didysis kunigaik�tis %s vald� nuo %d iki %d.", K, nuo, iki)


# Jei � �ablon� �statom� reik�mi� vektoriai turi skirting� element� skai�i�, tai
# trumpesnis vektorius cikli�kai prat�siamas. Pvz., sudarysime �ablon� tekstini�
# fail� pavadinimams sudaryti. Pirma pavadinimo dalis visiems failams vienoda, o 
# kita dalis yra eil�s numeris.

prefix <- "failas"
number <- 1:10

sprintf("%s_%02d.txt", prefix, number)


# U�ra�ant � �ablon� �dedamos reik�m�s format� galima nurodyti reik�mei u�ra�yti
# skiriam� simboli� skai�i� arba realaus skai�iaus skaitmen� po kablelio skai�i�.
# Pavyzd�iui, iki dviej� skaitmen� suapvalinto realaus skai�iaus formatas "%.2f".
# �iuo atveju konstrukcijoje m.n parametras m praleistas ir ra�oma tik parametro
# n reik�m�. Naudojant �� format� atvaizduosime skai�i� e.

sprintf("Skai�ius e apytiksliai lygus %.2f", e)

# �dedamos reik�m�s formatas yra �ablono dalis, tod�l, norint pakeisti skai�iaus 
# atvaizdavimo format�, reikia pakeisti pat� �ablon�. Tarkim, kad vietoje "%.2f"
# turi b�ti formatas "%.3f", vadinasi, u�tenka pakeisti tik parametro n reik�m�.
# U�ra�ant format� konstrukcijoje m.n vietoje parametro n galima �ra�yti simbol� 
# "*", o paties parametro reik�m� i�kelti prie kit� � �ablon� �statom� reik�mi�.
# Taigi, formate "%.*f" parametras m praleistas, simbolis "*" nurodo parametr� n, 
# o raid� "f" nurodo, kad �dedamas realusis skai�ius.

# Tokiu pavidalu u�ra�yto formato parametro n reik�m� taip pat �dedama � �ablon�.
# Kadangi reik�mi� eili�kumas nenurodytas, jos � �ablon� bus �statomos ta tvarka, 
# kuria jos sura�ytos. Vadinasi, �iuo atveju pirma turi b�ti parametro n reik�m�.

#                                       n    n
#                                       |    |
sprintf("Skai�ius e apytiksliai lygus %.*f", 2, e)
sprintf("Skai�ius e apytiksliai lygus %.*f", 3, e)

# Kadangi � �ablon� �statomos reik�m�s turi savo eil�s numerius, galima nurodyti,
# kuri i� i�vardint� reik�mi� yra formato parametras. Pavyzd�iui, jeigu skai�ius
# e �ra�ytas pirmas, o formato parametras n -- antras, tada formatas "%1$.*2$f".

sprintf("Skai�ius e apytiksliai lygus %1$.*2$f", e, 3)

# Tokiu pavidalu u�ra�ytas formatas jau gana sunkiai skaitomas, bet, i�naudojant 
# reik�mi� numeravim�, galima parametrizuoti ir kompakti�kai u�ra�yti sud�tingus 
# �ablonus. Pavyzd�iui, u�ra�ysime tok� �ablon�, kuriame galima keisti sveikajam 
# skai�iui atvaizduoti skiriam� simboli� skai�i�, t. y. m.n formato parametr� m,
# o skai�iaus priekyje b�t� ra�omi nuliai.

y <- 7

sprintf("Agentas %0*2$d", skai�ius = y, m = 3)
sprintf("Agentas %1$0*2$d", skai�ius = y, m = 2:4)

# Pavyzd�iui, sudarysime tok� �ablon�, kad real� skai�i� b�t� galima atvaizduoti 
# su vis did�jan�iu skaitmen� po kablelio skai�iumi.

phi <- 1.6180339887498948

sprintf("Skai�ius %1$2d skaitmen� po kablelio tikslumu: %2$.*1$f", 1:15, phi)


# NAUDINGA ------------------------------

# F-ja sprintf paprastai naudojama �vairi� informacini� prane�im�, kuri� turinys
# skai�iavim� metu kei�iasi, formavimui. Pavyzd�iui, atliekant ilgai trunkan�ius
# skai�iavimus, pravartu �inoti, kiek ciklo iteracij� atlikta.

N <- 10

for (i in 1:N) {

  # �sivaizduojamas skai�iavim� blokas.
  Sys.sleep(runif(1))

  # I�vedame informacij� apie iteracijos numer�.
  info <- sprintf("%02d iteracija i� %d.", i, N)
  cat(info, "\n")
  flush.console()
}


# U�ra�ysime funkcij�, kuri sekund�mis i�matuot� laiko interval� u�ra�yt� labiau
# �prastu HH:MM:SS formatu. Apskai�iuosime valand�, minu�i� ir sekund�i� skai�i�
# ir, naudojant funkcij� sprintf, �statysime gautas reik�mes � �ablon�.

sec2time <- function(x) {

    x <- as.numeric(x)
  val <- x %/% 3600
    x <- x %% 3600
  min <- x %/% 60
  sek <- x %% 60

  sprintf("%02.f:%02.f:%02.f", val, min, sek)
}

sec2time(21.6)
sec2time(4017)


# Toki� funkcij� galima �statyti � cikl� ir i�vesti informacij� apie skai�iavim�
# trukm�. I� prad�i�, naudojant funkcij� difftime, apskai�iuojame laiko skirtum� 
# sekund�mis. Tada, naudojant f-j� sec2time, t� skirtum� perra�ome kitu pavidalu
# ir �statome � �ablon�.

N <- 10
start <- Sys.time()

for (i in 1:N) {

  # �sivaizduojamas skai�iavim� blokas.
  Sys.sleep(runif(1, 0, i))

  # I�vedame informacij� apie skai�iavim� laik�.
  stop <- Sys.time()
  secs <- difftime(stop, start, units = "secs")
  time <- sec2time(secs)
  info <- sprintf("%04d | t = %s", i, time)
  cat(info, "\n")
  flush.console()
}


# U�DUOTIS ------------------------------ 

# 1. Duota reali�j� skai�i� seka x. U�ra�ysime program�, kuri nubrai�o pirm�j� n 
#    sekos nari� kitim� laike, kur n �gyja reik�mes 1, 2, ..., 1000. Papildykite
#    program� taip, kad animuoto grafiko antra�t�je b�t� �ra�oma besikei�ianti n
#    reik�m�, kuriai pavaizduoti skirti keturi simboliai, priekyje ra�omi nuliai.
#    
#    n <- 1000
#    x <- cumsum(rnorm(n))
#    for (i in 1:n) plot(x[1:i], type = "l", ylim = range(x), xlim = c(1, n))
#
# 2. Sudarykite toki� f-j�, kurios argumentas yra 1 x 2 dyd�io da�ni� lentel�, o
#    rezultatas yra tekstinis prane�imas, koks yra vienos i� reik�mi� procentas.
#    Tarkime, duota da�ni� lentel�: dd <- as.table(c(`FALSE` = 26, `TRUE` = 9)).
#    Tada prane�imas gal�t� b�ti toks: "TRUE reik�mi� yra 25.7 %".
