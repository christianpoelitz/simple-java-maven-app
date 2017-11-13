FROM gcr.io/tensorflow/tensorflow:0.10.0rc0-devel-gpu
 
RUN apt-get update && apt-get install -y python-dev
 
RUN apt-get install -y \
    libtiff5-dev \
    libjpeg8-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    tcl8.6-dev \
    tk8.6-dev \
    python-tk
 
RUN pip install Pillow
 
#do everything for opencv
RUN apt-get install -y \
  vim \
  build-essential \
  cmake \
  git \
  libgtk2.0-dev \
  pkg-config \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libtbb2 \
  libtbb-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev \
  libjasper-dev \
  libdc1394-22-dev
 
# clone repo, compile and install
RUN git clone https://github.com/Itseez/opencv.git \
  && cd opencv \
  && mkdir release \
  && cd release \
  && cmake -D BUILD_opencv_apps=OFF -D BUILD_TESTS=OFF -D BUILD_EXAMPLES=OFF -D BUILD_DOCS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D BUILD_EXAMPLES=OFF .. \
  && make -j8 \
  && make install \
  && cd ../../ \
  && rm -rf opencv
 
# Change a few link paths
RUN ln -s /usr/local/nvidia/lib64/libcuda.so.1 /usr/local/lib/libcuda.so && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH/usr/local/lib
