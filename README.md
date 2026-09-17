# Für Consumer 
Infos und Dokumentation der Skripte und Veröffentlichung der fertigen PDFs in allen Versionen unter: https://valentin-herrmann.com/fts/


# Für Creator

## Einrichtung (VS Code)

1. Repo klonen, in VS Code öffnen.
2. Terminal (`` Strg+` ``): `./init.sh` (einmalig).
3. **Run and Debug** (F5) 
   - **MAIN** baut `main.tex` (→ `build/`)
   - **PREVIEW** baut die PR-Vorschau-Auswahl, also leeres Skript, Musterlöung, Präsentation hell und dunkel (→ `build/`), 
   - **ALL** baut alle Varianten (→ `pdfs/`; dauert lange: ca. 60 PDFs).

## Wo kommt was hin?

- `_Skripte/` – Unterrichtsskripte, ein `.tex` pro (Teil)Skript/Kurs/Schuljahr/....
- `_Aufgaben/` – Arbeitsblätter/Aufgaben.
- `_Hefteintraege/` – Hefteinträge.
- Bilder/Anhänge jeweils im `img/`-Unterordner der zugehörigen Datei.
- `selected.tex` – legt fest, was `main.tex` tatsächlich baut (i.d.R. ein `\input{_Skripte/...}`).

## Terminal (ohne VS Code)

```bash
# einmalig repo und submodule initialisieren
./init.sh   

# baut main.tex als PDF und speichert es in ./build/
tectonic \
-Z search-path=. \
-Z search-path=template \
-Z search-path=template/sty/moloch \
-Z continue-on-errors \
-o build main.tex 
```
