IMAGES := $(wildcard imgs/*.tex)
pdf: tex
tex:
	if [ ! -d build ]; then \
		mkdir build \
	fi \
	cp main.tex preliminares.tex ref.bib build/
	cp -r imgs build/
	cd build && latexmk.exe -bibtex -xelatex -synctex=1 -interaction=nonstopmode main.tex
image:
	cd imgs && \
	if [ ! -d build ]; then \
    	mkdir build \
	fi \
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