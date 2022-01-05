TARGET=kubeshare-scheduler kubeshare-device-manager kubeshare-config-client
GO=go
GO_MODULE=GO111MODULE=on
BIN_DIR=bin/
ALPINE_COMPILE_FLAGS=CGO_ENABLED=0 GOOS=linux GOARCH=amd64
NVML_COMPILE_FLAGS=CGO_LDFLAGS_ALLOW='-Wl,--unresolved-symbols=ignore-in-object-files' GOOS=linux GOARCH=amd64
PACKAGE_PREFIX=github.com/NTHU-LSALAB/KubeShare/cmd/

.PHONY: all clean $(TARGET)

all: $(TARGET)

kubeshare-device-manager kubeshare-scheduler:
	$(GO_MODULE) $(ALPINE_COMPILE_FLAGS) $(GO) build -o $(BIN_DIR)$@ $(PACKAGE_PREFIX)$@

kubeshare-config-client:
	$(GO_MODULE) $(NVML_COMPILE_FLAGS) $(GO) build -o $(BIN_DIR)$@ $(PACKAGE_PREFIX)$@

images:
	docker build -t ogre0403/kubeshare-gemini-hook-init:nchc 	./docker/kubeshare-gemini-hook-init
	docker build -t ogre0403/kubeshare-config-client:nchc 		./docker/kubeshare-config-client
	docker build -t ogre0403/kubeshare-scheduler:nchc 			./docker/kubeshare-scheduler
	docker build -t ogre0403/kubeshare-device-manager:nchc	 	./docker/kubeshare-device-manager
	docker build -t ogre0403/kubeshare-gemini-scheduler:nchc 	./docker/kubeshare-gemini-scheduler

push:
	docker push ogre0403/kubeshare-gemini-hook-init:nchc
	docker push ogre0403/kubeshare-config-client:nchc
	docker push ogre0403/kubeshare-scheduler:nchc
	docker push ogre0403/kubeshare-device-manager:nchc
	docker push ogre0403/kubeshare-gemini-scheduler:nchc

clean:
	rm $(BIN_DIR)* 2>/dev/null; exit 0
