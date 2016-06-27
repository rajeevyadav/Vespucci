TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
QT += testlib
QT += widgets
QT += printsupport
QT += svg

SOURCES += main.cpp \
    testfileio.cpp \
    testhelpers.cpp \
    testquantification.cpp \
    testnormalization.cpp \
    testsmoothing.cpp \
    testfitting.cpp \
    testpeakfinding.cpp \
    testdatamodel.cpp \
    testworkspace.cpp \
    testdataset.cpp \
    testsession.cpp

INCLUDEPATH += ../VespucciLibrary/include
DEPENDPATH += ../VespucciLibrary/include
INCLUDEPATH += ../Vespucci
DEPENDPATH += ../Vespucci
#Boost, MLPACK, and Armadillo have code that produces warnings. Change the directory as appropriate.

HEADERS += test.h \
    testfileio.h \
    testhelpers.h \
    testquantification.h \
    testnormalization.h \
    testsmoothing.h \
    testfitting.h \
    testpeakfinding.h \
    testdatamodel.h \
    testworkspace.h \
    testdataset.h \
    testsession.h

unix:!macx{
    QMAKE_CXX=/usr/bin/g++-4.9
    CONFIG += c++11
    QMAKE_CXXFLAGS += -fext-numeric-literals
    LIBS += -L$$PWD/../../mlpack/lib -lmlpack
    LIBS += -L$$PWD/../../armadillo/lib -larmadillo
    LIBS += -L/usr/lib -larpack
    PRE_TARGETDEPS += /usr/lib/libarpack.a
    LIBS += -L/usr/lib/x86_64-linux-gnu -lhdf5
    PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libhdf5.a
    LIBS += -L/usr/lib -lblas
    LIBS += -L/usr/lib -llapack
    LIBS += -L$$PWD/../../yaml-cpp/lib -lyaml-cpp
    PRE_TARGETDEPS += $$PWD/../../yaml-cpp/lib/libyaml-cpp.a
    LIBS += -L$$PWD/../../quazip/lib -lquazip
    PRE_TARGETDEPS += $$PWD/../../quazip/lib/libquazip.a

    LIBS += -L/usr/lib/x86_64-linux-gnu/ -lz
    PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libz.a

    LIBS += -L$$OUT_PWD/../VespucciLibrary -lvespucci

    INCLUDEPATH += /usr/include
    DEPENDPATH += /usr/include

    INCLUDEPATH += /usr/include/libxml2
    DEPENDPATH += /usr/include/libxml2

    INCLUDEPATH += /usr/local/include
    DEPENDPATH += /usr/local/include

    INCLUDEPATH += $$PWD/../../mlpack/include
    DEPENDPATH += $$PWD/../../mlpack/include

    INCLUDEPATH += $$PWD/../../armadillo/include
    DEPENDPATH += $$PWD/../../armadillo/include

    INCLUDEPATH += $$PWD/../../quazip/include
    DEPENDPATH += $$PWD/../../quazip/include

    INCLUDEPATH += $$PWD/../../yaml-cpp/include
    DEPENDPATH += $$PWD/../../yaml-cpp/include

}

#mac libraries. These are the same in Travis-CI as in most local environments
#with all dependencies of armadillo and mlpack installed using homebrew
#and armadillo and mlpack installed to the ../armadillo and ../mlpack directories
macx{
    QMAKE_CXXFLAGS = -mmacosx-version-min=10.7 -std=gnu0x -stdlib=libc++

    CONFIG += app_bundle c++11
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7

    LIBS += -L/usr/lib -lc++

    LIBS += -L$$OUT_PWD/../VespucciLibrary/ -lvespucci
    LIBS += -L$$PWD/../../mlpack/lib/ -lmlpack
    INCLUDEPATH += $$PWD/../../mlpack/include
    DEPENDPATH += $$PWD/../../mlpack/include

    LIBS += -L$$PWD/../../armadillo/lib/ -larmadillo
    INCLUDEPATH += $$PWD/../../armadillo/include
    DEPENDPATH += $$PWD/../../armadillo/include

    LIBS += -L/usr/local/lib/ -larpack
    INCLUDEPATH += /usr/local/include
    DEPENDPATH += /usr/local/include

    LIBS += -framework Accelerate

    LIBS += -L/usr/local/lib/ -lhdf5
    PRE_TARGETDEPS += /usr/local/lib/libhdf5.a

    LIBS += -L$$PWD/../../quazip/lib/ -lquazip
    INCLUDEPATH += $$PWD/../../quazip/include
    DEPENDPATH += $$PWD/../../quazip/include
    PRE_TARGETDEPS += $$PWD/../../quazip/lib/libquazip.a

    LIBS += -L$$PWD/../../yaml-cpp/lib/ -lyaml-cpp
    INCLUDEPATH += $$PWD/../../yaml-cpp/include
    DEPENDPATH += $$PWD/../../yaml-cpp/include
    PRE_TARGETDEPS += $$PWD/../../yaml-cpp/lib/libyaml-cpp.a

    LIBS += -lz.1

    INCLUDEPATH += /usr/local/opt/libxml2/include/libxml2
    DEPENDPATH += /usr/local/opt/libxml2/include/libxml2
}

#windows libraries for msvc (we don't currently build the libraries for g++ on windows)
win32:!win32-g++{
    CONFIG += release force_debug_info
    QMAKE_CXXFLAGS += /MP /openmp

    LIBS += -L$$OUT_PWD/../VespucciLibrary/release -llibvespucci
    PRE_TARGETDEPS += $$OUT_PWD/../VespucciLibrary/release/libvespucci.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/mlpack/lib/ -lmlpack
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/mlpack/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/mlpack/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/mlpack/lib/mlpack.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/armadillo/lib/ -larmadillo
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/armadillo/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/armadillo/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/armadillo/lib/armadillo.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/OpenBLAS/ -llibopenblas
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/OpenBLAS/libopenblas.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/LAPACK/ -llapack_x64
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/LAPACK/lapack_x64.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/HDF5/lib/ -lhdf5
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/HDF5/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/HDF5/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/HDF5/lib/hdf5.lib

    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/boost_1_61_0
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/boost_1_61_0

    LIBS += -L$$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/ -llibboost_program_options-vc140-mt-1_61
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/libboost_program_options-vc140-mt-1_61.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/ -llibboost_math_c99-vc140-mt-1_61
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/libboost_math_c99-vc140-mt-1_61.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/ -llibboost_random-vc140-mt-1_61
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/libboost_random-vc140-mt-1_61.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/ -llibboost_serialization-vc140-mt-1_61
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/libboost_serialization-vc140-mt-1_61.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/ -llibboost_unit_test_framework-vc140-mt-1_61
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/boost_1_61_0/lib64-msvc-14.0/libboost_unit_test_framework-vc140-mt-1_61.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/quazip/lib/ -lquazip
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/quazip/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/quazip/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/quazip/lib/quazip.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/yaml-cpp/lib/ -llibyaml-cppmdd
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/yaml-cpp/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/yaml-cpp/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/yaml-cpp/lib/libyaml-cppmdd.lib

    LIBS += -L$$PWD/../../Vespucci_dependencies/HDF5/lib/ -lzlib
    INCLUDEPATH += $$PWD/../../Vespucci_dependencies/HDF5/include
    DEPENDPATH += $$PWD/../../Vespucci_dependencies/HDF5/include
    PRE_TARGETDEPS += $$PWD/../../Vespucci_dependencies/HDF5/lib/zlib.lib
}
