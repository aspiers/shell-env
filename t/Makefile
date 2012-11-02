# Run tests
#
# Copyright (c) 2005 Junio C Hamano
#

#GIT_TEST_OPTS=--verbose --debug
SHELL_PATH ?= $(SHELL)
PERL_PATH ?= /usr/bin/perl
TAR ?= $(TAR)
RM ?= rm -f
PROVE ?= prove
DEFAULT_TEST_TARGET ?= test

# Shell quote;
SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'

T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))

all: $(DEFAULT_TEST_TARGET)

test: pre-clean $(TEST_LINT)
	$(MAKE) aggregate-results-and-cleanup

prove: pre-clean $(TEST_LINT)
	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
	$(MAKE) clean-except-prove-cache

$(T):
	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)

pre-clean:
	$(RM) -r test-results

clean-except-prove-cache:
	$(RM) -r 'trash directory'.* test-results

clean: clean-except-prove-cache
	$(RM) .prove

aggregate-results-and-cleanup: $(T)
	$(MAKE) aggregate-results
	$(MAKE) clean

aggregate-results:
	for f in test-results/t*-*.counts; do \
		echo "$$f"; \
	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh

test-results:
	mkdir -p test-results

smoke: test-results/git-smoke.tar.gz

.PHONY: pre-clean $(T) aggregate-results clean
