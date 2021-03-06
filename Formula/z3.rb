class Z3 < Formula
  desc "High-performance theorem prover"
  homepage "https://github.com/Z3Prover/z3"
  url "https://github.com/Z3Prover/z3/archive/z3-4.5.0.tar.gz"
  sha256 "aeae1d239c5e06ac183be7dd853775b84698db1265cb2258e5918a28372d4a0c"
  head "https://github.com/Z3Prover/z3.git"

  bottle do
    cellar :any
    sha256 "0f1f3d3de36a046161950aa09e2dc42e1d49deccdd12acaf1ebbb472b2250ad1" => :sierra
    sha256 "4646641c96b2369b11cd87d6cc81debf675f078fee3e0a296c8d0a0b4ce738f5" => :el_capitan
    sha256 "72feb2352c0f9d5fbbf22ae83443520bff85acd6448898a5d89ba3fe42c61566" => :yosemite
    sha256 "404088b4d431dea2e6d245f99fdef9f3f8889c2e0ea4d6fa69cdd318f54f467b" => :x86_64_linux
  end

  option "without-python", "Build without python 2 support"
  depends_on :python => :recommended if MacOS.version <= :snow_leopard
  depends_on :python3 => :optional

  def install
    if build.without?("python3") && build.without?("python")
      odie "z3: --with-python3 must be specified when using --without-python"
    end

    Language::Python.each_python(build) do |python, version|
      system python, "scripts/mk_make.py", "--prefix=#{prefix}", "--python", "--pypkgdir=#{lib}/python#{version}/site-packages", "--staticlib"
      cd "build" do
        system "make"
        system "make", "install"
      end
    end

    pkgshare.install "examples"
  end

  test do
    system ENV.cc, pkgshare/"examples/c/test_capi.c",
      "-I#{include}", "-L#{lib}", "-lz3", "-o", testpath/"test"
    system "./test"
  end
end
