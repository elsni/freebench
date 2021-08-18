TARGET = pcompress2
VERSION = 1.0

SRCS = pcompress2.c compress.c uncompress.c arithmetic.c unarithmetic.c
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

pcompress2.o: ../../Makefile
compress.o: ../../Makefile
uncompress.o: ../../Makefile
arithmetic.o: ../../Makefile
unarithmetic.o: ../../Makefile
