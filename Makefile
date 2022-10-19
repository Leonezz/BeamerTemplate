IMAGES := $(wildcard imgs/*.tex)
pdf: tex
tex:
	[ -d build ] || mkdir -p build \
	cp main.tex preliminares.tex ref.bib build/
	cp -r imgs build/
	cd build && latexmk.exe -bibtex -xelatex -synctex=1 -interaction=nonstopmode main.tex
image:
	cd imgs && \
	[ -d build ] || mkdir -p build \
	cp *.tex build/; \
	cd build && \
	for t in ${IMAGES}; do \
		echo ${t##/}; \
		latexmk.exe -xelatex -synctex=1 -interaction=nonstopmode ${t##/}; \
	done && \
	cp *.pdf ../

all: image pdf
clean: 
	cd build && latexmk.exe -C