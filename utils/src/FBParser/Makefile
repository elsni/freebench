TARGET = fbparser
VERSION = 1.0

SRCS = fbparser.c
OBJS = $(SRCS:.c=.o)
HDRS = 

CC = cc

LDFLAGS = -lm

FLAGS = -O
CFLAGS = $(FLAGS) 

LD = $(CC)

all: $(TARGET) install

$(TARGET): $(OBJS)
	${CC} $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

install: 
	cp $(TARGET) ../../

clean:
	rm -f $(OBJS) $(TARGET) *~ *.bak
