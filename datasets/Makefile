all: covtype news20 rcv1 mushrooms splice

.PHONY: help

help: ## This help dialog
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
	    IFS=$$'#' ; \
	    help_split=($$help_line) ; \
	    help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
	    help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
	    printf "%-30s %s\n" $$help_command $$help_info ; \
	done

covtype: ## covtype
covtype: covtype.libsvm.binary

covtype.libsvm.binary:
	wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/covtype.libsvm.binary.bz2
	bzip2 -df covtype.libsvm.binary.bz2

news20: ## news20
news20: news20.binary

news20.binary:
	wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/news20.binary.bz2
	bzip2 -df news20.binary.bz2

rcv1: ## rcv1
rcv1: rcv1_train.binary rcv1_test.binary

rcv1_train.binary:
	wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/rcv1_train.binary.bz2
	bzip2 -df rcv1_train.binary.bz2

rcv1_test.binary:
	wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/rcv1_test.binary.bz2
	bzip2 -df rcv1_test.binary.bz2

mushrooms: ## mushrooms
	wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/mushrooms

splice: ## splice
splice: splice.t
	wget http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/splice

splice.t:
	wget http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/splice.t
