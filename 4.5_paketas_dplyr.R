
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Veiksmai su duomen� lentel�mis naudojant paket� dplyr.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2015-08-22 | 2015-08-27
#


# TURINYS -------------------------------

#
#   1. Trumpai apie paket� dplyr:
#      * operatorius %>% 
#      * funkcija tbl_df
#      * funkcija glimpse
#
#   2. Stulpeli� i�rinkimas, pervadinimas ir perskai�iavimas:
#      * funkcija select
#      * funkcija rename
#      * funkcija mutate
#      * funkcija transmute
#
#   3. Eilu�i� i�rinkimas ir i�rikiavimas:
#      * funkcija slice
#      * funkcija top_n
#      * funkcija sample_n
#      * funkcija filter
#      * funkcija between
#      * funkcija distinct
#      * funkcija arrange 
#      * funkcija desc 
#
#   4. S�lygini� charakteristik� skai�iavimas:
#      * funkcija count
#      * funkcija summarise
#      * funkcija summarise_each
#      * funkcija funs
#      * funkcija group_by
#      * funkcija groups 
#      * funkcija group_size 
#      * funkcija rowwise
#
#   5. Kai kurie tipiniai duomen� pertvarkymo atvejai:
#      * funkcija bind_rows 
#      * funkcija bind_cols 
#      * funkcija do 
#


# PASTABOS ------------------------------

#
# Joki� pastab� n�ra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE PAKET� DPLYR               #
# --------------------------------------- #

# Paketas dplyr naudojamas veiksmams su data.frame tipo duomen� lentel�mis ir j�
# pertvarkymui.

library(dplyr)

# Paprastai i� duomen� lentel�s reikia i�rinkti tam tikrus stulpelius ir eilutes,
# sugrupuoti jas bei apskai�iuoti �vairias statistines charakteristikas. Paketas
# dplyr kiekvienam i� �i� veiksm� turi specializuot� funkcij�. Pagrindin�s i� j�:
#
#     select -- stulpeli� i�rinkimui,
#     mutate -- stulpeli� reik�mi� perskai�iavimui,
#     filter -- eilu�i� i�rinkimui,
#    arrange -- eilu�i� i�rikiavimui,
#  summarise -- stulpeli� charakteristik� skai�iavimui.

# Vis� �i� funkcij� sintaks� prakti�kai vienoda: pirmasis argumentas yra duomen� 
# lentel�, kiti argumentai -- nurodo eilutes ar stulpelius, su kuriais atliekami 
# atitinkami veiksmai. 

# Kadangi vis� �i� funkcij� rezultatas yra nauja duomen� lentel�, vien� po kitos 
# einan�ias duomen� pertvarkymo operacijas galima apjungti, nesukuriant tarpini� 
# lenteli� - vienos funkcijos rezultatas yra kitos funkcijos argumentas. Veiksm� 
# apjungimas gali b�ti atliekamas dviem b�dais: a) nesting, b) chaiting. 

# Pirmuoju atveju atliekama �prasta keletos funkcij� superpozicija, kai funkcija 
# �dedama viena � kit�, o antruoju -- argumentai nuo vienos funkcijos prie kitos
# perduodami konvejeriu. Galima pasakyti, kad konvejeris -- tai Unix ir Linux OS
# naudojama tam tikra funkcijos argument� perdavimo forma, kada vienos funkcijos 
# reik�m� kaip argumentas perduodama kitai funkcijai. 

# R funkcij� konvejeriui u�ra�yti naudojamas operatorius %>% i� paketo magrittr, 
# kuris u�kraunamas kartu su paketu dplyr. Reikia �inoti operatoriaus pritaikymo 
# taisykles. Tarkime, kad f yra tam tikra funkcija, x, y ir z yra jos argumentai. 
# Tada:
#                   x %>% f(y)       atitinka f(x, y)
#                   x %>% f(z, ., y) atitinka f(z, x, y)

# Pavyzd�iui, jeigu i� duomen� lentel�s i�renkame eilutes, o i� gautos rezultat�
# lentel�s v�liau i�renkame tam tikrus stulpelius, tai toki� veiksm� sek� galima
# u�ra�yti taip:
#                      select(filter(duomenys, ...), ...)
#
# Naudojant konvejer�, ta pati veiksm� seka u�ra�oma tokiu pavidalu:
# 
#                   duomenys %>% filter(...) %>% selec(...)


# Daugelio paketo dplyr funkcij� argumentas yra data.frame tipo duomen� lentel�.
# Ta�iau, analizuojant labai daug eilu�i� turin�ias lenteles, geriau konvertuoti
# jas � tbl_df format�. Galima sakyti, kad tai savoti�kas data.frame apvalkalas,
# kuris apsaugo nuo didelio kiekio duomen� i�vedimo � ekran�.

airquality. <- tbl_df(airquality)
airquality.

# � ekran� i�vedam� eilu�i� skai�i� galima koreguoti.

print(tbl_df(airquality.), n = 20)

# Jei duomen� lentel� turi labai daug stulpeli�, jiems ap�velgti galima naudoti
# funkcij� glimpse, kuri transponuoja lentel�, stulpeliai vaizduojami eilut�se.

glimpse(airquality.)

# tbl_df tipo lentel� tuo pa�iu yra ir data.frame tipo lentel�.

class(airquality.)

# Funkcija tbl_df nedaro pradin�s lentel�s stulpeli� kopij�. Taip pat elgiasi ir 
# funkcijos select bei mutate, tod�l stulpeli� i�rinkimas bei j� perskai�iavimas
# atliekamas labai greitai -- tai svarbu dirbant su didel�s apimties duomenimis.


# --------------------------------------- #
# STULPELI� I�RINKIMAS IR PERVADINIMAS    #
# --------------------------------------- #

# Stulpeli� i�rinkimui naudojama funkcija select, o jos sintaks� labai paprasta:
# 
#                           select(duomenys, ...)
#
# �ia ... nurodo vien� arba kelis kableliu atskirtus stulpeli� pavadinimus. Tam,
# kad stulpelius b�t� galima i�rinkti pagal tam tikr� taisykl�, naudojamos kitos
# papildomos funkcijos:
#
#       one_of -- kintam�j� i� s�ra�o i�rinkimui,
#  starts_with -- i�rinkimui pagal pavadinimo prad�i�,
#    ends_with -- i�rinkimui pagal pavadinimo pabaig�,
#     contains -- i�rinkimui pagal sutampant� �od�,
#      matches -- i�rinkimui pagal reguliari� i�rai�k�,
#    num_range -- i�rinkimui pagal kintam�j� numerius,
#   everything -- vis� kintam�j� i�rinkimui.


# Pavyzd�iui, i� duomen� lentel�s airquality i�rinksime kintamuosius su vardais 
# "Temp", "Month", "Day". Funkcijos viduje stulpeli� vardai interpetuojami kaip 
# lentel�s aplinkos kintamieji, tod�l ra�omi be kabu�i�.

select(airquality, Temp, Month, Day)

# Tuo atveju, kada i�renkami stulpeliai eina i� eil�s, j� vardus galima nurodyti
# per dvita�k� -- lyg generuojant skai�i� sek�.

select(airquality, Temp:Day)

# Tok� stulpeli� vard� vektori� kaip parametr� galima perduoti funkcijai one_of.

kintamieji <- c("Temp", "Month", "Day")
select(airquality, one_of(kintamieji))


# Tuo atveju, kai yra �inoma, kokiu simboliu arba �od�iu prasideda arba baigiasi 
# stulpeli� pavadinimai, patogu naudoti funkcij� starts_with ir ends_with. Pvz.,
# i�rinksime stulpelius su prad�ia "Oz" ir pabaiga "th".

select(airquality, starts_with("Oz"))
select(airquality, ends_with("th"))

# Jei �inomas stulpelio pavadinimo fragmentas, galima naudoti funkcij� contains.
# Pavyzd�iui, i�rinksime stulpelius, kuri� pavadinime yra raid�i� junginys "on".

select(airquality, contains("on"))


# Stulpelius galima i�rinkti ir pagal abstraktesn� taisykl�. Kartais tai b�tina,
# kadangi stulpeli� pavadinim� gali b�ti labai daug arba jie i� anksto ne�inomi. 
# Tais atvejais, kai visiems vardams b�dingas tam tikras �ablonas, j� i�rinkimui 
# galima naudoti reguliarias i�rai�kas. Pavyzd�iui, taip galima i�rinkti vardus,
# kurie turi raid�s ir trij� skaitmen� kod�, arba vardus i� dviej� dali�, kurios
# atskirtos br�k�neliu, arba vardus, kuriuose n�ra tam tikros raid�s ir pana�iai.

# Pavyzd�iui, lentel�je airquality i�rinksime tuos stulpelius, kuri� pavadinime
# yra ta�kas. �ia problema tame, kad ta�ko simbolis "." reguliariose i�rai�kose
# nurodo bet kok� simbol�, tod�l �iuo atveju reikia ra�yti "\\." -- bus randami
# visi vardai, kuriuose bet kurioje pavadinimo vietoje yra ta�kas.

select(airquality, matches("\\."))

# Jei ta�kas stulpelio pavadinime atskiria du bet kokio ilgio �od�ius, reguliari 
# i�rai�ka ra�oma �iek tiek kitaip. �iuo atveju rezultatas sutampa.

select(airquality, matches("^[a-z,A-Z]+\\.[a-z,A-Z]+$"))

# Pavyzd�iui, i�rinksime stulpelius, kuri� pavadinime yra raid�i� junginys "on"
# arba "ol". Atskirai vienam ir kitam atvejui tinka f-ja contains, ta�iau abiem
# kartu u�ra�yti naudojama nesud�tinga reguliari i�rai�ka.

select(airquality, matches("o[n,l]"))


# Jeigu stulpeliai turi b�ti pa�alinti, prie� j� vard� vektori� ra�omas minusas.
# Gali b�ti naudojamos tos pa�ios pagalbin�s f-jos one_of, starts_with ir kitos.
# Pvz., �ia pateikti keli lygiaver�iai trij� stulpeli� pa�alinimo variantai.

select(airquality, -c(Ozone, Wind, Solar.R))
select(airquality, -Ozone, -Wind, -Solar.R)
select(airquality, -one_of(c("Ozone", "Wind", "Solar.R")))


# Jei i�rinktam stulpeliui reikia pakeisti pavadinim�, tai ra�oma lygyb�, kurios
# kair�je pus�je yra naujas vardas, o de�in�je -- senasis. Pavyzd�iui, pakeisime
# vieno pasirinkto kintamojo vard�.

select(airquality, Solar = Solar.R)

# Kintam�j� vardus galima pervadinti pagal �ablon�. Pavyzd�iui, i�rinksime visus
# lentel�s airquality stulpelius ir j� vardus pakeisime � "x1", "x2", ..., "x6".

select(airquality, x = everything())


# Funkcija rename naudojama atskir� duomen� lentel�s stulpeli� vard� pakeitimui.
# Vis� kit� stulpeli� vardai i�lieka tokie patys. Pavyzd�iui, pakeisime lentel�s
# airquality stulpelio "Solar.R" pavadinim� � paprastesn�.

rename(airquality, Solar = Solar.R)

# Stulpeli� perskai�iavimui naudojama funkcija mutate. Pvz., lentel�s airquality
# kintamojo Temp reik�mes perskai�iuosime i� Farenheito � Celcijaus skal�. 

mutate(airquality, Temp = 5*(Temp - 32)/9)

# Naudojant �i� funkcij�, lentel�je galima sukurti naujus stulpelius. Pavyzd�iui,
# lentel�je airquality sukursime nauj� stulpel� su eilu�i� numeriais.

mutate(airquality, Nr = 1:153)

# Bendras eilu�i� skai�ius duomen� lentel�je yra fiksuotas, bet, i�skaid�ius jas
# � tam tikras grupes, eilu�i� skai�ius grup�se i� anksto da�niausiai ne�inomas. 
# Paketo dplyr funkcija n() gr��ina eilu�i� skai�i� duomen� lentel�s grup�je. �� 
# kart� eilut�s negrupuojamos, tod�l rezultatas yra bendras eilu�i� skai�ius.

mutate(airquality, Nr = 1:n())

# Funkcija transmute skiriasi tuo, kad stulpeliai su perskai�iuotomis reik�m�mis
# i�skiriami � atskir� lentel�.

transmute(airquality, Temp = 5*(Temp - 32)/9)


# U�DUOTIS ------------------------------ 

# 1. I� duomen� lentel�s airquality i�rinkite stulpelius su eil�s numeriais 1, 5
#    ir 6. U�duo�iai atlikti naudokite paketo dplyr funkcij� select.
# 2. U�ra�ykite komand�, kuri i� duomen� lentel�s iris i�renka stulpelius, kuri�
#    pavadinimas prasideda �od�iu "Petal" ir juos pervadina pagal nauj� �ablon�.


# --------------------------------------- #
# EILU�I� I�RINKIMAS IR I�RIKIAVIMAS      #
# --------------------------------------- #

# Lengviausias b�das i�rinkti duomen� lentel�s eilutes - pagal j� numerius. �iuo 
# atveju galima naudoti paketo dplyr funkcij� slice. Jos argumentas yra lentel�s
# pavadinimas ir kitas argumentas - eilu�i� numeri� vektorius. Pvz., i� lentel�s 
# airquality i�skirsime pirm� eilut�.

slice(airquality, 1)

# Galima nurodyti keli� eilu�i� numeri� vektori�. Pavyzd�iui, i�skirsime 5, 6 ir 
# 20-� eilutes.

slice(airquality, c(5, 6, 20))

# Jeigu reikalingas bendras lentel�s eilu�i� skai�ius, galima panaudoti funkcij�
# n(). Pavyzd�iui, i�skirsime paskutines eilutes pradedant nuo �imtosios.

slice(airquality, 100:n())


# Norint i� kiekvienos lentel�s grup�s i�skirti kelias pirm�sias eilutes, galima
# naudoti funkcij� top_n. Pavyzd�iui, i� lentel�s airquality i�rinksime pirmas 3 
# eilutes.

top_n(airquality, 3)


# Paprastoji atsitiktin� imtis i� lentel�s eilu�i� i�renkama naudojant funkcijas
# sample_n bei sample_frac. Pirmuoju atveju nurodomas konkretus eilu�i� skai�ius,
# antruoju -- dalis nuo lentel�s eilu�i� skai�iaus. Pvz., i� lentel�s airquality
# atsitiktine tvarka be pasikartojim� i�rinksime 10 eilu�i�.

sample_n(airquality, 10)

# Jeigu i�renkamos eilut�s gali kartotis, tai parametro replace reik�m� kei�iame
# � TRUE.

sample_n(airquality, 10, replace = TRUE)


# Duomen� analiz�s praktikoje da�nai reikia i�rinkti eilutes, kurios tenkina tam
# tikr� login� s�lyg�. Tokiu atveju galima naudoti paketo dplyr funkcij� filter.
# Pavyzd�iui, i� lentel�s airquality i�skirsime tas eilutes, kur kintamojo Temp 
# reik�m� didesn� u� 90.

filter(airquality, Temp > 90)


# Jei reikia i�skirti duomen� lentel�s eilutes, kuriose vieno stulpelio reik�m�s 
# patenka � tam tikr� interval�, galima panaudoti paketo dplyr funkcij� between. 
# Jos sintaks�:
#                         between(x, left, right)
# 
# �ia x yra skaitinis vektorius, o left ir right reik�mi� intervalo galai. Pvz.,
# i�skirsime eilutes, kuri� stulpelio Temp reik�m�s patenka � interval� [50, 60].

filter(airquality, between(Temp, 50, 60))

# Kitas pavyzdys, surasime tas eilutes, kurios stulpelyje Ozone turi NA reik�m�.

filter(airquality, is.na(Ozone))


# Gana da�nas u�davinys -- pa�alinti i� lentel�s pasikartojan�ias eilutes. Tokiu
# atveju galima naudoti naudoti standartin� R funkcij� unique ar analogi�k� f-j� 
# distinct i� paketo dplyr. Pvz., lentel�je airquality paliksime tik tas eilutes, 
# kurios turi unikalias reik�mes stulpelyje Temp.

distinct(airquality, Temp)


# Kartais duomen� lentel�s eilutes reikia i�rikiuoti kintamojo reik�mi� did�jimo 
# ar ma��jimo tvarka. Toki� kintam�j� gali b�ti vienas, bet gali b�ti ir daugiau.
# Eilu�i� i�rikiavimui galima naudoti paketo dplyr funkcij� arrange. Pavyzd�iui, 
# lentel�s mtcars eilutes i�rikiuosime kintamojo cyl (variklio cilindr� skai�ius)
# reik�mi� did�jimo tvarka.

arrange(mtcars, cyl)

# Standarti�kai kintamojo reik�m�s i�rikiuojamos did�jimo tvarka. Naudojant f-j�
# desc, kintamojo reik�m�s transformuojamos taip, kad funkcija arrange i�rikiuos 
# eilutes to kintamojo reik�mi� ma��jimo tvarka. Pavyzd�iui, pagal kintam�j� cyl
# jau i�rikiuot� lentel� dar kart� i�rikiuosime kintamojo disp reik�mi� ma��jimo 
# tvarka.

arrange(mtcars, cyl, desc(disp))


# U�DUOTIS ------------------------------ 

# 1. I� duomen� lentel�s iris i�rinkite tik tas eilutes, kurios priklauso r��iai
#    "versicolor".
# 2. I� duomen� lentel�s airquality i�rinkite tik tas eilutes, kuriose stulpelio 
#    Temp reik�m� didesn� u� 90, o stulpelio Wind reik�m� didesn� u� 5. Komandas
#    u�ra�ykite dviem variantais: naudojant paketo dplyr ir standartines R f-jas.
# 3. I� duomen� lentel�s airquality i�rinkite eilutes, kurios atitinka ma�iausi�
#    temperat�r� turin�ias tris bir�elio m�nesio dienas.
# 4. Nustatykite, kokias reik�mes �gijo lentel�s airquality kintamasis "Solar.R"
#    eilut�se, kuriose kintamojo "Temp" reik�m�s didesn�s u� 90.
# 5. I� lentel�s iris atsitiktine tvarka be pasikartojim� i�rinkite 25 % eilu�i�.
#    Gaut� lentel� i�rikiuokite kintamojo Sepal.Length reik�mi� ma��jimo tvarka.


# --------------------------------------- #
# S�LYGINI� CHARAKTERISTIK� SKAI�IAVIMAS  #
# --------------------------------------- #

# Imties element� da�nis gali b�ti nustatytas naudojant paketo dplyr f-j� count.
# Jos sintaks�:
#                               count(x, ...)
#
# �ia x yra duomen� lentel�, vietoje ... ra�ome vien� ar keli kableliu atskirtus
# stulpeli� pavadinimus, kuri� reik�mi� da�niai ir bus apskai�iuoti. Pavyzd�iui,
# apskai�iuosime lentel�s airquality stebini� skai�i� atskirai kiekvien� m�nes�.

count(airquality, Month)

# Jei nurodomas daugiau nei vienas kintamasis, sudaroma kry�min� da�ni� lentel�.
# Vietoje lentel�s stulpelio vardo galima �ra�yti tam tikr� login� s�lyg�. Pvz.,
# nustatysime, kiek buvo atvej�, kai kintamojo Temp reik�m� vir�ijo 70 laipsni�, 
# o Wind reik�m� didesn� u� 10 m/s.

count(airquality, T = Temp > 70, W = Wind > 10)


# Vienas i� tipini� veiksm� -- vieno ar keli� lentel�s stulpeli� charakteristik�
# skai�iavimas. Tai gali b�ti kintam�j� vidurkiai, element� skai�ius ir pana�ios
# charakteristikos. �iam tikslui galima naudoti paketo dplyr funkcij� summarize.
# Jos sintaks�:
#                             summarise(x, ...)
#
# �ia x yra duomen� lentel�, o vietoj ... ra�oma viena ar kelios lygyb�s, kurios 
# de�in�je pus�je ra�oma tam tikr� stulpelio charakteristik� skai�iuojanti f-ja,
# o kair�je ra�omas tos charakteristikos pavadinimas. Pavyzd�iui, apskai�iuosime
# lentel�s airquality stulpelio Temp vidurk� ir dispersij�.

summarise(airquality, Temperat�ra = mean(Temp), Dispersija = var(Temp))


# Labai da�nai reikia apskai�iuoti tam tikras stulpeli� charakteristikas grup�se
# pagal kito kintamojo reik�mes. Lentel�s eilu�i� grupavimui galima naudoti f-j�
# group_by. Jos argumentais yra duomen� lentel� ir grupavimo kintamojo vardas, o
# rezultatas yra � grupes suskaidyta lentel�, kuri� j� galima perduoti funkcijai 
# summarize.

G <- group_by(airquality, Month)
G

# Funkcija groups parodo, pagal kok� kintam�j� yra sugrupuotos lentel�s eilut�s,
# o funkcija group_size parodo, kokio dyd�io yra grup�s.

groups(G)
group_size(G)

# Pavyzd�iui, apskai�iuosime stulpelio Temp vidurk� ir dispersij� atskirai pagal
# m�nesius.

summarise(G, Temperat�ra = mean(Temp), Dispersija = var(Temp))

# Grupavimo kintamasis gali b�ti sudarytas dirbtinai. Pavyzd�iui, apskai�iuosime
# temperat�ros vidurk� ir dispersij� grup�se pagal v�jo greit�. �ia j� sudarymui
# panaudosime standartines R funkcijas cut ir pretty.

G <- group_by(airquality, Wind = cut(Wind, pretty(Wind)))
summarise(G, Temperat�ra = mean(Temp), Dispersija = var(Temp))

# Eilu�i� grupavimas gali b�ti atliekamas ir pagal tam tikr� login� s�lyg�. Pvz.,
# suformuosime dvi grupes pagal tai, ar v�jo greitis didesnis u� savo vidurk� ar 
# ne. �iose grup�se apskai�iuosime temperat�ros vidurk� ir dispersij�.

G <- group_by(airquality, Wind = Wind > mean(Wind))
summarise(G, Temperat�ra = mean(Temp), Dispersija = var(Temp))


# Kadangi paketo dplyr funkcija n() gr��ina eilu�i� skai�i� lentel�je, naudojant 
# j� kartu su funkcijomis group_by ir summarize, galima sudaryti da�ni� lentel�. 
# Pavyzd�iui, apskai�iuosime, kiek praleist� reik�mi� turi airquality kintamasis 
# Ozone.

summarise(group_by(airquality, is.na(Ozone)), Freq = n())


# Da�nai t� pa�i� skaitin� charakteristik� reikia apskai�iuoti i� karto keliems 
# stulpeliams. Tokiu atveju patogiau naudoti funkcij� summarise_each. Sintaks�:
#
#                     summarise_each(x, funs(), ...)
#
# �ia x yra duomen� lentel�, kuri gali b�ti ir grupuota, funs yra speciali f-ja,
# kuri leid�ia suformuoti funkcij� s�ra��, o vietoje ... ra�omi stulpeli� vardai.
# Jei kintamieji nenurodomi, tai charakteristikos skai�iuojamos visiems i�skyrus
# grupavimo kintam�j�. Pavyzd�iui, apskai�iuosime kintam�j� Temp, Wind vidurkius 
# kiekvienam m�nesiui atskirai.

summarise_each(group_by(airquality, Month), funs(mean), Temp, Wind)

# Funkcij�, kuri� reik�mes reikia apskai�iuoti, s�ra�e gali b�ti ne viena. Pvz., 
# apskai�iuosime t� pa�i� stulpeli� reik�mi� vidurk� ir dispersij�.

summarise_each(group_by(airquality, Month), funs(mean, var), Temp, Wind)

# Apskai�iuotoms stulpeli� charakteristikoms galima suteikti vardus. Pavyzd�iui,
# rezultat� stulpeliai su vidurkio reik�m�mis tur�s priesag� E, o dispersijos D.

summarise_each(group_by(airquality, Month), funs(E = mean, D = var), Temp, Wind)

# Tuo atveju, kai stulpelio charakteristik� skai�iuojanti funkcija pati dar turi
# koki� nors parametr�, stulpel� atitinkantis parametrus joje �ymimas ta�ku. �i�
# situacij� galima pailiustruoti tokiu pavyzd�iu: reikia apskai�iuoti airquality
# lentel�s stulpelio Ozone vidurk�. �iame stulpelyje yra NA reik�mi�, tod�l tam, 
# kad b�t� galima apskai�iuoti vidurk�, reikia pakeisti funkcijos mean parametro 
# na.rm reik�m� i� FALSE � TRUE.

summarise_each(group_by(airquality, Month), funs(mean(., na.rm=T)), Ozone, Wind)


# NAUDINGA ------------------------------

# Galima pasteb�ti, kad visi veiksmai duomen� lentel�je atliekami su stulpeliais. 
# Funkcij� mutate ir summarise argumentas yra visos lentel�s stulpelis arba, jei 
# lentel� yra grupuota, - tam tikrai eilu�i� grupei priklausanti stulpelio dalis.

# Kartais tuos pa�ius veiksmus reikia atlikti su visomis lentel�s eilut�mis. Tai
# gali b�ti, pavyzd�iui, maksimalios reik�m�s suradimas eilut�je. Pvz., surasime
# maksimum� i� kintam�j� Sepal.Length, Petal.Length reik�mi� kiekvienai lentel�s
# iris eilutei.

# Vienas galimas b�das -- kiekvien� lentel�s eilut� sutapatinti su atskira grupe.
# Grupavimas atliekamas naudojant funkcij� group_by, o grup�s sutampa su eilu�i�
# numeriais.

summarise(group_by(iris, Nr. = 1:n()), max = max(Sepal.Length, Petal.Length))

# Kitas b�das -- naudoti specialiai tokiam atvejui skirt� dplyr funkcij� rowwise.

summarise(rowwise(iris), max = max(Sepal.Length, Petal.Length))

# T� pa�i� komand� u�ra�ysime naudojant operatori� %>%.

iris %>% rowwise() %>% summarise(max = max(Sepal.Length, Petal.Length))


# U�DUOTIS ------------------------------ 

# 1. Apskai�iuoti lentel�s airquality kintamojo Ozone praleist� reik�mi� skai�i� 
#    atskirai kiekvienam m�nesiui. U�ra�ykite komand� naudojant �i� paketo dplyr
#    funkcij�: a) count, b) n().
# 2. Naudodami lentel� airquality, nustatykite kiekvieno m�nesio kintamojo Ozone 
#    vidurk�, kai temperat�ra svyruoja intervale [70, 80].
# 3. Lentel�je airquality i� kiekvieno m�nesio i�skirkite po pirmas dvi eilutes.
#    U�ra�ykite 2 komandos versijas: a) su funkcija top_n, b) su funkcija slice.
# 4. I� lentel�s airquality i�skirkite po dvi kiekvieno m�nesio eilutes, kuriose
#    did�iausios to m�nesio stulpelio Temp reik�m�s i�rikiuotos ma��jimo tvarka.


# --------------------------------------- #
# KELI TIPINIAI DUOMEN� ANALIZ�S ATVEJAI  #
# --------------------------------------- #

# Paprastai duomen� lentel�s pertvarkymas susideda i� keli� �ingsni�: eilu�i� ir
# stulpeli� i�rinkimo, grupi� atskyrimo, tam tikr� charakteristik� �iose grup�se
# skai�iavimo ir rezultat� apjungimo. Labai da�nai �iuos etapus tenka pakartoti,
# priklausomai nuo situacijos atsisakyti kai kuri� etap�, keisti j� eili�kum� ir
# pana�iai. U�ra�ysime kelet� tipini� duomen� pertvarkymo pavyzd�i�. 

# Lentel�je airquality sura�yti keli� m�nesi� meteorologini� steb�jim� duomenys.
# Apskai�iuosime kiekvieno m�nesio temperat�ros vidurk�.

summarise(group_by(airquality, Month), vidurkis = mean(Temp))

# Naudojant operatori� %>%, t� pati komanda u�ra�oma tokiu b�du:

airquality %>% group_by(Month) %>% summarise(vidurkis = mean(Temp))

# I� esm�s tok� pat rezultat� galime gauti ir naudojant standartines R funkcijas
# tapply, by ir aggregate -- skiriasi tik rezultat� i�vedimo forma.

with(airquality, tapply(Temp, Month, mean))
with(airquality, by(Temp, Month, mean))
with(airquality, aggregate(Temp, list(r��is = Month), mean))


# �i split-apply-combine schema nesunkiai realizuojama naudojant standartines R
# funkcijas:
#                                      split 
#                                      |   |
#                                 sapply   lappy
#                                              |
#                                              stack

      sapply(with(airquality, split(Temp, Month)), mean) 
stack(lapply(with(airquality, split(Temp, Month)), mean))

# Tos pa�ios komandos u�ra�ytos naudojant %>% operatori�:

airquality %>% with(split(Temp, Month)) %>% sapply(mean)
airquality %>% with(split(Temp, Month)) %>% lapply(mean) %>% stack


# --------------------------------------- #

# Pavyzd�iui, naudojant lentel�s airquality duomenis, nustatysime kiekvieno m�n.
# dien� su ma�iausia to m�nesio temperat�ra.

select(filter(group_by(airquality, Month), Temp == min(Temp)), Month, Day, Temp)

# Vietoje funkcijos filter galima naudoti f-jas slice ir which.min. Tokiu atveju
# vietoje login�s s�lygos f-jai slice nurodomas konkretus eilut�s numeris, tod�l
# gaunama trumpesn� ir ai�kesn� komanda.

select(slice(group_by(airquality, Month), which.min(Temp)), Month, Day, Temp)

# Naudojant operatori� %>%, �ios dvi komandos u�ra�omos taip:

airquality %>% 
           group_by(Month) %>% 
                           filter(Temp == min(Temp)) %>% 
                                                     select(Month, Day, Temp)
airquality %>% 
           group_by(Month) %>% 
                           slice(which.min(Temp)) %>% 
                                                  select(Month, Day, Temp)

# Naudojant standartines R funkcijas split ir lapply, duomen� lentel� i� prad�i�
# padalinama � grupes, v�liau i� kiekvienos grup�s i�renkami reikiami stulpeliai
# ir reikiamos eilut�s. Kadangi galutin�je lentel�je lieka datos ir temperat�ros
# kintamieji, nereikaling� stulpeli� galima atsisakyti lentel�s grupavimo etape.
# �iuo atveju funkcijos lapply rezultatas yra data.table tipo duomen� lentel� su 
# viena eilute. � galutin� lentel� jas apjungiame naudojant do.call konstrukcij�
#
#                              do.call(f, x)
#
# �ia x yra list tipo s�ra�as, o f yra funkcija, kurios argumentai ir yra s�ra�e.
# Atskiros eilut�s � vien� data.frame lentel� apjungiamos naudojant R f-j� rbind.

G <- with(airquality, split(airquality[, c("Month", "Day", "Temp")], Month))
do.call(rbind, lapply(G, subset, subset = Temp == min(Temp)))

# Vietoje konstrukcijos do.call(rbind, ... ) eilu�i� i� s�ra�o apjungimui galima
# naudoti paketo dplyr funkcij� bind_rows.

bind_rows(lapply(G, subset, subset = Temp == min(Temp)))


# NAUDINGA ------------------------------

# Tarkim, kad reikia apskai�iuoti kiekvieno m�nesio santykin� praleist� reik�mi�
# da�n� lentel�s airquality stulpelyje Ozone. Tokiu atveju papras�iausia naudoti 
# standartin� R funkcij� tapply ir skai�iuoti reik�mi� NA indikatoriaus vidurk�.  

with(airquality, tapply(Ozone, Month, function(x) mean(is.na(x), na.rm = TRUE)))

# Kitas b�das -- naudojant f-j� split, i�skaidyti kintam�j� Ozone � grupes, tada,
# turint grupi� s�ra��, naudojant f-j� sapply, apskai�iuoti jose santykin� da�n�.

G <- with(airquality, split(Ozone, Month))
sapply(G, function(x) mean(is.na(x), na.rm = TRUE))

# Abiem atvejais santykinio da�nio apskai�iavimui reikia u�ra�yti anonimin� f-j�.
# Naudojant operatori� %>% galima sutrumpinti jos u�ra�ym�, kadangi ta�kas prie�
# operatori� %>% sukuria toki� funkcij�. U�ra�ysim nauj� komandos su f-ja tapply 
# variant�:

with(airquality, tapply(Ozone, Month, . %>% is.na %>% mean(na.rm = TRUE)))


# PASTABA! �i� komand� galima u�ra�yti visai be anonimin�s funkcijos. Tam reikia
# � grupes skaidyti ne pradin� kintam�j� Ozone, o i� karto funkcij� is.na(Ozone), 
# kurios reik�m�s perduodamos standartinei funkcijai mean su parametru na.rm.

with(airquality, tapply(is.na(Ozone), Month, mean, na.rm = TRUE))


# NAUDINGA ------------------------------

# Pagrindines duomen� pertvarkymo funkcijas papildo bendro pob�d�io funkcija do, 
# kuri leid�ia pritaikyti bet koki� funkcij� atskiroms duomen� lentel�s grup�ms.

# Pavyzd�iui, i� kiekvienos lentel�s iris kintamojo Species grup�s i�skirsime po
# tris pirmas eilutes. Pirmuosius n vektoriaus element� ar lentel�s eilu�i� rodo
# standartin� R funkcija head. U�ra�ysime toki� komand� naudojant operatori� %>%.

iris %>% group_by(Species) %>% do(head(., 3))

# Viena i� f-jos do pritaikymo sri�i� -- statistini� modeli� sudarymas atskiroms 
# duomen� grup�ms. Pvz., �vertinsime paprastosios tiesin�s regresijos modelio
#
#                               y = a + b*x + e
#
# parametrus a ir b, atskirai kiekvienai lentel�s iris kintamojo Species grupei.
# Tarkime, kad �ia y yra kintamasis Sepal.Length, o x --- kintamais Sepal.Width.
# U�ra�ysime toki� komand� naudojant operatori� %>%. Trumpas komentaras - ta�kas 
# i�rai�koje data = . nurodo, kad modelio duomenys bus viena lentel�s iris grup�.
# Kadangi kintamasis Species turi tris skirtingas reik�mes, grupi� irgi bus trys 
# ir tod�l gausime tris to paties modelio parametr� rinkinius.

M <- iris %>% 
          group_by(Species) %>% 
                            do(reg = lm(Sepal.Length ~ Sepal.Width, data = .))

# Gautos duomen� lentel�s M elementai yra tiesin�s regresijos modeliai. Tai gana
# ne�prasta, kadangi �prasta, jog duomen� lentel�s stulpeliai yra to paties tipo 
# reik�mes turintys vektoriai. Ta�iau �ia prie�taravimo n�ra, kadangi stulpeliai
# duomen� lentel�je yra list tipo s�ra�ai, o s�ra�ai tuo pa�iu yra ir vektoriai.

M

# Norint i� gautos lentel�s i�traukti modeli� parametrus, naudosime standartines
# funkcijas. Pavyzd�iui, modelio koeficientus gr��ina funkcija coef. �iuo atveju
# pirmas koeficientas atitinka parametr� a, antras - parametr� b. �ios funkcijos
# argumentas bus statistinis modelis, kuris yra lentel�s M stulpelio reg reik�m�.

summarise(M, grup� = Species, a = coef(reg)[1], b = coef(reg)[2])

# Gaut� modeli� parametrus galima apjungti � vien� data.frame lentel�s stulpel�. 
# �iuo atveju funkcij� data.frame �d�sime � funkcij� do. �ia galima pakomentuoti:
# ta�kas i�rai�koje coef(.$reg) nurodo lentel�s M eilut�, o .$reg nurodo eilut�s
# element� stulpelyje reg, o tai jau yra tiesin�s regresijos modelis. J� �dedame
# � funkcij� coef ir gauname modelio parametr� vektori�, �iuo atveju tai a ir b.
# Kadangi toki� eilu�i� lentel�je M yra trys, tai galutin�je lentel�je j� bus 6.

do(M, data.frame(r��is = .$Species, param = c("a", "b"), reik�m� = coef(.$reg)))


# Turint statistin� model�, �vairios jo charakteristikos gaunamos naudojant f-j�
# summary. Pvz., nustatysime vis� 3 modeli� determinacijos koeficiento reik�mes.

summarise(M, R = summary(reg)$r.squared)

# Funkcija summary suformuoja lentel� su modelio parametrais, j� std. nuokrypiu,
# hipotez�s apie j� lygyb�s nuliui statistika ir tos hipotez�s p-reik�me. Tokias
# lenteles apjungsime � vien� bendr� data.frame tipo lentel�.

do(M, data.frame(r��is = .$Species, param = c("a", "b"), coef(summary(.$reg))))


# U�DUOTIS ------------------------------ 

# 1. I� lentel�s airquality i�skirkite po pirmas tris kiekvieno m�nesio eilutes.
#    U�ra�ykite �i� komand� naudojant paketo dplyr funkcijas bei operatori� %>%.
#    Sugalvokite, kaip i�spr�sti �i� u�duoti naudojant standartines R funkcijas.
# 2. Naudojant lentel�s airquality duomenis, nustatykite, kurio m�nesio pirm� 15
#    dien� temperat�ros vidurkis did�iausias. U�ra�ykite komand� naudojant dplyr
#    funkcijas ir perra�ykite j� naudojant %>% operatori�.
# 3. U�ra�ykite funkcij�, kuri nustatyt�, kokios trys da�niausiai pasitaikan�ios
#    kintamojo Petal.Length reik�m�s b�dingos kiekvienai lentel�s iris kintamojo
#    Species reik�mei.
# 4. Naudojant duomen� lentel� iris, nustatykite, kuriai augal� r��iai vidutinis
#    kintam�j� Sepal.Length ir Sepal.Width santykis yra did�iausias. Sudarykite
#    �io santykio did�jimo tvarka i�rikiuot� rezultat� lentel�, kurioje dar b�t�
#    ir kintamasis Species.
