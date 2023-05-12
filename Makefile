# .DEFAULT_GOAL := ava.analyzer.hfst

# for the general lexd
#ava.lexd: $(wildcard ava_*.lexd)
#	cat ava_*.lexd > ava.lexd

#ava.noun.analyzer.hfst: ava.noun.generator.hfst
#	hfst-invert $< -o $@

ava.adv.analyzer.hfst: ava.adv.generator.hfst
	hfst-invert $< -o $@

ava.adv.generator.hfst: ava_adv.lexd
	lexd $< | hfst-txt2fst -o $@
   
ava.adj.analyzer.hfst: ava.adj.generator.hfst
	hfst-invert $< -o $@

ava.adj.generator.hfst: ava_adj.lexd
	lexd $< | hfst-txt2fst -o $@
	
ava.num.analyzer.hfst: ava.num.generator.hfst
	hfst-invert $< -o $@

ava.num.generator.hfst: ava_num.lexd
	lexd $< | hfst-txt2fst -o $@
	
#ava.twol.hfst: ava.twol
#	hfst-twolc $< -o $@

# delete .hfst
#clean:
#	rm *.hfst
