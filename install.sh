#!/system/bin/sh

TERM_EMU_DIR=/data/data/jackpal.androidterm/
  OCTAVE_DIR=/data/data/com.octave
 GNUPLOT_DIR=/data/data/com.droidplot
TERM_IDE_DIR=/data/data/com.spartacusrex.spartacuside
     BIN_DIR=/data/data/com.spartacusrex.spartacuside/files/local/bin

# ****** PRE INSTALL CHECKS ******
OCTAVE_ARM_DIR=${OCTAVE_DIR}.arm

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
    cp -r $OCTAVE_DIR $OCTAVE_ARM_DIR
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
    mkdir -p $OCTAVE_ARM_DIR/freeRoot/usr/local/bin/
    cp ./local/bin/* $OCTAVE_ARM_DIR/freeRoot/usr/local/bin/.
    mkdir -p $OCTAVE_ARM_DIR/freeRoot/usr/local/share/man/man1/
    cp ./local/share/man/man1/* $OCTAVE_ARM_DIR/freeRoot/usr/local/share/man/man1/.
    mkdir -p $OCTAVE_ARM_DIR/freeRoot/usr/local/share/
    cp -r ./local/share/ngspice/ $OCTAVE_ARM_DIR/freeRoot/usr/local/share/.

    # Copy octave_space files
    mkdir -p $OCTAVE_ARM_DIR/freeRoot/usr/local/share/octave/3.7.0+/m/
    cp -r ./octave_spice/ $OCTAVE_ARM_DIR/freeRoot/usr/local/share/octave/3.7.0+/m/.

    # Copy ghostscript binary
    cp ./bin/gs $BIN_DIR/.
    chmod +x $BIN_DIR/gs

    echo done!

    # Generate calling scripts
    echo "generating scripts..."

    echo = DEBUG: BNINDIR: $BIN_DIR =

    touch $BIN_DIR/gnuplot
    echo "#!/system/bin/sh" > $BIN_DIR/gnuplot
    echo "/data/data/com.droidplot/bin/gnuplot \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/gnuplot
    chmod +x $BIN_DIR/gnuplot
    echo "->$BIN_DIR/gnuplot"

    touch $BIN_DIR/droidplot
    echo "#!/system/bin/sh" > $BIN_DIR/droidplot
    echo "/data/data/com.droidplot/bin/droidplot \$1 \$2 \$3 \$4 \$5 \$6" >> $BIN_DIR/droidplot
    chmod +x $BIN_DIR/droidplot
    echo "->$BIN_DIR/droidplot"

    cp octave.sh      $BIN_DIR/octave
    cp ngmultidec.sh  $BIN_DIR/ngmultidec
    cp ngnutmeg.sh    $BIN_DIR/ngnutmeg
    cp ngproc2mod.sh  $BIN_DIR/ngproc2mod
    cp ngsconvert.sh  $BIN_DIR/ngsconvert
    cp ngspice.sh     $BIN_DIR/ngspice

    echo done!

    echo "installation completed!"
else
    echo "installation stopped!"
fi

# ****** END INSTALLATION ******
