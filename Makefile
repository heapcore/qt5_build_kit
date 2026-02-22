QT_VERSION ?= 5.15
PARALLEL_JOBS ?=

WIN_I386_IMAGE := qt5-win-i386
WIN_AMD64_IMAGE := qt5-win-amd64
LINUX_I386_IMAGE := qt5-linux-i386
LINUX_AMD64_IMAGE := qt5-linux-amd64
LINUX_ARM64_IMAGE := qt5-linux-arm64
MACOS_AMD64_IMAGE := qt5-macos-amd64
MACOS_ARM64_IMAGE := qt5-macos-arm64

BUILD_DIR := build
ARTIFACTS_DIR := artifacts

ifeq ($(NO_CACHE),1)
DOCKER_CACHE_FLAG := --no-cache
else
DOCKER_CACHE_FLAG :=
endif

.PHONY: win-i386 win-amd64 linux-i386 linux-amd64 linux-arm64 macos-amd64 macos-arm64 \
        linux-amd64-app clean prune-cache

win-i386:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.windows-i386 -t $(WIN_I386_IMAGE) .

win-amd64:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.windows-amd64 -t $(WIN_AMD64_IMAGE) .

linux-i386:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.linux-i386 -t $(LINUX_I386_IMAGE) .

linux-amd64:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.linux-amd64 -t $(LINUX_AMD64_IMAGE) .

linux-arm64:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.linux-arm64 -t $(LINUX_ARM64_IMAGE) .

macos-amd64:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.macos-amd64 -t $(MACOS_AMD64_IMAGE) .

macos-arm64:
	docker build $(DOCKER_CACHE_FLAG) -f Dockerfile.macos-arm64 -t $(MACOS_ARM64_IMAGE) .

linux-amd64-app:
ifeq ($(OS),Windows_NT)
	if not exist "$(ARTIFACTS_DIR)\linux-amd64" mkdir "$(ARTIFACTS_DIR)\linux-amd64"
endif
	docker run --rm \
		-v "$(CURDIR):/src" \
		-v "$(CURDIR)/$(ARTIFACTS_DIR)/linux-amd64:/out" \
		$(LINUX_AMD64_IMAGE) \
		bash -lc '\
			cmake -S /src -B /tmp/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/local/Qt-5.15 && \
			cmake --build /tmp/build --parallel && \
			cp /tmp/build/calculator_demo /out/calculator_demo && \
			cp /tmp/build/lineedits_demo /out/lineedits_demo && \
			cp /tmp/build/dragdroprobot_demo /out/dragdroprobot_demo'

clean:
ifeq ($(OS),Windows_NT)
	if exist "$(BUILD_DIR)" rmdir /s /q "$(BUILD_DIR)"
	if exist "$(ARTIFACTS_DIR)" rmdir /s /q "$(ARTIFACTS_DIR)"
else
	rm -rf $(BUILD_DIR) $(ARTIFACTS_DIR)
endif

prune-cache:
	docker builder prune -f
	docker image prune -f
