#!/system/bin/sh

# ****** NOTES ******

# angspice installation script. It performs the following actions:
# 1) Performs checks to see if terminal-emulator, octave, gnuplot and terminal-ide have been installed.
# 2) Copies the ngspice files into the correct location (/data/data/com.octave/freeRoot/usr/local/).
# 3) Copies the octave_spice files into the correct location (/data/data/com.octave/freeRoot/usr/local/share/octave/3.7.0+/m/).
# 4) Copies the gs (ghostscript) binary into the correct location (/data/data/com.octave/freeRoot/usr/local/).
# 5) Generates the necessary calling scripts in "~/local/bin/".

# ****** DIRECTORIES ******

TERM_EMU_DIR=/data/data/jackpal.androidterm/
OCTAVE_DIR=/data/data/com.octave
GNUPLOT_DIR=/data/data/com.droidplot
TERM_IDE_DIR=/data/data/com.spartacusrex.spartacuside
BIN_DIR=/data/data/com.spartacusrex.spartacuside/files/local/bin


# ****** PRE INSTALL CHECKS ******

PROCEED=TRUE
echo -n "terminal emulator installed..."
if [ -d "$TERM_EMU_DIR" ]; then
    echo "yes"
else
    echo "no"
    PROCEED=FALSE
fi

echo -n "octave installed..."
if [ -d "$OCTAVE_DIR" ]; then
    echo "yes"
else
    echo "no"
    PROCEED=FALSE
fi

echo -n "gnuplot installed..."
if [ -d "$GNUPLOT_DIR" ]; then
    echo "yes"
else
    echo "no"
    PROCEED=FALSE
fi

echo -n "terminal-ide installed..."
if [ -d "$TERM_IDE_DIR" ]; then
    echo "yes"
else
    echo "no"
    PROCEED=FALSE
fi

# ****** START INSTALLATION ******

if [ $PROCEED == TRUE ]; then

    echo -n "copying files..."

    # Copy ngspice files
    mkdir -p $OCTAVE_DIR/freeRoot/usr/local/bin/
    cp ./local/bin/* $OCTAVE_DIR/freeRoot/usr/local/bin/.
    mkdir -p $OCTAVE_DIR/freeRoot/usr/local/share/man/man1/
    cp ./local/share/man/man1/* $OCTAVE_DIR/freeRoot/usr/local/share/man/man1/.
    mkdir -p $OCTAVE_DIR/freeRoot/usr/local/share/
    cp -r ./local/share/ngspice/ $OCTAVE_DIR/freeRoot/usr/local/share/.

    # Copy octave_space files
    mkdir -p $OCTAVE_DIR/freeRoot/usr/local/share/octave/3.7.0+/m/
    cp -r ./octave_spice/ $OCTAVE_DIR/freeRoot/usr/local/share/octave/3.7.0+/m/.

    # Copy ghostscript binary
    cp ./bin/gs $BIN_DIR/.
    chmod +x $BIN_DIR/gs

    echo done!

    # Generate calling scripts
    echo "generating scripts..."

    touch $BIN_DIR/octave
    echo "#!/system/bin/sh" > $BIN_DIR/octave
    echo "/data/data/com.octave/freeRoot/lib/ld-linux.so.3 --library-path /data/data/com.octave/freeRoot/lib:/data/data/com.octave/freeRoot/usr/local/lib /data/data/com.octave/freeRoot/usr/local/bin/octave \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/octave
    chmod +x $BIN_DIR/octave
    echo "->$BIN_DIR/octave"

    touch $BIN_DIR/gnuplot
    echo "#!/system/bin/sh" > $BIN_DIR/gnuplot
    echo "/data/data/com.droidplot/mylib/ld-linux.so.3 --library-path /data/data/com.droidplot/mylib /data/data/com.droidplot/bin/gnuplot \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/gnuplot
    chmod +x $BIN_DIR/gnuplot
    echo "->$BIN_DIR/gnuplot"

    touch $BIN_DIR/droidplot
    echo "#!/system/bin/sh" > $BIN_DIR/droidplot
    echo "/data/data/com.droidplot/bin/droidplot \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/droidplot
    chmod +x $BIN_DIR/droidplot
    echo "->$BIN_DIR/droidplot"

    touch $BIN_DIR/ngspice
    echo "#!/system/bin/sh" > $BIN_DIR/ngspice
    echo "/data/data/com.octave/freeRoot/lib/ld-linux.so.3 --library-path /data/data/com.octave/freeRoot/lib/ /data/data/com.octave/freeRoot/usr/local/bin/ngspice \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/ngspice
    chmod +x $BIN_DIR/ngspice
    echo "->$BIN_DIR/ngspice"

    echo done!

    echo "installation completed!"
else
    echo "installation stopped!"
fi
# ****** END INSTALLATION ******
