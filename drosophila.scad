// =====================================================================
//  T-Maze Olfactometer – wersja modułowa (v1.0.0)
//  Jednostki: mm  |  Technologia: FDM
//  Tryby pracy:
//    - widok złożony   : podgląd gotowego, zmontowanego urządzenia
//    - widok rozłożony : wszystkie elementy obok siebie, w orientacji do druku
//    - element         : pojedyncza część do eksportu STL (orientacja do druku)
//  Uwaga: gwint M20x1.5 jest generowany geometrycznie (linear_extrude + twist),
//  nie wymaga zewnętrznych bibliotek.
// =====================================================================

/* [Widok] */
// Tryb wyświetlania
widok = 0; // [0:Zlozony - podglad, 1:Rozlozony - obok siebie]
// Pojedynczy element do eksportu STL
element = "wszystkie"; // [wszystkie, rdzen, lejek, szufladka, zapadka, ramie, nakretka]
// Odstęp między elementami (stan rozłożony)
odstep = 20; // [5:1:80]
// Otwarcie zapadek (0 = zamknięte, 1 = otwarte)
otwarcie_zapadek = 0; // [0:0.05:1]
// Wysunięcie szufladki (0 = schowana, 1 = wysunięta)
wysuniecie_szufladki = 0; // [0:0.05:1]
// Jakość okręgów (segmenty)
jakosc = 64; // [24:8:160]

/* [Parametry globalne] */
// Średnica wewnętrzna rurek
d_wew = 15; // [8:0.5:30]
// Średnica zewnętrzna rurek
d_zew = 19; // [10:0.5:40]
// Grubość ścianki bloków
scianka = 2; // [1:0.1:5]
// Szerokość szczeliny zapadki
szczelina_zapadki = 2.6; // [1.5:0.1:5]
// Grubość płytki zapadki
grubosc_zapadki = 2.2; // [1:0.1:4]

/* [Tolerancje] */
// Luz pasowania suwliwego
luz_suwliwy = 0.2; // [0:0.05:1]
// Luz pasowania ciasnego (wcisk)
luz_ciasny = 0.1; // [0:0.05:0.5]
// Luz gwintu (na średnicy)
luz_gwintu = 0.15; // [0:0.05:0.6]

/* [MOD_01 - Rdzeń krzyżowy] */
// Długość pionowa rdzenia
rdzen_dl_pion = 60; // [40:1:120]
// Rozpiętość ramion bocznych
rdzen_rozpietosc = 60; // [40:1:120]
// Długość gniazda rurki bocznej
gniazdo_dl = 12; // [5:1:25]
// Wysokość szczeliny prowadzącej zapadkę
szczelina_wys = 35; // [20:1:60]
// Zagłębienie zapadki pod dnem otworu
zapadka_zaglebienie = 0.5; // [0:0.1:3]
// Grubość ścianek prowadnicy zapadki
prowadnica_scianka = 3; // [2:0.5:6]
// Średnica nominalna gwintu dolnego
gwint_d = 20; // [12:0.5:40]
// Skok gwintu
gwint_skok = 1.5; // [0.5:0.1:3]
// Wysokość występu gwintowanego
rdzen_wystep_wys = 10; // [6:1:20]
// Średnica występu gwintowanego
rdzen_wystep_d = 25; // [20:0.5:40]

/* [MOD_02 - Lejek górny] */
// Całkowita wysokość lejka (z czopem)
lejek_wys = 75; // [40:1:150]
// Średnica zewnętrzna górna lejka
lejek_d_zew = 45; // [25:1:80]
// Średnica wewnętrzna górna lejka
lejek_d_wew = 41; // [20:1:76]
// Wysokość prostej kryzy górnej
lejek_kryza = 8; // [0:1:20]
// Kąt stożka lejka
lejek_kat = 45; // [20:1:70]
// Długość czopa wciskanego w rdzeń
czop_dl = 15; // [5:1:30]
// Grubość ścianki czopa
czop_scianka = 1.5; // [1:0.1:3]

/* [MOD_03 - Szufladka zapachowa] */
// Szerokość szufladki
szuf_x = 20; // [10:0.5:40]
// Długość szufladki
szuf_y = 45; // [20:1:80]
// Wysokość szufladki
szuf_z = 12; // [6:0.5:25]
// Szerokość komory na wacik
komora_x = 14; // [6:0.5:30]
// Długość komory na wacik
komora_y = 25; // [10:0.5:60]
// Głębokość komory na wacik
komora_z = 8; // [3:0.5:20]
// Promień zaokrąglenia komory
komora_r = 2; // [0:0.5:5]
// Kąt jaskółczego ogona
jaskolka_kat = 60; // [45:1:80]
// Szerokość podstawy jaskółczego ogona
jaskolka_podstawa = 22; // [12:0.5:45]
// Wysokość prowadnicy jaskółczego ogona
jaskolka_wys = 3; // [1.5:0.5:8]
// Długość uchwytu szufladki
szuf_uchwyt = 6; // [0:1:15]
// Położenie kątowe obudowy na lejku
szuf_kat = 90; // [0:15:345]
// Wysokość osi szufladki nad rdzeniem
szuf_wys = 20; // [5:1:60]
// Szerokość szczelin okienka (siatka)
okienko_szczelina = 2; // [1:0.25:5]
// Szerokość żeberek okienka
okienko_zeberko = 1; // [0.5:0.25:3]

/* [MOD_04 - Zapadki gilotynowe] */
// Szerokość zapadki
zapadka_szer = 25; // [15:1:40]
// Wysokość zapadki
zapadka_wys = 40; // [20:1:70]
// Średnica otworu przelotowego
zapadka_otwor_d = 15; // [8:0.5:30]
// Wysokość środka otworu od dołu
zapadka_otwor_h = 9; // [5:0.5:40]
// Promień zaokrąglenia naroży
zapadka_r = 2; // [0:0.5:5]
// Wysokość uchwytu (pogrubienie górne)
zapadka_uchwyt_wys = 5; // [0:0.5:12]
// Grubość uchwytu
zapadka_uchwyt_gr = 5; // [2:0.5:10]

/* [MOD_05 - Ramiona boczne] */
// Długość ramienia bocznego
ramie_dl = 75; // [30:1:150]

/* [MOD_06 - Nakrętka dolna] */
// Wysokość części radełkowanej
nakretka_wys = 10; // [5:0.5:20]
// Średnica nakrętki
nakretka_d = 25; // [20:0.5:40]
// Długość gwintu zewnętrznego
nakretka_gwint_dl = 8; // [4:0.5:15]
// Liczba rowków radełka
radelko_n = 24; // [8:1:60]
// Głębokość rowków radełka
radelko_gl = 0.8; // [0.3:0.1:2]
// Otwór wylotowy w nakrętce (0 = pełna)
nakretka_otwor_d = 0; // [0:0.5:15]

/* [Hidden] */
$fn = jakosc;
eps = 0.01;

// ---------------------------------------------------------------------
//  Wartości pochodne
// ---------------------------------------------------------------------
r_o = d_zew/2;
r_i = d_wew/2;
gl_gwintu   = 0.6*gwint_skok;          // głębokość zarysu gwintu
faza_gwintu = gl_gwintu + 0.2;

// rdzeń
gniazdo_d_zew = d_zew + luz_suwliwy + 2*scianka;
zapadka_x     = r_o + scianka + szczelina_zapadki/2;        // oś szczeliny zapadki
slot_z0       = -(r_i + zapadka_zaglebienie + zapadka_otwor_h + zapadka_otwor_d/2); // dno szczeliny
zapadka_skok  = -zapadka_otwor_h - slot_z0;                  // skok otwarcia zapadki
rdzen_gora    = rdzen_dl_pion/2;

// lejek
czop_ro       = (d_wew - luz_ciasny)/2;
czop_ri       = czop_ro - czop_scianka;
ro_top        = lejek_d_zew/2;
ri_top        = lejek_d_wew/2;
stozek_h      = (ro_top - r_o)*tan(lejek_kat);
stozek_h_in   = (ri_top - r_i)*tan(lejek_kat);
lejek_scianka = ro_top - ri_top;
z_stozka      = lejek_wys - lejek_kryza - stozek_h;
delta_stozka  = lejek_scianka/cos(lejek_kat) - (r_o - r_i)*tan(lejek_kat);
h_fazy_czopa  = r_i - czop_ri;

// obudowa szufladki (w układzie lejka, strona +X przed obrotem o szuf_kat)
x_b0   = r_i;                                   // początek bloku (lico otworu)
x_top  = x_b0 + scianka;                        // lico górne szufladki (płytka z okienkiem)
x_b1   = x_top + luz_suwliwy + szuf_z + scianka;// koniec bloku
blok_z = jaskolka_podstawa + 2*luz_suwliwy + 2*scianka;
blok_y = szuf_y + scianka;                      // ze ścianką oporową od strony -Y
z_h    = czop_dl + szuf_wys;                    // oś szufladki (układ lejka)

// ---------------------------------------------------------------------
//  Gwint (zarys trójkątny, generowany przez linear_extrude z twist)
// ---------------------------------------------------------------------
module gwint_profil2d(d_max, gl, n) {
    polygon([ for (i = [0:n-1])
        let(a = 360*i/n, t = i/n,
            tri = (t < 0.5) ? 2*t : 2 - 2*t,
            r = d_max/2 - gl*(1 - tri))
        [r*cos(a), r*sin(a)] ]);
}

// gwint zewnętrzny, prawoskrętny; d = średnica nominalna
module gwint_zewn(d, skok, dl) {
    linear_extrude(height = dl, twist = -360*dl/skok,
                   slices = max(8, ceil(dl/skok*jakosc/2)), convexity = 10)
        gwint_profil2d(d, gl_gwintu, jakosc);
}

// ---------------------------------------------------------------------
//  MOD_01 – Rdzeń krzyżowy
// ---------------------------------------------------------------------
module prowadnica_zapadki(s) {
    bx0 = r_o - 1;                                              // zaczep o walec pionowy
    bx1 = zapadka_x + szczelina_zapadki/2 + prowadnica_scianka;
    by  = zapadka_szer + 2*luz_suwliwy + 2*prowadnica_scianka;
    bz0 = slot_z0 - prowadnica_scianka;
    bz1 = slot_z0 + szczelina_wys;
    translate([s > 0 ? bx0 : -bx1, -by/2, bz0])
        cube([bx1 - bx0, by, bz1 - bz0]);
}

module szczelina_zapadki_wyciecie(s) {
    translate([s*zapadka_x - szczelina_zapadki/2,
               -(zapadka_szer/2 + luz_suwliwy), slot_z0])
        cube([szczelina_zapadki, zapadka_szer + 2*luz_suwliwy, szczelina_wys + 1]);
}

module rdzen() {
    difference() {
        union() {
            cylinder(h = rdzen_dl_pion, d = d_zew, center = true);              // walec pionowy
            rotate([0,90,0]) cylinder(h = rdzen_rozpietosc, d = d_zew, center = true); // ramiona
            for (s = [-1,1])                                                     // gniazda rurek
                translate([s*(rdzen_rozpietosc/2 - gniazdo_dl/2), 0, 0])
                    rotate([0,90,0]) cylinder(h = gniazdo_dl, d = gniazdo_d_zew, center = true);
            translate([0,0,-rdzen_gora])                                         // występ gwintowany
                cylinder(h = rdzen_wystep_wys, d = rdzen_wystep_d);
            for (s = [-1,1]) prowadnica_zapadki(s);                              // prowadnice zapadek
        }
        cylinder(h = rdzen_dl_pion + 2, d = d_wew, center = true);               // otwór pionowy
        rotate([0,90,0]) cylinder(h = rdzen_rozpietosc + 2, d = d_wew, center = true); // otwór poziomy
        for (s = [-1,1])                                                         // gniazda na rurki
            translate([s*rdzen_rozpietosc/2, 0, 0])
                rotate([0,90,0]) cylinder(h = 2*gniazdo_dl, d = d_zew + luz_suwliwy, center = true);
        for (s = [-1,1]) szczelina_zapadki_wyciecie(s);                          // szczeliny zapadek
        translate([0,0,-rdzen_gora - eps])                                       // gwint wewnętrzny
            gwint_zewn(gwint_d + luz_gwintu, gwint_skok, nakretka_gwint_dl + 1);
        translate([0,0,-rdzen_gora - eps])                                       // faza wejściowa
            cylinder(h = faza_gwintu, d1 = gwint_d + 2*faza_gwintu, d2 = gwint_d - 2*gl_gwintu);
    }
}

// ---------------------------------------------------------------------
//  MOD_03 – Szufladka zapachowa (układ lokalny: X szer., Y dł., Z wys.)
// ---------------------------------------------------------------------
module szuf_profil() {
    hw   = szuf_x/2;
    hb   = jaskolka_podstawa/2;
    neck = hb - jaskolka_wys/tan(jaskolka_kat);
    union() {
        polygon([[-hb,0],[hb,0],[neck,jaskolka_wys],[-neck,jaskolka_wys]]); // jaskółczy ogon
        translate([-hw, jaskolka_wys - eps]) square([szuf_x, szuf_z - jaskolka_wys + eps]);
    }
}

module komora_wacika() {
    rr = min(komora_r, komora_x/2 - 0.1, komora_y/2 - 0.1);
    translate([0,0,szuf_z - komora_z])
        linear_extrude(komora_z + 1)
            offset(r = rr) square([komora_x - 2*rr, komora_y - 2*rr], center = true);
}

module szufladka() {
    difference() {
        union() {
            rotate([90,0,0]) linear_extrude(szuf_y, center = true) szuf_profil();
            if (szuf_uchwyt > 0)                                          // uchwyt
                translate([-szuf_x/2, szuf_y/2 - eps, 0])
                    cube([szuf_x, szuf_uchwyt + eps, szuf_z]);
        }
        komora_wacika();
        if (szuf_uchwyt > 2)                                              // rowek na palec
            translate([0, szuf_y/2 + szuf_uchwyt/2, szuf_z])
                rotate([0,90,0]) cylinder(h = szuf_x + 2, d = szuf_uchwyt*0.8, center = true);
    }
}

// transformacja: układ szufladki -> układ obudowy na lejku
module w_obudowie() {
    translate([x_top + luz_suwliwy/2 + szuf_z, 0, z_h]) rotate([0,-90,0]) children();
}

module obudowa_szufladki() {
    hull() {
        translate([x_b0, -(szuf_y/2 + scianka), z_h - blok_z/2]) cube([x_b1 - x_b0, blok_y, blok_z]);
        translate([x_b0, -(szuf_y/2 + scianka), z_h - blok_z/2 - (x_b1 - x_b0)]) // skos 45° (bez podpór)
            cube([eps, blok_y, eps]);
    }
}

module obudowa_szufladki_wyciecia() {
    // rowek jaskółczy (otwarty od +Y, ścianka oporowa od -Y)
    w_obudowie()
        translate([0, szuf_y/2 + 1, 0]) rotate([90,0,0])
            linear_extrude(szuf_y + 1) offset(delta = luz_suwliwy/2) szuf_profil();
    // okienko-siatka do komory lejka
    skok_ok = okienko_szczelina + okienko_zeberko;
    n_ok    = max(1, floor((komora_y + okienko_zeberko)/skok_ok));
    dl_ok   = n_ok*skok_ok - okienko_zeberko;
    for (i = [0:n_ok-1])
        translate([r_i - 1, -dl_ok/2 + i*skok_ok, z_h - komora_x/2 + 1])
            cube([x_top - r_i + 1 + eps, okienko_szczelina, komora_x - 2]);
}

// ---------------------------------------------------------------------
//  MOD_02 – Lejek górny (z = 0 na dole czopa)
// ---------------------------------------------------------------------
module lejek() {
    difference() {
        union() {
            cylinder(h = czop_dl + eps, d = 2*czop_ro);                              // czop wciskany
            translate([0,0,czop_dl]) cylinder(h = z_stozka - czop_dl, r = r_o);      // rurka
            translate([0,0,z_stozka]) cylinder(h = stozek_h, r1 = r_o, r2 = ro_top); // stożek
            translate([0,0,z_stozka + stozek_h - eps]) cylinder(h = lejek_kryza + eps, r = ro_top); // kryza
            rotate([0,0,szuf_kat]) obudowa_szufladki();
        }
        // kanał wewnętrzny
        translate([0,0,-1]) cylinder(h = czop_dl + 1 + eps, r = czop_ri);
        translate([0,0,czop_dl]) cylinder(h = h_fazy_czopa, r1 = czop_ri, r2 = r_i); // faza 45°
        translate([0,0,czop_dl + h_fazy_czopa - eps])
            cylinder(h = (z_stozka + delta_stozka) - (czop_dl + h_fazy_czopa) + 2*eps, r = r_i);
        translate([0,0,z_stozka + delta_stozka]) cylinder(h = stozek_h_in, r1 = r_i, r2 = ri_top);
        translate([0,0,z_stozka + delta_stozka + stozek_h_in - eps])
            cylinder(h = max(eps, lejek_wys + 1 - (z_stozka + delta_stozka + stozek_h_in)), r = ri_top);
        // obudowa szufladki
        rotate([0,0,szuf_kat]) obudowa_szufladki_wyciecia();
    }
}

// ---------------------------------------------------------------------
//  MOD_04 – Zapadka gilotynowa (płasko: X szer., Y wys., Z grubość)
// ---------------------------------------------------------------------
module zapadka() {
    difference() {
        union() {
            linear_extrude(grubosc_zapadki)
                translate([0, zapadka_wys/2])
                    offset(r = zapadka_r) offset(delta = -zapadka_r)
                        square([zapadka_szer, zapadka_wys], center = true);
            if (zapadka_uchwyt_wys > 0)                                     // uchwyt
                translate([-zapadka_szer/2, zapadka_wys - zapadka_uchwyt_wys, 0])
                    cube([zapadka_szer, zapadka_uchwyt_wys, zapadka_uchwyt_gr]);
        }
        translate([0, zapadka_otwor_h, -1])                                 // otwór przelotowy
            cylinder(h = zapadka_uchwyt_gr + 2, d = zapadka_otwor_d);
    }
}

// ---------------------------------------------------------------------
//  MOD_05 – Ramię boczne (pionowo, z = 0 na dole)
// ---------------------------------------------------------------------
module ramie() {
    difference() {
        cylinder(h = ramie_dl, d = d_zew);
        translate([0,0,-1]) cylinder(h = ramie_dl + 2, d = d_wew);
    }
}

// ---------------------------------------------------------------------
//  MOD_06 – Nakrętka dolna (płasko, gwintem do góry)
// ---------------------------------------------------------------------
module nakretka() {
    s_rad = radelko_gl*sqrt(2);
    difference() {
        union() {
            difference() {                                                  // korpus radełkowany
                cylinder(h = nakretka_wys, d = nakretka_d);
                for (i = [0:radelko_n-1]) rotate([0,0,i*360/radelko_n])
                    translate([nakretka_d/2, 0, nakretka_wys/2]) rotate([0,0,45])
                        cube([s_rad, s_rad, nakretka_wys + 2], center = true);
            }
            translate([0,0,nakretka_wys - eps]) intersection() {            // gwint zewnętrzny
                gwint_zewn(gwint_d - luz_gwintu, gwint_skok, nakretka_gwint_dl + eps);
                union() {
                    cylinder(h = nakretka_gwint_dl - faza_gwintu, d = gwint_d + 2);
                    translate([0,0,nakretka_gwint_dl - faza_gwintu - eps])
                        cylinder(h = faza_gwintu + eps, d1 = gwint_d, d2 = gwint_d - 2*faza_gwintu);
                }
            }
        }
        if (nakretka_otwor_d > 0)                                           // opcjonalny otwór
            translate([0,0,-1]) cylinder(h = nakretka_wys + nakretka_gwint_dl + 2, d = nakretka_otwor_d);
    }
}

// ---------------------------------------------------------------------
//  Złożenie
// ---------------------------------------------------------------------
module zlozony() {
    color("LightSteelBlue") rdzen();
    translate([0,0,rdzen_gora - czop_dl]) {
        color("LightSkyBlue", 0.85) lejek();
        color("Orange") rotate([0,0,szuf_kat])
            translate([0, wysuniecie_szufladki*szuf_y*0.8, 0]) w_obudowie() szufladka();
    }
    for (s = [-1,1]) color("Tomato") mirror([s < 0 ? 1 : 0, 0, 0])
        translate([zapadka_x - grubosc_zapadki/2, 0, slot_z0 + otwarcie_zapadek*zapadka_skok])
            rotate([90,0,90]) zapadka();
    for (s = [-1,1]) color("PaleGreen", 0.7) mirror([s < 0 ? 1 : 0, 0, 0])
        translate([rdzen_rozpietosc/2 - gniazdo_dl, 0, 0]) rotate([0,90,0]) ramie();
    color("Gold") translate([0,0,-rdzen_gora - nakretka_wys]) nakretka();
}

// ---------------------------------------------------------------------
//  Elementy w orientacji do druku (na stole, z = 0)
// ---------------------------------------------------------------------
module druk_rdzen()     { translate([0,0,rdzen_gora]) rdzen(); }          // pionowo, podpory drzewiaste pod ramionami
module druk_lejek()     { lejek(); }                                       // lejkiem do góry, brim
module druk_szufladka() { szufladka(); }                                   // płasko, komorą do góry
module druk_zapadka()   { translate([0,-zapadka_wys/2,0]) zapadka(); }     // płasko, 2 szt.
module druk_ramie()     { ramie(); }                                       // pionowo, 2 szt.
module druk_nakretka()  { nakretka(); }                                    // płasko, gwintem do góry

// ---------------------------------------------------------------------
//  Stan rozłożony – elementy obok siebie
// ---------------------------------------------------------------------
module rozlozony() {
    x_rdz = 0;
    x_lej = x_rdz + rdzen_rozpietosc/2 + odstep + max(lejek_d_zew/2, x_b1);
    x_szu = x_lej + max(lejek_d_zew/2, x_b1) + odstep + jaskolka_podstawa/2;
    x_za1 = x_szu + jaskolka_podstawa/2 + odstep + zapadka_szer/2;
    x_za2 = x_za1 + zapadka_szer + odstep;
    x_ra1 = x_za2 + zapadka_szer/2 + odstep + d_zew/2;
    x_ra2 = x_ra1 + d_zew + odstep;
    x_nak = x_ra2 + d_zew/2 + odstep + nakretka_d/2;

    color("LightSteelBlue") translate([x_rdz,0,0]) druk_rdzen();
    color("LightSkyBlue")   translate([x_lej,0,0]) druk_lejek();
    color("Orange")         translate([x_szu,0,0]) druk_szufladka();
    color("Tomato")         translate([x_za1,0,0]) druk_zapadka();
    color("Tomato")         translate([x_za2,0,0]) druk_zapadka();
    color("PaleGreen")      translate([x_ra1,0,0]) druk_ramie();
    color("PaleGreen")      translate([x_ra2,0,0]) druk_ramie();
    color("Gold")           translate([x_nak,0,0]) druk_nakretka();
}

// ---------------------------------------------------------------------
//  Wybór renderowania
// ---------------------------------------------------------------------
if      (element == "rdzen")     druk_rdzen();
else if (element == "lejek")     druk_lejek();
else if (element == "szufladka") druk_szufladka();
else if (element == "zapadka")   druk_zapadka();
else if (element == "ramie")     druk_ramie();
else if (element == "nakretka")  druk_nakretka();
else if (widok == 1)             rozlozony();
else                             zlozony();

echo(str("Skok otwarcia zapadki: ", zapadka_skok, " mm | dno szczeliny z=", slot_z0,
         " | czop OD=", 2*czop_ro, " | gniazdo ramienia ID=", d_zew + luz_suwliwy));
