SHELL 		= /bin/sh
CC      	= elm make

PORT		= 1975
TARGET  	= elm.js
WEBSERVER	= elm reactor

.PHONY: clean dev hooks prod production serve

define compile
	$(CC) src/Main.elm --output=$(TARGET) \
		$(if $1,--debug)
endef

$(TARGET):
	$(call compile, dev)

clean:
	rm -f $(TARGET)

dev: clean $(TARGET)

hooks:
	cd .git/hooks && \
	echo make dev >> post-merge && \
		chmod 755 post-merge

prod: production

production: clean
	$(call compile)

serve: $(TARGET)
	$(WEBSERVER) -p $(PORT)

