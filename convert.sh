#!/bin/bash

# Verzeichnis, in dem die docx-Dateien gespeichert sind
output_dir=".output"

# Aktuelles Datum im gewünschten Format
current_date=$(date +"%d.%m.%Y")


# fine alle .md Dateien und konvertiere sie in docx
find . -name "*.md" -type f -exec zsh -c 'pandoc -s "${0}" -o ".output/$(basename ${0%.md}.docx)"' {} \;

# Kombinieren aller docx-Dateien
pandoc $output_dir/*.docx -o Terraform-in-der-Praxis-"$current_date".docx

echo "Die aktuelle Version  des Buches Terraform-in-der-Praxis wurde gespeichert. $current_date.docx"

# entferne die einzelnen docx Dateien
rm -rf $output_dir/*.docx