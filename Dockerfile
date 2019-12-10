FROM wesleygriffin/llvm-9

WORKDIR $HOME
RUN git clone https://github.com/llvm/llvm-project llvm-project-trunk

ENV CMAKE=$HOME/cmake-3.16.0-Linux-x86_64/bin/cmake \
    LLVM_PROJECTS="-DLLVM_ENABLE_PROJECTS='clang;libcxx;libcxxabi'" \
    LLVM_TARGETS="-DLLVM_TARGETS_TO_BUILD='X86'" \
    LLVM_OPTIONS="-G Ninja -DCMAKE_BUILD_TYPE=Release"

WORKDIR $HOME/llvm-project-trunk
RUN INSTALL="-DCMAKE_INSTALL_PREFIX=/opt/app-root/llvm-trunk" \
    && scl enable devtoolset-8 -- $CMAKE -Bbuild $LLVM_OPTIONS $INSTALL $LLVM_PROJECTS $LLVM_TARGETS llvm \
    && $CMAKE --build build --target install