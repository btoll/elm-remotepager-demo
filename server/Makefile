SHELL 		= /bin/sh
CC      	= go
GENERATED	= .__gen__
GOADESIGN	= design/*
TARGET		= elm-remotepager-demo

.PHONY: build clean generate hooks serve

$(GENERATED): $(GOADESIGN)
	@echo [make] Generating Goa code, please be patient...
	@# Don't suppress the error if the following operation fails!
	@goagen bootstrap -d github.com/btoll/$(TARGET)/server/design
	@# We only want to modify the generated file when successful.
	@touch $(GENERATED)

$(TARGET): *.go sql/*.go $(GENERATED)
	$(CC) build -o $(TARGET)
	@echo [make] Success!

build: $(TARGET) $(GENERATED)

clean:
	rm -rf elm-remotepager-demo app client swagger tool

generate: $(GENERATED)

hooks:
	@echo [make] Installing git hook...
	@cd ../.git/hooks && \
	echo make generate >> post-merge && \
		chmod 755 post-merge

serve: $(TARGET)
	./$(TARGET)

