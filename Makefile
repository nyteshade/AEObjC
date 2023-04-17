CC = gcc
OBJC_FLAG = -x objective-c
CFLAGS = -w -Iinclude
LDFLAGS = -lobjc

OBJ_DIR = objs
SRC_DIR = src
DIST_DIR = dist
INCLUDE_DIR = include
TARGET = $(DIST_DIR)/main

SRCS = $(wildcard $(SRC_DIR)/*.m)
OBJS = $(patsubst $(SRC_DIR)/%.m,$(OBJ_DIR)/%.o,$(SRCS))

.PHONY: all clean directories

all: directories $(TARGET)

directories:
	@mkdir -p $(OBJ_DIR) $(DIST_DIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.m
	$(CC) $(OBJC_FLAG) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(TARGET)
