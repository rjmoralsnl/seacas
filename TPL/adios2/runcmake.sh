#! /usr/bin/env bash
EXTRA_ARGS=$@

MPI="${MPI:-OFF}"

echo "MPI set to ${MPI}"

### The following assumes you are building in a subdirectory of ACCESS Root
if [ "X$ACCESS" == "X" ] ; then
  ACCESS=$(cd ../../../..; pwd)
  echo "ACCESS set to ${ACCESS}"
fi
INSTALL_PATH=${INSTALL_PATH:-${ACCESS}}

SHARED="${SHARED:-ON}"

if [ "$MPI" == "ON" ] && [ "$CRAY" = "ON" ]
then
  export CC=cc
  export CXX=cxx
elif [ "$MPI" == "ON" ]
then
  export CC=mpicc
  export CXX=mpicxx
else
  COMPILER="${COMPILER:-gnu}"
  if [ "$COMPILER" == "gnu" ]
  then
      export CC=gcc
      export CXX=g++
  fi
  if [ "$COMPILER" == "clang" ]
  then
      export CC=clang
      export CXX=clang++
  fi
  if [ "$COMPILER" == "intel" ]
  then
      export CC=icc
      export CXX=icpc
  fi
  if [ "$COMPILER" == "ibm" ]
  then
      export CC=xlc
      export CXX=xlC
  fi
fi

CFLAGS="-I${INSTALL_PATH}/include"; export CFLAGS
CPPFLAGS="-DNDEBUG"; export CPPFLAGS

rm -f CMakeCache.txt

cmake \
${RPATH} \
-D BUILD_SHARED_LIBS:BOOL=${SHARED} \
-D CMAKE_PREFIX_PATH:PATH=${INSTALL_PATH}/lib \
-D CMAKE_INSTALL_PREFIX:PATH=${INSTALL_PATH} \
-D CMAKE_INSTALL_LIBDIR:PATH=lib \
-D ADIOS2_USE_MPI:BOOL=${MPI} \
-D ADIOS2_BUILD_EXAMPLES:BOOL=OFF \
-D ADIOS2_BUILD_TESTING:BOOL=OFF \
-D INSTALL_GTEST:BOOL=OFF \
-D ADIOS2_USE_Fortran:BOOL=OFF \
-D ADIOS_USE_Profiling=OFF \
$EXTRA_ARGS \
..

echo ""
echo "         MPI: ${MPI}"
echo "    COMPILER: ${CC}"
echo "C++ COMPILER: ${CXX}"
echo "      ACCESS: ${ACCESS}"
echo "INSTALL_PATH: ${INSTALL_PATH}"
echo ""
