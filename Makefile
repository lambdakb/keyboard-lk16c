NAME	:= LK16C
GITROOT	:= $(shell git rev-parse --show-toplevel)
KIBOT	:= $(GITROOT)/libraries/kicad-lkbd/kibot/.bin/kibot

default: export step

export: clean pcb plate

pcb:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/pcb
	$(KIBOT) \
	    -c ./pcb/lk16c-pcb.kibot.yaml \
	    -b ./pcb/lk16c-pcb.kicad_pcb \
	    -d output/pcb

plate:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/plate
	$(KIBOT) \
	    -c ./case/plate/lk16c-plate.kibot.yaml \
	    -b ./case/plate/lk16c-plate_regular.kicad_pcb \
	    -d output/plate
	$(KIBOT) \
	    -c ./case/plate/lk16c-plate.kibot.yaml \
	    -b ./case/plate/lk16c-plate_2space.kicad_pcb \
	    -d output/plate

step:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/step
	$(KIBOT) \
	    -c libraries/kicad-lkbd/kibot/3dexport.kibot.yaml \
	    -b ./pcb/lk16c-pcb.kicad_pcb \
	    -d output 3d_step
	$(KIBOT) \
	    -c libraries/kicad-lkbd/kibot/3dexport.kibot.yaml \
	    -b ./case/plate/lk16c-plate_regular.kicad_pcb \
	    -d output 3d_step
	$(KIBOT) \
	    -c libraries/kicad-lkbd/kibot/3dexport.kibot.yaml \
	    -b ./case/plate/lk16c-plate_2space.kicad_pcb \
	    -d output 3d_step

clean:
	$(info + [$(NAME)] $@)
	rm -rf output/pcb output/plate output/step

.PHONY: default export pcb plate step clean
