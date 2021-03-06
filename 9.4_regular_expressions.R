
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Reguliarios i�rai�kos.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2016-04-19 | 2016-04-23 | 2016-04-30
#


# TURINYS -------------------------------

#
#   1. Teorinis reguliari� i�rai�k� pagrindimas:
#      * �vadas � baigtini� automat� teorij�
#      * Kleene teorema apie baigtinius automatus
#      * reguliari� i�rai�k� ry�ys su automatais
#      * formalios kalbos ir formalios gramatikos
#
#   2. Reguliari� i�rai�k� sudarymo taisykl�s:
#      * trumpai apie reguliarias i�rai�k� istorij�
#      * reguliari� i�rai�k� ir reguliari� kalb� ry�ys
#      * reguliari� i�rai�k� sudarymo taisykl�s
#      * operacijos su reguliariomis i�rai�komis
#      * operatori� prioritetai ir savyb�s
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
# BAIGTINIAI AUTOMATAI, FORMALIOS KALBOS  #
# --------------------------------------- #

# Automat� teorija -- diskre�iosios matematikos �aka, nagrin�janti matematiniais
# modeliais u�ra�omas abstrak�ias skai�iavimo ma�inas (jos vadinamos automatais)
# ir u�davinius, kuriuos jos gali spr�sti. Automatas diskre�iais laiko momentais
# konvertuoja diskre�i� informacij� ir �ingsnis po �ingsnio vykdydamas i� anksto
# u�duot� algoritm� formuoja rezultat�. �iuo at�vilgiu automat� teorija susijusi
# su algoritm� teorija. Atskirai galima pamin�ti baigtinius automatus. Tai tokie
# automatai, kuri� vidini� b�sen� aib� yra baigtin�. Baigtinis automatas �simena
# savo b�sen� ir, priklausomai nuo veiksmo ir dabartin�s b�senos, pereina � kit�
# b�sen�. 

# Norint detaliau apra�yti baigtinio automato veikimo princip�, paai�kinsime kai
# kuriuos toliau tekste naudojamus terminus. Simboliu vadiname bet kok� nedalom�
# duomen� blok�. Da�niausiai simboliais laikomi nat�ralios kalbos ra�to �enklai:
# raid�s, skai�iai, skyrybos �enklai. Ta�iau simboliai gali b�ti ir abstraktesni
# objektai, pavyzd�iui, grafiniai diagramos elementai. Alfabetas -- tai baigtin�
# skirting� simboli� aib�. �odis --- simboli� seka, gaunama apjungiant simbolius
# i� vieno alfabeto. Kalba --- tam tikro alfabeto pagrindu sudaryt� �od�i� aib�.
# Jei kalb� sudaro riboto ilgio �od�iai, tai j� aib� bus baigtin�, bet prie�ingu
# atveju gaunama begalin� aib�. Kalb� sudaro neb�tinai visi �od�iai, kuriuos tik
# �manoma sudaryti i� tam tikro alfabeto simboli�, tod�l bendru atveju kalba yra
# poaibis vis� �manom� vieno alfabeto �od�i� aib�s.

# Laikoma, kad baigtinis automatas pradeda darb� tam tikroje pradin�je b�senoje.
# Toliau nuosekliai skaitoma simboli� seka s_1 s_2 ... s_n, kuri vadinama ��jimo
# �od�iu. Kiekvienas nuskaitytas simbolis perveda automat� � nauj� b�sen�. Kokia
# bus nauja b�sena, priklauso nuo dabartin�s b�senos ir nuskaityto simbolio. �i�
# per�jimo i� b�senos � b�sen� taisykl� apra�o per�jimo funkcija. Taip automatas
# skaitydamas sek� bei keisdamas b�senas nuskaito paskutin� simbol� ir patenka �
# tam tikr� b�sen�. Jeigu �i b�sena yra i� leistin� baigtini� b�senos aib�s, tai
# sakoma, kad nuskaityta simboli� seka (�odis) yra priimtina. 

# Apibendrintai baigtinis automatas u�ra�omas rinkiniu M = {A, Q, q, F, d}, kur:
#
#          A -- ��jimo simboli� aib� (alfabetas),
#          Q -- baigtin� vidini� b�sen� aib�,
#          q -- pradin� b�sena, q priklauso aibei Q,
#          F -- galutini� b�sen� aib�, F yra aib�s Q poaibis,
#          d -- per�jimo funkcija, kuri apra�o per�jimo � kit� b�sen� taisykl�.

# Baigtin� automat� galima atvaizduoti orientuotu grafu. Grafo vir��n�s atitinka
# automato b�senas, o briauna, su jai priskirtu simboliu, atitinka par�jim� tarp
# dviej� b�sen�. 

# Baigtiniai automatai skirstomi � deterministinius ir nedeterministinius. Jeigu
# automatui leid�iama pereiti � kit� b�sen� nenuskai�ius simbolio arba i� vienos
# b�senos (nuskai�ius t� pat� simbol�) galima patekti � daugiau nei vien� b�sen�,
# tada toks automatas vadinamas nedeterministiniu. 

# Automat� teorija --- �iuolaikin�s skai�iavimo technikos ir programin�s �rangos
# pagrindas. Baigtiniai deterministiniai automatai naudojami sprend�iant plataus
# spektro u�davinius, pavyzd�iui:
#
#   -- automatizuotame elektronikos projektavime,
#   -- neurologini� sistem� ir j� veiklos apra�ymui,
#   -- informacijos perdavimo protokol� sudarymui,
#   -- nat�ralios kalbos tekst� analiz�je,
#   -- nat�ralios kalbos signal� atpa�inime,
#   -- atliekant programin�s �rangos testavim�,
#   -- nustatant algoritm� korekti�kum� kriptografijoje,
#   -- projektuojant programavimo kalbas ir j� kompiliatorius.
#
# Kai kurie visi�kai paprasti, o kartais ir gana sud�tingi mechaniniai �rengimai
# bei elektronikos prietaisai suprojektuoti taip, kad jie veikt� kaip baigtiniai
# automatai. Pavyzd�iui, �viesoforas, kavos aparatas ar pardavim� automatas.

# Buvo pasakyta, kad nuskaitytas �odis yra leistinas, jeigu jis automat� perveda
# � leistin� baigtin� b�sen�. I� �ia i�plaukia dar bendresn� i�vada: sakoma, kad
# kalba L priimama automato M, jeigu ji susideda i� alfabeto A pagrindu sudaryt�
# �od�i�, kurie automat� perveda � b�senas i� baigtini� b�sen� aib�s F. Teisinga
# ir tokia i�vada, kad baigtin� automat� galima suprasti, kaip kalbos atpa�inimo
# prietais�.

# Automat� teorija glaud�iai susijusi su formali� kalb� teorija. Paai�kinsime ��
# ry��. I� prad�i� suformuluosime tekste naudojamos formalios kalbos apibr��im�.
# Formali kalba --- tai baigtinio ilgio simboli� i� baigtinio alfabeto sek� aib�.
# Taisykl�s, pagal kurias sudaromos tokios simboli� sekos, vadinamos formaliomis
# taisykl�mis arba formalia gramatika. Formalias kalbas nagrin�ja formali� kalb� 
# teorija. Jos naudojamos automat� teorijoje, algoritm� ir skai�iavimo teorijoje.

# Formali� kalb� teorijoje reguliari kalba yra tokia, kuri i�rei�kiama naudojant
# reguliaras i�rai�kas. �is teiginys susieja reguliarias kalbas su reguliariomis
# i�rai�komis, bet neatsako � klausim�, kas tai yra reguliari i�rai�ka. Galutin�
# atsakym� duoda Kleene teorema, kuri susieja reguliarias i�rai�kas, reguliarias
# kalbas ir baigtinius automatus.

# Teorema. Tegul A yra baigtinis alfabetas. �io alfabeto pagrindu sudaryta kalba 
# L yra reguliari tada ir tik tada, jei ji priimama tam tikro baigtinio automato.
# �rodymas remiasi tuo, kad kiekvienai reguliariai i�rai�kai gali b�ti sudarytas 
# baigtinis automatas, kartai nedeterminuotas, atpa��stantis reguliaria i�rai�ka 
# R u�duot� kalb�. Vadinas, kiekvien� reguliari� kalb� galima sutapatinti su tam 
# tikru baigtiniu automatu. I� �ia seka galutin� i�vada, kad reguliari� kalb� ir 
# kalb�, kurias atpa��sta baigtiniai automatai, klas�s sutampa. 

# Galima pamin�ti, kad automatai paprastai klasifikuojami pagal formalios kalbos,
# kuri� jie gali atpa�inti, klas�. Visa automat� �vairov� gali b�ti apra�yta per
# taip vadinam� Chomskio hierarchij�, kuri apra�o ry�ius tarp formali� gramatik�.
# Formali� kalb� teorijoje formali gramatika yra formalios kalbos apra�ymo b�das.
# Jei tiksliau, gramatika nusako b�d�, kaip i� vis� alfabeto A pagrindu sudaryt� 
# �od�i� aib�s i�skirti tam tikr� poaib�, kurio elementai (�od�iai) ir sudaro j� 
# atitinkan�i� formali� kalb� L. I�skiriamos dviej� r��i� gramatikos: 
#
#   -- generuojan�ios,
#   -- atpa��stan�ios.

# Generuojanti gramatika yra toks taisykli� rinkinys, pagal kur� galima sudaryti 
# bet kok� kalbos �od�. Atpa��stanti arba analitin� gramatika leid�ia nustatyti, 
# ar �odis priklauso tam tikrai kalbai, ar nepriklauso.


# --------------------------------------- #
# TRUMPAI APIE REGULIARIAS I�RAI�KAS      #
# --------------------------------------- #

# Reguliari i�rai�ka --- pagal specialias taisykles sudaryta simboli� seka, kuri
# apra�o paie�kos kitoje simboli� sekoje �ablon�. Reguliari� i�rai�k� koncepcija
# atsirado apie 1950 m., kai matematikas Stephen'as Kleene formalizavo teorin�je
# informatikoje nagrin�jam� reguliari� kalb� apibr��im�. Vienas i� UNIX sistemos
# k�r�j� Kenneth Thompson realizavo reguliarias i�rai�kas pirmame standartiniame
# UNIX tekstiniame redaktoriuje ed. Nuo to laiko reguliarios i�rai�kos tapo UNIX
# operacin�s sistemos dalimi, kartu su tokiomis programomis kaip grep ar filter.
# Reg. i�rai�kos naudojamos specializuotose programavimo kalbose, kurios skirtos
# teksto skanavimui ir apdorojimui, pavyzd�iui, sed, awk ir perl. Jos palaikomos
# ir daugelyje bendro pob�d�io programavimo kalb�. Reguliarios i�rai�kos pla�iai
# naudojamos teksto redaktoriuose tokiuose, kaip Emacs, vim. Kita svarbi taikym�
# sritis -- leksiniai analizatoriai programavimo kalb� kompiliatoriuose. 


# Formali� kalb� teorijoje reguliarios i�rai�kos apra�o reguliarias kalbas. Reg.
# i�rai�kos susideda i� konstant� ir operatori�. I� konstant� sudaromos simboli�
# sek� aib�s, o operatoriai apra�o operacijas, kurias galima atlikti su t� aibi�
# elementais -- sekomis. �sivesime kai kuriuos reguliarioms i�rai�koms apibr��ti
# reikalingus terminus. 

# Tarkime, kad L ir K yra dvi kalbos. J� s�junga vadinsime aib� �od�i�, kuri yra
# tas kalbas atitinkan�i� �od�i� aibi� s�junga. Pavyzd�iui, kalba L = {001, 10},
# o K = {1, 001}. Tada �i� kalb� s�junga bus aib� {1, 001, 10}.

# Kalb� L ir K konkatenacija vadinsime aib� �od�i�, kurie yra gauti prie aib�s L
# �od�i� prijungus aib�s K �od�ius. Pavyzd�iui, jei L = {001, 10}, K = {1, 001},
# tada j� konkatenacija yra aib� {0011, 101, 001001, 10001}.

# Kalbos L u�dariniu L* vadinsime aib� toki� �od�i�, kurie gauti visais galimais 
# b�dais sujungus kalbos L �od�ius. �od�iai konkatenacijose gali kartotis norima 
# kiek� kart�, t.y. galima vis� L laipsni� konkatenacija. Pvz., jeigu L = {0, 1}, 
# tai L* bus vis� galim� i� nuli� ir vienet� sudaryt� �od�i� aib�. U�dariniui L* 
# priklauso ir tu��ias �odis "", kur� �ymime e. Tu��ios aib�s u�darinys yra aib�,
# turinti tik vien� element� -- tu��i� �od� e.

# Dabar galime apibr��ti konstantas ir operatorius, kurie naudojami reguliari�j�
# i�rai�k� sudarymui. Tarkime, kad A yra baigtinis alfabetas. Tada reg. i�rai�k� 
# konstantos yra tokie objektai:
#
#          0 -- tu��ia aib�,
#          e -- tu��ias �odis,
#          a -- simboliai i� alfabeto A.
#
# Tegul R ir S yra reguliarios i�rai�kos. Tada joms apibr��tos �itos operacijos:
#
#         RS -- sek� i� R ir S sujungimas (concatenation);
#        R|S -- sek� i� R ir S s�junga (alternation);
#         R* -- sek� i� R u�darinys (Kleene star).


# Galima priminti, kad reguliari i�rai�ka apra�o kalb�, o kalba yra �od�i� aib�.
# Tarkime, kad L(R) nurodo kalb�, kuri� apra�o reguliari i�rai�ka R. Pagrindin�s
# taisykl�s nurodan�ios, kokias kalbas apra�o reguliarios i�rai�kos, yra tokios: 
#
#   -- L(a) = {a}, kiekvienam simboliui a i� alfabeto A;
#   -- L(e) = e;
#   -- L(0) = 0;
#   -- L(R|S) = L(R) U L(S);
#   -- L(RS) = L(R)L(S) = {ab | a i� R, b i� S};
#   -- L(R*) = {e} U {s_1 ... s_k | s_1, ..., s_k i� R}.

# Taigi, konkatenacija RS nurodo aib� toki� �od�i� (sek�), kurie gaunami �od�ius 
# i� kalbos, kuri� apra�o reguliari i�rai�ka R, prijungus prie �od�i� i� kalbos, 
# kuri� apra�o reguliari i�rai�ka S. 

# Pvz., tarkime, kad i�rai�ka R apra�o kalb�, kurios �od�i� aib� yra {"ab", "c"}, 
# o reguliari i�rai�ka S atitinka kalb�, kurios �od�i� aib� {"d", "ef"}. Vadinas,
# konkatenacija RS = {"ab", "c"}{"d", "ef"} = {"abd", "abef", "cd", "cef"}.

# Taip R|S apra�o aib�, kuri yra reguliarias i�rai�kas R ir S atitinkan�i� kalb�
# s�junga. Pavyzd�iui, jeigu R = {"ab", "c"}, o S = {"c", "bd"}, tai s�junga R|S
# apra�o kalb� {"ab", "c", "bd"}.

# Liko dar viena operacija -- Klini �vaig�d�. I�rai�ka R* apra�o aib� vis� toki�
# �od�i�, kuriuos galima gauti apjungiant bet kok� baigtin� skai�i� kalbos, kuri
# apra�oma i�rai�ka R, �od�i�. Arba kitaip - R* apra�o kalb�, kurios �od�i� aib�
# yra kalbos, kuria apra�o R, u�darinys. Pvz., jeigu R apra�o kalb� {"ab", "c"},
# tai R* apra�o kalb� {e, "ab", "c", "abab", "abc", "cab", "cc", "ababab", ...}.
# Galima dar kart� atkreipti d�mes�, kad tokiu b�du gautoje �od�i� aib�je yra ir
# tu��ias �odis e.

# I� �i� operacij� did�iausi� prioritet� turi Klini �vaig�d�, tada konkatenacija,
# o �emiausi� prioritet� turi s�junga. Kaip �prasta matematikoje, skliausteliais
# gali pakeisti veiksm� tvark�. Pvz., vietoje (ab)c galima ra�yti abc, o vietoje  
# a|(b(c*)) galima ra�yti a|bc*. Norint i�rai�koje i�vengti skliausteli�, galima 
# i�naudoti operatori� savybes. Konkatenacija ir s�junga yra asociatyvios, tod�l
# (ab)c = a(bc) = abc. Be to, s�junga yra komutatyvi: a|b = b|a. O konkatenacija
# nekomutatyvi, kadangi �od�io prijungimas i� kair�s ir i� de�in�s bendru atveju 
# duoda skirtingus rezultatus, tod�l ab != ba. Klini �vaig�d� --- idempotentinis 
# operatorius, tod�l R** = R*. Konkatenacijai ir s�jungai galioja distributyvumo
# d�snis: (a|b)c = ac|bc.


# Dar kart� kitais �od�iais u�ra�ysime taisykles, kurios nusako, kas tai yra reg. 
# i�rai�kos. Bet kuris atskirai paimtas alfabeto A elementas a yra reg. i�rai�ka 
# a, apibr��ianti kalb� {a} --- aib�, kuri turi vienintel� element� a. Konstanta 
# e (tu��ias �odis "") yra reguliarioji i�rai�ka, apibr��ianti kalb� {e}. Tu��i� 
# aib� {} apibr��ime reguliaria i�rai�ka 0. Jei R ir S yra reguliarios i�rai�kos, 
# tada RS taip pat yra reguliari i�rai�ka, �yminti R ir S apibr��iam� kalb� L(R) 
# ir L(S) s�jung�: L(R|S) = L(E) U L(F). Jeigu R ir S yra reguliarios i�rai�kos, 
# tada RS taip pat yra reguliari i�rai�ka, �yminti R ir S apibr��iam� kalb� L(E) 
# ir L(F) konkatenacij�: L(EF) = L(E)L(F). Jei R yra reguliarioji i�rai�ka, tada 
# R* taip pat yra reg. i�rai�ka, kuri �ymi kalbos L(R) u�darin�: L(R*) = (L(E))*. 
# Jeigu R yra reguliarioji i�rai�ka, tada (R) taip pat yra reguliarioji i�rai�ka, 
# �yminti t� pa�i� kalb�, kuri� apibr��ia ir E: L((E)) = L(E).


# Pavyzd�iui, i�nagrin�sime, koki� �od�i� aib� apra�o reguliari i�rai�ka (a|b)c.
# Pagal apibr��im� �i reguliari i�rai�ka apra�o simboli� sek� rs, kur r yra arba 
# raid� "a", arba raid� "b", o simbolis s yra raid� "c". �i� aib� u�ra�ome taip:
#
#                    {rs | r i� ({"a"} U {"b"}), s i� {"c"}}
#
# Taigi, reguliari i�rai�ka (a|b)c apra�o kalb�, kurios �od�i� aib� {"ac", "bc"}.
# U�ra�ysime kelet� papras�iausi� reguliari� i�rai�k� bei jas atitinkan�i� kalb� 
# �od�i� aibes:
#
#          a -- {"a"}
#         ab -- {"ab"}
#      ac|bc -- {"ac", "bc"}
#      a|b|c -- {"a", "b", "c"}

# U�ra�ysime kelet� reguliari� i�rai�k� su Klini �vaig�de bei atitinkan�i� kalb� 
# �od�i� aibes:
#
#       a|b* -- {e, "a", "b", "bb", "bbb", ... }
#       ab*c -- {"ac", "abc", "abbc", "abbbc", ... }
#      (ab)* -- {e, "ab", "abab", "ababab", ...}
#     (a|b)* -- {e, "a", "aa", "aaa", ..., "b", "bb", "bbb", ... }
#       a*b* -- {e, "a", "b", "aa", "ab", "ba", "bb", "aaa", "aab", "abb", ...}
#     a*|ab* -- {e, "a", "aa", "aaa", ..., "ab", "abb", "abbb", ...}
#   (a|b)*aa -- {"aa", "aaa", "baa","abaa", ...}
#     (a*b)* -- {e, "b", "bb", ..., "ab", "abab", ..., "aab", "aabaab", ...}


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite toki� reguliari� i�rai�k�, kuri apra�o sekas, sudarytas i� nuli� 
#    ir vienet�, kuriose i� prad�i� yra bet kokio ilgio nuli� serija, o u�baigia
#    toki� sek� vienas vienetas. Pvz., 1, 01, 0000001 ir t.t.
# 2. U�ra�ykite reguliari� i�rai�k�, kuri apra�o bet kokio ilgio sekas sudarytas
#    vien tik i� nuli� arba vien tik i� vienet�.
# 3. Nustatykite, koki� �od�i� aib� apra�o reguliari i�rai�ka a) ab*c, b) a*|b*,
#    c) ab*|ac*, d) (a|b|c)*.
# 4. Pasakykite, kuo reguliaria i�rai�ka ab*c apra�omi �od�iai skiriasi nuo reg.
#    i�rai�ka abb*cd apra�om� �od�i�?
# 5. Nustatykite, ar galima kitu b�du u�ra�yti reg. i�rai�k� ab*|ac*. Jei galima,
#    tada kaip?
# 6. Sudarykite reguliari� i�rai�k�, kuri apra�o kalb�, kurioje �od�iai baigiasi
#    gal�ne "as".
# 7. Sudarykite toki� reguliari� i�rai�k�, kuri apra�o kalb� su tokiais �od�iais, 
#    kurie prasideda raide "n", o baigiasi gal�ne "as".
