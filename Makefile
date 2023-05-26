.DEFAULT_GOAL := ava.analyzer.hfst

# for the general lexd
ava.lexd: $(wildcard ava_*.lexd)
	cat ava_*.lexd > ava.lexd

#for twol
ava.twol.hfst: ava.twol
	hfst-twolc $< -o $@

#generator
ava.generator.hfst: ava.lexd
	lexd $< | hfst-txt2fst -o $@
	hfst-compose-intersect ava.generator.hfst ava.twol.hfst -o ava_.generator.hfst
#	rm ava.generator.hfst
#	rm ava.twol.hfst
	
# test generator
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
check: ava.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt

# generate analizer
ava.analyzer.hfst: check
#	rm test.*
	hfst-invert ava_.generator.hfst -o $@

ava.analyzer.hfstol: ava.analyzer.hfst
	hfst-fst2fst -O -i $< -o $@

# delete .hfst
clean:
#	rm *.hfst
