
#
#   Dalykas: STATISTIN�S DUOMEN� ANALIZ�S SISTEMA IR PROGRAMAVIMO KALBA R
#            Grafiniai �renginiai. Vektorin� ir rastrin� grafika.
#
#  Autorius: Tomas Reka�ius
#
#   Sukurta: 2015-03-07 | 2015-04-09
#


# TURINYS -------------------------------

#
#   1. Trumpai apie grafinius �renginius:
#      * Devices
#
#   2. Grafiko brai�ymas kompiuterio ekrane:
#      * windows
#      * x11
#      * X11
#      * win.graph
#      * win.metafile
#      * win.print
#
#   3. Grafiko i�saugojimas � vektorin�s grafikos fail�:
#      * pdf
#      * pdfFonts
#      * pdf.options
#      * postscript
#
#   4. Grafiko i�saugojimas � rastrin�s grafikos fail�:
#      * png
#      * bmp
#      * jpeg
#      * tiff
#


# PASTABOS ------------------------------

#
# Sugalvoti u�davini�.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuvi�ka lokal�. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# I�trinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE GRAFINIUS �RENGINIUS       #
# --------------------------------------- #

# Grafiko atvaizdavimui naudojamas grafinis �renginys. Tai gali b�ti kompiuterio 
# ekranas, spausdintuvas arba kokio nors tipo grafinis failas, pvz., pdf, png ir 
# dar keletas kit�. Vis� R kalboje naudojam� grafini� �rengini� s�ra�as:

?Devices

# Jei nenurodyta kitaip, auk�to lygio grafin�s f-jos grafik� atvaizduoja ekrane,
# o j� atitinkan�io �renginio pavadinimas priklauso nuo operacin�s sistemos:
# 
#    windows -- MS Windows
#        X11 -- Unix arba Linux
#     quartz -- OS X


# Naudojant kitokius grafinius �renginius, grafik� galima i�saugoti � fail�. Tai 
# gali b�ti rastrin�s arba vektorin�s grafikos tipo failai:
#           ---------      ----------
#           bmp            pdf   
#           gif            postscript
#           jpeg           svg
#           tiff
#           png


# --------------------------------------- #
# GRAFIKO BRAI�YMAS KOMPIUTERIO EKRANE    #
# --------------------------------------- #

# MS Windows operacin�je sistemoje grafin� lang� kompiuterio ekrane atidaro f-ja
# windows. Pagrindiniai jos parametrai yra tokie:
#
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango auk�tis coliais,
#    rescale -- taisykl�, pagal kuri� nustatomas grafiko mastelis,
#  pointsize -- ta�ko dydis, 
#         bg -- grafiko fono spalva,
#     canvas -- grafinio lango pagrindo spalva,
#       xpos -- pradin�s lango pozicijos ekrane koordinat� x,
#       ypos -- pradin�s lango pozicijos ekrane koordinat� y,
#      title -- grafinio lango pavadinimas,
#     family -- �rifto �eima,
#  antialias -- �rifto glodinimo metodas.


# Jeigu nenurodomas joks parametras, funkcija windows atidaro 7 x 7 coli� dyd�io
# standartin� grafin� lang�. Tuo galima �sitikinti patikrinus grafinio parametro
# din reik�m�.

windows()
par("din")

# Grafinio lango dydis nustatomas per parametrus width ir height. Pvz, sukursime
# 8 x 4 coli� dyd�io grafin� lang� ir jame nubrai�ysime f-jos y = sin(x) grafik�
# intervale [-3pi, 3pi].

windows(8, 4)
plot(sin, -3*pi, 3*pi)


# Parametras rescale nurodo, kaip turi b�ti atnaujinamas grafikas, kai kei�iamas
# lango, kuriame jis nubrai�ytas, dydis. Galimos parametro reik�m�s:
#
#        "R" -- nurodo, kad grafiko dydis sutampa su lango dyd�iu,
#      "fit" -- grafikas perbrai�omas i�laikant kra�tini� santyk�,
#     fixed" -- nurodo, kad grafiko dydis yra fiksuotas.

# Standartin� parametro reik�m� - "R", tod�l, kei�iant grafinio lango dyd� (pvz., 
# su pele), jame nubrai�yto grafiko dydis taip pat kei�iasi, grafikas u�ima vis�
# lang�. Jei parametrui priskiriama reik�m� "fit", tada grafikas i�laiko pradin� 
# kra�tini� santyk�, ta�iau, priklausomai nuo grafinio lango dyd�io, kei�iasi jo
# �rifto dydis.

windows(rescale = "fit")
plot(sin, -pi, pi, main = "Grafinis langas su fiksuotu grafiko kra�tini� santykiu")


# Parametras pointsize nustato ta�ko dyd�. Nuo jo priklauso teksto �rifto dydis.
# Standartin� parametro reik�m� 12. Pavyzd�iui, nubrai�ysime grafik� su 8 dyd�io 
# �riftu.

windows(pointsize = 8)
plot(sin, -pi, pi, main = "Parametro pointsize reik�m� lygi 8")


# �rifto, kuriuo ra�omos grafiko ir a�i� antra�t�s bei padal� pavadinimai, �eim� 
# nusako parametras family. Standartin� parametro reik�m� yra "", kiti variantai 
# tokie:
# 
#    "serif" -- lotyni�kas �riftas, pvz., Times,
#     "sans" -- groteskinis �riftas, pvz., Aria, Helvetica,
#     "mono" -- pastovaus plo�io �riftas, pvz., Courier.

# Pvz., nustatysime, kad naujai atidarytame grafiniame lange pagrindinis grafiko
# �riftas b�t� i� "mono" �eimos.

windows(family = "mono")
plot(sin, -pi, pi)

# Galima priminti, kad grafike naudojamo �rifto �eima gali b�ti nustatoma ir per 
# grafin� parametr� family.

par(family = "mono")
plot(sin, -pi, pi)


# Parametras antialias nustato �rift� glodinimo metod�, nuo kurio priklauso kaip 
# jie atrodys ekrane. Pavyzd�iui, nubrai�ysime grafik�, kuriame sura�yti m�nesi�
# pavadinimai. Vienu atveju glodinimas nenaudojamas, kitu -- naudojamas.

windows(antialias = "none")
plot(0, 0, type = "n", main = "�riftas nesuglodintas")
text(0, 0, paste(month.name, collapse = "\n"), cex = 2)

windows(antialias = "cleartype")
plot(0, 0, type = "n", main = "�riftas suglodintas")
text(0, 0, paste(month.name, collapse = "\n"), cex = 2)


# Naujai atidarytam grafinim langui automati�kai priskiriamas eil�s numeris, bet, 
# naudojant parametr� title, jam galima suteikti bet kok� pavadinim�. 

windows(title = "Trigonometrin�s funkcijos grafikas")
plot(sin, -pi, pi)

# Parametrai xpos, ypos nustato naujo grafinio lango viet� ekrane. Ta�kas (0, 0) 
# atitinka vir�utin� kair�s pus�s kamp�. Standartin� lango pozicija - vir�utinis 
# de�in�s pus�s kampas, kur� atitinka ta�kas (-25, 0). Neigiamos reik�m�s nurodo, 
# kad langas atitraukiamas nuo de�inio ir apatinio ekrano kra�to. 

windows(xpos = -10, ypos = -25)


# Parametrai bg ir canvas nustato grafiko fono ir grafinio lango pagrindo spalv�.
# Pagrindas matomas tik tada, jei fono spalva yra permatoma. Kadangi standartin� 
# parametro bg reik�m� yra "transparent", grafikuose matome balt� grafinio lango
# pagrindo spalv�. 

# Pavyzd�iui, nubrai�ysime grafikus su skirtingomis fono bei pagrindo spalvomis.

windows(bg = "skyblue")
plot(sin, -pi, pi)

windows(canvas = "red")
plot(sin, -pi, pi)

# Jeigu pagrindo ir fono spalvas nurodome kartu, grafike bus matoma fono spalva.
# �ia fono spalv� "skyblue" nurodome RGB kodu.

windows(canvas = "red", bg = rgb(0.53, 0.81, 0.92))
plot(sin, -pi, pi)

# Jeigu fono spalva permatoma (tai reguliuojama parametru alpha), grafike matosi 
# ir grafinio lango pagrindo spalva.

windows(canvas = "red", bg = rgb(0.53, 0.81, 0.92, alpha = 0.5))
plot(sin, -pi, pi)


# Funkcijos windows, win.graph, x11 ir X11 yra tos pa�ios funkcijos realizacijos.
# Jos reikalingos d�l suderinamumo su kitomis operacin�mis sistemomis, nes Linux
# bei Unix sistemoje tas pats �renginys vadinasi X11. Funkcijos x11 bei X11 turi 
# ma�iau parametr�, ta�iau jie, galima sakyti, yra esminiai:
#
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango auk�tis coliais,
#  pointsize -- ta�ko dydis, 
#         bg -- grafiko fono spalva,
#       xpos -- pradin�s lango pozicijos ekrane koordinat� x,
#       ypos -- pradin�s lango pozicijos ekrane koordinat� y,
#      title -- grafinio lango pavadinimas.

x11(8, 6, pointsize = 11, bg = "skyblue", title = "x11 langas")
plot(sin, -pi, pi)


# MS Windows operacin�je sistemoje u� grafini� objekt� atvaizdavim� skirtinguose 
# grafiniuose �renginiuose, tokiuose kaip monitorius ar spausdintuvas, atsakinga 
# GDI (Graphics Device Interface). Tai leid�ia gauti prakti�kai tok� pat� vaizd� 
# monitoriuje, faile arba spausdintuve. Tam R gali b�ti naudojamos �ios f-jos:
#
#        win.graph
#        win.metafile 
#        win.print

# Pavyzd�iui, naudodami �ias funkcijas, t� pat� grafik� atvaizduosime ekrane, j�
# i�saugosime � Windows Metafile (wmf) tipo fail� ir nukreipsime � spausdintuv�.

win.graph()
plot(sin, -pi, pi, main = "Grafikas ekrane")
dev.off()

win.metafile(file = "grafikas.wmf")
plot(sin, -pi, pi, main = "Grafikas faile")
dev.off()

win.print(printer = "")
plot(sin, -pi, pi, main = "Grafikas spausdinimui")
dev.off()


# NAUDINGA ------------------------------

# Ta�k� tank� colyje (pixels per inch, PPI) nustato parametrai xpinch ir ypinch. 
# Standartin�s �i� parametr� reik�m�s priklauso nuo ekrano skiriamosios gebos ir 
# apskai�iuojamos automati�kai. Pavyzd�iui, jei PPI = 96, tai 7 x 7 dyd�io lange
# nubrai�ytas grafikas yra 672 x 672 ta�k� dyd�io. Spaudoje naudojamas PPI = 300.

# Jeigu parametr� xpinch ir ypinch reik�m�s skiriasi, grafinis langas ekrane yra
# i�tempiamas. Pavyzd�iui, tegu parametro xpinch reik�m� bus dvigubai didesn� u�
# ypinch reik�m�. Ekrane toks grafikas i�temptas horizontaliai, ta�iau formaliai
# jis i�liko kvadratinis. Jeigu spausdinant b�t� atsi�velgiama � skirting� ta�k� 
# tank�, grafikas ant popieriaus taip pat b�t� kvadratinis. Tai rodo ir grafinio 
# parametro din reik�m�. 

windows(7, 7, xpinch = 160, ypinch = 80)
plot(sin, -pi, pi, main = "Kvadratinis grafikas")
par("din")

# Pavyzd�iui, jei grafikas turi b�ti 900 x 600 dyd�io, tai, �inant, kad PPI = 96,
# grafinio lango dydis turi b�ti 900/96 = 9.375 plo�io ir 6.25 auk��io (coliais).

windows(width = 9.38, height = 6.25, xpinch = 96, ypinch = 96)
plot(sin, -pi, pi, main = "900 x 600 ta�k� dyd�io grafikas")

# Jei standartiniame 7 x 7 coli� grafiniame lange nubrai�ytas grafikas turi b�ti
# 700 x 700 ta�k� dyd�io, tai PPI turi b�ti 100.

windows(7, 7, xpinch = 100, ypinch = 100)
plot(sin, -pi, pi, main = "700 x 700 ta�k� dyd�io grafikas")


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# VEKTORIN� GRAFIKA                       #
# --------------------------------------- #

# �iuo metu labiausiai paplit� du nuo operacin�s sistemos ir programin�s �rangos
# nepriklausantys elektronini� dokument� formatai:
#
#         ps -- PostScript,
#        pdf -- Portable Document Format.
#
# PostScript ir PDF tipo dokumentai pla�iai naudojami elektronin�je leidyboje ir
# spaudoje, kur reikalinga auk�ta poligrafin� teksto ir grafikos kokyb�.

# PostScript yra auk�to lygio programavimo kalba, kuri skirta teksto ir grafikos
# tu��iame puslapyje apra�ymui. Galima sakyti, kad PostScript dokumentas tai yra 
# tokia programa, kuri spausdintuvui nurodo, kaip atvaizduoti dokumente apra�yt�
# puslap�. Paprastai dokument� su PostScript programa generuoja kitos programos. 
# Norint pa�i�r�ti, kaip atrodys PostScript dokumentas, reikia tur�ti PostScript
# kalbos interpretatori�. Pvz., tam galima naudoti program� Ghostscript.

# PDF yra PostScript kalbos pagrindu sukurtas elektroninio dokumento formatas. �
# tok� fail� galima �traukti tekst� kartu su jam reikalingais �riftais, rastrin�
# ir vektorin� grafik�. Dokument� PDF formatu gali i�saugoti grafiniai ar teksto
# redaktoriai. PDF dokumentui per�i�r�ti reikia specialios programos, pavyzd�iui, 
# SumatraPDF.


# Grafik� i�saugojimui PostScript ar PDF formatu naudojamos f-jos postscript bei 
# pdf. �ia pla�iau aptarsime tik funkcij� pdf, kurios pagrindiniai parametrai ir
# j� standartin�s reik�m�s yra tokie patys kaip ir funkcijos windows, ta�iau kai 
# kurie i� j� yra specifiniai PDF dokumentams:
#
#       file -- pdf failo pavadinimas,
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango auk�tis coliais,
#  pointsize -- ta�ko dydis,
#         bg -- grafiko fono spalva,
#         fg -- grafiko ta�k� ir linij� spalva,
#      title -- � pdf fail� �ra�omas grafiko pavadinimas,
#     family -- grafike naudojamo �rifto �eima,
#   encoding -- �rifto koduot�,
#    onefile -- nurodo, ar faile galima brai�yti kelis grafikus,
#      paper -- popieriaus lapo dydis,
# pagecentre -- nurodo, ar grafik� atvaizduoti puslapio centre.


# Papras�iausiu atveju u�tenka nurodyti pdf dokumento, � kur� bus atvaizduojamas 
# grafikas, vard�. Jeigu prie� tai, naudojant funkcij� setwd, nurodomas darbinis 
# katalogas, failo vardas gali b�ti trumpas, prie�ingu atveju -- reikia nurodyti 
# piln� keli� iki failo. Nubrai�ius grafik�, ra�ymas � pdf fail� nutraukiamas, o
# grafinis �renginys u�daromas. Tam naudojama speciali funkcija dev.off().

# Pavyzd�iui, nubrai�ysime paprast� funkcijos y = sin(x) grafik� ir �ra�ysime j� 
# � fail� "grafikas.pdf", kuris bus sukurtas darbiniame kataloge. Pasitikslinti,
# kuris katalogas yra darbinis, galima naudojant funkcij� getwd().

pdf(file = "grafikas.pdf")
  plot(sin, -pi, pi, main = "Funkcijos y = sin(x) grafikas")
dev.off()


# Labai da�nai grafikui nubrai�yti reikia keletos grafini� funkcij� ir papildom�
# skai�iavim�. Tokiu atveju visos grafin�s f-jos ra�omos tarp pdf() ir dev.off().

pdf(file = "grafikas.pdf")

  # nubrai�ome funkcijos grafik� be Ox a�ies ir r�melio
  plot(sin, -pi, pi, las = 1, xaxt = "n", frame = FALSE)

  # apskai�iuojame Ox a�ies padalas ir sudarome j� pavadinimus
  Ox <- seq(-pi, pi, by = pi/2)
  Lx <- expression(-pi, -pi/2, 0, pi/2, pi)

  # ant grafiko u�dedame Ox a��
  axis(1, at = Ox, labels = Lx)

  # u�dedame prie Ox a�ies padal� priderint� tinklel�
  abline(v = Ox, h = -2:2/2, lty = "dotted", col = "gray80")

  # u�ra�ome pagrindin� grafiko antra�t�
  title(main = "Funkcijos y = sin(x) grafikas")

dev.off()


# Grafiko dyd� nustato parametrai width ir height. Jeigu nenurodyta kitaip, tada
# standartinio grafiko dydis yra 7 x 7 colio. Parametras pointsize nustato ta�ko 
# dyd�, nuo kurio priklauso teksto �rifto dydis. Pvz., nubrai�ysime 6 x 4 dyd�io
# grafik� su 8 dyd�io �riftu.

pdf(file = "grafikas.pdf", width = 6, height = 4, pointsize = 8)
  plot(Nile)
dev.off()


# Puslapio, kuriame atvaizduojamas grafikas, dydis priklauso nuo parametro paper. 
# Standartin� jo reik�m� "special" nurodo, kad puslapio dydis sutampa su grafiko
# dyd�iu, ta�iau puslapis gali tur�ti savo format�. Kitos parametro reik�m�s yra 
# tokios:
# 
#       "a4" -- 8.27 x 11.7 in (210.0 x 297.0 mm),
#   "letter" -- 8.50 x 11.0 in (215.9 x 279.4 mm),
#    "legal" -- 8.50 x 14.0 in (215.9 x 355.6 mm),
#
#      "a4r" -- pasuktas A4 formatas,
#      "USr" -- pasuktas Legal formatas.

# Standarti�kai grafikas vaizduojamas puslapio centre. Tai priklauso nuo loginio 
# parametro pagecentre. Jam priskyrus reik�m� FALSE, grafikas bus atvaizduojamas
# viename puslapio kampe.

# Pavyzd�iui, ant pasukto A4 formato puslapio nubrai�ysime i� karto du grafikus.
# Kadangi standartin� parametro pagecenter reik�m� lygi TRUE, grafikas brai�omas 
# puslapio centre.

pdf(file = "grafikas.pdf", width = 11, height = 6, paper = "a4r")
  par(mfrow = c(1, 2))
  plot(Nile, frame = FALSE)
  hist(Nile, main = "")
dev.off()


# PDF dokumente naudojamo �rifto �eim� nustato parametras family. Problema tame,
# kad standartin�s reik�m�s "serif", "sans" arba "mono" PDF dokumentuose rei�kia
# tam tikr� konkret� �rift�, pavyzd�iui:
#
#    "serif" -- "Times"
#     "sans" -- "Helvetica"
#     "mono" -- "Courier"

# Ry�� tarp standartin�je R grafikoje naudojamos �rift� �eimos ir konkretaus PDF 
# dokumento �rifto nusako funkcija pdfFonts.

pdfFonts("serif")
pdfFonts("sans")
pdfFonts("mono")

# Be to, PDF dokumente galima naudoti ir kitus �riftus. Pavyzd�iui, gausime vis� 
# j� s�ra��.

names(pdfFonts())


# Tai, kokiu �enklu bus atvaizduota raid� (tiksliau - raid� atitinkantis kodas), 
# priklauso nuo koduot�s. Lotyni�kos ab�c�l�s pagrindu sudaryta ASCII koduot� i�
# viso koduoja 256 simbolius. Kodai nuo 0 iki 127 koduoja skaitmenis, did�i�sias 
# ir ma��sias lotyni�kos ab�c�l�s raides, skyrybos �enklus ir specialius valdymo 
# simbolius. Lik� 128 kodai naudojami papildomiems simboliams, tarp j� gali b�ti 
# ir nacionalini� ab�c�li� simboliai. Priklausomai nuo to, kokiais simboliais �i
# lentel� papildoma, gaunama viena ar kita koduot�.

# Vakar� Europos kalboms, kurios naudoja lotyni�k� ab�c�l�, naudojama ISO 8859-1 
# koduot�, kuri dar vadinama Latin-1. MS Windows operacin�je sistemoje j� beveik 
# visi�kai atitinka Windows-1252 (CP-1252) koduot�. Savo koduotes turi Centrin�s
# ir Ryt� Europos kalbos, balt� kalbos, taip pat graik� kalba bei kalbos, kurios 
# savo ra�tui naudoja kirilic�.

# PDF dokumento koduot� priklauso nuo parametro encoding reik�m�s. Paprastai yra
# naudojamos tokios koduot�s:
#
#  "WinAnsi" -- Western European,
#   "CP1250" -- Central European,
#   "CP1251" -- Cyrillic,
#   "CP1253" -- Greek,
#   "CP1257" -- Baltic.

# Standartin� parametro reik�m� "default" gali reik�ti bet kuri� i� �i� koduo�i�.
# Tai priklauso nuo to, kokia koduot� naudojama R aplinkoje, bet da�niausiai tai
# yra "WinAnsi" (kuri i� tikro turi b�ti vadinama Windows-1252).

# Pavyzd�iui, t� pat� grafik� atvaizduosime � PDF fail� naudodami dvi skirtingas 
# koduotes. Galima pasteb�ti, kad � Windows-1252 koduot� i� 9 lietuvi�k� raid�i�
# patenka tik � ir �, o likusios atvaizduojamos nekorekti�kai.

pdf(file = "grafikas.pdf", encoding = "WinAnsi")
  plot(0, 0, type = "n", frame = FALSE, main = "WinAnsi, Western European")
  text(0, 0, "Lietuvi�kos raid�s\n ���������\n arba matosi, arba ne.", cex = 3)
dev.off()

pdf(file = "grafikas.pdf", encoding = "CP1257")
  plot(0, 0, type = "n", frame = FALSE, main = "CP-1257, Baltic")
  text(0, 0, "Lietuvi�kos raid�s\n ���������\n arba matosi, arba ne.", cex = 3)
dev.off()


# NAUDINGA ------------------------------

# Per�i�r�ti PDF dokumento parametr� reik�mes galima naudojant f-j� pdf.options.

pdf.options()

# �i� funkcij� galima panaudoti tuo atveju, kai reikia nubrai�yti i� karto kelis 
# grafikus su vienodomis PDF parametr� reik�m�mis. Nusta�ius visiems dokumentams
# bendr� parametr� reik�mes, funkcijai pdf u�tenka nurodyti tik failo vard�.

pdf.options(width = 6, height = 4, pointsize = 8, encoding = "CP1257")

pdf(file = "grafikas-1.pdf")
  plot(Nile)
dev.off()

pdf(file = "grafikas-2.pdf")
  hist(Nile)
dev.off()

pdf(file = "grafikas-3.pdf")
  boxplot(Nile)
dev.off()


# Naudojant �i� funkcij�, galima atstatyti standartines vis� parametr� reik�mes.

pdf.options(reset = TRUE)


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# RASTRIN� GRAFIKA                        #
# --------------------------------------- #

# Rastrin�s grafikos paveiksle vaizdas sudarytas i� daug ta�k�, kuri� kiekvienas 
# yra tam tikros spalvos ir u�ima tam tikr� viet�. Svarbiausios charakteristikos
# tai paveikslo dydis ta�kais ir spalv� skai�ius. Dydis da�niausiai i�rei�kiamas
# pikseli� skai�iumi � plot� ir auk�t�, spalv� skai�ius nusakomas bit� skai�iumi.
# Pvz., jei spalvoms koduoti skiriami 8 bitai, tada tokiame paveiksle naudojamos
# 256 spalvos. 

# Kadangi kiekvienas ta�kas gali b�ti skirtingos spalvos, rastrin� grafika labai
# gerai tinka fotografijai bei kitiems sud�tingiems vaizdams fiksuoti ir saugoti, 
# ta�iau rastriniu formatu saugomas vaizdas u�ima daugiau vietos negu vektoriniu.
# Be to, kei�iant mastel� arba atliekant kitas geometrines transformacijas, pvz., 
# pasukant, prarandama vaizdo kokyb�.

# Daugeliui �rengini� rastrin� grafika yra nat�ralus b�das atvaizduoti tam tikr�
# vaizd�: tai skaitmenin� fotokamera, kompiuterio ekranas, spausdintuvas ir t.t. 
# Labiausiai paplit� �ie rastrin�s grafikos fail� formatai:
#
#        png -- Portable Network Graphics,
#        bmp -- Bitmap Image File,
#       jpeg -- Joint Photographic Experts Group,
#       tiff -- Tagged Image File Format.

# Kiekvienas failo formatas turi savo pritaikymo srit�. Pavyzd�iui, BMP formatas 
# naudojamas nesuspaustiems rastriniams vaizdams saugoti ir yra nat�tali Windows
# OS grafin�s sistemos dalis. JPEG tai rastrini� vaizd� saugojimo bei suspaudimo 
# metodas. Jis da�niausiai naudojamas skaitmetin�je fotografijoje ir �em�lapiams
# atvaizduoti. Vaizdo suspaudimo laipsn� galima nustatyti, ta�iau �ia prarandama
# informacija, tod�l nuken�ia paveikslo kokyb�. D�l tos prie�asties JPEG netinka 
# br��iniams bei diagramoms vaizduoti. PNG formate vaizdo suspaudimas atliekamas 
# be informacijos praradimo. PGN formatas naudojat tik RGB spalv� sistem�, tod�l
# netinka spaudai, bet grafikams, diagramoms ir br��iniams tinka geriau nei JPEG.
# Spaudoje pla�iai naudojamas TIFF formatas, kuriame suspaudimas gali b�ti ir be 
# informacijos praradimo, ir su praradimu, o spalvoms naudojamos ir RGB, ir CMYK
# sistemos.

# Grafikams i�saugoti rastriniu formatu R turi funkcijas bmp, jpeg, png ir tiff. 
# Beveik visi �i� funkcij� parametrai yra tie patys, svarbiausi i� j� yra tokie:
#
#       file -- failo pavadinimas,
#      width -- grafiko plotis,
#     height -- grafiko auk�tis,
#      units -- grafiko i�matavimo vienetai, px, in,
#        res -- ta�k� tankis, 
#  pointsize -- ta�ko dydis,
#         bg -- grafiko fono spalva,
#     family -- grafike naudojamo �rifto �eima,
#       type -- grafikos tipas, standartinis Windows GDI arba Cairo,
#  antialias -- glodinimo metodas.

# Jei grafikas i�saugomas JPEG formatu, vaizdo suspaudimo laipnis yra nustatomas 
# naudojant parametr� quality, jei TIFF formatu, naudojant parametr� compression
# nustatomas vaizdo suspaudimo algoritmas, kuri� yra keletas.


# Jeigu grafikas bus per�i�rimas kompiuterio ekrane arba naudojamas publikavimui
# internete, tai jam i�saugoti geriausiai tinka PNG formatas. Pvz., nubrai�ysime 
# paprast� 800 x 600 px dyd�io grafik� ir i�saugosime j� PNG formatu.

png(file = "grafikas-800x600.png", 800, 600)
  plot(sin, -3*pi, 3*pi)
dev.off()


# JPEG formatu saugomo vaizdo kokyb� labai priklauso nuo jo suspaudimo laipsnio.
# Pavyzd�iui, nubrai�ysime tam tikros vietov�s �em�lap� su auk��io izolinijomis, 
# kur� prad�ioje i�saugosime JPEG formatu su dideliu suspaudimo laipsniu, o tada
# dar kart� i�saugosime i�laikant beveik maksimali� vaizdo kokyb�. Jai nustatyti
# naudojamas funkcijos jpeg parametras quality. Galima pasteb�ti, kad 

jpeg(file = "zemelapis-jpg-15proc.jpg", 800, 600, quality = 15)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()

jpeg(file = "zemelapis-jpg-95proc.jpg", 800, 600, quality = 95)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()

# Nesunkiai galima pasteb�ti spalvos netolygumus, nery�kias linijas ir kitus d�l 
# didelio vaizdo suspaudimo atsiradusius artefaktus. Didel�s kokyb�s faile tokie
# artefaktai vizualiai nematomi, ta�iau toks failas u�ima �ymiai daugiau vietos.
# Palyginimui t� pat� grafik� i�ssaugosime PNG formatu. Galima pasteb�ti, kad to
# paties dyd�io ir vizualiai tos pa�ios vaizdo kokyb�s JPEG failas u�ima daugiau 
# vietos diske negu PNG formato failas.

png(file = "zemelapis-png.png", 800, 600)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()


# Rastrin�s grafikos paveiksliuko dydis i�rei�kiamas ta�k� skai�iumi - paprastai
# nurodomas plotis ir auk�tis. Realus paveikslo dydis ekrane arba ant popieriaus 
# priklauso nuo ta�k� tankio; kuo ta�k� tankis didesnis, tuo paveikslas ma�esnis. 
# Ta�k� tankis ekrane nurodomas PPI (points per inch), o spausdinto paveiksliuko 
# ta�k� tankis nurodomas DPI (dots per inch) vienetais. Kompiuterio ekrane ta�k� 
# tankis standarti�kai yra 72 ppi. Spaudoje, kur reikalinga auk�ta vaizdo kokyb�, 
# paveiksliukas gali b�ti 300 arba net ir 600 dpi.

# Rastrin�s grafikos funkcijose ta�k� tankis nustatomas naudojant parametr� res. 
# Tarkime, kad atspausdintas 200 ppi paveiksliukas turi b�ti 8 x 6 coli� dyd�io. 
# Tok� grafik� i�saugosime PNG formatu. Nesunku apskai�iuoti, kad paveikslas bus 
# 1600 x 1200 pikseli� dyd�io.

png(file = "zemelapis-8x6-200ppi.png", 8, 6, units = "in", res = 200)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()


# NAUDINGA ------------------------------

# Gana da�nai pasitaiko situacija, kada reikia nubrai�yti ir i�saugoti kelet� to 
# paties tipo grafik�. Tipin� situacija -- analogi�k� skai�iavim� su skirtingais
# duomenimis rezultat� atvaizdavimas ir j� palyginimas. 

# Pavyzd�iui, turime matric� su 25 stulpeliais. Reikia nubrai�yti vis� kintam�j�
# histogramas ir i�saugoti jas PNG formato failuose su skirtingais pavadinimais.
# �ia panaudosime modeliuotus duomenis.

duomenys <- replicate(25, rnorm(200, sample(20, 1)))

# Papras�iausias b�das atlikti �i� u�duot� -- histogramos brai�ymo funkcij� hist 
# �d�ti � cikl�, kurio indeksas perb�ga per matricos stulpelius. Kadangi grafik�
# reikia i�saugoti vis kitame faile, failo vardus sudarome kiekvienos iteracijos 
# metu. Papras�iausia prie failo vardo prid�ti numer�, tam naudojame f-j� paste.

for (i in 1:25) {

  failas <- paste("histograma-", i, ".png", sep = "")

  png(file = failas, 800, 600)
    hist(duomenys[, i])
  dev.off()
}

# Per�i�rint gautas histogramas, i� karto i�ry�k�ja keletas tr�kum�. Pvz., fail� 
# numeracija teisinga, bet j� i�d�stymo tvarka 1, 10, 11, ..., 19, 2, 20 ir t.t.
# yra nepatogi. Vis� histogram� antra�t�s yra vienodos. Histogramos i� skirting�
# fail� tarpusavyje nepalyginamos, kadangi vis� j� a�i� ribos yra skirtingos. �� 
# grafik� brai�ymo algoritm� galima patobulinti ir i�taisyti pasteb�tus tr�kumus:
#
#   1. failo vardus numeruoti pradedant nuo 01, 02 ir t.t.;
#   2. kiekvienam grafikui u�d�ti individuali� antra�t�;
#   3. nustatyti bendras visiems grafikams a�i� kitimo ribas;
#   4. visoms histogramoms nustatyti vienod� stulpeli� skai�i�;
#   5. automati�kai nustatyti iteracij� skai�i�.


# Pirmiausia nustatome, kokiose ribose kinta vis� lentel�s kintam�j� reik�m�s, o
# tada jas �iek tiek i�ple�iame ir suapvaliname iki sveik� reik�mi�. Histogramos
# stulpeli� maksimalus auk�tis parenkamas bandym� keliu.

xx <- round(range(duomenys) + c(-0.5, 0.5)) 
yy <- c(0, 60)


for (i in 1:ncol(duomenys)) {

  nr <- sprintf("%02d", i)
  failas   <- paste("histograma-", nr, ".png", sep = "")
  antra�t� <- paste("Histogramos numeris", nr)    

  png(file = failas, 800, 600)
    hist(duomenys[, i], breaks = 10, xlim = xx, ylim = yy, ann = FALSE)
    title(main = antra�t�, xlab = "x")
  dev.off()
}


# U�DUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    
