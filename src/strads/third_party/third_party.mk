# Boost is too heavy to host on github..
THIRD_PARTY_HOST = http://www.cs.cmu.edu/~jinlianw/third_party
BOOST_HOST = http://downloads.sourceforge.net/project/boost/boost/1.56.0
CAPNP_HOST = https://capnproto.org/capnproto-c++-0.4.1.tar.gz


third_party_core: path \
	          gflags \
                  glog \
                  zeromq \
                  gperftools \
                  libconfig \
                  eigen \
                  protobuf


third_party_all: third_party_core \
                 sparsehash \
                 oprofile \
                 gtest \
		 iftop
.PHONY: third_party_core third_party_all



# ==================== eigen ====================                                                             
EIGEN_SRC = $(THIRD_PARTY_SRC)/3.2.3.tar.gz
EIGEN_TAR = $(THIRD_PARTY_SRC)/eigen.tar.gz
EIGEN_INCLUDE= $(THIRD_PARTY_INCLUDE)/Eigen

eigen: $(EIGEN_INCLUDE)
$(EIGEN_INCLUDE): $(EIGEN_SRC)
	cp $(THIRD_PARTY_SRC)/3.2.3.tar.gz $(EIGEN_TAR)
	tar zxf $(EIGEN_TAR) -C $(THIRD_PARTY_SRC)
	cp -r $(THIRD_PARTY_SRC)/eigen*/Eigen $(THIRD_PARTY_INCLUDE)/

# ==================== protobuf  ====================

PROTOBUF_SRC = $(THIRD_PARTY_SRC)/protobuf-2.6.0.tar.gz
PROTOBUF_LIB = $(THIRD_PARTY_LIB)/libprotobuf.so

protobuf: $(PROTOBUF_LIB)

$(PROTOBUF_LIB): $(PROTOBUF_SRC)
	echo THIRD_PARTY_SRC = $(THIRD_PARTY_SRC)
	echo PROTOBUF_SRC = $(PROTOBUF_SRC)
	echo THIRD_PARTY = $(THIRD_PARTY)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make; \
	make check; \
	make install
#	./configure  \
#	sudo make; \
#	sudo make check; \
#	sudo make install; \

$(PROTOBUF_SRC):
	echo THIRD_PARTY_SRC = $(THIRD_PARTY_SRC)
	cp $(THIRD_PARTY)/tarball/protobuf-2.6.0.tar.gz $(THIRD_PARTY_SRC)

# ===================== gflags ===================
GFLAGS_SRC = $(THIRD_PARTY_SRC)/gflags-2.0.tar.gz
GFLAGS_LIB = $(THIRD_PARTY_LIB)/libgflags.so

gflags: $(GFLAGS_LIB)

$(GFLAGS_LIB): $(GFLAGS_SRC)
#$(GFLAGS_LIB): 
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(GFLAGS_SRC):
	cp $(THIRD_PARTY)/tarball/gflags-2.0.tar.gz $(THIRD_PARTY_SRC)

# ===================== glog =====================

GLOG_SRC = $(THIRD_PARTY_SRC)/glog-0.3.3.tar.gz
GLOG_LIB = $(THIRD_PARTY_LIB)/libglog.so

glog: $(GLOG_LIB)

$(GLOG_LIB): $(GLOG_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(GLOG_SRC):
#	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
	cp $(THIRD_PARTY)/tarball/glog-0.3.3.tar.gz $(THIRD_PARTY_SRC)	
# ===================== gtest ====================

GTEST_SRC = $(THIRD_PARTY_SRC)/gtest-1.7.0.tar
GTEST_LIB = $(THIRD_PARTY_LIB)/libgtest_main.a

gtest: $(GTEST_LIB)

$(GTEST_LIB): $(GTEST_SRC)
	tar xf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $<)/make; \
	make; \
	./sample1_unittest; \
	cp -r ../include/* $(THIRD_PARTY_INCLUDE)/; \
	cp gtest_main.a $@

$(GTEST_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@

# ==================== zeromq ====================

ZMQ_SRC = $(THIRD_PARTY_SRC)/zeromq-3.2.3.tar.gz
ZMQ_LIB = $(THIRD_PARTY_LIB)/libzmq.so

zeromq: $(ZMQ_LIB)

$(ZMQ_LIB): $(ZMQ_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(ZMQ_SRC):
#	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
#	wget $(THIRD_PARTY_HOST)/zmq.hpp -P $(THIRD_PARTY_INCLUDE)
	cp $(THIRD_PARTY)/tarball/zeromq-3.2.3.tar.gz $(THIRD_PARTY_SRC)	
	cp $(THIRD_PARTY)/tarball/zmq.hpp $(THIRD_PARTY_INCLUDE)

# ==================== boost ====================

BOOST_SRC = $(THIRD_PARTY_SRC)/boost_1_56_0.tar.bz2
BOOST_INCLUDE = $(THIRD_PARTY_INCLUDE)/boost

boost: $(BOOST_INCLUDE)

$(BOOST_INCLUDE): $(BOOST_SRC)
	tar jxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./bootstrap.sh \
		--with-libraries=system,thread,date_time,program_options \
		--prefix=$(THIRD_PARTY); \
	./b2 install

$(BOOST_SRC):
	wget $(BOOST_HOST)/$(@F) -O $@



# ================== gperftools =================

GPERFTOOLS_SRC = $(THIRD_PARTY_SRC)/gperftools-2.1.tar.gz
GPERFTOOLS_LIB = $(THIRD_PARTY_LIB)/libtcmalloc.so

gperftools: $(GPERFTOOLS_LIB)

$(GPERFTOOLS_LIB): $(GPERFTOOLS_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY) --enable-frame-pointers; \
	make install

$(GPERFTOOLS_SRC):
#	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
	cp $(THIRD_PARTY)/tarball/gperftools-2.1.tar.gz $(THIRD_PARTY_SRC)	

# ===================== libcuckoo =====================

CUCKOO_SRC = $(THIRD_PARTY_SRC)/libcuckoo.tar
CUCKOO_INCLUDE = $(THIRD_PARTY_INCLUDE)/libcuckoo

cuckoo: $(CUCKOO_INCLUDE)

$(CUCKOO_INCLUDE): $(CUCKOO_SRC)
	tar xf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	autoreconf -fis; \
	./configure --prefix=$(THIRD_PARTY); \
	make; make install

$(CUCKOO_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
#
# =================== oprofile ===================
# NOTE: need libpopt-dev binutils-dev

OPROFILE_SRC = $(THIRD_PARTY_SRC)/oprofile-0.9.9.tar.gz
OPROFILE_LIB = $(THIRD_PARTY_LIB)/oprofile

oprofile: $(OPROFILE_LIB)

$(OPROFILE_LIB): $(OPROFILE_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(OPROFILE_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@

# ================== sparsehash ==================

SPARSEHASH_SRC = $(THIRD_PARTY_SRC)/sparsehash-2.0.2.tar.gz
SPARSEHASH_INCLUDE = $(THIRD_PARTY_INCLUDE)/sparsehash

sparsehash: $(SPARSEHASH_INCLUDE)

$(SPARSEHASH_INCLUDE): $(SPARSEHASH_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(SPARSEHASH_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@

# ================== iftop ==================

IFTOP_SRC = $(THIRD_PARTY_SRC)/iftop-1.0pre4.tar.gz
IFTOP_BIN = $(THIRD_PARTY_BIN)/iftop

iftop: $(IFTOP_BIN)

$(IFTOP_BIN): $(IFTOP_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install; \
	cp iftop $(IFTOP_BIN)

$(IFTOP_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@


# ==================== libconfig ===================

LIBCONFIG_SRC = $(THIRD_PARTY_SRC)/libconfig-1.4.9.tar.gz
LIBCONFIG_LIB = $(THIRD_PARTY_LIB)/libconfig++.so

libconfig: $(LIBCONFIG_LIB)

$(LIBCONFIG_LIB): $(LIBCONFIG_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

$(LIBCONFIG_SRC):
#	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
	cp $(THIRD_PARTY)/tarball/libconfig-1.4.9.tar.gz $(THIRD_PARTY_SRC)	

# ==================== yaml-cpp ===================

YAMLCPP_SRC = $(THIRD_PARTY_SRC)/yaml-cpp-0.5.1.tar.gz
YAMLCPP_MK = $(THIRD_PARTY_SRC)/yaml-cpp.mk
YAMLCPP_LIB = $(THIRD_PARTY_LIB)/libyaml-cpp.a

yaml-cpp: boost $(YAMLCPP_LIB)

$(YAMLCPP_LIB): $(YAMLCPP_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	make -f $(YAMLCPP_MK) BOOST_PREFIX=$(THIRD_PARTY) TARGET=$@; \
	cp -r include/* $(THIRD_PARTY_INCLUDE)/

$(YAMLCPP_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
	wget $(THIRD_PARTY_HOST)/$(notdir $(YAMLCPP_MK)) -P $(THIRD_PARTY_SRC)

# ==================== leveldb ===================

LEVELDB_SRC = $(THIRD_PARTY_SRC)/leveldb-1.15.0.tar.gz
LEVELDB_LIB = $(THIRD_PARTY_LIB)/libleveldb.so

leveldb: $(LEVELDB_LIB)

$(LEVELDB_LIB): $(LEVELDB_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	LIBRARY_PATH=$(THIRD_PARTY_LIB):${LIBRARY_PATH} \
	make; \
	cp ./libleveldb.* $(THIRD_PARTY_LIB)/; \
	cp -r include/* $(THIRD_PARTY_INCLUDE)/

$(LEVELDB_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@

# ==================== snappy ===================


SNAPPY_SRC = $(THIRD_PARTY_SRC)/snappy-1.1.2.tar.gz
SNAPPY_LIB = $(THIRD_PARTY_LIB)/libsnappy.so

snappy: $(SNAPPY_LIB)

$(SNAPPY_LIB): $(SNAPPY_SRC)
	tar zxf $< -C $(THIRD_PARTY_SRC)
	cd $(basename $(basename $<)); \
	./configure --prefix=$(THIRD_PARTY); \
	make install

# TODO(wdai): Make sure the file is actually hosted.
$(SNAPPY_SRC):
	wget $(THIRD_PARTY_HOST)/$(@F) -O $@
