// ============================================================================
// PROJEKT: Modułowy Aparat do Warunkowania Węchowego i Labirynt T (v2.0)
//          dla Drosophila melanogaster (Zgodny z pełną specyfikacją)
// TECHNOLOGIA: Druk 3D FDM (zoptymalizowane kąty 45 st., tolerancje pasowań)
// ============================================================================

// --- 1. PARAMETRY GLOBALNE I STEROWANIE WIDOKIEM ---

exploded_view = true;        // true = widok rozstrzelony, false = aparat złożony
shuttle_down  = false;       // Pozycja windy: false = GÓRA (odbiór z treningu), true = DÓŁ (komora startowa T)
spacing = exploded_view ? 38 : 0; // Odstęp eksplozji [mm]

$fn = 64; // Gładkość okręgów

// Wymiary bazowe i tolerancje
tol = 0.25;          // Tolerancja dla połączeń wciskanych i suwaków
slide_tol = 0.35;    // Tolerancja dla płynnego ruchu windy transferowej
id_main = 20.0;      // Średnica wewnętrzna głównych komór (Trening, Winda, Komora Startowa)
od_main = 26.0;      // Średnica zewnętrzna rur głównych (ścianka 3 mm pod rowki elektrod)
arm_id  = 16.0;      // Średnica wewnętrzna ramion wyboru
arm_od  = 20.0;      // Średnica zewnętrzna ramion wyboru
arm_len = 75.0;      // Długość ramienia wyboru

// Kolory funkcjonalne (ułatwiają ocenę sekcji w podglądzie)
c_body    = [0.20, 0.22, 0.25, 1.0]; // Ciemny grafit - korpus główny i komory
c_clear   = [0.75, 0.88, 0.98, 0.55]; // Transparentny - ramiona i komora wprowadzania
c_shuttle = [0.25, 0.65, 0.85, 0.90]; // Niebieski - ruchoma winda transferowa
c_sliders = [0.90, 0.40, 0.15, 1.0]; // Pomarańczowy - wszystkie zasuwki i gilotyny
c_odor    = [0.20, 0.70, 0.40, 0.90]; // Zielony - wymienne moduły zapachowe i fiolka
c_plugs   = [0.80, 0.20, 0.25, 1.0]; // Czerwony - korki spustowe do odzyskiwania 3 grup much


// ============================================================================
// --- 2. GŁÓWNY BLOK ZŁOŻENIOWY (ASSEMBLY) ---
// ============================================================================

// Obliczenie przesunięcia windy w zależności od wybranego trybu pracy
shuttle_z_pos = shuttle_down ? 0 : 35;

// 1. Korpus Główny (Wieża prowadząca windę + Skrzyżowanie Labiryntu T) [Pkt 4 & 5.1]
MainFrameTower();

// 2. Ruchomy Tłok Transferowy / Winda (Przenosi muchy i odcina górę) [Pkt 4]
translate([0, -spacing * 1.4, shuttle_z_pos + spacing * 0.4])
    TransferShuttle();

// 3. Stacjonarna Komora Treningowa (Elektrody + Wentylacja + Gniazdo zapachu) [Pkt 3]
translate([0, 0, 55 + spacing * 1.2])
    TrainingChamber();

// 4. Wymienny Moduł Zapachowy Komory Treningowej (Koszyk + Szklana Fiolka) [Pkt 3.2]
translate([0, 22 + spacing * 1.2, 85 + spacing * 1.2])
    TrainingOdorCartridge();

// 5. Zasuwki Wentylacji Komory Treningowej (Wlot i Wylot) [Pkt 3.3]
translate([-20 - spacing * 0.8, 0, 68 + spacing * 1.4])
    VentValveSlider(is_left = true);
translate([20 + spacing * 0.8, 0, 102 + spacing * 1.4])
    VentValveSlider(is_left = false);

// 6. Zasuwka Transferowa (Pomiędzy Komorą Wprowadzania, Treningową a Windą) [Pkt 2 & 4]
translate([0, -20 - spacing * 1.0, 55 + spacing * 1.0])
    HorizontalGateSlider(); // Zasuwka dolna komory treningowej
translate([0, -20 - spacing * 1.0, 115 + spacing * 2.0])
    HorizontalGateSlider(); // Zasuwka pod komorą wprowadzania

// 7. Szeroka Komora Wprowadzania Much + Szczelna Pokrywa [Pkt 2]
translate([0, 0, 118 + spacing * 2.2])
    FlyLoadingChamber();
translate([0, 0, 155 + spacing * 3.0])
    FlyLoadingLid();

// 8. Ramiona Wyboru Labiryntu T (Z dolnymi wylotami ewakuacyjnymi) [Pkt 5.2 & 6]
translate([-(18 + spacing * 1.0), 0, 0])
    ChoiceArmWithDrain(is_left = true);
translate([(18 + spacing * 1.0), 0, 0])
    ChoiceArmWithDrain(is_left = false);

// 9. Niezależne Gilotyny Ramion Wyboru (Odcinają Komorę Startową od Ramion) [Pkt 5.3]
translate([-14 - spacing * 0.3, 0, 22 + spacing * 0.8])
    ArmGuillotine(is_left = true);
translate([14 + spacing * 0.3, 0, 22 + spacing * 0.8])
    ArmGuillotine(is_left = false);

// 10. Koncowe Moduły Zapachowe Ramion (Z kratką ochronną i komorą wacika) [Pkt 5.2]
translate([-(18 + arm_len + spacing * 2.2), 0, 0])
    ArmOdorCap(is_left = true);
translate([(18 + arm_len + spacing * 2.2), 0, 0])
    ArmOdorCap(is_left = false);

// 11. Trzy Niezależne Korki Spustowe do Zbierania Much po Teście [Pkt 6]
// Korek 1: Środkowa Komora Startowa
translate([0, 0, -25 - spacing * 1.2])
    CollectionPlug(is_center = true);
// Korek 2: Lewe Ramię Wyboru
translate([-(18 + arm_len - 18 + spacing * 1.0), 0, -18 - spacing * 1.0])
    CollectionPlug(is_center = false);
// Korek 3: Prawe Ramię Wyboru
translate([(18 + arm_len - 18 + spacing * 1.0), 0, -18 - spacing * 1.0])
    CollectionPlug(is_center = false);


// ============================================================================
// --- 3. DEFINICJE MODUŁÓW FUNKCJONALNYCH ---
// ============================================================================

// ----------------------------------------------------------------------------
// MODUŁ 1: MainFrameTower() - Korpus Główny (Prowadnica Windy + Skrzyżowanie T)
// ----------------------------------------------------------------------------
module MainFrameTower() {
    tower_h = 75.0; // Od Z=-20 do Z=+55
    
    color(c_body)
    difference() {
        union() {
            // Dolny blok skrzyżowania T (Komora Startowa)
            translate([0, 0, 0])
                cube([36, 32, 40], center = true);
                
            // Górna kolumna prowadząca Tłok Transferowy (od Z=20 do Z=55)
            translate([0, 0, 37.5])
                cube([30, 32, 35], center = true);
                
            // Górny kołnierz z prowadnicą na zasuwkę pod Komorą Treningową
            translate([0, 0, 53])
                cube([34, 34, 6], center = true);
        }
        
        // 1. Główny pionowy kanał cylindryczny dla Tłoka Transferowego (OD windy = 24 mm)
        translate([0, 0, -22])
            cylinder(d = 24.0 + slide_tol, h = tower_h + 5);
            
        // 2. Pionowy kanał prowadzący uchwyt windy (od przodu, oś -Y), zapobiega obracaniu się windy!
        translate([0, -12, 18])
            cube([8.0 + slide_tol, 16, 42], center = true);
            
        // 3. Poziomy kanał przelotowy Labiryntu T (oś X, średnica 16 mm)
        rotate([0, 90, 0])
            cylinder(d = arm_id, h = 40, center = true);
            
        // 4. Gniazda montażowe na Ramiona Wyboru (średnica 20.25 mm, głębokość 5 mm)
        for (side = [-1, 1]) {
            translate([side * 15.5, 0, 0])
            rotate([0, 90, 0])
                cylinder(d = arm_od + tol, h = 6, center = true);
        }
        
        // 5. Dwie pionowe szczeliny na Gilotyny Ramion (x = -14 oraz x = +14)
        for (side = [-1, 1]) {
            translate([side * 14.0, 0, 4])
                cube([2.4, 22.0, 36], center = true);
        }
        
        // 6. Pozioma szczelina na zasuwkę odcinającą pod Komorą Treningową (Z = 53)
        translate([0, -2, 53])
            cube([24.0, 36, 2.5], center = true);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 2: TransferShuttle() - Ruchoma Winda / Rdzeń Suwakowy (Pkt 4)
// Przenosi muchy w dół, a jej pełny sufit automatycznie odcina Komorę Treningową
// ----------------------------------------------------------------------------
module TransferShuttle() {
    shuttle_od = 24.0;
    shuttle_id = id_main; // 20.0 mm
    
    color(c_shuttle)
    union() {
        difference() {
            // Korpus cylindryczny tłoka (wysokość 58 mm: komora dolna + lity blok odcinający u góry)
            translate([0, 0, -14])
                cylinder(d = shuttle_od, h = 58);
                
            // Wewnętrzna Komora Transportowa/Startowa (od dołu do Z=+14)
            translate([0, 0, -15])
                cylinder(d = shuttle_id, h = 29);
                
            // Stożkowe sklepienie komory transportowej (45 st. - druk bez podpór!)
            translate([0, 0, 14 - 0.01])
                cylinder(d1 = shuttle_id, d2 = 0, h = shuttle_id/2);
                
            // Górny przelot łączący (gdy winda jest w górze, łączy Komorę Treningową z wnętrzem)
            translate([0, 0, 15])
                cylinder(d = shuttle_id, h = 30);
                
            // Boczne okna wylotowe (oś X) - w dolnej pozycji pokrywają się z ramionami wyboru!
            rotate([0, 90, 0])
                cylinder(d = arm_id, h = 30, center = true);
        }
        
        // Przedni uchwyt suwakowy z zatrzaskiem pozycjonującym (wystaje przez szczelinę w osi -Y)
        translate([0, -15, 0]) {
            cube([8.0, 12.0, 10.0], center = true);
            // Wygodny uchwyt palcowy
            translate([0, -5, 0])
                cube([18.0, 4.0, 10.0], center = true);
        }
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 3: TrainingChamber() - Stacjonarna Komora Treningowa (Pkt 3.1, 3.2, 3.3)
// Posiada wewnętrzne mikro-kanalikowanie pod miedziane druciki (elektrody)
// ----------------------------------------------------------------------------
module TrainingChamber() {
    ch_h = 60.0;
    
    color(c_body)
    difference() {
        union() {
            // Rura główna komory
            cylinder(d = od_main + 4, h = ch_h);
            
            // Dolny i górny kołnierz montażowy z prowadnicą na zasuwkę
            translate([0, 0, 3])
                cube([34, 34, 6], center = true);
            translate([0, 0, ch_h - 3])
                cube([34, 34, 6], center = true);
                
            // Gniazdo (uchwyt) na wymienny moduł zapachowy z tyłu (+Y) w połowie wysokości
            translate([0, 16, ch_h/2])
                cube([24, 14, 24], center = true);
                
            // Port Wlotowy Wentylacji (na dole po lewej, Z = 13) + uniwersalny króciec Luer/Wężyk
            translate([-15, 0, 13])
            rotate([0, -90, 0]) {
                cube([14, 14, 8], center = true);
                translate([0, 0, 4])
                    cylinder(d1 = 7.0, d2 = 4.2, h = 10); // Stożek pod strzykawkę Luer i wężyk 6mm
            }
            
            // Port Wylotowy Wentylacji (u góry po prawej, Z = 47) + uniwersalny króciec
            translate([15, 0, 47])
            rotate([0, 90, 0]) {
                cube([14, 14, 8], center = true);
                translate([0, 0, 4])
                    cylinder(d1 = 7.0, d2 = 4.2, h = 10);
            }
        }
        
        // 1. Główna przestrzeń treningowa (ID 20 mm) - bezpośredni dostęp much do ścianek
        translate([0, 0, -1])
            cylinder(d = id_main, h = ch_h + 2);
            
        // 2. UKŁAD ELEKTROD (Pkt 3.1): 12 pionowych mikrorowków na wewnętrznej ściance
        // Pozwalają na wplecenie miedzianych drucików bezpośrednio w świetle komory (bez przegrody!)
        for (angle = [0 : 30 : 330]) {
            rotate([0, 0, angle])
            translate([id_main/2, 0, -1])
                cylinder(d = 1.4, h = ch_h + 2);
        }
        // Dwa boczne otwory wyprowadzające zaciski przewodów elektrycznych do generatora impulsów
        translate([0, 0, 8])
            rotate([90, 0, 0]) cylinder(d = 2.5, h = 35, center = true);
        translate([0, 0, ch_h - 8])
            rotate([90, 0, 0]) cylinder(d = 2.5, h = 35, center = true);
            
        // 3. Wycięcie pod koszyk wymiennego modułu zapachowego (+Y)
        translate([0, 18, ch_h/2])
        rotate([-90, 0, 0])
            cylinder(d = 18.0 + tol, h = 12, center = true);
            
        // Perforowana przegroda (mikrositko 0.8 mm) oddzielająca muchy od modułu zapachowego!
        for (z_off = [-4 : 2.5 : 4]) {
            for (x_off = [-4 : 2.5 : 4]) {
                translate([x_off, 10, ch_h/2 + z_off])
                rotate([90, 0, 0])
                    cylinder(d = 1.2, h = 8, center = true);
            }
        }
        
        // 4. Kanały wentylacyjne z siatką zabezpieczającą i szczelinami na zasuwki zamykające
        // Dolny wlot (-X)
        translate([-18, 0, 13]) rotate([0, -90, 0]) cylinder(d = 3.0, h = 15);
        for (dy = [-2, 0, 2]) translate([-12, dy, 13]) cube([6, 1.0, 5], center = true); // Kratka przeciw ucieczce
        translate([-16, 0, 16]) cube([2.2, 16, 16], center = true); // Szczelina zasuwki
        
        // Górny wylot (+X)
        translate([18, 0, 47]) rotate([0, 90, 0]) cylinder(d = 3.0, h = 15);
        for (dy = [-2, 0, 2]) translate([12, dy, 47]) cube([6, 1.0, 5], center = true); // Kratka przeciw ucieczce
        translate([16, 0, 50]) cube([2.2, 16, 16], center = true); // Szczelina zasuwki
        
        // 5. Górna szczelina pod zasuwkę Komory Wprowadzania
        translate([0, -2, ch_h - 2])
            cube([24.0, 36, 2.5], center = true);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 4: TrainingOdorCartridge() - Wymienny Moduł Zapachowy z Fiolka (Pkt 3.2)
// ----------------------------------------------------------------------------
module TrainingOdorCartridge() {
    color(c_odor)
    rotate([-90, 0, 0])
    difference() {
        union() {
            // Cylindryczny adapter wsuwany w gniazdo komory treningowej
            cylinder(d = 18.0, h = 10);
            // Kołnierz oporowy ułatwiający szybkie wyjęcie i wymianę
            translate([0, 0, 10])
                cylinder(d = 22.0, h = 3);
            // Uchwyt zaciskowy na małą szklaną fiolkę (np. średnica 12 mm) z wacikiem
            translate([0, 0, 13])
                cylinder(d = 15.0, h = 18);
        }
        // Wnętrze na szklaną fiolkę i wacik
        translate([0, 0, 2])
            cylinder(d = 12.2, h = 30);
        // Otwory dyfuzyjne od strony komory treningowej
        translate([0, 0, -1])
            cylinder(d = 10.0, h = 5);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 5: VentValveSlider() & HorizontalGateSlider() - Zasuwki (Pkt 2, 3.3, 4)
// ----------------------------------------------------------------------------
module VentValveSlider(is_left = true) {
    color(c_sliders)
    union() {
        cube([1.8, 12.0, 18.0], center = true);
        translate([0, 0, 9.0])
            cube([5.0, 14.0, 3.0], center = true); // Uchwyt
    }
}

module HorizontalGateSlider() {
    color(c_sliders)
    difference() {
        union() {
            // Płytka zasuwki z zaokrąglonym końcem
            translate([0, 0, 0])
                cube([23.5, 42.0, 2.0], center = true);
            // Uchwyt przedni ograniczający głębokość wsunięcia
            translate([0, -21, 0])
                cube([28.0, 4.0, 6.0], center = true);
        }
        // Otwór przelotowy 20 mm (po wsunięciu do końca otwiera przejście dla much,
        // po wysunięciu o 20 mm pełna część płytki szczelnie zamyka komorę)
        translate([0, 8, 0])
            cylinder(d = id_main, h = 5, center = true);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 6: FlyLoadingChamber() & FlyLoadingLid() - Komora Wprowadzania (Pkt 2)
// Szeroka, stabilna komora ze szczelnym zamknięciem i łagodnym stożkiem
// ----------------------------------------------------------------------------
module FlyLoadingChamber() {
    load_id = 36.0; // Znacznie szersza niż kanał treningowy (36 mm vs 20 mm)
    load_od = 40.0;
    
    color(c_clear)
    difference() {
        union() {
            // Dolny kołnierz mocowany na szczycie Komory Treningowej
            cylinder(d = 32.0, h = 6);
            // Łagodne przejście stożkowe (brak ostrych krawędzi, zero stresu przy schodzeniu)
            translate([0, 0, 6])
                cylinder(d1 = 32.0, d2 = load_od, h = 12);
            // Szeroka komora właściwa
            translate([0, 0, 18])
                cylinder(d = load_od, h = 22);
        }
        // Kanał dolny (20 mm)
        translate([0, 0, -1])
            cylinder(d = id_main, h = 7.1);
        // Stożek wewnętrzny (z 36 mm do 20 mm)
        translate([0, 0, 6])
            cylinder(d1 = id_main, d2 = load_id, h = 12.01);
        // Wnętrze szerokiej komory (36 mm)
        translate([0, 0, 18])
            cylinder(d = load_id, h = 23);
    }
}

module FlyLoadingLid() {
    color(c_body)
    difference() {
        union() {
            // Pokrywa górna z radełkowanym rantem
            cylinder(d = 42.0, h = 4);
            // Czop uszczelniający wchodzący do wnętrza komory wprowadzania
            translate([0, 0, -6])
                cylinder(d = 36.0 - tol, h = 6);
            // Uchwyt górny
            translate([0, 0, 4])
                cylinder(d = 16.0, h = 6);
        }
        // Drobna siatka oddechowa w pokrywie (wyrównuje ciśnienie przy zamykaniu!)
        for (x = [-4, 0, 4]) for (y = [-4, 0, 4]) {
            translate([x, y, -7])
                cylinder(d = 0.8, h = 20);
        }
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 7: ChoiceArmWithDrain() - Ramiona Wyboru z Portem Spustowym (Pkt 5.2 & 6)
// ----------------------------------------------------------------------------
module ChoiceArmWithDrain(is_left = true) {
    dir = is_left ? -1 : 1;
    drain_x = is_left ? -(arm_len - 18) : (arm_len - 18);
    
    color(c_clear)
    difference() {
        union() {
            // Rura główna ramienia wyboru (OD 20 mm, ID 16 mm)
            rotate([0, dir * 90, 0])
                cylinder(d = arm_od, h = arm_len);
                
            // Dolny kominek spustowy (umożliwia zebranie much z ramienia bez jego demontażu!)
            translate([drain_x, 0, -14])
                cylinder(d = 18.0, h = 14);
        }
        
        // Kanał wewnętrzny ramienia (ID 16 mm)
        rotate([0, dir * 90, 0])
        translate([0, 0, -1])
            cylinder(d = arm_id, h = arm_len + 2);
            
        // Otwór spustowy skierowany w dół (ID 14 mm)
        translate([drain_x, 0, -15])
            cylinder(d = 14.0, h = 15);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 8: ArmOdorCap() - Niezależne Moduły Zapachowe na Końcach Ramion (Pkt 5.2)
// Wbudowana perforowana bariera ochronna + tylna komora na wacik
// ----------------------------------------------------------------------------
module ArmOdorCap(is_left = true) {
    dir = is_left ? -1 : 1;
    
    color(c_odor)
    rotate([0, dir * 90, 0])
    difference() {
        union() {
            // Mufa nachodząca na koniec ramienia wyboru
            cylinder(d = 24.0, h = 12);
            // Tylny pojemnik na wacik zapachowy
            translate([0, 0, 12])
                cylinder(d = 20.0, h = 16);
        }
        // Gniazdo na rurkę ramienia (do głębokości 10 mm)
        translate([0, 0, -1])
            cylinder(d = arm_od + tol, h = 11);
            
        // Komora na wacik zapachowy (dostępna od zewnątrz/tyłu)
        translate([0, 0, 14])
            cylinder(d = 15.0, h = 15);
            
        // FIZYCZNA BARIERA / PERFOROWANA PRZEGRODA (grubość 2 mm między Z=10 a Z=12)
        // Przepuszcza lotne cząsteczki zapachu, uniemożliwia muchom dotknięcie wacika
        for (dx = [-4 : 2.5 : 4]) {
            for (dy = [-4 : 2.5 : 4]) {
                translate([dx, dy, 9])
                    cylinder(d = 1.1, h = 6);
            }
        }
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 9: ArmGuillotine() - Niezależne Zamknięcia Ramion (Pkt 5.3)
// ----------------------------------------------------------------------------
module ArmGuillotine(is_left = true) {
    color(c_sliders)
    union() {
        // Płytka odcinająca ramię wyboru
        cube([2.0, 21.5, 38.0], center = true);
        // Uchwyt górny
        translate([0, 0, 19.0])
            cube([6.0, 25.0, 4.0], center = true);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 10: CollectionPlug() - Korki Spustowe do Odzyskiwania Much (Pkt 6)
// Wyprofilowane tak, aby podczas testu tworzyć gładkie dno kanału (zero szczelin!)
// ----------------------------------------------------------------------------
module CollectionPlug(is_center = true) {
    plug_d = is_center ? (24.0) : (14.0 - tol);
    flange_d = is_center ? 30.0 : 22.0;
    
    color(c_plugs)
    union() {
        // Trzpień zamykający wylot od dołu
        cylinder(d = plug_d, h = 10);
        // Kołnierz oporowy do wygodnego wyjmowania przy podstawionej fiolce
        translate([0, 0, -4])
            cylinder(d = flange_d, h = 4);
    }
}
