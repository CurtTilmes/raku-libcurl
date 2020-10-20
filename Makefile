CWD := $(shell pwd)
NAME := $(shell jq -r .name META6.json)
VERSION := $(shell jq -r .version META6.json)
ARCHIVENAME := $(subst ::,-,$(NAME))

check:
	git diff-index --check HEAD
	prove6

tag:
	git tag $(VERSION)
	git push origin --tags

dist:
	git archive --prefix=$(ARCHIVENAME)-$(VERSION)/ \
		-o ../$(ARCHIVENAME)-$(VERSION).tar.gz $(VERSION)

test-alpine:
	docker run --rm -t -u root \
	  -e RELEASE_TESTING=1 \
	  -v $(CWD):/test \
          --entrypoint="/bin/sh" \
	  jjmerelo/raku-test \
	  -c "apk add --update --no-cache libcurl && cd /home/raku && zef install --/test --deps-only --test-depends . && zef -v test ."

test-debian:
	docker run --rm -t \
	  -e RELEASE_TESTING=1 \
	  -v $(CWD):/test -w /test \
          --entrypoint="/bin/sh" \
	  jjmerelo/rakudo-nostar \
	  -c "zef install --/test --deps-only --test-depends . && zef -v test ."

# Yeah, I know I should put all this in a docker image
test-centos:
	docker run --rm -t \
	  -e RELEASE_TESTING=1 \
	  -v $(CWD):/test -w /test \
          --entrypoint="/bin/bash" \
	  centos:latest \
	  -c "yum install -y wget curl git && wget https://dl.bintray.com/nxadm/rakudo-pkg-rpms/CentOS/8/x86_64/rakudo-pkg-CentOS8-2020.05-01.x86_64.rpm && yum install -y rakudo-pkg-CentOS8-2020.05-01.x86_64.rpm && rm rakudo-pkg-CentOS8-2020.05-01.x86_64.rpm && source ~/.bashrc && zef install --/test --deps-only --test-depends . && zef -v test ."

test: test-alpine test-debian test-centos
