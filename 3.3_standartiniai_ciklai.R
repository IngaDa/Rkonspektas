
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Ciklai ir j� nutraukimo komandos.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2013-08-22 | 2013-08-25
#


# TURINYS -------------------------------

#
#   1. Cikl� for ir while konstrukcijos:
#      * komanda for
#      * komanda while
#
#   2. Ciklo nutraukimo komandos:  
#      * komanda repeat
#      * komanda next
#      * komanda break
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
# CIKLAS FOR                              #
# --------------------------------------- #

# Programavimo kalbose ciklai naudojami tokiuose algoritmuose, kur atliekami tam 
# tikri pasikartojantys veiksmai. J� skai�ius gali b�ti i� anksto �inomas arba 
# keistis priklausomai nuo ciklo metu tikrinam� s�lyg�.

# Ciklas for naudojamas tais atvejais, kai iteracij� skai�ius i� anksto �inomas.
# Duomen� analiz�je tai gali b�ti vektoriaus element� kiekis, matricos stulpeli�
# arba eilu�i� skai�ius, s�ra�o �ra�� skai�ius, nuskaitom� duomen� fail� kiekis, 
# modeliuojam� proces� skai�ius ir t.t. 

# Bendra ciklo for konstrukcija atrodo taip:
# 
#    for (var in set) {
#       i�rai�kos
#    }
# 
# Kintamasis var �gyja reik�mes i� indeks� aib�s set. �i aib� gali b�ti sudaryta
# i� bet kokia tvarka sura�yt� vektoriaus element� numeri�, matricos eilu�i� ar 
# stulpeli� numeri�, taip pat vard�, kod� ar kit� kintam�j�, kuri� reik�mes turi
# �gyti ciklo kintamasis var.

# I� eil�s einan�i� indeks� aib� papras�iausia nurodyti naudojant : operatori�. 
# Kai vektoriaus ar s�ra�o element� skai�ius i� anksto ne�inomas, jam nustatyti 
# galima naudoti funkcij� length.

# Pavyzd�iui, naudodami cikl� for, apskai�iuosime vis� vektoriaus element� sum�.

v <- c(19, 5, 2, 19, 29, 42, 32, 35, 25, 18, 6, 22, 7, 28, 11, 8, 9, 37, 45, 23)

suma <- 0

for (i in 1:length(v)) {
  suma <- suma + v[i]
}

suma

# Kadangi ciklo kintamasis turi perb�gti per vis� vektoriaus element� indeksus, 
# o ciklo viduje naudojamos vektoriaus element� reik�m�s, vietoje indeks� aib�s 
# galima nurodyti pat� vektori�. Tada sumavimo algoritmas u�ra�omas papras�iau.

suma <- 0

for (i in v) {
  suma <- suma + i
}

suma

# Paprastai vektoriaus element� sumavimui naudojama standartin� funkcija sum.
sum(v)


# I� eil�s einan�i� vektoriaus arba s�ra�o element� indeks� aib� galima sudaryti 
# ir naudojant funkcij� seq_along.

# Pavyzd�iui, apskai�iuosime tam tikr� rib� vir�ijan�i� vektoriaus element� sum�
# ir toki� element� skai�i�.

riba <- 30
suma <- 0
kiek <- 0

for (i in seq_along(v)) {
  if (v[i] > riba) {
    suma <- suma + v[i] 
    kiek <- kiek + 1
  }
}

suma
kiek

# Taip �i u�duotis tur�t� b�ti atlikta pagal R programavimo ideologij�.
sum(v[v > riba])
sum(v > riba)


# Indeks� aib� neb�tinai turi apimti visus vektoriaus elementus, be to, indeksai
# gali b�ti sura�yti bet kokia tvarka, jie gali kartotis ir t.t.

# Pavyzd�iui, sudarysime nelygini� vektoriaus element� indeks� aib� ir i�vesime
# juos � konsol�.

nelyginiai <- seq(1, length(v), by = 2)

for (i in nelyginiai) {
  cat("Elemento", i, "reik�m�:\n")
  print(v[i])
}

# Taip �i u�duotis tur�t� b�ti atlikta pagal R programavimo ideologij�.
v[nelyginiai]


# Indeks� aib� gali b�ti sudaryta ir ne i� skai�i�. J� gali sudaryti bet kokie
# kiti objektai. Pavyzd�iui, sudarysime aib� i� raid�i� ir patikrinsime, koks j�
# numeris lotyni�koje ab�c�l�je.

�odis <- c("L", "I", "E", "T", "U", "V", "A")

for (raid� in �odis) {
  numeris <- which(raid� == LETTERS)
  cat(raid�, numeris, "\n")
}


# Ciklus galima �d�ti vien� � kit�. Paprastai taip daroma atliekant veiksmus su 
# matricomis. Pavyzd�iui, sukursime 4x5 dyd�io nulin� matric� ir jos elementams 
# priskirsime t� element� eilut�s ir stulpelio numeri� sum�.

m <- matrix(0, nrow = 4, ncol = 5)

# Matricos eilu�i� ir stulpeli� skai�ius nustatomas naudojant funkcijas nrow ir 
# ncol.

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i, j] <- i + j
  }
}

m


# NAUDINGA ------------------------------

# Atliekant ilgai trunkan�ius skai�iavimus, � konsol� naudinga i�vesti papildom� 
# informacij� apie skai�iavim� progres�: tarpini� kintam�j� reik�mes, iteracijos 
# numer� ar laik�.

# Pavyzd�iui, � cikl� for �d�sime informacij� apie iteracijos numer� ir sumin�
# algoritmo veikimo laik�. �is laikas gaunamas kaip skirtumas tarp dviej� laiko 
# moment�: vienas u�fiksuojamas prie� cikl�, kitas - kiekvienos iteracijos metu. 
# Tam naudojama funkcija proc.time.

# Informacija � konsol� i�vedama kiekvienos iteracijos metu, ta�iau pati konsol�
# atnaujinama tik i��jus i� ciklo. Konsol�s atnaujinimui naudojama funkcija
# flush.console.

# Vietoje ilgai trunkan�i� skai�iavim� �ia cikle �d�ta funkcija Sys.sleep, kuri 
# nustatytam laiko intervalui sustabdo bet kokius skai�iavimus. �iuo atveju tai
# vienos sekund�s pauz�.

start.time <- proc.time()
n <- 10

for (i in 1:n) {

  # I�vedame informacij� apie iteracijos numer� ir bendr� laik�.
  info.index <- formatC(i, digits = 0, width = 2, format = "f", flag = "0")
  info.time  <- proc.time()[3] - start.time[3]
  cat("Iteracija", info.index, "i�", n, " .�. ", info.time, "\n")
  flush.console()

  Sys.sleep(1)
}


# U�DUOTIS ------------------------------ 

# 1. Tarkim, kad vektoriaus element� reik�m�s gautos vienodais laiko intervalais
#    matuojant tam tikr� kintant� dyd�. Toks vektorius vadinamas laiko eilute. 
#    Statistikoje da�nai taikomas laiko eilut�s glodinimas slenkan�iu vidurkiu.
#    Sudarykite vektori�, kurio pirmojo elemento reik�m� b�t� lygi vektoriaus v
#    1, 2 ir 3 element� vidurkiui, antro elemento reik�m� -- 2, 3, ir 4 element� 
#    vidurkiui ir taip toliau iki galo. 
# 2. U�ra�ykite algoritm�, kuris surast� did�iausia reik�m� turint� vektoriaus v
#    element� ir nustatyt� jo eil�s numer�.
# 3. Naudodami cikl� for, sudarykite vektori�, kurio elementai lyg�s matricos m
#    eilu�i� sumoms.
# 4. Naudodami cikl� for, u�ra�ykite algoritm� nat�rinio skai�iaus n faktorialui
#    apskai�iuoti.


# --------------------------------------- #
# CIKLAS WHILE                            #
# --------------------------------------- #

# Ciklas while naudojamas tada, kai tam tikrus pasikartojan�ius veiksmus reikia
# kartoti tol, kol tenkinama tam tikra s�lyga. Bendra ciklo while konstrukcija 
# atrodo taip:
# 
#    while (login� s�lyga) {
#       i�rai�kos
#    }

# S�lyga turi b�ti tokia, kad ciklas netapt� am�inas. Tai rei�kia, kad tam tikru 
# momentu login�s s�lygos reik�m� b�tinai turi tapti FALSE.

# Pavyzd�iui, u�ra�ysime algoritm� skai�iaus n faktorialui apskai�iuoti.

n <- 5
faktorialas <- 1
 
while (n > 0) {
  faktorialas <- faktorialas * n
  n <- n - 1
}
 
faktorialas

# Paprastai faktorial� skai�iavimui naudojama standartin� funkcija factorial.
factorial(5)


# Cikl� while kartais galima naudoti ir tokiose situacijoje, kur tinka ir ciklas
# for. Pavyzd�iui, patikrinsime, ar simboli� seka vienodai skaitoma i� abiej� 
# pusi�. Tokia skai�i� arba simboli� seka vadinama palindromu.

s <- c("S", "�", "D", "�", "K", "U", "�", "U", "K", "�", "D", "�", "S")

# Loginiam kintamajam palindromas i� karto priskiriama reik�m� TRUE. Tada pirm�
# element� lyginame su paskutiniu, antr� su prie�paskutiniu i� taip toliau iki 
# vektoriaus vidurio. Jei nors viena pora nesutampa, tai kintamajam palindromas
# priskiriama reik�m� FALSE.

i <- 0
k <- length(s)

palindromas <- TRUE

while (i < k/2) {
  i <- i + 1
  cat("Raid�i� pora:", s[i], s[k-i+1], "\n")
  if (s[i] != s[k-i+1]) palindromas <- FALSE
}

palindromas


# U�DUOTIS ------------------------------ 

# 1. Naudodami cikl� while, apskai�iuokite, kiek i� eil�s einan�i� vektoriaus v 
#    element� reikia susumuoti, norint gauti did�iausi� sum� nevir�ijan�i� 100.
#    Login� s�lyg� reikia u�ra�yti taip, kad susumavus visus elementus, bet sumai 
#    nevir�ijus 100, ciklas b�t� nutraukiamas.
# 2. Naudodami cikl� while, u�ra�ykite vektoriaus element� i�rikiavimo prie�inga
#    tvarka algoritm�.


# --------------------------------------- #
# CIKLAS REPEAT IR JO NUTRAUKIMAS         #
# --------------------------------------- #

# Ciklas repeat labai pana�us � cikl� while, ta�iau ciklo nutraukimo s�lyga 
# tikrinama ciklo viduje: 
# 
#    repeat {
#       i�rai�kos
#       if (login� s�lyga) break
#    }

# Pavyzd�iui, u�ra�ysime algoritm�, kuris skai�iavimus nutraukia po tam tikro 
# laiko tarpo. �iuo atveju tai bus 1 sekund�. � konsol� bus i�vedamas iteracijos 
# numeris.

start.time <- proc.time()
i <- 0

repeat {
  i <- i + 1
  cat(i, "\n")
  flush.console()

  laikas <- proc.time()[3] - start.time[3]
  if (laikas > 1) break
}


# Kartais cikl� reikia nutraukti d�l skai�iavim� metu susidariusi� s�lyg�. Tai
# gali b�ti praleista ar neapibr��ta reik�m� duomenyse, ma�as stebini� skai�ius
# ar kitokia nekorekti�ka situacija. Bet kokio tipo ciklui nutraukti naudojamos 
# dvi komandos: 
#
#     next -- nutraukia iteracij� ir pereina prie sekan�ios,
#    break -- nutraukia cikl� ir i�eina i� jo.

# Pavyzd�iui, naudojant cikl� for, susumuosime tik nelygines reik�mes turin�ius 
# vektoriaus v elementus. Jei elemento reik�m� lygin�, tai sumavimo veiksmas
# praleid�iamas ir pereinama prie sekan�io elemento.

suma <- 0

for (i in v) {
  if (i %% 2 == 0) next
  suma <- suma + i
  cat("Elemento reik�m�:", i, "\n")
}

suma

# Sumavimo i�rai�k� galima �d�ti � if-else konstrukcij� ir u�ra�yti kiek kitaip.
suma <- 0

for (i in v) {
  if (i %% 2 == 1) suma <- suma + i else next
}

suma

# Taip �i u�duotis tur�t� b�ti atlikta pagal R programavimo ideologij�.
sum(v[v %% 2 == 1])


# Nors ciklui for nurodomas fiksuotas iteracij� skai�ius, bet esant tam tikroms
# s�lygoms cikl� galima nutraukti anks�iau. Pavyzd�iui, nutrauksime cikl�, jei
# trij� i� eil�s vektoriaus v element� reik�m�s vir�ija 30.

# Ciklo viduje � atskir� vektori� i�skiriame tris i� eil�s einan�ius elementus,
# pa�ym�kime j� indeksus atitinkamai j - 2, j - 1 ir j. Kadangi pilnas trejetas 
# susidaro tik nuo tre�iojo elemento, tai pirmasis indeksas j - 2 iki tol �gyj� 
# reik�m� -1 arba 0, ir vektoriaus element� su tokiais indeksais n�ra. D�l to 
# �vedamas tarpinis kintamasis i = j - 2, kurio reik�m� lygi 1, jei j - 2 < 1.

riba <- 30

for (j in seq_along(v)) {
  i <- max(1, j - 2)
  t <- v[i:j]
  cat("Numeris:", j, "\n")
  cat(t, "\n")

  if (all(t > riba)) {
    cat("Trys i� eil�s reik�m�s didesn�s u� ", riba, "! ", sep = "")
    cat("Skai�iavimai nutraukiami.\n", sep = "")
    break  
  }
}


# U�DUOTIS ------------------------------ 

# 1. U�ra�ykite vektoriaus element� sumavimo cikl� for, kuris nutraukiamas, jei 
#    vektoriaus elemento reik�m� yra NA. I�einant i� ciklo, � konsol� i�vedamas
#    prane�imas, kad ciklas nutraukiamas d�l praleistos reik�m�s duomenyse.
# 2. Naudodami cikl� for, apskai�iuokite didesni� nei 30 vektoriaus v element�
#    sum� ir �i� element� skai�i�. Netenkinan�i� �ios s�lygos element� sumavim�
#    praleiskite naudojant komand� next.
