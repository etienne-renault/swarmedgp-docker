FROM debian:sid
MAINTAINER Etienne RENAULT <renault@lrde.epita.fr>

WORKDIR /build

RUN apt-get update \
 && apt-get install -y --force-yes --no-install-recommends                                     \
    ca-certificates golang git make-guile clang gcc g++ wget python zsh bc                     \
    cmake pkgconf libgmp-dev flex bison libtool lib32z1 lib32z1-dev libpopt-dev automake       \
    libltdl-dev                                                                                \
 && wget https://www.lrde.epita.fr/~renault/benchs/ISSE-2020/spot-2.3.3.dev.tar.gz             \
 && tar -xzvf spot-2.3.3.dev.tar.gz                                                            \
 && cd spot-2.3.3.dev                                                                          \
 && ./configure --disable-python --disable-devel                                               \
 && make                                                                                       \
 && cd tests/ && make ltsmin/modelcheck                                                        \
 && cd ../..                                                                                   \
 && rm spot-2.3.3.dev.tar.gz                                                                   \
 && ln -s /build/spot-2.3.3.dev/tests/ltsmin/modelcheck /bin/modelcheck                        \
 && git clone https://github.com/utwente-fmt/sylvan.git                                        \
 && cd sylvan/ && mkdir _build && cd _build                                                    \
 && cmake .. && make && make install && cd ../..                                               \
 && git clone https://github.com/utwente-fmt/ltsmin.git                                        \
 && cd ltsmin && git submodule update --init --recursive                                       \
 && sed -i 's/sylvan < 1.5/sylvan < 1.6/g' configure.ac                                        \
 && ./ltsminreconf && ./configure && make && make install && cd ..                             \
 && git clone https://gitlab.lrde.epita.fr/spot/divine-ltsmin-deb.git                          \
 && cd divine-ltsmin-deb/ && git checkout  er/bounds && mkdir _build && cd _build              \
 && cmake .. -DMURPHI=OFF && make && make install && cd ../..                                  \
 && wget https://www.lrde.epita.fr/~renault/benchs/ISSE-2020/models.tar.gz                     \
 && tar -xzvf  models.tar.gz && rm models.tar.gz                                               \
 && wget https://www.lrde.epita.fr/~renault/benchs/ISSE-2020/README.txt