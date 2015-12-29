all: demo

clean:
	rm -fv *~ *.o demo my-resources.c mywidget.c

my-resources.c: my-resources.xml mywidget.ui
	glib-compile-resources my-resources.xml \
		--target=$@ --sourcedir=$(srcdir) --c-name _my --generate-source

mywidget.c:mywidget.vala
	valac -C $< --pkg gtk+-3.0 --target-glib=2.38 --gresources my-resources.xml

%.o:%.c
	gcc -o $@ -c $< -Wall `pkg-config --cflags gtk+-3.0 gmodule-export-2.0`

demo: mywidget.o my-resources.o
	gcc -o $@  $^ `pkg-config --libs gtk+-3.0 gmodule-export-2.0`
