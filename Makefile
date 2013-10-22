all: build

clean:
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
