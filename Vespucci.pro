#    Copyright (C) 2014 Daniel P. Foose - All Rights Reserved

#    This file is part of Vespucci.

#    Vespucci is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    Vespucci is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with Vespucci.  If not, see <http://www.gnu.org/licenses/>.

#Vespucci Qt Profile
#The configuration settings for Windows are very specific to my configuration
#and very likely will have to be changed. Compiling on Windows is not recommended
#as binary releases for Windows will occur frequently (this is what we use in our
#research group). It took me about a week just to compile all the libraries on
#MinGW and

#Configuration settings for unix systems are based either on the Ubuntu package
#manager or the install scripts of the library when the package is not availible
#from the repository

QT       += core gui
QT       += widgets printsupport
CONFIG   += static
mac: CONFIG += app_bundle
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = vespucci
TEMPLATE = app

unix: QMAKE_CXXFLAGS += -isystem "/usr/include" \
                        -isystem "/usr/include/armadillo_bits" \
                        -isystem "/usr/include/boost" \
                        -isystem "/usr/include/mlpack"

win32-g++: QMAKE_CXXFLAGS += -isystem "C:/Libraries/OpenBLAS/include" \
                         -isystem "C:/Libraries/armadillo/include" \
                         -isystem "C:/Libraries/mlpack/include" \
                         -isystem "C:/Boost/include/" \
                         -isystem "C:/QtSDK/include/"


#Libraries
#Include paths for *nix
unix: INCLUDEPATH += /usr/include
unix: DEPENDPATH += /usr/include
#include paths for Windows
win32-g++: INCLUDEPATH += $$PWD/../../../../usr/include
win32-g++: DEPENDPATH += $$PWD/../../../../usr/include

#BLAS/LAPACK Libraries
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libopenblas.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libopenblas.a

unix: !macx: LIBS += /usr/lib/openblas-base/libopenblas.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/openblas-base/libopenblas.so
macx: LIBS += -framework Accelerate


#ARPACK
win32-g++: LIBS += $$PWD/../../../../usr/lib/libarpack_win64.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libarpack_win64.a
unix: LIBS += /usr/lib/libarpack.so
unix: PRE_TARGETDEPS += /usr/lib/libarpack.so


#gfortran
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libgfortran.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libgfortran.a


#MLPACK
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libmlpack.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../../Libraries/mlpack/lib/libmlpack.a

#Boost path for mac (also default nix path, but not used by ubuntu's package manager)
macx: INCLUDEPATH += /usr/local/include
macx: DEPENDPATH += /usr/local/include

#Boost math
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libboost_math_c99-mgw48-mt-1_55.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libboost_math_c99-mgw48-mt-1_55.a

unix: !macx: LIBS += /usr/lib/x86_64-linux-gnu/libboost_math_c99.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libboost_math_c99.so

macx: LIBS += /usr/local/lib/libboost_math_c99.so
macx: PRE_TARGETDEPS += /usr/local/lib/libboost_math_c99.so

#Boost program options
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libboost_program_options-mgw48-mt-1_55.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libboost_program_options-mgw48-mt-1_55.a

unix: !macx: LIBS += /usr/lib/x86_64-linux-gnu/libboost_program_options.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libboost_program_options.so

macx: LIBS += /usr/local/lib/libboost_program_options.so
macx: PRE_TARGETDEPS += /usr/local/lib/libboost_program_options.so

#Boost random
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libboost_random-mgw48-mt-1_55.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libboost_random-mgw48-mt-1_55.a

unix: !macx: LIBS += /usr/lib/x86_64-linux-gnu/libboost_random.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libboost_random.so

macx: LIBS += /usr/local/lib/libboost_random.so
macx: PRE_TARGETDEPS += /usr/local/lib/libboost_random.so

#Boost test
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libboost_unit_test_framework-mgw48-mt-1_55.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libboost_unit_test_framework-mgw48-mt-1_55.a

unix: !macx: LIBS += /usr/lib/x86_64-linux-gnu/libboost_unit_test_framework.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libboost_unit_test_framework.so

macx: LIBS += /usr/local/lib/libboost_unit_test_framework.so
macx: PRE_TARGETDEPS += /usr/local/lib/libboost_unit_test_framework.so

#LibXML2 (a MLPACK dependency)
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libxml2.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libxml2.a

unix: !macx: LIBS += /usr/lib/x86_64-linux-gnu/libxml2.so
unix: !macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libxml2.so
macx: LIBS += -framework libxml2

#QCustomPlot
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libqcustomplot1.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libqcustomplot1.a

unix: LIBS += /usr/lib/libqcustomplot1.so
unix: PRE_TARGETDEPS += /usr/lib/libqcustomplot1.so

#Armadillo
win32-g++: LIBS += -L$$PWD/../../../../usr/lib/libarmadillo.a
win32-g++: PRE_TARGETDEPS += $$PWD/../../../../usr/lib/libarmadillo.a

unix: LIBS += /usr/lib/libarmadillo.so
unix: PRE_TARGETDEPS += /usr/lib/libarmadillo.so


SOURCES += main.cpp\
        mainwindow.cpp \
    specmap.cpp \
    loaddataset.cpp \
    mapdata.cpp \
    univariatemap.cpp \
    vespucciworkspace.cpp \
    aboutdialog.cpp \
    citationdialog.cpp \
    univariatedialog.cpp \
    spectrumviewer.cpp \
    bandratiodialog.cpp \
    mapviewer.cpp \
    principalcomponentsdata.cpp \
    principalcomponentsdialog.cpp \
    scalebardialog.cpp \
    filterdialog.cpp \
    baselinedialog.cpp \
    dataviewer.cpp \
    cropdialog.cpp \
    arma_ext.cpp \
    vespuccitablemodel.cpp

HEADERS  += mainwindow.h \
    specmap.h \
    loaddataset.h \
    mapdata.h \
    univariatemap.h \
    vespucciworkspace.h \
    aboutdialog.h \
    citationdialog.h \
    univariatedialog.h \
    spectrumviewer.h \
    bandratiodialog.h \
    mapviewer.h \
    principalcomponentsdata.h \
    principalcomponentsdialog.h \
    scalebardialog.h \
    filterdialog.h \
    cropdialog.h \
    dataviewer.h \
    baselinedialog.h \
    arma_ext.h \
    vespuccitablemodel.h

FORMS    += mainwindow.ui \
    loaddataset.ui \
    aboutdialog.ui \
    citationdialog.ui \
    univariatedialog.ui \
    spectrumviewer.ui \
    bandratiodialog.ui \
    mapviewer.ui \
    principalcomponentsdialog.ui \
    scalebardialog.ui \
    filterdialog.ui \
    baselinedialog.ui \
    dataviewer.ui \
    cropdialog.ui

RESOURCES += \
    resources.qrc


