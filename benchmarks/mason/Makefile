TARGET = mason
VERSION = 1.0

SRCS = mason.c
OBJS = $(SRCS:.c=.o)
HDRS = 

DATE=$(shell date)
HOSTNAME=$(shell hostname)
CFLAGS = $(FLAGS) $(COMPILEVARS) $(DEBUG) $(BITWIDTH)
COMPILEVARS = -DVERSION='"$(VERSION)"' -DCOMPDATE='"$(DATE)"' -DCFLAGS='"$(FLAGS)"' -DHOSTNAME='"$(HOSTNAME)"'

LDFLAGS = $(LFLAGS) -lm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET) core *~ *.bak

mason.o: ../../Makefile
