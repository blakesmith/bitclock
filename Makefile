CONF_DIR=conf
RELEASE_DIR=release
PKG_NAME=bitclock
PWD=$(shell pwd)
PREFIX=/usr/local

all: build

clean:
	rm -rf $(RELEASE_DIR)
	rm -f $(PKG_NAME).deb
	cabal clean

configure:
	cabal configure

deps:
	cabal update
	cabal install --only-dependencies

build:
	cabal build

install:
	cabal install

setup:
	mkdir -p $(RELEASE_DIR)
	cp -r $(CONF_DIR)/* $(RELEASE_DIR)/

package: setup build
	cabal install --prefix=$(PWD)/$(RELEASE_DIR)$(PREFIX)
	dpkg -b $(RELEASE_DIR)/ $(PKG_NAME).deb

