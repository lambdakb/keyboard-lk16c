NAME	:= LK16C
GITROOT	:= $(shell git rev-parse --show-toplevel)
KIBOT	:= $(GITROOT)/.kibot/bin/kibot

default: export step

test:
	$(info + [$(NAME)] $@)
	$(KIBOT) -c .kibot/test.kibot.yaml -b ./pcb/lk16c-pcb.kicad_pcb

export: pcb

pcb:
	$(info + [$(NAME)] $@)
	$(KIBOT) -c .kibot/pcb.kibot.yaml -d output/pcb -b ./pcb/lk16c-pcb.kicad_pcb

step:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/step
	$(KIBOT) -c .kibot/pcb.kibot.yaml -d output -b ./pcb/lk16c-pcb.kicad_pcb 3d_step

clean:
	$(info + [$(NAME)] $@)
	rm -rf output/

.PHONY: default test export pcb step clean
