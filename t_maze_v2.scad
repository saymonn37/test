// ============================================================================
// PROJEKT: Zunifikowany Labirynt T (T-Maze) dla Drosophila melanogaster
// PRZEZNACZENIE: Warunkowanie awersyjne i testowanie pamięci węchowej
// TECHNOLOGIA: Druk 3D FDM (bez podpór wewnętrznych - fazowania 45 st.)
// ============================================================================

// --- 1. PARAMETRY GLOBALNE I KONFIGURACJA WIDOKU ---

exploded_view = true; // Zmień na false, aby złożyć model w całość
spacing = exploded_view ? 40 : 0; // Odstęp eksplozji [mm]

$fn = 64; // Rozdzielczość krzywych

// Tolerancje i wymiary bazowe
tol = 0.2;           // Standardowa tolerancja pasowania (wcisk / klej)
slide_tol = 0.4;     // Luźniejsza tolerancja dla ruchomej windy (TrainingTube)
tube_od = 20.0;      // Średnica zewnętrzna rurek
tube_id = 16.0;      // Średnica wewnętrzna rurek
wall = 2.0;          // Standardowa grubość ścianki
mesh_thick = 0.6;    // Grubość szczeliny na siatkę miedzianą

// Wymiary Bloku Centralnego
hub_size = 32.0;     // Rozmiar bazy sześcianu (32mm daje bezpieczną ściankę dla gniazd)
socket_depth = 5.0;  // Głębokość osadzenia rurek bocznych

// Wymiary pozostałych komponentów
training_len = 80.0; // Długość rurki treningowej
arm_len = 60.0;      // Długość ramion wyboru

// Kolory do wizualizacji materiałowej
c_black_petg = [0.18, 0.18, 0.20, 1.0];   // Czarny mat (brak dystrakcji świetlnej)
c_clear_pmma = [0.75, 0.88, 0.95, 0.55];  // Transparentne rurki (obserwacja)
c_doors      = [0.85, 0.35, 0.15, 1.0];   // Kontrastowy kolor dla zapadek (gilotyn)


// ============================================================================
// --- 2. GŁÓWNY BLOK ZŁOŻENIOWY (ASSEMBLY) ---
// ============================================================================

// 1. Blok Centralny - Nieruchome serce układu w punkcie [0,0,0]
CentralHub();

// 2. Rurka Treningowa (Winda) - Wsuwana od góry (oś +Z)
// W stanie złożonym wchodzi 5 mm w głąb górnego portu Bloku Centralnego
translate([0, 0, (hub_size/2 - 5) + spacing * 1.2])
    TrainingTube();

// 3. Wsyp much (Lejek) - Osadzony na szczycie Rurki Treningowej (oś +Z)
translate([0, 0, (hub_size/2 - 5 + training_len) + spacing * 2.4])
    Funnel();

// 4. Ramiona Wyboru (Lewe i Prawe) - Oś X (-X oraz +X)
translate([-((hub_size/2 - socket_depth) + spacing), 0, 0])
    ChoiceArms(is_left = true);

translate([((hub_size/2 - socket_depth) + spacing), 0, 0])
    ChoiceArms(is_left = false);

// 5. Zaślepki Zapachowe - Na końcach Ramion Wyboru (oś -X oraz +X)
translate([-((hub_size/2 - socket_depth + arm_len) + spacing * 2.0), 0, 0])
    EndCaps(is_left = true);

translate([((hub_size/2 - socket_depth + arm_len) + spacing * 2.0), 0, 0])
    EndCaps(is_left = false);

// 6. Zapadki (Gilotyny) - Wsuwane od góry w szczeliny Bloku Centralnego
translate([0, 0, spacing * 0.9]) {
    GuillotineDoors(is_left = true);
    GuillotineDoors(is_left = false);
}

// 7. Korek Dolny - Zamykający Blok Centralny od dołu (oś -Z)
translate([0, 0, -(hub_size/2 + spacing * 1.0)])
    BottomCap();


// ============================================================================
// --- 3. DEFINICJE MODUŁÓW ---
// ============================================================================

// ----------------------------------------------------------------------------
// MODUŁ 1: CentralHub() - Blok Centralny (Skrzyżowanie)
// ----------------------------------------------------------------------------
module CentralHub() {
    slot_x_offset = 10.75; // Pozycja szczelin gilotyn (pomiędzy windą a gniazdem ramion)
    
    color(c_black_petg)
    difference() {
        // Baza główna z króćcem podciśnienia (w osi +Y)
        union() {
            // Sześcian centralny
            cube([hub_size, hub_size, hub_size], center = true);
            
            // Króciec podciśnienia z tyłu (+Y) z podstawą fazowaną pod 45 st. (druk bez podpór)
            translate([0, hub_size/2, 0])
            rotate([-90, 0, 0]) {
                cylinder(d1 = 16, d2 = 10, h = 3); // Fazowany kołnierz wzmacniający
                cylinder(d = 10, h = 14);          // Właściwy króciec OD 10mm
            }
        }
        
        // 1. Pionowy otwór przelotowy w osi Z (prowadnica windy i gniazdo korka dolnego)
        // Średnica 20.4 mm (tube_od + 2*tol)
        cylinder(d = tube_od + slide_tol, h = hub_size + 2, center = true);
        
        // Fazowanie wejścia od góry ułatwiające wsunięcie windy
        translate([0, 0, hub_size/2 - 1.0])
            cylinder(d1 = tube_od + slide_tol, d2 = tube_od + slide_tol + 2.0, h = 1.1);
            
        // 2. Kanał przelotowy poziomy w osi X (ID 16 mm)
        rotate([0, 90, 0])
            cylinder(d = tube_id, h = hub_size + 2, center = true);
            
        // 3. Gniazda (20.2 mm) na wklejenie/wciśnięcie rurek ChoiceArms (głębokość 5 mm)
        // Prawe gniazdo (+X) z fazowaniem 45 st. przejścia 20.2 -> 16.0 mm
        translate([hub_size/2 - socket_depth, 0, 0])
        rotate([0, 90, 0])
            cylinder(d = tube_od + tol, h = socket_depth + 1);
        translate([hub_size/2 - socket_depth - 2.1, 0, 0])
        rotate([0, 90, 0])
            cylinder(d1 = tube_id, d2 = tube_od + tol, h = 2.11);
            
        // Lewe gniazdo (-X) z fazowaniem 45 st.
        translate([-(hub_size/2 + 1), 0, 0])
        rotate([0, 90, 0])
            cylinder(d = tube_od + tol, h = socket_depth + 1);
        translate([-(hub_size/2 - socket_depth), 0, 0])
        rotate([0, 90, 0])
            cylinder(d1 = tube_od + tol, d2 = tube_id, h = 2.11);
            
        // 4. Kanał podciśnienia w osi +Y (ID 6 mm)
        translate([0, 0, 0])
        rotate([-90, 0, 0])
            cylinder(d = 6.0, h = hub_size/2 + 16);
            
        // 5. Dwie pionowe szczeliny dla zapadek (GuillotineDoors)
        // Wymiary: szerokość 2.5 mm (oś X), długość 22 mm (oś Y)
        // Schodzą od góry aż poniżej kanału 16 mm (do Z = -11 mm)
        for (side = [-1, 1]) {
            translate([side * slot_x_offset, 0, 3.0])
                cube([2.5, 22.0, hub_size], center = true);
        }
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 2: TrainingTube() - Rurka Treningowa / Winda
// ----------------------------------------------------------------------------
module TrainingTube() {
    color(c_clear_pmma)
    difference() {
        union() {
            // Główna rura pionowa (OD 20 mm, wysokość 80 mm)
            cylinder(d = tube_od, h = training_len);
            
            // Boczny port (szufladka) na wacik z zapachem w połowie wysokości (Z = 40 mm)
            // Wystaje w kierunku -Y (do przodu urządzenia)
            translate([0, 0, training_len/2]) {
                // Obudowa kieszeni (wym. zewn. 19 x 16 mm)
                translate([0, -11, 0])
                    cube([19, 16, 14], center = true);
                
                // Podpora kątowa 45 stopni pod szufladką (umożliwia druk FDM na stojąco bez podpór!)
                hull() {
                    translate([0, -11, -7])
                        cube([19, 16, 0.1], center = true);
                    translate([0, -4, -19])
                        cube([14, 2, 0.1], center = true);
                }
            }
        }
        
        // Główny kanał wewnętrzny (ID 16 mm)
        translate([0, 0, -1])
            cylinder(d = tube_id, h = training_len + 2);
            
        // Wewnętrzne wycięcie szufladki na wacik (wymiary wewnętrzne: 15 mm szer. x 10 mm wys.)
        translate([0, -12, training_len/2])
            cube([15, 16, 10], center = true);
            
        // Otwory wentylacyjne łączące szufladkę zapachową z wnętrzem rurki treningowej
        // Zamiast jednego dużego otworu: 3 pionowe szczeliny (1.5 mm), aby muchy nie uciekły do wacika
        for (x_off = [-4, 0, 4]) {
            translate([x_off, -8, training_len/2])
                cube([1.5, 10, 8], center = true);
        }
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 3: Funnel() - Wsyp much (Lejek)
// ----------------------------------------------------------------------------
module Funnel() {
    plug_h = 6.0;    // Wysokość kołnierza wchodzącego do TrainingTube
    cone_h = 30.0;   // Wysokość stożka
    rim_h  = 5.0;    // Górny prosty rant ułatwiający przykładanie fiolek
    
    plug_od = tube_id - tol; // 15.8 mm (wchodzi na wcisk w ID 16 mm)
    plug_id = plug_od - 2 * wall; // 11.8 mm
    
    color(c_clear_pmma)
    difference() {
        union() {
            // Dolny kołnierz (wypustka wsuwana do wnętrza rurki treningowej)
            translate([0, 0, -plug_h])
                cylinder(d = plug_od, h = plug_h);
                
            // Stożek zewnętrzny (od OD 20 mm na dole do OD 44 mm na górze)
            cylinder(d1 = tube_od, d2 = 40.0 + 2*wall, h = cone_h);
            
            // Górny rant cylindryczny
            translate([0, 0, cone_h])
                cylinder(d = 40.0 + 2*wall, h = rim_h);
        }
        
        // Kanał wewnętrzny w kołnierzu dolnym (z fazowaniem przejścia)
        translate([0, 0, -plug_h - 1])
            cylinder(d = plug_id, h = plug_h + 1.1);
            
        // Wnętrze stożka (od ID 11.8 mm do ID 40 mm)
        cylinder(d1 = plug_id, d2 = 40.0, h = cone_h + 0.01);
        
        // Wnętrze górnego rantu (ID 40 mm)
        translate([0, 0, cone_h - 0.01])
            cylinder(d = 40.0, h = rim_h + 1);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 4: ChoiceArms(is_left) - Ramiona wyboru (L/P)
// ----------------------------------------------------------------------------
module ChoiceArms(is_left = true) {
    dir = is_left ? -1 : 1;
    
    color(c_clear_pmma)
    rotate([0, dir * 90, 0])
    difference() {
        cylinder(d = tube_od, h = arm_len);
        translate([0, 0, -1])
            cylinder(d = tube_id, h = arm_len + 2);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 5: EndCaps(is_left) - Zaślepki zapachowe na końce ramion
// ----------------------------------------------------------------------------
module EndCaps(is_left = true) {
    dir = is_left ? -1 : 1;
    cap_od = 24.0;
    cap_inner_d = tube_od + tol; // 20.2 mm (zgodnie ze specyfikacją, wsuwane na rurkę 20 mm)
    sleeve_depth = 10.0;         // Głębokość nachodzenia na rurkę
    baffle_thick = 3.0;          // Grubość wewnętrznej przegrody
    total_len = sleeve_depth + baffle_thick;
    
    // Przesunięcie tak, aby w widoku złożonym kołnierz nachodził na koniec rurki ChoiceArms
    offset_x = is_left ? sleeve_depth : -sleeve_depth;
    
    color(c_black_petg)
    translate([offset_x, 0, 0])
    rotate([0, dir * 90, 0])
    difference() {
        union() {
            // Korpus główny zaślepki (OD 24 mm)
            cylinder(d = cap_od, h = total_len);
            
            // Zewnętrzny króciec na wężyk doprowadzający zapach
            translate([0, 0, total_len])
                cylinder(d1 = 10.0, d2 = 8.0, h = 8.0);
        }
        
        // Wewnętrzne wybranie na rurkę (średnica 20.2 mm, głębokość 10 mm)
        translate([0, 0, -1])
            cylinder(d = cap_inner_d, h = sleeve_depth + 1);
            
        // Szczelina 0.6 mm na "wklikiwaną" siatkę miedzianą tuż przy przegrodzie
        translate([0, 0, sleeve_depth - mesh_thick])
            cylinder(d = cap_inner_d + 1.6, h = mesh_thick + 0.05);
            
        // Stożkowe przejście od siatki do otworu 6 mm (ułatwia druk i rozprowadza powietrze)
        translate([0, 0, sleeve_depth - 0.01])
            cylinder(d1 = tube_id, d2 = 6.0, h = 1.5);
            
        // Centralny otwór wlotowy powietrza / zapachu (ID 6 mm)
        translate([0, 0, sleeve_depth])
            cylinder(d = 6.0, h = baffle_thick + 10);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 6: GuillotineDoors(is_left) - Zapadki (Gilotyny)
// ----------------------------------------------------------------------------
module GuillotineDoors(is_left = true) {
    dir = is_left ? -1 : 1;
    slot_x_offset = 10.75; // Dokładne dopasowanie do szczelin w CentralHub
    
    blade_w = 22.0 - tol;  // Szerokość 21.8 mm (pod szczelinę 22 mm)
    blade_t = 2.0;         // Grubość 2.0 mm (pod szczelinę 2.5 mm)
    blade_h = 40.0;        // Wysokość całkowita płytki
    
    color(c_doors)
    // W stanie złożonym zapadka jest wsunięta do połowy (otwiera światło kanału)
    translate([dir * slot_x_offset, 0, hub_size/2 + 8])
    union() {
        // Płaska płytka odcinająca
        cube([blade_t, blade_w, blade_h], center = true);
        
        // Fazowany dolny brzeg płytki (łatwiejsze wsuwanie w szczelinę)
        translate([0, 0, -blade_h/2 + 1])
            cube([blade_t - 0.4, blade_w - 0.4, 2], center = true);
        
        // Szerszy, ergonomiczny uchwyt na górze (zapobiega wpadnięciu do środka)
        translate([0, 0, blade_h/2 + 2.0])
            cube([blade_t + 4.0, blade_w + 6.0, 4.0], center = true);
    }
}

// ----------------------------------------------------------------------------
// MODUŁ 7: BottomCap() - Korek Dolny (Zintegrowany z siatką wentylacyjną)
// ----------------------------------------------------------------------------
module BottomCap() {
    plug_h = 8.0;            // Wysokość części wsuwanej do Bloku Centralnego
    flange_h = 3.0;          // Grubość kołnierza oporowego
    plug_od = tube_od;       // 20.0 mm (wchodzi w otwór 20.4 mm z minimalnym luzem)
    
    color(c_black_petg)
    difference() {
        union() {
            // Kołnierz oporowy (opiera się o dolną ściankę CentralHub)
            translate([0, 0, -flange_h])
                cylinder(d = 26.0, h = flange_h);
                
            // Trzpien główny wsuwany od dołu (OD 20 mm)
            cylinder(d = plug_od, h = plug_h);
            
            // Delikatny pierścień zatrzaskowy (snap-fit ridge) kompensujący luz 20.4 mm
            translate([0, 0, plug_h/2])
                cylinder(d = plug_od + 0.25, h = 1.2, center = true);
        }
        
        // Wewnętrzny otwór przelotowy 16 mm
        translate([0, 0, -flange_h - 1])
            cylinder(d = tube_id, h = plug_h + flange_h + 2);
            
        // Gniazdo od góry na wklejenie/wciśnięcie krążka siatki miedzianej (głębokość 1.0 mm)
        translate([0, 0, plug_h - 1.0])
            cylinder(d = tube_id + 2.0, h = 1.5);
    }
}
