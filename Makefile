.DEFAULT_GOAL := ava.analyzer.hfst

# for the general lexd
ava.lexd: $(wildcard ava_*.lexd)
	cat ava_*.lexd > ava.lexd

#for twol
ava.twol.hfst: ava.twol
	hfst-twolc $< -o $@

#generator
ava.generator.hfst: ava.lexd ava.twol.hfst
	lexd $< | hfst-txt2fst -o ava_.generator.hfst
	hfst-compose-intersect ava_.generator.hfst ava.twol.hfst -o $@

# generate analyzer
ava.analyzer.hfst: ava.generator.hfst
	hfst-invert $< -o $@

hfstol:
	hfst-fst2fst -O -i ava.analyzer.hfst -o ./coverage/ava.analyzer.hfstol
#	hfst-fst2fst -O -i $< -o $@

# test generator
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
check: ava.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt

clean:
	rm *.hfst *.txt *.mchar *.res ava.lexd
