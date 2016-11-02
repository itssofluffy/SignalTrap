all: build

build:
	swift build

build-release:
	swift build --configuration release

docs:
	swift package generate-xcodeproj

clean:
	swift build --clean

.PHONY: build build-release docs clean
