IMAGES := $(wildcard imgs/*.tex)
LATEXMK := latexmk.exe
pdf: tex
tex:
	[ -d build ] || mkdir -p build; \
	cp main.tex preliminares.tex ref.bib build/
	cp -r imgs build/
	cd build && ${LATEXMK} -bibtex -xelatex -synctex=1 -interaction=nonstopmode main.tex
image:
	cd imgs && \
	[ -d build ] || mkdir -p build; \
	cp *.tex build/; \
	cd build && \
	for t in ${IMAGES}; do \
		echo ${t##/}; \
		${LATEXMK} -xelatex -synctex=1 -interaction=nonstopmode ${t##/}; \
	done && \
	cp *.pdf ../

all: image pdf
clean: 
	cd build && ${LATEXMK} -C