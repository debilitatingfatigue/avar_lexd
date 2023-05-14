#.DEFAULT_GOAL := ava.analyzer.hfst

# for the general lexd
ava.lexd: $(wildcard ava_*.lexd)
	cat ava_*.lexd > ava.lexd

#for twol
#ava.twol.hfst: ava.twol
#	hfst-twolc $< -o $@

#generator
ava.generator.hfst: ava.lexd
	lexd $< | hfst-txt2fst -o $@
	
#ava.analyzer.hfst: ava.generator.hfst
#	hfst-invert $< -o $@

# delete .hfst
#clean:
#	rm *.hfst
