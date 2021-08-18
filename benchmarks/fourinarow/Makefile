TARGET = fourinarow
VERSION = 1.0

SRCS = fourinarow.c
OBJS = $(SRCS:.c=.o)
HDRS = 

CFLAGS = $(FLAGS) $(COMPILEVARS) $(DEBUG) $(BITWIDTH)
COMPILEVARS = -DVERSION='"$(VERSION)"' -DCOMPDATE="\"`date`\"" -DCFLAGS='"$(FLAGS)"' -DHOSTNAME="\"`hostname`\""

LDFLAGS = $(LFLAGS)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET) core *~ *.bak

fourinarow.o: ../../Makefile
