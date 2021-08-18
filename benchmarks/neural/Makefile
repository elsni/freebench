TARGET = neural
VERSION = 1.0

SRCS = neural.c
OBJS = $(SRCS:.c=.o)
HDRS = 

CFLAGS = $(FLAGS) $(COMPILEVARS) $(DEBUG) $(BITWIDTH)
COMPILEVARS = -DVERSION='"$(VERSION)"' -DCOMPDATE="\"`date`\"" -DCFLAGS='"$(FLAGS)"' -DHOSTNAME="\"`hostname`\""

LDFLAGS = $(LFLAGS) -lm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET) core *~ *.bak

neural.o: ../../Makefile
