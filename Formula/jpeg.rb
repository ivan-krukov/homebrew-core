class Jpeg < Formula
  desc "Image manipulation library"
  homepage "http://www.ijg.org"
  url "http://www.ijg.org/files/jpegsrc.v8d.tar.gz"
  sha256 "00029b1473f0f0ea72fbca3230e8cb25797fbb27e58ae2e46bb8bf5a806fe0b3"

  bottle do
    cellar :any
    rebuild 2
    sha256 "85d1f6055de99c1b764c697498bb86d003f5d24b324133f036f0393b97b3e869" => :sierra
    sha256 "bbc74f8b5980065d7bf95927150c2d56806d30abea459c2b1edcbdeed2d7c458" => :el_capitan
    sha256 "75419be793eefb3decd69de8ee0444ef697aef3d0f942361437c5d967fd8ecec" => :yosemite
    sha256 "c94f5859603b34d9b3c1b021ee21cf3a41a5d92b178a41ed5c05a1e5b7d19ff5" => :mavericks
    sha256 "816f0f826e633cb70f8efc173b6fe745fb9b90334d6cb78813de25f48aec6191" => :mountain_lion
    sha256 "f94b7976c0e867dfc36ff6cead1d88db8b1198a91a01589e008d2006fcf37c61" => :lion
    sha256 "8e6268c3b76d4d3a98873aece2beb0c092c186959afc412dc5e92eba5c98b70d" => :x86_64_linux
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/djpeg", test_fixtures("test.jpg")
  end
end
