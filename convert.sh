find ./ -iname "*.md" -type f -exec sh -c 'pandoc "${0}" -o "${0%.md}.docx"' {} \;
find . -name "*.docx" -exec sh -c 'mv "${0}" output/'
pandoc output/*.docx -o output/alles.docx