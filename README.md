Materialien für den Datenbanken-Kurs (Inf10). Mehr Infos:
https://valentin-herrmann.com/inf10_db/

## Einrichtung (VS Code)

1. Repo klonen, in VS Code öffnen.
2. Terminal (`` Strg+` ``): `./init.sh` (einmalig).
3. **Run and Debug** (F5) → **MAIN** baut `main.tex` (→ `build/`), **PREVIEW**
   baut die PR-Vorschau-Auswahl (→ `build/`), **ALL** baut alle Varianten
   (→ `pdfs/`, dauert lange).

## Wo kommt was hin?

- `_Skripte/` – Unterrichtsskripte, ein `.tex` pro Halbjahr/Kurs.
- `_Aufgaben/` – Arbeitsblätter/Aufgaben.
- `_Hefteintraege/` – Hefteinträge.
- Bilder/Anhänge jeweils im `img/`-Unterordner der zugehörigen Datei.
- `selected.tex` – legt fest, was `main.tex` tatsächlich baut (i.d.R. ein
  `\input{_Skripte/...}`).

## Terminal (ohne VS Code)

```bash
./init.sh   # einmalig
tectonic -Z search-path=. -Z search-path=template -Z search-path=template/sty/moloch \
  -Z continue-on-errors -o build main.tex
```
