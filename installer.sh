CURRENT_FOLDER=pwd
apt update

#general dependencies
apt install -y git cmake g++ clang python3 curl build-essential python3-dev python3-pip python3-virtualenv python3-venv python3-sphinx python3-sphinx-autoapi python3-pandas python3-tk python3-pytest ruby ruby-dev help2man perl time

#dependencies for ngspice
apt install -y autoconf automake bison flex fontconfig libtool libxaw7 libxaw7-dev libxmu6 libxmu-dev libxext6 libxext-dev libxft2 libxft-dev libxrender1 libxrender-dev zlib1g zlib1g-dev libx11-6 libx11-dev libreadline-dev libedit-dev 

#dependencies for magic
apt install -y m4 libtcl8.6 tcl8.6 tcl tcl-dev libtk8.6 tk tk8.6 tk-dev libcairo libcairo2-dev mesa-common-dev libgl-dev libglu1-mesa-dev libncurses-dev

#dependencies for xschem
apt install -y libjpeg-dev libxpm-dev libx11-xcb-dev libxcb1 libxpm4 gawk xterm vim-gtk3 tcl-tclreadline

#dependencies for qucs-s
apt install -y gperf dos2unix qt6-base-dev qt6-tools-dev libgl1-mesa-dev qt6-charts-dev qt6-svg-dev libxkbcommon-dev

#dependencies for klayout
apt install -y libqt5designer5 libqt5multimedia5 libqt5multimediawidgets5 libqt5opengl5t64 libqt5xmlpatterns5

#another dependencies recommended by IHP
apt install -y btop tree graphviz octave octave-dev xdot pkg-config libgtk-3-dev libffi-dev libreadline-dev gettext libboost-system-dev libboost-python-dev libboost-filesystem-dev libfl2 libfl-dev libz-dev libgit2-dev libgoogle-perftools-dev gengetopt groff pod2pdf libhpdf-dev libxml-libxml-perl libgd-perl gfortran swig libspdlog-dev libeigen3-dev liblemon-dev

#installing ngspice
cd $HOME
git clone git://git.code.sf.net/p/ngspice/ngspice
cd ngspice
./autogen.sh
./configure --enable-openmp --enable-xspice --enable-osdi --enable-klu --with-readline=yes --enable-cider --enable-pss
make
make install
cd ..
rm -rf ngspice

#installing magic VLSI
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
make
make install
cd ..
rm -rf magic

#install xschem
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure
make
make install
cd ..
rm -rf xschem

#installing qucs-s
git clone https://github.com/ra3xdh/qucs_s
cd qucs_s
git submodule init
git submodule update
mkdir builddir
cd builddir
cmake ..
make
make install
cd ../..
rm --rf qucs_s

#installing klayout
wget https://www.klayout.org/downloads/Ubuntu-24/klayout_0.30.2-1_amd64.deb
dpkg -i klayout_0.30.2-1_amd64.deb
rm klayout_0.30.2-1_amd64.deb

#installing IHP
mkdir pdks
cd pdks
git clone --recursive https://github.com/IHP-GmbH/IHP-Open-PDK.git
cd IHP-Open-PDK
git checkout dev

#installing OpenVAF
cd $HOME
wget https://openva.fra1.cdn.digitaloceanspaces.com/openvaf_23_5_0_linux_amd64.tar.gz
tar -zxf openvaf_23_5_0_linux_amd64.tar.gz
rm openvaf_23_5_0_linux_amd64.tar.gz
mv openvaf /usr/local/bin

#Adding IHP Paths
echo "export PDK_ROOT=\$HOME/pdks/IHP-Open-PDK" >> ~/.bashrc
echo "export PDK=ihp-sg13g2" >> ~/.bashrc
echo "export KLAYOUT_PATH=\"\$HOME/.klayout:\$PDK_ROOT/\$PDK/libs.tech/klayout\"" >> ~/.bashrc
echo "export KLAYOUT_HOME=\$HOME/.klayout" >> ~/.bashrc
source ~/.bashrc

#Configuring installations
cd $PDK_ROOT/ihp-sg13g2/libs.tech/xschem/
python3 install.py
cd $PDK_ROOT/ihp-sg13g2/libs.tech/qucs/
python3 install.py