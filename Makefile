CRYSTAL = crystal
CR_FLAGS = --release --prelude=./linux_prelude -Dcryloc_lock -Dcryloc_external_sbrk
CR_SOURCES := $(shell find src -type f -name '*.cr')
NAME = cryloc
BUILD_DIR = build

all: $(BUILD_DIR)/$(NAME).a $(BUILD_DIR)/$(NAME).so

$(NAME).o: $(CR_SOURCES)
	$(CRYSTAL) build src/cryloc.cr -o $(BUILD_DIR)/$(NAME) --emit obj $(CR_FLAGS)

$(BUILD_DIR)/$(NAME).a: $(BUILD_DIR) $(NAME).o
	$(AR) -rc $(BUILD_DIR)/$(NAME).a $(NAME).o

$(BUILD_DIR)/$(NAME).so: $(BUILD_DIR) $(NAME).o
	$(CC) -shared -fPIC $(CFLAGS) $(NAME).o -o $(BUILD_DIR)/$(NAME).so 

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR) $(NAME).o

.PHONY: clean