TARGET = analyzer
VERSION = 1.00

# There should be no need to modify anything below this line...

SRCS = analyzer.c types.c functs.c parse_settings.c help.c
OBJS = $(SRCS:.c=.o)
HDRS = 

CFLAGS = $(FLAGS) $(COMPILEVARS) $(DEBUG)
COMPILEVARS = -DVERSION='"$(VERSION)"' -DCOMPDATE="\"`date`\"" -DCFLAGS='"$(FLAGS)"' -DHOSTNAME="\"`hostname`\""

LDFLAGS = $(LFLAGS)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET) *~ *.bak

depend:
	makedepend -- $(SRCS)

# DO NOT DELETE THIS LINE -- make depend depends on it.

analyzer.o: ../../Makefile
types.o: ../../Makefile
functs.o: ../../Makefile
parse_settings.o: ../../Makefile
help.o: ../../Makefile
