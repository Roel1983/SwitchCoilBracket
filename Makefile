# Applications
OPENSCAD                ?= openscad

.PHONY: all
all: 

.PHONY: cleanall
cleanall:
	rm SwitchCoilBracket.stl SwitchCoilBracket.png


all: SwitchCoilBracket.stl
SwitchCoilBracket.stl: SwitchCoilBracket.scad
	$(OPENSCAD) -o SwitchCoilBracket.stl SwitchCoilBracket.scad

all: SwitchCoilBracket.png
SwitchCoilBracket.png: SwitchCoilBracket.scad
	$(OPENSCAD) -o SwitchCoilBracket.png SwitchCoilBracket.scad

